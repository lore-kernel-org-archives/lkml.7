Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F1DEC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 13:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 185FA2133F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 13:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="g1CGoCwN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfE0NWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 09:22:08 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35691 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbfE0NWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 09:22:05 -0400
Received: by mail-wr1-f68.google.com with SMTP id m3so16943027wrv.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 06:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T95ZQlA6lX+40Lhm6IUwdSzze46k73cFevOVZXOTee0=;
        b=g1CGoCwNSEGKRD0Ut/4cJGCrE3QZykkRFvqivPRJa4jpyFrpTxQSksGSIRpFKDo5yl
         QP+Olgb2asgUvOl5y20PXku1Us0ELGXqMh0Nph7H2pDsEFrPqUntPPdU9NxKbRahNjRJ
         3LYBdOFznQQvzHJ7zRfAIKcfDkrO+2eMKt9AA//choxXBIIZfh51oSKuwjH6SNzoaX0g
         2NdLZMFdjFNiX88qpPMYF4nwudX5uw3giLwzgXOB+t1AWvldAv4wHbznahlIXegaenLK
         uri2HZForiU+R91YsE71oMEmjYgiQiGjslPXZjKyFy8B1dwE/SnhQ9OB2cM5RVT3H5VA
         uxOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T95ZQlA6lX+40Lhm6IUwdSzze46k73cFevOVZXOTee0=;
        b=RnzPPUqS38C8Lgvll7iQJqNvZl/L8PMO2MevbVFKsMv84DL70GsjNkLC+yNJdOLA5T
         SPvWG5Xkpn/khi9+Hg29KwO3QCG5I+jXjQPJmiVcgqnZ/IERkwddmcnEeqshrj8qOeJX
         OzCVutSpbdG0RACVJs1nvMGfGHlvxkfgO12oofVD6yqTcnIAozcppGkSptN2GaP+4DEU
         qr50BLRPMXNtyOFbXqZYaL8tbMQtl/ZBgrk1cM7EsfZap1NG3ZaFtAvCI/Km7SLuXXbs
         TawHm9elHCLi+L34LdfWqhYqvL9Pr4A2+omJS9A63bbZ/dTO9fjHGEmekYJ13yOiAEtq
         08Xg==
X-Gm-Message-State: APjAAAU4+uEXeOg3p68hETt0Z0zlB2Y56JQILuWXGYWqrSFIOORIpDTC
        yqYQnUKyK0tkUlOCAvAWpjAzNw==
X-Google-Smtp-Source: APXvYqymA+dN50e6OgVbRt3gPhz5kZvcuJc9tJqA4+IAQr5buFHgQO7vfJ1KrGPvnu4NRcR62G9fyw==
X-Received: by 2002:a5d:6588:: with SMTP id q8mr28940610wru.259.1558963323258;
        Mon, 27 May 2019 06:22:03 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id l12sm7019836wmj.22.2019.05.27.06.22.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 May 2019 06:22:02 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 01/10] arm64: dts: meson-gxm-khadas-vim2: fix gpio-keys-polled node
Date:   Mon, 27 May 2019 15:21:51 +0200
Message-Id: <20190527132200.17377-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190527132200.17377-1-narmstrong@baylibre.com>
References: <20190527132200.17377-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Hewitt <christianshewitt@gmail.com>

Fix DTC warnings:

meson-gxm-khadas-vim2.dtb: Warning (avoid_unnecessary_addr_size):
   /gpio-keys-polled: unnecessary #address-cells/#size-cells
	without "ranges" or child "reg" property

Fixes: b8b74dda3908 ("ARM64: dts: meson-gxm: Add support for Khadas VIM2")
Suggested-by: Christian Hewitt <christianshewitt@gmail.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
index c5f3f90a42ae..25079501f2bb 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
@@ -63,11 +63,9 @@
 
 	gpio-keys-polled {
 		compatible = "gpio-keys-polled";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		poll-interval = <100>;
 
-		button@0 {
+		power-button {
 			label = "power";
 			linux,code = <KEY_POWER>;
 			gpios = <&gpio_ao GPIOAO_2 GPIO_ACTIVE_LOW>;
-- 
2.21.0

