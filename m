Return-Path: <SRS0=RGqN=Z6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4479CC43603
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 13:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2029620726
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 13:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbfLHN4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 08:56:17 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60414 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726864AbfLHNyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 08:54:45 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1idx1F-0007gT-6a; Sun, 08 Dec 2019 13:54:41 +0000
Received: from ben by deadeye with local (Exim 4.93-RC1)
        (envelope-from <ben@decadent.org.uk>)
        id 1idx1D-0002Ob-Je; Sun, 08 Dec 2019 13:54:39 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Navid Emamdoost" <navid.emamdoost@gmail.com>
Date:   Sun, 08 Dec 2019 13:53:36 +0000
Message-ID: <lsq.1575813165.527589559@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 52/72] wimax: i2400: fix memory leak
In-Reply-To: <lsq.1575813164.154362148@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.79-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Navid Emamdoost <navid.emamdoost@gmail.com>

commit 2507e6ab7a9a440773be476141a255934468c5ef upstream.

In i2400m_op_rfkill_sw_toggle cmd buffer should be released along with
skb response.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/wimax/i2400m/op-rfkill.c | 1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/wimax/i2400m/op-rfkill.c
+++ b/drivers/net/wimax/i2400m/op-rfkill.c
@@ -142,6 +142,7 @@ int i2400m_op_rfkill_sw_toggle(struct wi
 			"%d\n", result);
 	result = 0;
 error_cmd:
+	kfree(cmd);
 	kfree_skb(ack_skb);
 error_msg_to_dev:
 error_alloc:

