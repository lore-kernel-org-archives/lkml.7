Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A70C2D0D1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5C9E24684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576781404;
	bh=iaX4qoWzrHJ87FANjOxQtE9U3qI0YIdir/spzdB2Z/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DpO0GSP3d8ZEuXka9mS04yO7kcB46EikiPvd4cGo8W+0cERf2VoFlAmsPbpU3XnYg
	 EB4gjb83DrsNhZFgHa0VQYW7MpoBWy+CNSjrN+Z0T+PKnzjJwe5N/W/Dze0EKc1zAn
	 GFnNYYOUL6lTfdkQMhhVDfH/cHbYFDljtXUm21cg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729912AbfLSSuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:50:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:43666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729893AbfLSSuB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:50:01 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4383024672;
        Thu, 19 Dec 2019 18:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576781400;
        bh=iaX4qoWzrHJ87FANjOxQtE9U3qI0YIdir/spzdB2Z/E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r/6HTMUOFnO+GDUJsI4QLCGRXj1IGRljHDN/izlfBwvJD51OwsH7CvWHaMr/SF/hI
         CW78nZuVRqYoAChq377dv1gZXMqSJaOIrW8xERofjQ0ZdR4seSLvh38lmzuFrtrO6y
         2cRu5pUdaUUltFOKvAsV72u48oNuPLAN9ehQdTBk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eran Ben Elisha <eranbe@mellanox.com>,
        Aya Levin <ayal@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 173/199] net/mlx5e: Fix SFF 8472 eeprom length
Date:   Thu, 19 Dec 2019 19:34:15 +0100
Message-Id: <20191219183225.110570192@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219183214.629503389@linuxfoundation.org>
References: <20191219183214.629503389@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eran Ben Elisha <eranbe@mellanox.com>

[ Upstream commit c431f8597863a91eea6024926e0c1b179cfa4852 ]

SFF 8472 eeprom length is 512 bytes. Fix module info return value to
support 512 bytes read.

Fixes: ace329f4ab3b ("net/mlx5e: ethtool, Remove unsupported SFP EEPROM high pages query")
Signed-off-by: Eran Ben Elisha <eranbe@mellanox.com>
Reviewed-by: Aya Levin <ayal@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index e42ece20cd0b1..e13a6cd5163f4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -1368,7 +1368,7 @@ static int mlx5e_get_module_info(struct net_device *netdev,
 		break;
 	case MLX5_MODULE_ID_SFP:
 		modinfo->type       = ETH_MODULE_SFF_8472;
-		modinfo->eeprom_len = MLX5_EEPROM_PAGE_LENGTH;
+		modinfo->eeprom_len = ETH_MODULE_SFF_8472_LEN;
 		break;
 	default:
 		netdev_err(priv->netdev, "%s: cable type not recognized:0x%x\n",
-- 
2.20.1



