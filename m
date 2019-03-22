Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C6AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 05:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81ED2213F2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 05:24:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbfCVFYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 01:24:01 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:45726 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727630AbfCVFXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 01:23:17 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1h7Ce9-000160-Ou; Fri, 22 Mar 2019 05:23:13 +0000
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1h7Ce9-0001og-IG; Fri, 22 Mar 2019 05:23:13 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Oliver Hartkopp" <socketcan@hartkopp.net>,
        "David S. Miller" <davem@davemloft.net>,
        "Marc Kleine-Budde" <mkl@pengutronix.de>,
        "Muyu Yu" <ieatmuttonchuan@gmail.com>,
        "Michal Kubecek" <mkubecek@suse.cz>,
        "Marcus Meissner" <meissner@suse.de>
Date:   Fri, 22 Mar 2019 05:20:18 +0000
Message-ID: <lsq.1553232018.741933337@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 07/16] can: gw: ensure DLC boundaries after CAN frame
 modification
In-Reply-To: <lsq.1553232017.771830163@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.64-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Oliver Hartkopp <socketcan@hartkopp.net>

commit 0aaa81377c5a01f686bcdb8c7a6929a7bf330c68 upstream.

Muyu Yu provided a POC where user root with CAP_NET_ADMIN can create a CAN
frame modification rule that makes the data length code a higher value than
the available CAN frame data size. In combination with a configured checksum
calculation where the result is stored relatively to the end of the data
(e.g. cgw_csum_xor_rel) the tail of the skb (e.g. frag_list pointer in
skb_shared_info) can be rewritten which finally can cause a system crash.

Michael Kubecek suggested to drop frames that have a DLC exceeding the
available space after the modification process and provided a patch that can
handle CAN FD frames too. Within this patch we also limit the length for the
checksum calculations to the maximum of Classic CAN data length (8).

CAN frames that are dropped by these additional checks are counted with the
CGW_DELETED counter which indicates misconfigurations in can-gw rules.

This fixes CVE-2019-3701.

Reported-by: Muyu Yu <ieatmuttonchuan@gmail.com>
Reported-by: Marcus Meissner <meissner@suse.de>
Suggested-by: Michal Kubecek <mkubecek@suse.cz>
Tested-by: Muyu Yu <ieatmuttonchuan@gmail.com>
Tested-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/can/gw.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

--- a/net/can/gw.c
+++ b/net/can/gw.c
@@ -417,13 +417,29 @@ static void can_can_gw_rcv(struct sk_buf
 	while (modidx < MAX_MODFUNCTIONS && gwj->mod.modfunc[modidx])
 		(*gwj->mod.modfunc[modidx++])(cf, &gwj->mod);
 
-	/* check for checksum updates when the CAN frame has been modified */
+	/* Has the CAN frame been modified? */
 	if (modidx) {
-		if (gwj->mod.csumfunc.crc8)
+		/* get available space for the processed CAN frame type */
+		int max_len = nskb->len - offsetof(struct can_frame, data);
+
+		/* dlc may have changed, make sure it fits to the CAN frame */
+		if (cf->can_dlc > max_len)
+			goto out_delete;
+
+		/* check for checksum updates in classic CAN length only */
+		if (gwj->mod.csumfunc.crc8) {
+			if (cf->can_dlc > 8)
+				goto out_delete;
+
 			(*gwj->mod.csumfunc.crc8)(cf, &gwj->mod.csum.crc8);
+		}
+
+		if (gwj->mod.csumfunc.xor) {
+			if (cf->can_dlc > 8)
+				goto out_delete;
 
-		if (gwj->mod.csumfunc.xor)
 			(*gwj->mod.csumfunc.xor)(cf, &gwj->mod.csum.xor);
+		}
 	}
 
 	/* clear the skb timestamp if not configured the other way */
@@ -435,6 +451,14 @@ static void can_can_gw_rcv(struct sk_buf
 		gwj->dropped_frames++;
 	else
 		gwj->handled_frames++;
+
+	return;
+
+ out_delete:
+	/* delete frame due to misconfiguration */
+	gwj->deleted_frames++;
+	kfree_skb(nskb);
+	return;
 }
 
 static inline int cgw_register_filter(struct cgw_job *gwj)

