Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8BB8C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 944D820818
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557919860;
	bh=HsE/PVs5oxByEtR7DJrXCuySZSGpF0FiEXOJmXGVDlg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2aZ1aQP3Pi8SG0kZAsfFlGNj2lN630m/7IftYbe86gmGn186lUJNGy5QLquguR0Fo
	 WgX9IDrcj66fNzYrld6mnnm2dqV+jl6dLYh2Nt5FMX/zkfNV3xXX8+Kbvo1OFV1k92
	 +2nXjSdldUI7F0OmxcDsF4Qva60z8AWpGHkVekOY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732825AbfEOLa7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:30:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:42602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731950AbfEOLa6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:30:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 282512084A;
        Wed, 15 May 2019 11:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557919857;
        bh=HsE/PVs5oxByEtR7DJrXCuySZSGpF0FiEXOJmXGVDlg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o1NQCWIu5yImW8fWgvjrcENCMTzmH4jk9sr3bcxn8oxMqqz84Krpy7EwB0X6Q573t
         pH5PFZneCtDy5czHcrTNAzMfFc09l8djkej+M2eq8o5K7seIScKOFrl0IiDn+PDkJC
         oGVZs2vhjv+lqI8S6JPcwBHYhxlDc9JVyeFJknxo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hangbin Liu <liuhangbin@gmail.com>,
        Richard Cochran <richardcochran@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.0 118/137] vlan: disable SIOCSHWTSTAMP in container
Date:   Wed, 15 May 2019 12:56:39 +0200
Message-Id: <20190515090702.233519669@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090651.633556783@linuxfoundation.org>
References: <20190515090651.633556783@linuxfoundation.org>
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
@@ -368,10 +368,12 @@ static int vlan_dev_ioctl(struct net_dev
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


