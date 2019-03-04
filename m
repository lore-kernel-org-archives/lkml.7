Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B7BC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 10:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF61520823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 10:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="BRmVM0pg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbfCDKyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 05:54:02 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37555 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfCDKyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 05:54:02 -0500
Received: by mail-wr1-f65.google.com with SMTP id w6so4995865wrs.4
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 02:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YBMGzFIEHIQ7zv+jwc9v87XTUsS+NaVoQ1+r7qeHMU0=;
        b=BRmVM0pgR+XnUsEccy9kGG+98Q+d2CQSVst+lIhoYlMhfD3GzbvaoNWx+iMbKhSf2K
         hid5q9nAyKvYGfgkoWwke8UXwXwwbBWGh9JW/bWtMXpng+GEIQRMjDlEIaBgT8hl+26/
         rJpU46HGsfcpqg7ltr23k7L3DW5AQNkOSISM7xzids0CM2Ts89YHMUisRAKsrByCkzH5
         xQYTf55l+ltnxizDZONfLT370yQF2CH/HUFt15LVqISjT+MFcOBAuxSPBom9ulK6QT2Q
         nY8ScJEpT4T+OyfmD0bJUBShNKMvmsG/bDJL2on75EXeknLzXqcHdMTsnyObh8zSPjt2
         eI8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YBMGzFIEHIQ7zv+jwc9v87XTUsS+NaVoQ1+r7qeHMU0=;
        b=c75bZtDN8EWhxTXtjDRSOzNSRz8OwClmZFLlC3YF0TL6Eja5GdmlJteshfjrfBaurw
         FZixLANIhYXht/1FJ/lAsw6QDn69NlwQmoVddjhR3NuUtvQGA9j5fJNjWTXNXgOQAhkg
         WpsdRTELtULUKv3EB8ZUvgyTK1xy8nv2kRtyssUM5wbZz4/rZrIio/wEcMapceufSz8c
         6HGsHtC5eqroBcgW+UWtx0giLSlH1EWKgGtsx8emZAP3h5UjDqxcUU4EKoEwyH2KW7/c
         +hBwQevb8JRzy+2DpluiwyzQIru57QxAkQibEfuW5QUrX1SpQvyySncVvO3Zb8EVjaWp
         nFLg==
X-Gm-Message-State: APjAAAVAiwvLmWRk9A7W5oo2dQMA+QcqE3WHkiBvIo65n/xTrjZRnp5M
        yiBmAd7LLxNJtMdaT1QqQjoosw==
X-Google-Smtp-Source: APXvYqwzyvJ/CENiAa1enYYEUkpI981sn+aj1XtJn7/p5P9NvQVymeZQ1Mv9eb4/SSoNO84bqu4fwA==
X-Received: by 2002:adf:d4c6:: with SMTP id w6mr12033156wrk.65.1551696840245;
        Mon, 04 Mar 2019 02:54:00 -0800 (PST)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id n2sm5915996wrq.58.2019.03.04.02.53.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Mar 2019 02:53:59 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     jbrunet@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH] clk: g12a-aoclk: re-export CLKID_AO_SAR_ADC_SEL clock id
Date:   Mon,  4 Mar 2019 11:53:58 +0100
Message-Id: <20190304105358.4987-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When submitted v2 of the G12A AO-CLK IDs, the SAR_ADC_SEL ID was moved
to the internal non-exported bindings, but this clock is necessary and
mandatory for the SAR ADC bindings.

Export it back to the public bindings.

Fixes: be3d960b0aeb ("dt-bindings: clk: add G12A AO Clock and Reset Bindings")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/clk/meson/g12a-aoclk.h          | 1 -
 include/dt-bindings/clock/g12a-aoclkc.h | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/meson/g12a-aoclk.h b/drivers/clk/meson/g12a-aoclk.h
index 04b0d5506641..666b4493822c 100644
--- a/drivers/clk/meson/g12a-aoclk.h
+++ b/drivers/clk/meson/g12a-aoclk.h
@@ -16,7 +16,6 @@
  * to expose, such as the internal muxes and dividers of composite clocks,
  * will remain defined here.
  */
-#define CLKID_AO_SAR_ADC_SEL	16
 #define CLKID_AO_SAR_ADC_DIV	17
 #define CLKID_AO_CTS_OSCIN	19
 #define CLKID_AO_32K_PRE	20
diff --git a/include/dt-bindings/clock/g12a-aoclkc.h b/include/dt-bindings/clock/g12a-aoclkc.h
index 8db01ffbeb06..5ac66a2eee0f 100644
--- a/include/dt-bindings/clock/g12a-aoclkc.h
+++ b/include/dt-bindings/clock/g12a-aoclkc.h
@@ -26,6 +26,7 @@
 #define CLKID_AO_M4_FCLK	13
 #define CLKID_AO_M4_HCLK	14
 #define CLKID_AO_CLK81		15
+#define CLKID_AO_SAR_ADC_SEL	16
 #define CLKID_AO_SAR_ADC_CLK	18
 #define CLKID_AO_32K		23
 #define CLKID_AO_CEC		27
-- 
2.20.1

