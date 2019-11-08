Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F1C4C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EF84218AE
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573239755;
	bh=kjVY/QYwGT0A/t48RdyXw9jg7Zcaof+ZFiXgC9WvTZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xP3tK9iybZWT+4YV+JtI6IgKtgEILGXLq/7dWCEkTUpIB9OcyyTIBX12HdwNNF9TL
	 sIODxBpcEVRpKUYkwj8bI2COi5JjKtjt4hmxjC3SWUq2bfkvOOwkBIS7T6pauhCPW0
	 4/MQbbdZKnKd7Zh+/1KPkF7PcdNS1iWa511EZ0zc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390562AbfKHTCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 14:02:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:60244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390553AbfKHTCc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 14:02:32 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B997B222C6;
        Fri,  8 Nov 2019 19:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573239752;
        bh=kjVY/QYwGT0A/t48RdyXw9jg7Zcaof+ZFiXgC9WvTZI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2or22b4s3kXOtl8/3A4YcqZVfZ+MdipLp+zwx7VnxCy7BQbQR5vsi2rkvF+61omsQ
         2GYbnJwen/uxRxHcMS8FJcheIRGcxiXwd1HYJpwLP7MSN6CaHSQ2Dbhw2LwKX0MyFj
         gze8fSEpUR+OL8NwjjlN6OaU1RnJanIkPBFLvE1c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, zhanglin <zhang.lin16@zte.com.cn>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 50/79] net: Zeroing the structure ethtool_wolinfo in ethtool_get_wol()
Date:   Fri,  8 Nov 2019 19:50:30 +0100
Message-Id: <20191108174814.533229269@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191108174745.495640141@linuxfoundation.org>
References: <20191108174745.495640141@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhanglin <zhang.lin16@zte.com.cn>

[ Upstream commit 5ff223e86f5addbfae26419cbb5d61d98f6fbf7d ]

memset() the structure ethtool_wolinfo that has padded bytes
but the padded bytes have not been zeroed out.

Signed-off-by: zhanglin <zhang.lin16@zte.com.cn>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/ethtool.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/net/core/ethtool.c
+++ b/net/core/ethtool.c
@@ -1482,11 +1482,13 @@ static int ethtool_reset(struct net_devi
 
 static int ethtool_get_wol(struct net_device *dev, char __user *useraddr)
 {
-	struct ethtool_wolinfo wol = { .cmd = ETHTOOL_GWOL };
+	struct ethtool_wolinfo wol;
 
 	if (!dev->ethtool_ops->get_wol)
 		return -EOPNOTSUPP;
 
+	memset(&wol, 0, sizeof(struct ethtool_wolinfo));
+	wol.cmd = ETHTOOL_GWOL;
 	dev->ethtool_ops->get_wol(dev, &wol);
 
 	if (copy_to_user(useraddr, &wol, sizeof(wol)))


