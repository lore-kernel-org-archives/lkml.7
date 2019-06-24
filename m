Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC82C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18F8D205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561371389;
	bh=OYzrlx2PcG/tyb34xB667l00sDOGV1VV1As7ECozjiw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=X5sTIvTiNaGGIfkQVXRlZXBHvuaOKElfSqnpejSTRsTG+/DX25tQXQkBTkUIXfpFs
	 HfY41kM4Fz7a+kCygjFvIQ/ryPPu/er2IT+qxBV3O5dx4tyNBPOaPY23X/NMwEF/9q
	 kuF3NLiMeTrrSiyip8XA7wq7/PxoWMimn2kCWWRM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730735AbfFXKQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 06:16:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:53906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728376AbfFXKQZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 06:16:25 -0400
Received: from localhost (f4.8f.5177.ip4.static.sl-reverse.com [119.81.143.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 329942089F;
        Mon, 24 Jun 2019 10:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561371384;
        bh=OYzrlx2PcG/tyb34xB667l00sDOGV1VV1As7ECozjiw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T2GtARzehQJQTTJdgzlrvMVGURRwiW6R1hNvKMTyd+7we4oe9if+3uI4MLD1m8LnC
         CtYgdyfhPctK2M3jr66RV2maMPNi2tjnQ0tmxk28HOtZhugoqAT6pjTKBSZ+YB0kh4
         g5YQlc9wESEu8HbWeg6eIlQEFEx6kmkP8UdYsTRs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexandra Winter <wintera@linux.ibm.com>,
        Julian Wiedmann <jwi@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 084/121] s390/qeth: fix VLAN attribute in bridge_hostnotify udev event
Date:   Mon, 24 Jun 2019 17:56:56 +0800
Message-Id: <20190624092325.137038420@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190624092320.652599624@linuxfoundation.org>
References: <20190624092320.652599624@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 335726195e460cb6b3f795b695bfd31f0ea70ef0 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/net/qeth_l2_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index c3067fd3bd9e..fece768efcb1 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -1679,7 +1679,7 @@ static void qeth_bridgeport_an_set_cb(void *priv,
 
 	l2entry = (struct qdio_brinfo_entry_l2 *)entry;
 	code = IPA_ADDR_CHANGE_CODE_MACADDR;
-	if (l2entry->addr_lnid.lnid)
+	if (l2entry->addr_lnid.lnid < VLAN_N_VID)
 		code |= IPA_ADDR_CHANGE_CODE_VLANID;
 	qeth_bridge_emit_host_event(card, anev_reg_unreg, code,
 		(struct net_if_token *)&l2entry->nit,
-- 
2.20.1



