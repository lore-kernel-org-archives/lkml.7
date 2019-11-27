Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44088C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B6A5217AB
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574887397;
	bh=RIQTKhDDQiNcNFXqGKPVnrkTgxXZnNicodfxzrmhHKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UHcc3hSAgVT1AKK61UK/mQHU9EW1TAU7N3GwY3nwRMsVTMU/Mspe4vV4uL1sUnvWa
	 DMHdZ4Z7Gc/QvDH1BalZqgMRoMqAK2V4MW86uhyIAhLHvWkiadlMDDzX4T47zGpDG/
	 8AJYokO7Rw1xtiHOja2mjxZhn3gQMQ1EtK/FgQqM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbfK0UnP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:43:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:50606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729423AbfK0UnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:43:13 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E229217AB;
        Wed, 27 Nov 2019 20:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574887392;
        bh=RIQTKhDDQiNcNFXqGKPVnrkTgxXZnNicodfxzrmhHKY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w0rdMBn0c0eP3SZlcP0pHN24HG5miqlufU67CYEI8OEpVMPRD/NyFvPujm/t5rcx9
         b/HE+UaJurECdscLR9SvE0eB6MVPMR1PJmQao4+E8SxPeHYaB2Jvgj8m7Hu6tq7Q0n
         ZH9qrSvbBEYPleJX9DIMtFUZ9toRD8a9EvbDfJH4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Radu Rendec <radu.rendec@gmail.com>,
        Patrick Talbert <ptalbert@redhat.com>,
        Sabrina Dubroca <sd@queasysnail.net>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 066/151] macsec: update operstate when lower device changes
Date:   Wed, 27 Nov 2019 21:30:49 +0100
Message-Id: <20191127203033.956899010@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203000.773542911@linuxfoundation.org>
References: <20191127203000.773542911@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sabrina Dubroca <sd@queasysnail.net>

[ Upstream commit e6ac075882b2afcdf2d5ab328ce4ab42a1eb9593 ]

Like all other virtual devices (macvlan, vlan), the operstate of a
macsec device should match the state of its lower device. This is done
by calling netif_stacked_transfer_operstate from its netdevice notifier.

We also need to call netif_stacked_transfer_operstate when a new macsec
device is created, so that its operstate is set properly. This is only
relevant when we try to bring the device up directly when we create it.

Radu Rendec proposed a similar patch, inspired from the 802.1q driver,
that included changing the administrative state of the macsec device,
instead of just the operstate. This version is similar to what the
macvlan driver does, and updates only the operstate.

Fixes: c09440f7dcb3 ("macsec: introduce IEEE 802.1AE driver")
Reported-by: Radu Rendec <radu.rendec@gmail.com>
Reported-by: Patrick Talbert <ptalbert@redhat.com>
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/macsec.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index da10104be16cf..d2a3825376be5 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -3275,6 +3275,9 @@ static int macsec_newlink(struct net *net, struct net_device *dev,
 	if (err < 0)
 		goto del_dev;
 
+	netif_stacked_transfer_operstate(real_dev, dev);
+	linkwatch_fire_event(dev);
+
 	macsec_generation++;
 
 	return 0;
@@ -3446,6 +3449,20 @@ static int macsec_notify(struct notifier_block *this, unsigned long event,
 		return NOTIFY_DONE;
 
 	switch (event) {
+	case NETDEV_DOWN:
+	case NETDEV_UP:
+	case NETDEV_CHANGE: {
+		struct macsec_dev *m, *n;
+		struct macsec_rxh_data *rxd;
+
+		rxd = macsec_data_rtnl(real_dev);
+		list_for_each_entry_safe(m, n, &rxd->secys, secys) {
+			struct net_device *dev = m->secy.netdev;
+
+			netif_stacked_transfer_operstate(real_dev, dev);
+		}
+		break;
+	}
 	case NETDEV_UNREGISTER: {
 		struct macsec_dev *m, *n;
 		struct macsec_rxh_data *rxd;
-- 
2.20.1



