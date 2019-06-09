Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 214D2C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 16:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E71BE20840
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 16:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560098682;
	bh=pzVPEGB29rxDVyY7UFKBEsxqkSSuIe3pdooEKe9VtJU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bnQDRV0yHH8PmocoUax7TgoiHUvhksfo+/js83KgpClP82Rd9kQZiIXS1oIfokTUA
	 hi3ZT9T0/9SfjaWkF2eJyZasvQGSrdpqe+03yk8TxVMvg1ELYp7qER5njs99+QTgRe
	 oKuKIY1Blk3RfAbjWNXOlARu2AdozD650oWqZfIk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729418AbfFIQol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 12:44:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:41796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729373AbfFIQof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 12:44:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C32342083D;
        Sun,  9 Jun 2019 16:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560098675;
        bh=pzVPEGB29rxDVyY7UFKBEsxqkSSuIe3pdooEKe9VtJU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=omp5DRrJyPvzjhirMHXP3r2rm56hh7K4+khs+tIKfWqKw/jKIUbHXwhqf8lBm2A7W
         vqxAKkgUhKo6heFVhQuAy5HXVqbNr66yNhNs3v9zJgXvwEtWSWUtZzQn4RRD9UnQ/B
         me+ptcvks3PeNslPzplQrw4pyu5wh1PL5E9Pe3eQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Erez Alfasi <ereza@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.1 20/70] net/mlx4_en: ethtool, Remove unsupported SFP EEPROM high pages query
Date:   Sun,  9 Jun 2019 18:41:31 +0200
Message-Id: <20190609164128.758877792@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164127.541128197@linuxfoundation.org>
References: <20190609164127.541128197@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Erez Alfasi <ereza@mellanox.com>

[ Upstream commit 135dd9594f127c8a82d141c3c8430e9e2143216a ]

Querying EEPROM high pages data for SFP module is currently
not supported by our driver but is still tried, resulting in
invalid FW queries.

Set the EEPROM ethtool data length to 256 for SFP module to
limit the reading for page 0 only and prevent invalid FW queries.

Fixes: 7202da8b7f71 ("ethtool, net/mlx4_en: Cable info, get_module_info/eeprom ethtool support")
Signed-off-by: Erez Alfasi <ereza@mellanox.com>
Signed-off-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c |    4 +++-
 drivers/net/ethernet/mellanox/mlx4/port.c       |    5 -----
 2 files changed, 3 insertions(+), 6 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
@@ -2010,6 +2010,8 @@ static int mlx4_en_set_tunable(struct ne
 	return ret;
 }
 
+#define MLX4_EEPROM_PAGE_LEN 256
+
 static int mlx4_en_get_module_info(struct net_device *dev,
 				   struct ethtool_modinfo *modinfo)
 {
@@ -2044,7 +2046,7 @@ static int mlx4_en_get_module_info(struc
 		break;
 	case MLX4_MODULE_ID_SFP:
 		modinfo->type = ETH_MODULE_SFF_8472;
-		modinfo->eeprom_len = ETH_MODULE_SFF_8472_LEN;
+		modinfo->eeprom_len = MLX4_EEPROM_PAGE_LEN;
 		break;
 	default:
 		return -EINVAL;
--- a/drivers/net/ethernet/mellanox/mlx4/port.c
+++ b/drivers/net/ethernet/mellanox/mlx4/port.c
@@ -2077,11 +2077,6 @@ int mlx4_get_module_info(struct mlx4_dev
 		size -= offset + size - I2C_PAGE_SIZE;
 
 	i2c_addr = I2C_ADDR_LOW;
-	if (offset >= I2C_PAGE_SIZE) {
-		/* Reset offset to high page */
-		i2c_addr = I2C_ADDR_HIGH;
-		offset -= I2C_PAGE_SIZE;
-	}
 
 	cable_info = (struct mlx4_cable_info *)inmad->data;
 	cable_info->dev_mem_address = cpu_to_be16(offset);


