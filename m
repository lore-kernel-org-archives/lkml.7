Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C79EC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32AFD2053B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557920149;
	bh=zgxJFo41n2tRNguAeuAbLqkNgYqPJNN4eVAR+xGXUoE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Yb9kqAsqhGy1h9jAwWZLFO2mqQfd/fZkOiSCwXKghYVcjV2N60i6LumSYlvassAjM
	 pDQHkB5epDGnRsPZptyv9P9XBXUYJ89RFy+msGko1nv/s9VbbLh62wzBpngVn4GfNh
	 qmiCkSlvl9yWjfMcsYoBuq4RGFj7XyzipwcGhDCM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733150AbfEOLdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:33:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:44902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733110AbfEOLc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:32:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0EA4206BF;
        Wed, 15 May 2019 11:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557919976;
        bh=zgxJFo41n2tRNguAeuAbLqkNgYqPJNN4eVAR+xGXUoE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A57E3hU2GDt6tjDksdNCIeCAd1/0GGBEFDTt+JW3JRFhxz6kn82st3QfvFkKbulfD
         KZeT19m/JycLNF4DFhy4TBfaTqc7lExEw+NSJv8qIZVGmUTt5hNUq7iiJVg2RjUNfm
         /swsHwwwlGaxDOhZCLfoVkXoUI43oQssqR7kxwBk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hangbin Liu <liuhangbin@gmail.com>,
        Richard Cochran <richardcochran@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.1 27/46] vlan: disable SIOCSHWTSTAMP in container
Date:   Wed, 15 May 2019 12:56:51 +0200
Message-Id: <20190515090625.571849309@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090616.670410738@linuxfoundation.org>
References: <20190515090616.670410738@linuxfoundation.org>
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
@@ -367,10 +367,12 @@ static int vlan_dev_ioctl(struct net_dev
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


