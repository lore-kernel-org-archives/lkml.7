Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B48BC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 16:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1160206DD
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 16:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+LGCG6l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729538AbfDDQ5h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 12:57:37 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42534 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727415AbfDDQ5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 12:57:36 -0400
Received: by mail-pf1-f194.google.com with SMTP id w25so203685pfi.9;
        Thu, 04 Apr 2019 09:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ehyl5UZ+tyostJdkwWdGz1fU3mPnH2bSVKNeEhhJzVw=;
        b=S+LGCG6lozColhzJJvjSCO0u1KBuBYUWpmcnC1XSGoEgdw+UewhzCBg0My4xps3iRk
         3s0cJGeFuATMWHXl9kiMi3Mst/fF9eZZSrBQiFtMtcOd4MQTypOAcBEqXwGLTNP6wgCk
         i37zvarzyImb5gDzVUMv5rlOMPUZMRfPppdoHTYeQijFa3m8wJEzRERJwxQ5B2Y2TGYZ
         MWSS9yao4S2i8rdC3nP4MdDzG/F1afeR98eca3lxrhIEeECmLwn8icRD6WYPJQn7bNgH
         k+ivetv2kZgm8x/1SgNSCttmQiDOpAo63YthNzYoeOsGpfglrvaFmgHZUepw+irc2h6Q
         AMCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ehyl5UZ+tyostJdkwWdGz1fU3mPnH2bSVKNeEhhJzVw=;
        b=AcUl4Efpf+qb2eHnZRptb3+O60M4N6HtEwl/8pY7M9/FsoJKPG/XBz+xpaCjYB1cRT
         J9tTFYeLdjq+xofLx/1ZvhqmkxsqJDv0wjb1sUchtfIaafAzKcNJzGXdxBeNymPT+jpF
         JHo3edKsI3DH7o3+Xwvw9QOaGxW8xysY/S/ZVbMlETvfvW7mzII943nP64ahPvmR6T7V
         sf6ctqi3sNi3R/ES8/lLQtL4g4813bC/u4WSEQSrPJJJ/2IBv22TF0pvPcMK++MH/a4R
         luHLnB9h35nQmwG9qRFsxBP0Eh4t6YYR/ikJfVXQ/EBs58nu1gfC5QX3BYOfWiQ4omrS
         5nSg==
X-Gm-Message-State: APjAAAXEgsdESSSmtcvsKNpQTTlI7PJLf2lfl3VXMQ8gZR58Zxawk4tk
        uOoozbXVUo/68uqgOyBkmSA=
X-Google-Smtp-Source: APXvYqzEsBpNqnjFsQuMbFpos8hNvvTkRfxufvfxQ1PcQCiRsGTK0NzcpbAOuCR8RbOWEwBekPIfZw==
X-Received: by 2002:a63:6f0a:: with SMTP id k10mr6821263pgc.78.1554397055110;
        Thu, 04 Apr 2019 09:57:35 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id 25sm24127789pfo.96.2019.04.04.09.57.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 09:57:34 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org,
        mark.rutland@arm.com, srinivas.kandagatla@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [RESEND 1/2] nvmem: sunxi_sid: Support SID on H6
Date:   Thu,  4 Apr 2019 12:57:25 -0400
Message-Id: <20190404165726.13149-2-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190404165726.13149-1-tiny.windzz@gmail.com>
References: <20190404165726.13149-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for H6's SID controller. It supports 4K-bit
EFUSE, bigger than before.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/nvmem/sunxi_sid.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
index 7013f9cc43c7..a079a80ddf2c 100644
--- a/drivers/nvmem/sunxi_sid.c
+++ b/drivers/nvmem/sunxi_sid.c
@@ -188,6 +188,11 @@ static const struct sunxi_sid_cfg sun50i_a64_cfg = {
 	.size = 0x100,
 };
 
+static const struct sunxi_sid_cfg sun50i_h6_cfg = {
+	.value_offset = 0x200,
+	.size = 0x200,
+};
+
 static const struct of_device_id sunxi_sid_of_match[] = {
 	{ .compatible = "allwinner,sun4i-a10-sid", .data = &sun4i_a10_cfg },
 	{ .compatible = "allwinner,sun7i-a20-sid", .data = &sun7i_a20_cfg },
@@ -195,6 +200,7 @@ static const struct of_device_id sunxi_sid_of_match[] = {
 	{ .compatible = "allwinner,sun8i-h3-sid", .data = &sun8i_h3_cfg },
 	{ .compatible = "allwinner,sun50i-a64-sid", .data = &sun50i_a64_cfg },
 	{ .compatible = "allwinner,sun50i-h5-sid", .data = &sun50i_a64_cfg },
+	{ .compatible = "allwinner,sun50i-h6-sid", .data = &sun50i_h6_cfg },
 	{/* sentinel */},
 };
 MODULE_DEVICE_TABLE(of, sunxi_sid_of_match);
-- 
2.17.0

