Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C1E7C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2038820881
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557918775;
	bh=fZqsv+Ui5GrAdYWrR7deKW8R/ugZlorGSgK6oNcg2oA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0aimMrRIAroGFHJD354aRxM/SlYx0djeW7ht7FKwzgPSESFiSEP8m1TV8HvLSMsGj
	 xSLKSjzEdqMoOvci56/pX8kcWsycNy1t3cfb0B0gC4Zy+yUehnIgxvKZGlH8cVPqrh
	 M1bvvxOFmvlZbJiXpJ9t9Clh18W775GM+8rhTIs8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729884AbfEOLMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:12:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:48410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729860AbfEOLMu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:12:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF9DF20881;
        Wed, 15 May 2019 11:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557918770;
        bh=fZqsv+Ui5GrAdYWrR7deKW8R/ugZlorGSgK6oNcg2oA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VikBB2IG4cGMZTYrOR+ZjUz7fNxFx1HxrOJX77CjGPXZPFF0k0h5X8fTWP3PK/zst
         jh+7smUg1y0+qGVMqtB38xs7pZI+/MoXshffgHTJ70jt+V1sf7Eij+7UKy9ehcq/wg
         HR/BwIIANwonzlLbdcgut8olE/h7MywW0keluLZA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hangbin Liu <liuhangbin@gmail.com>,
        Richard Cochran <richardcochran@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 260/266] vlan: disable SIOCSHWTSTAMP in container
Date:   Wed, 15 May 2019 12:56:07 +0200
Message-Id: <20190515090731.812591029@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090722.696531131@linuxfoundation.org>
References: <20190515090722.696531131@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hangbin Liu <liuhangbin@gmail.com>

[ Upstream commit 873017af778439f2f8e3d87f28ddb1fcaf244a76 ]

With NET_ADMIN enabled in container, a normal user could be mapped to
root and is able to change the real device's rx filter via ioctl on
vlan, which would affect the other ptp process on host. Fix it by
disabling SIOCSHWTSTAMP in container.

Fixes: a6111d3c93d0 ("vlan: Pass SIOC[SG]HWTSTAMP ioctls to real device")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Acked-by: Richard Cochran <richardcochran@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/8021q/vlan_dev.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -363,10 +363,12 @@ static int vlan_dev_ioctl(struct net_dev
 	ifrr.ifr_ifru = ifr->ifr_ifru;
 
 	switch (cmd) {
+	case SIOCSHWTSTAMP:
+		if (!net_eq(dev_net(dev), &init_net))
+			break;
 	case SIOCGMIIPHY:
 	case SIOCGMIIREG:
 	case SIOCSMIIREG:
-	case SIOCSHWTSTAMP:
 	case SIOCGHWTSTAMP:
 		if (netif_device_present(real_dev) && ops->ndo_do_ioctl)
 			err = ops->ndo_do_ioctl(real_dev, &ifrr, cmd);


