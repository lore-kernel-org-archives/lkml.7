Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC24EC10F14
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 19:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D53F121D82
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 19:08:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729431AbfJBTI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 15:08:26 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35574 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726669AbfJBTIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 15:08:11 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1iFjyr-00035t-2v; Wed, 02 Oct 2019 20:08:09 +0100
Received: from ben by deadeye with local (Exim 4.92.1)
        (envelope-from <ben@decadent.org.uk>)
        id 1iFjyo-0003dN-9v; Wed, 02 Oct 2019 20:08:06 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Alexandra Winter" <wintera@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Julian Wiedmann" <jwi@linux.ibm.com>
Date:   Wed, 02 Oct 2019 20:06:51 +0100
Message-ID: <lsq.1570043211.669685180@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 44/87] s390/qeth: fix VLAN attribute in
 bridge_hostnotify udev event
In-Reply-To: <lsq.1570043210.379046399@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.75-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Alexandra Winter <wintera@linux.ibm.com>

commit 335726195e460cb6b3f795b695bfd31f0ea70ef0 upstream.

Enabling sysfs attribute bridge_hostnotify triggers a series of udev events
for the MAC addresses of all currently connected peers. In case no VLAN is
set for a peer, the device reports the corresponding MAC addresses with
VLAN ID 4096. This currently results in attribute VLAN=4096 for all
non-VLAN interfaces in the initial series of events after host-notify is
enabled.

Instead, no VLAN attribute should be reported in the udev event for
non-VLAN interfaces.

Only the initial events face this issue. For dynamic changes that are
reported later, the device uses a validity flag.

This also changes the code so that it now sets the VLAN attribute for
MAC addresses with VID 0. On Linux, no qeth interface will ever be
registered with VID 0: Linux kernel registers VID 0 on all network
interfaces initially, but qeth will drop .ndo_vlan_rx_add_vid for VID 0.
Peers with other OSs could register MACs with VID 0.

Fixes: 9f48b9db9a22 ("qeth: bridgeport support - address notifications")
Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/s390/net/qeth_l2_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -1956,7 +1956,7 @@ static void qeth_bridgeport_an_set_cb(vo
 
 	l2entry = (struct qdio_brinfo_entry_l2 *)entry;
 	code = IPA_ADDR_CHANGE_CODE_MACADDR;
-	if (l2entry->addr_lnid.lnid)
+	if (l2entry->addr_lnid.lnid < VLAN_N_VID)
 		code |= IPA_ADDR_CHANGE_CODE_VLANID;
 	qeth_bridge_emit_host_event(card, anev_reg_unreg, code,
 		(struct net_if_token *)&l2entry->nit,

