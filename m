Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 089D7C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFDE720862
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557919402;
	bh=OauWDb99dndtmVwXevW2sEDRQJz0FaVlZ55NtZqBDZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aSOlzyaw96uN7PvhdpZ72kDhg0Ee+E0lHOc4+fUcwpOmPB/h6/Dsg8AjDq0TaNh03
	 uzD59+x9RmL8YicvZgdC8dWdqESvd5jlBjtZvUAjtHppSlDLUC0oiUX+zwweEI6W0+
	 ia/k3lNI6YfX0MtIjXH1o97xVH0QFNhAyuEun3lY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731629AbfEOLXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:23:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:33606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731335AbfEOLXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:23:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0C2E206BF;
        Wed, 15 May 2019 11:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557919396;
        bh=OauWDb99dndtmVwXevW2sEDRQJz0FaVlZ55NtZqBDZw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nYAiWGj5FdJCl08IoZDwGtrKp3i3l1DT4+8TriOD2vKg8RPE8GR7L4I1jD1ZRpNVM
         KlmD9UijkUlOmCGs1kQjLLD6lTP3ONMKQjMtZ2RitYxwSdTgyQfdY/o9ai/kUjkiBv
         eoZTrEDr5TkQqtmXk13J2AB1V9yf5VTr8/srohl4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Javier Martinez Canillas <javier@dowhile0.org>,
        Daniel Gomez <dagmcr@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 059/113] spi: Micrel eth switch: declare missing of table
Date:   Wed, 15 May 2019 12:55:50 +0200
Message-Id: <20190515090658.075732313@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090652.640988966@linuxfoundation.org>
References: <20190515090652.640988966@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 2f23a2a768bee7ad2ff1e9527c3f7e279e794a46 ]

Add missing <of_device_id> table for SPI driver relying on SPI
device match since compatible is in a DT binding or in a DTS.

Before this patch:
modinfo drivers/net/phy/spi_ks8995.ko | grep alias
alias:          spi:ksz8795
alias:          spi:ksz8864
alias:          spi:ks8995

After this patch:
modinfo drivers/net/phy/spi_ks8995.ko | grep alias
alias:          spi:ksz8795
alias:          spi:ksz8864
alias:          spi:ks8995
alias:          of:N*T*Cmicrel,ksz8795C*
alias:          of:N*T*Cmicrel,ksz8795
alias:          of:N*T*Cmicrel,ksz8864C*
alias:          of:N*T*Cmicrel,ksz8864
alias:          of:N*T*Cmicrel,ks8995C*
alias:          of:N*T*Cmicrel,ks8995

Reported-by: Javier Martinez Canillas <javier@dowhile0.org>
Signed-off-by: Daniel Gomez <dagmcr@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/spi_ks8995.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/phy/spi_ks8995.c b/drivers/net/phy/spi_ks8995.c
index f17b3441779bf..d8ea4147dfe78 100644
--- a/drivers/net/phy/spi_ks8995.c
+++ b/drivers/net/phy/spi_ks8995.c
@@ -162,6 +162,14 @@ static const struct spi_device_id ks8995_id[] = {
 };
 MODULE_DEVICE_TABLE(spi, ks8995_id);
 
+static const struct of_device_id ks8895_spi_of_match[] = {
+        { .compatible = "micrel,ks8995" },
+        { .compatible = "micrel,ksz8864" },
+        { .compatible = "micrel,ksz8795" },
+        { },
+ };
+MODULE_DEVICE_TABLE(of, ks8895_spi_of_match);
+
 static inline u8 get_chip_id(u8 val)
 {
 	return (val >> ID1_CHIPID_S) & ID1_CHIPID_M;
@@ -529,6 +537,7 @@ static int ks8995_remove(struct spi_device *spi)
 static struct spi_driver ks8995_driver = {
 	.driver = {
 		.name	    = "spi-ks8995",
+		.of_match_table = of_match_ptr(ks8895_spi_of_match),
 	},
 	.probe	  = ks8995_probe,
 	.remove	  = ks8995_remove,
-- 
2.20.1



