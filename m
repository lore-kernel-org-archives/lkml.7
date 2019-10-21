Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D2CCA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 14:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCE8720882
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 14:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="1ZyCG1ok"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbfJUO3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 10:29:18 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38086 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728776AbfJUO3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 10:29:13 -0400
Received: by mail-wm1-f68.google.com with SMTP id 3so13045307wmi.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 07:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o2g5MppcRcxrnsPQBvomKNHr4TeFrtJvAa8pk/mHOiE=;
        b=1ZyCG1okRY4dyPz4T0huoXg+PIbmxW0rg+faaMGWsRd0sSzZKzDh58t2YXt4bPk73g
         JKqfpSJmBJosg7OF3PcUW1Z1Jkqrm2hZvqWkGnQSKUD0Kk05iO/vVLluPyEOsAOF0HYv
         CBoFTTtqRB7ZjeWQ2mxxgUwEEIPICBAJrJHsU8DGtS3ghQnRsiYLmCuQeINF8iP+6J2x
         6vmvv7bmVVvDeJ0Cu167jEcFsha2vBAa2bE5sor+h25iEReQoD/AjkjOzvocnvUVmCiW
         qxT7w9wvcy9RKErNZIP8c8ZibvN5cBbPYTC1gMTApcJrlNlcIX6No/ekpIgxNH7Yxxt/
         tqiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o2g5MppcRcxrnsPQBvomKNHr4TeFrtJvAa8pk/mHOiE=;
        b=KL9VIOOVLGO0opsABKmZ+aWufN3MGiuPto/NTF+7gNIKMaRtO3C1gfjhyjQtg5EMU5
         S6h3o8iT7FUeseyh5ntJ8m+6tMPgAjDcOh6Nmici6PSD85Ju/+lJiK1WdVAectd13A/A
         WiLz/b4KhpN7upulKH54JzSn9AQ2zbJVRJd7/L8Zv8DIWtNmWxVQ87s+d+SHn64YhhyE
         HEyRend23+myn5IzRbyEODbnzLt9+ZnMVvg1OwQOZrNCrWjP8/Dq0EyexkWTRDr45g5T
         4mAYdXmhx8o4/3agkgdNizBqSID0VFerXh81ZqGxvCGfvClOFD0BYmAu5HXohAXly49v
         t0tw==
X-Gm-Message-State: APjAAAXZWgwZfMM0ouSeynq+6uV55cNYj0EciJc0b6qsHypFKqARluYw
        lS5yOIkDFYnn6iqpyxe+XB+lfA==
X-Google-Smtp-Source: APXvYqxeUGEAtkX1OR8rn7MFQuU+/p8DKQ2ipjOJurJYS3W7VQjwRXnYOLNiAr44/VtEEL+1x+f5rg==
X-Received: by 2002:a7b:ce88:: with SMTP id q8mr18314690wmj.160.1571668150520;
        Mon, 21 Oct 2019 07:29:10 -0700 (PDT)
Received: from localhost.localdomain (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id d11sm17304463wrf.80.2019.10.21.07.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 07:29:10 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 4/5] arm64: dts: meson-gx: cec node should be disabled by default
Date:   Mon, 21 Oct 2019 16:29:03 +0200
Message-Id: <20191021142904.12401-5-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20191021142904.12401-1-narmstrong@baylibre.com>
References: <20191021142904.12401-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the following DT schemas check errors:
meson-gxl-s905x-hwacom-amazetv.dt.yaml: cec@100: 'hdmi-phandle' is a required property
meson-gxm-rbox-pro.dt.yaml: cec@100: 'hdmi-phandle' is a required property

because CEC is not enabled on these boards.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index 6733050d735f..042132bf5b76 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -391,6 +391,7 @@
 				compatible = "amlogic,meson-gx-ao-cec";
 				reg = <0x0 0x00100 0x0 0x14>;
 				interrupts = <GIC_SPI 199 IRQ_TYPE_EDGE_RISING>;
+				status = "disabled";
 			};
 
 			sec_AO: ao-secure@140 {
-- 
2.22.0

