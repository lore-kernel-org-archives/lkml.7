Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C1FC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 20:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CD1F2465E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 20:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576613470;
	bh=yfXMX4PLHDZv8MTXcX+8/pQrj/RT0pN2aDR+vwmqh9Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Jn11TyWM5B4RUoQfLplKW5aDXZh55q28oHHknYkT/ywy1VILsUOfUgc5S7lcXnZEv
	 2wOSLDm26b+6wEJBQDOgAvlrUObxJVQIKRM8enoiwGiUF8GXdozXTeaXtye9h2+aeW
	 mIwfXFAWdAH1hY6a/NiMiaVu79wlnpLfWKXgwWtI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbfLQULJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 15:11:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:37530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728592AbfLQULH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 15:11:07 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 481EC24684;
        Tue, 17 Dec 2019 20:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576613466;
        bh=yfXMX4PLHDZv8MTXcX+8/pQrj/RT0pN2aDR+vwmqh9Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w/wVYWPskjTc7r31YD6vgMeY63vmskNuDbC5UcfDnHJjHX5AaJ6jwHnCqqP48RsK+
         sDe2c8qhqanrtK0PJuEp1ugN1oJmiNOHfRjWo1oG11xw/N0b8odBftddjd0wkJ8qeN
         1u1YTpZW5A9YaWoQ7H40bPh8yIVQ5b+6J1dfrgaE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aya Levin <ayal@mellanox.com>,
        Eran Ben Elisha <eranbe@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 5.4 31/37] net/mlx5e: Fix translation of link mode into speed
Date:   Tue, 17 Dec 2019 21:09:52 +0100
Message-Id: <20191217200733.783539788@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191217200721.741054904@linuxfoundation.org>
References: <20191217200721.741054904@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aya Levin <ayal@mellanox.com>

[ Upstream commit 6d485e5e555436d2c13accdb10807328c4158a17 ]

Add a missing value in translation of PTYS ext_eth_proto_oper to its
corresponding speed. When ext_eth_proto_oper bit 10 is set, ethtool
shows unknown speed. With this fix, ethtool shows speed is 100G as
expected.

Fixes: a08b4ed1373d ("net/mlx5: Add support to ext_* fields introduced in Port Type and Speed register")
Signed-off-by: Aya Levin <ayal@mellanox.com>
Reviewed-by: Eran Ben Elisha <eranbe@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/port.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en/port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/port.c
@@ -73,6 +73,7 @@ static const u32 mlx5e_ext_link_speed[ML
 	[MLX5E_50GAUI_2_LAUI_2_50GBASE_CR2_KR2]	= 50000,
 	[MLX5E_50GAUI_1_LAUI_1_50GBASE_CR_KR]	= 50000,
 	[MLX5E_CAUI_4_100GBASE_CR4_KR4]		= 100000,
+	[MLX5E_100GAUI_2_100GBASE_CR2_KR2]	= 100000,
 	[MLX5E_200GAUI_4_200GBASE_CR4_KR4]	= 200000,
 	[MLX5E_400GAUI_8]			= 400000,
 };


