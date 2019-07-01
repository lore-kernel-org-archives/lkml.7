Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F40C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 10:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D79C7208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 10:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="k7J1KRmm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbfGAKr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 06:47:59 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38175 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727514AbfGAKrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 06:47:32 -0400
Received: by mail-wm1-f68.google.com with SMTP id s15so15357133wmj.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 03:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ece299ytvP7yN78Hs02gs2k+yzKLtb8C246cXyy/J10=;
        b=k7J1KRmmgFun4BA2i3oPlYksUUldqwyXSzFEhn00YyT8XIVG6XB+qXAU8Hi2QMZ4Z0
         7vOaind+maxmRIWY137zaYsHUcioYdfao9s6PLYT8Uwttz9DnHrDPH7Ux25iM2r325Ll
         Jbiz3btaa6V/PQgR3lZDwvVbKOPt4Z8dlTw2pA/rQrOsqKz5a1B4YiIshCzS9axDrrSF
         f+h4Cbngn/F4CIq5Shuni2vo0SFw6QC5kqbIYi26ZJuj+UsvWGGtyRKdRfFyAw6Ul0mA
         6pzxCsIVnE1YnlndNf8o0kZxiNa1wlF9s+SRh7W2zjdFQ4sxEJ1tuoa9V//6Dli37Sle
         o4CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ece299ytvP7yN78Hs02gs2k+yzKLtb8C246cXyy/J10=;
        b=Re+7aX3vCUewk5VLoHLLvEtbDxSXMr1qWwUL4bUcpnYZIAaVaJBuVA+nyRPrL05CuQ
         8HC5NTUb4JrktmWpusgDQlZTlPZfIG0zk0IpN55yBQAwPSacoblyBEXHe+L+s73n0qfW
         eRs9+KRG1FOqG/pVpa6TbUw/vNSgyWVSgDiNCGYPY//4Yclv3+1G72w7FsiZyuM/Uuwa
         Dk54r6eBGrSWGfF/joyZxrTh46/mS/ZU7syObXtoTlbfwmboHWDgFkjvXUplTrDcxoei
         bM2/tvvj9C07E834TDrMn9qiDXkU3lui+Lij5DXpUvj5BINyq8xqOzRc8rF7JQHWwf1x
         wqlg==
X-Gm-Message-State: APjAAAUlwS+IdrjTa6G0nZLvS9y9xCBXC7P6ZrxnRwU6N1NwZuQwzWtY
        qxkE3m5uHoJgurzMLFlmopNWExrAOrE=
X-Google-Smtp-Source: APXvYqzsGce5jNbvLbcHrXoHvxuJP3qpQf1e3M0Kf/Sn3O+drlZC31NhDKiyko0NuEJvs932xrzHsA==
X-Received: by 2002:a05:600c:2383:: with SMTP id m3mr16467107wma.20.1561978050501;
        Mon, 01 Jul 2019 03:47:30 -0700 (PDT)
Received: from localhost.localdomain (176-150-251-154.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id d24sm11658802wra.43.2019.07.01.03.47.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 01 Jul 2019 03:47:29 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     jbrunet@baylibre.com, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [RFC 06/11] soc: amlogic: clk-measure: Add support for SM1
Date:   Mon,  1 Jul 2019 12:47:00 +0200
Message-Id: <20190701104705.18271-7-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190701104705.18271-1-narmstrong@baylibre.com>
References: <20190701104705.18271-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the clk-measurer clocks IDs for the Amlogic SM1 SoC family.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/soc/amlogic/meson-clk-measure.c | 134 ++++++++++++++++++++++++
 1 file changed, 134 insertions(+)

diff --git a/drivers/soc/amlogic/meson-clk-measure.c b/drivers/soc/amlogic/meson-clk-measure.c
index f09b404b39d3..e32e97613000 100644
--- a/drivers/soc/amlogic/meson-clk-measure.c
+++ b/drivers/soc/amlogic/meson-clk-measure.c
@@ -357,6 +357,136 @@ static struct meson_msr_id clk_msr_g12a[CLK_MSR_MAX] = {
 	CLK_MSR_ID(122, "audio_pdm_dclk"),
 };
 
+static struct meson_msr_id clk_msr_sm1[CLK_MSR_MAX] = {
+	CLK_MSR_ID(0, "ring_osc_out_ee_0"),
+	CLK_MSR_ID(1, "ring_osc_out_ee_1"),
+	CLK_MSR_ID(2, "ring_osc_out_ee_2"),
+	CLK_MSR_ID(3, "ring_osc_out_ee_3"),
+	CLK_MSR_ID(4, "gp0_pll"),
+	CLK_MSR_ID(5, "gp1_pll"),
+	CLK_MSR_ID(6, "enci"),
+	CLK_MSR_ID(7, "clk81"),
+	CLK_MSR_ID(8, "encp"),
+	CLK_MSR_ID(9, "encl"),
+	CLK_MSR_ID(10, "vdac"),
+	CLK_MSR_ID(11, "eth_tx"),
+	CLK_MSR_ID(12, "hifi_pll"),
+	CLK_MSR_ID(13, "mod_tcon"),
+	CLK_MSR_ID(14, "fec_0"),
+	CLK_MSR_ID(15, "fec_1"),
+	CLK_MSR_ID(16, "fec_2"),
+	CLK_MSR_ID(17, "sys_pll_div16"),
+	CLK_MSR_ID(18, "sys_cpu_div16"),
+	CLK_MSR_ID(19, "lcd_an_ph2"),
+	CLK_MSR_ID(20, "rtc_osc_out"),
+	CLK_MSR_ID(21, "lcd_an_ph3"),
+	CLK_MSR_ID(22, "eth_phy_ref"),
+	CLK_MSR_ID(23, "mpll_50m"),
+	CLK_MSR_ID(24, "eth_125m"),
+	CLK_MSR_ID(25, "eth_rmii"),
+	CLK_MSR_ID(26, "sc_int"),
+	CLK_MSR_ID(27, "in_mac"),
+	CLK_MSR_ID(28, "sar_adc"),
+	CLK_MSR_ID(29, "pcie_inp"),
+	CLK_MSR_ID(30, "pcie_inn"),
+	CLK_MSR_ID(31, "mpll_test_out"),
+	CLK_MSR_ID(32, "vdec"),
+	CLK_MSR_ID(34, "eth_mpll_50m"),
+	CLK_MSR_ID(35, "mali"),
+	CLK_MSR_ID(36, "hdmi_tx_pixel"),
+	CLK_MSR_ID(37, "cdac"),
+	CLK_MSR_ID(38, "vdin_meas"),
+	CLK_MSR_ID(39, "bt656"),
+	CLK_MSR_ID(40, "arm_ring_osc_out_4"),
+	CLK_MSR_ID(41, "eth_rx_or_rmii"),
+	CLK_MSR_ID(42, "mp0_out"),
+	CLK_MSR_ID(43, "fclk_div5"),
+	CLK_MSR_ID(44, "pwm_b"),
+	CLK_MSR_ID(45, "pwm_a"),
+	CLK_MSR_ID(46, "vpu"),
+	CLK_MSR_ID(47, "ddr_dpll_pt"),
+	CLK_MSR_ID(48, "mp1_out"),
+	CLK_MSR_ID(49, "mp2_out"),
+	CLK_MSR_ID(50, "mp3_out"),
+	CLK_MSR_ID(51, "sd_emmc_c"),
+	CLK_MSR_ID(52, "sd_emmc_b"),
+	CLK_MSR_ID(53, "sd_emmc_a"),
+	CLK_MSR_ID(54, "vpu_clkc"),
+	CLK_MSR_ID(55, "vid_pll_div_out"),
+	CLK_MSR_ID(56, "wave420l_a"),
+	CLK_MSR_ID(57, "wave420l_c"),
+	CLK_MSR_ID(58, "wave420l_b"),
+	CLK_MSR_ID(59, "hcodec"),
+	CLK_MSR_ID(40, "arm_ring_osc_out_5"),
+	CLK_MSR_ID(61, "gpio_msr"),
+	CLK_MSR_ID(62, "hevcb"),
+	CLK_MSR_ID(63, "dsi_meas"),
+	CLK_MSR_ID(64, "spicc_1"),
+	CLK_MSR_ID(65, "spicc_0"),
+	CLK_MSR_ID(66, "vid_lock"),
+	CLK_MSR_ID(67, "dsi_phy"),
+	CLK_MSR_ID(68, "hdcp22_esm"),
+	CLK_MSR_ID(69, "hdcp22_skp"),
+	CLK_MSR_ID(70, "pwm_f"),
+	CLK_MSR_ID(71, "pwm_e"),
+	CLK_MSR_ID(72, "pwm_d"),
+	CLK_MSR_ID(73, "pwm_c"),
+	CLK_MSR_ID(74, "arm_ring_osc_out_6"),
+	CLK_MSR_ID(75, "hevcf"),
+	CLK_MSR_ID(74, "arm_ring_osc_out_7"),
+	CLK_MSR_ID(77, "rng_ring_osc_0"),
+	CLK_MSR_ID(78, "rng_ring_osc_1"),
+	CLK_MSR_ID(79, "rng_ring_osc_2"),
+	CLK_MSR_ID(80, "rng_ring_osc_3"),
+	CLK_MSR_ID(81, "vapb"),
+	CLK_MSR_ID(82, "ge2d"),
+	CLK_MSR_ID(83, "co_rx"),
+	CLK_MSR_ID(84, "co_tx"),
+	CLK_MSR_ID(85, "arm_ring_osc_out_8"),
+	CLK_MSR_ID(86, "arm_ring_osc_out_9"),
+	CLK_MSR_ID(87, "mipi_dsi_phy"),
+	CLK_MSR_ID(88, "cis2_adapt"),
+	CLK_MSR_ID(89, "hdmi_todig"),
+	CLK_MSR_ID(90, "hdmitx_sys"),
+	CLK_MSR_ID(91, "nna_core"),
+	CLK_MSR_ID(92, "nna_axi"),
+	CLK_MSR_ID(93, "vad"),
+	CLK_MSR_ID(94, "eth_phy_rx"),
+	CLK_MSR_ID(95, "eth_phy_pll"),
+	CLK_MSR_ID(96, "vpu_b"),
+	CLK_MSR_ID(97, "cpu_b_tmp"),
+	CLK_MSR_ID(98, "ts"),
+	CLK_MSR_ID(99, "arm_ring_osc_out_10"),
+	CLK_MSR_ID(100, "arm_ring_osc_out_11"),
+	CLK_MSR_ID(101, "arm_ring_osc_out_12"),
+	CLK_MSR_ID(102, "arm_ring_osc_out_13"),
+	CLK_MSR_ID(103, "arm_ring_osc_out_14"),
+	CLK_MSR_ID(104, "arm_ring_osc_out_15"),
+	CLK_MSR_ID(105, "arm_ring_osc_out_16"),
+	CLK_MSR_ID(106, "ephy_test"),
+	CLK_MSR_ID(107, "au_dac_g128x"),
+	CLK_MSR_ID(108, "audio_locker_out"),
+	CLK_MSR_ID(109, "audio_locker_in"),
+	CLK_MSR_ID(110, "audio_tdmout_c_sclk"),
+	CLK_MSR_ID(111, "audio_tdmout_b_sclk"),
+	CLK_MSR_ID(112, "audio_tdmout_a_sclk"),
+	CLK_MSR_ID(113, "audio_tdmin_lb_sclk"),
+	CLK_MSR_ID(114, "audio_tdmin_c_sclk"),
+	CLK_MSR_ID(115, "audio_tdmin_b_sclk"),
+	CLK_MSR_ID(116, "audio_tdmin_a_sclk"),
+	CLK_MSR_ID(117, "audio_resample"),
+	CLK_MSR_ID(118, "audio_pdm_sys"),
+	CLK_MSR_ID(119, "audio_spdifout_b"),
+	CLK_MSR_ID(120, "audio_spdifout"),
+	CLK_MSR_ID(121, "audio_spdifin"),
+	CLK_MSR_ID(122, "audio_pdm_dclk"),
+	CLK_MSR_ID(123, "audio_resampled"),
+	CLK_MSR_ID(124, "earcrx_pll"),
+	CLK_MSR_ID(125, "earcrx_pll_test"),
+	CLK_MSR_ID(126, "csi_phy0"),
+	CLK_MSR_ID(127, "csi2_data"),
+};
+
 static int meson_measure_id(struct meson_msr_id *clk_msr_id,
 			       unsigned int duration)
 {
@@ -545,6 +675,10 @@ static const struct of_device_id meson_msr_match_table[] = {
 		.compatible = "amlogic,meson-g12a-clk-measure",
 		.data = (void *)clk_msr_g12a,
 	},
+	{
+		.compatible = "amlogic,meson-sm1-clk-measure",
+		.data = (void *)clk_msr_sm1,
+	},
 	{ /* sentinel */ }
 };
 
-- 
2.21.0

