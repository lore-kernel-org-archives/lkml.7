Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C219C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51A5520665
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560441762;
	bh=wxsC2Sqqr9JhCsUroZoSPwPTxcPD/QR0oQmnP/rs/0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pMD+Mfpbz9J+PrGyYyTNr8CxCBNGlEceqZu8ytWvms/V3waMfe5ZP5JkL6cpuQTKa
	 vnNkp+L+aktLwHuYl1TF7Fle+hSTXlRxeHzUKe9dI+2krRnyfRK2QZazB+YAXISb1g
	 9z66IahKR1WaQeHKWAClcue2wWGyIWNRkR8xnPHw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390987AbfFMQCi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:02:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:35940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731404AbfFMIru (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 04:47:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1051206BA;
        Thu, 13 Jun 2019 08:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560415669;
        bh=wxsC2Sqqr9JhCsUroZoSPwPTxcPD/QR0oQmnP/rs/0M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2SehRWT9iGGKKVPGG0orH7w5N/aa+HHceM9MuJ0XMAIBg/MyN1+vJkFg5TWlJbM8T
         sGhOu7RvhrOGMc2SXPklg8kxzWEwlptMIDvyPuYHXrdXt21G4tqvD0ea7QjnD1cx9X
         oF8lwY/NYjhZPBfg8DkZVaNwML8bzK5mEbKoeQLc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 084/155] nvmem: sunxi_sid: Support SID on A83T and H5
Date:   Thu, 13 Jun 2019 10:33:16 +0200
Message-Id: <20190613075657.776381915@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190613075652.691765927@linuxfoundation.org>
References: <20190613075652.691765927@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit da75b8909756160b8e785104ba421a20b756c975 ]

The device tree binding already lists compatible strings for these two
SoCs. They don't have the defect as seen on the H3, and the size and
register layout is the same as the A64. Furthermore, the driver does
not include nvmem cell definitions.

Add support for these two compatible strings, re-using the config for
the A64.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvmem/sunxi_sid.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
index 570a2e354f30..ef3d776bb16e 100644
--- a/drivers/nvmem/sunxi_sid.c
+++ b/drivers/nvmem/sunxi_sid.c
@@ -222,8 +222,10 @@ static const struct sunxi_sid_cfg sun50i_a64_cfg = {
 static const struct of_device_id sunxi_sid_of_match[] = {
 	{ .compatible = "allwinner,sun4i-a10-sid", .data = &sun4i_a10_cfg },
 	{ .compatible = "allwinner,sun7i-a20-sid", .data = &sun7i_a20_cfg },
+	{ .compatible = "allwinner,sun8i-a83t-sid", .data = &sun50i_a64_cfg },
 	{ .compatible = "allwinner,sun8i-h3-sid", .data = &sun8i_h3_cfg },
 	{ .compatible = "allwinner,sun50i-a64-sid", .data = &sun50i_a64_cfg },
+	{ .compatible = "allwinner,sun50i-h5-sid", .data = &sun50i_a64_cfg },
 	{/* sentinel */},
 };
 MODULE_DEVICE_TABLE(of, sunxi_sid_of_match);
-- 
2.20.1



