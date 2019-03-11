Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0ADC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 16:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BF2D2084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 16:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=nelint.com header.i=@nelint.com header.b="bRMJv/E1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbfCKQCH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 12:02:07 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33916 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727710AbfCKQCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 12:02:04 -0400
Received: by mail-pg1-f193.google.com with SMTP id v12so1377115pgq.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 09:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nelint.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aLbPgAA+etD+gVIikE6jcQm2hwH4Kj7w39uBmNfKmfs=;
        b=bRMJv/E1uKenUSRolO/ar+op7wbn/JKxedIWqdeVrP1ZDH85qRVViKRAECYPVk7gwI
         PIJ00GYY0+wvCfCznANEitzuKC3vj6sF6RQzRX7kmc0sw/NUZGo5pVV3JJokA6tbqTUw
         TaKG5whVTenX+t8yblTwaMiKqv8jJf6mkBA9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aLbPgAA+etD+gVIikE6jcQm2hwH4Kj7w39uBmNfKmfs=;
        b=aLZ0iEverRD2jML/qj6tI5xnRklvdrjNnveEMB4Zg4S7UwXj4N2xzpWwmYiHFunhM5
         oWjpphj+hx9DsTbB4/j/f0NRxrSSRZAafqY+jnWiBYY7ghjrTXw24O3KrcQW51axJ9hP
         b/PLr1qg6Hbntna7UIJW3jEuSQ6A0P7JEBnM7JT32VzdJ6aJy4w//L7r+Sss9A3/3dVI
         Y15Pma8u5gWE9ksmEjKOfvgkhOSGC9T1XAseEjPAOlUYlUmTTtKZePERus5oB3KwzO64
         IiZLf381yjHOVAZ2ShQbn7XkjgZ8Gtc+jI55DhQLOmJS/Sqz/v0o6PVpkvlHOgCJh40h
         RloA==
X-Gm-Message-State: APjAAAUifRa5rgLwZZdB8uiyIN8mCpmkRyI1Kh+t4+rqqtUoz7aGIOjA
        utb1x/dybVYApqgG5Uny1OE9Aw==
X-Google-Smtp-Source: APXvYqynycQ/6hVg5WAycr7Ltu7b0uLUGFsLaODzbeZ41SnzYK6pCml+Y83cDZqloO2cZb/OGYJ+aw==
X-Received: by 2002:a62:38d4:: with SMTP id f203mr33287862pfa.143.1552320123317;
        Mon, 11 Mar 2019 09:02:03 -0700 (PDT)
Received: from localhost.localdomain ([2600:8800:1301:2190:cc32:ad00:b1c0:818c])
        by smtp.gmail.com with ESMTPSA id v8sm8319722pfm.174.2019.03.11.09.02.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 09:02:02 -0700 (PDT)
From:   Eric Nelson <eric@nelint.com>
To:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     anson.huang@nxp.com, colin.didier@devialet.com, festevam@gmail.com,
        kernel@pengutronix.de, l.stach@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        mturquette@baylibre.com, robh+dt@kernel.org,
        s.hauer@pengutronix.de, sboyd@kernel.org, shawnguo@kernel.org,
        tiny.windzz@gmail.com, Eric Nelson <eric@nelint.com>
Subject: [V2 1/2] clk: imx6q: remove unsupported pll4_audio_div
Date:   Mon, 11 Mar 2019 08:59:56 -0700
Message-Id: <1552319997-24622-2-git-send-email-eric@nelint.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1552319997-24622-1-git-send-email-eric@nelint.com>
References: <1552304271.2453.12.camel@pengutronix.de>
 <1552319997-24622-1-git-send-email-eric@nelint.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pll4_audio_div attempted to reflect one bit of a two-bit
divisor (AUDIO_DIV_LSB) in the CCM_ANALOG_MISC2 register.

Unfortunately, this divisor is non-functional at least on the
latest silicon revisions and has been removed from the reference
manual.

This is discussed in this NXP Community thread:

    https://community.nxp.com/thread/462806

Remove the definition of pll4_audio_div to reflect this and
reparent the ssi, cko1, and ESAI/ASRC/SPDIF clocks to the
pll4_post_div clock.

Signed-off-by: Eric Nelson <eric@nelint.com>
---
Changes in v2:
 * Keep numbering of clock array as suggested by Lucas Stach
 * Sent as series with updates to several device tree files
 * Expanded cc list to include maintainers of device trees

 drivers/clk/imx/clk-imx6q.c               |  7 +++----
 include/dt-bindings/clock/imx6qdl-clock.h | 10 +++++++++-
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
index 708e7c5..56d6ebb 100644
--- a/drivers/clk/imx/clk-imx6q.c
+++ b/drivers/clk/imx/clk-imx6q.c
@@ -32,7 +32,7 @@ static const char *periph2_clk2_sels[]	= { "pll3_usb_otg", "pll2_bus", };
 static const char *periph_sels[]	= { "periph_pre", "periph_clk2", };
 static const char *periph2_sels[]	= { "periph2_pre", "periph2_clk2", };
 static const char *axi_sels[]		= { "periph", "pll2_pfd2_396m", "periph", "pll3_pfd1_540m", };
-static const char *audio_sels[]	= { "pll4_audio_div", "pll3_pfd2_508m", "pll3_pfd3_454m", "pll3_usb_otg", };
+static const char *audio_sels[]	= { "pll4_post_div", "pll3_pfd2_508m", "pll3_pfd3_454m", "pll3_usb_otg", };
 static const char *gpu_axi_sels[]	= { "axi", "ahb", };
 static const char *pre_axi_sels[]	= { "axi", "ahb", };
 static const char *gpu2d_core_sels[]	= { "axi", "pll3_usb_otg", "pll2_pfd0_352m", "pll2_pfd2_396m", };
@@ -52,7 +52,7 @@ static const char *ipu2_di0_sels_2[]	= { "ipu2_di0_pre", "dummy", "dummy", "ldb_
 static const char *ipu2_di1_sels_2[]	= { "ipu2_di1_pre", "dummy", "dummy", "ldb_di0_podf", "ldb_di1_podf", };
 static const char *hsi_tx_sels[]	= { "pll3_120m", "pll2_pfd2_396m", };
 static const char *pcie_axi_sels[]	= { "axi", "ahb", };
-static const char *ssi_sels[]		= { "pll3_pfd2_508m", "pll3_pfd3_454m", "pll4_audio_div", };
+static const char *ssi_sels[]		= { "pll3_pfd2_508m", "pll3_pfd3_454m", "pll4_post_div", };
 static const char *usdhc_sels[]	= { "pll2_pfd2_396m", "pll2_pfd0_352m", };
 static const char *enfc_sels[]	= { "pll2_pfd0_352m", "pll2_bus", "pll3_usb_otg", "pll2_pfd2_396m", };
 static const char *enfc_sels_2[] = {"pll2_pfd0_352m", "pll2_bus", "pll3_usb_otg", "pll2_pfd2_396m", "pll3_pfd3_454m", "dummy", };
@@ -66,7 +66,7 @@ static const char *ecspi_sels[] = { "pll3_60m", "osc", };
 static const char *can_sels[] = { "pll3_60m", "osc", "pll3_80m", };
 static const char *cko1_sels[]	= { "pll3_usb_otg", "pll2_bus", "pll1_sys", "pll5_video_div",
 				    "video_27m", "axi", "enfc", "ipu1_di0", "ipu1_di1", "ipu2_di0",
-				    "ipu2_di1", "ahb", "ipg", "ipg_per", "ckil", "pll4_audio_div", };
+				    "ipu2_di1", "ahb", "ipg", "ipg_per", "ckil", "pll4_post_div", };
 static const char *cko2_sels[] = {
 	"mmdc_ch0_axi", "mmdc_ch1_axi", "usdhc4", "usdhc1",
 	"gpu2d_axi", "dummy", "ecspi_root", "gpu3d_axi",
@@ -607,7 +607,6 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 	}
 
 	clk[IMX6QDL_CLK_PLL4_POST_DIV] = clk_register_divider_table(NULL, "pll4_post_div", "pll4_audio", CLK_SET_RATE_PARENT, base + 0x70, 19, 2, 0, post_div_table, &imx_ccm_lock);
-	clk[IMX6QDL_CLK_PLL4_AUDIO_DIV] = clk_register_divider(NULL, "pll4_audio_div", "pll4_post_div", CLK_SET_RATE_PARENT, base + 0x170, 15, 1, 0, &imx_ccm_lock);
 	clk[IMX6QDL_CLK_PLL5_POST_DIV] = clk_register_divider_table(NULL, "pll5_post_div", "pll5_video", CLK_SET_RATE_PARENT, base + 0xa0, 19, 2, 0, post_div_table, &imx_ccm_lock);
 	clk[IMX6QDL_CLK_PLL5_VIDEO_DIV] = clk_register_divider_table(NULL, "pll5_video_div", "pll5_post_div", CLK_SET_RATE_PARENT, base + 0x170, 30, 2, 0, video_div_table, &imx_ccm_lock);
 
diff --git a/include/dt-bindings/clock/imx6qdl-clock.h b/include/dt-bindings/clock/imx6qdl-clock.h
index b3cef29..34bb14d 100644
--- a/include/dt-bindings/clock/imx6qdl-clock.h
+++ b/include/dt-bindings/clock/imx6qdl-clock.h
@@ -213,7 +213,15 @@
 #define IMX6QDL_CLK_CKO2			200
 #define IMX6QDL_CLK_CKO				201
 #define IMX6QDL_CLK_VDOA			202
-#define IMX6QDL_CLK_PLL4_AUDIO_DIV		203
+
+/* The PLL4_AUDIO_DIV divider only appeared in
+ * early versions of the reference manual.
+ *
+ * Renamed to _BROKEN to prevent inadvertent use,
+ * but reserved the array slot to maintain DT binary
+ * compatibility.
+ */
+#define IMX6QDL_CLK_PLL4_AUDIO_DIV_BROKEN	203
 #define IMX6QDL_CLK_LVDS1_SEL			204
 #define IMX6QDL_CLK_LVDS2_SEL			205
 #define IMX6QDL_CLK_LVDS1_GATE			206
-- 
2.7.4

