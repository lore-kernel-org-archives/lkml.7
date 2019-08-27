Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0DFFC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 07:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88991206BF
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 07:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566892602;
	bh=wBDTt3QJeNyBbFdPFFDHHbJOAO4Y4cMJPz8/cwlUn7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=r9dO8p3/hVAF7iQG4Es/Rj2zm8fPHSYF9SU4+o/FworRNFEI68Wdb0Sj7DwfN28WS
	 3WgcLIPUwDkwGREwGAEpHxqcjN2HVBzysoLZYCVx/F2KKB628Df83BEgwBwP8+Nvkx
	 Zv2XG1nsjU13GKWO25x2j8MmP1vxDY7Xgn5/n4ak=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729139AbfH0H4l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 03:56:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:48688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730656AbfH0H4j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 03:56:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AA58217F5;
        Tue, 27 Aug 2019 07:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566892599;
        bh=wBDTt3QJeNyBbFdPFFDHHbJOAO4Y4cMJPz8/cwlUn7M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NG7H+U8pZa1ML8TuivjZCoLOkruC3UC3iRGNvsZn3/9aVc9Aw4c/vJYsYlQsNMDk7
         kyy4HbJSfAmffSh4bRKKyelBjZL+n+bqijye+rZn3DMZ50HMsBMyynV9SHeTZTlLLy
         A8sUUyW8xHbrzYogWhK3XbAPLOgm1g5rSPI6rjKo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Willem de Bruijn <willemb@google.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 11/98] can: dev: call netif_carrier_off() in register_candev()
Date:   Tue, 27 Aug 2019 09:49:50 +0200
Message-Id: <20190827072718.817559293@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190827072718.142728620@linuxfoundation.org>
References: <20190827072718.142728620@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit c63845609c4700488e5eacd6ab4d06d5d420e5ef ]

CONFIG_CAN_LEDS is deprecated. When trying to use the generic netdev
trigger as suggested, there's a small inconsistency with the link
property: The LED is on initially, stays on when the device is brought
up, and then turns off (as expected) when the device is brought down.

Make sure the LED always reflects the state of the CAN device.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Acked-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/can/dev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index c05e4d50d43d7..bd127ce3aba24 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -1260,6 +1260,8 @@ int register_candev(struct net_device *dev)
 		return -EINVAL;
 
 	dev->rtnl_link_ops = &can_link_ops;
+	netif_carrier_off(dev);
+
 	return register_netdev(dev);
 }
 EXPORT_SYMBOL_GPL(register_candev);
-- 
2.20.1



