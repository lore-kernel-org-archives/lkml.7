Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD69C5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 00:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3B3121E6B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 00:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="PfODrLPt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbfGCAqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 20:46:51 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33748 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbfGCAqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 20:46:50 -0400
Received: by mail-ot1-f68.google.com with SMTP id q20so532449otl.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 17:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y8CM/kRSfMkCLm6zorYMm+jmWg0Fr4K0UKURUwHLiI0=;
        b=PfODrLPtL/UekUDd5MyivTx7mO9uIfNsXn1/AL0i36O2i27oA1cIPzJin/uG0IzLpt
         S5Xx4hNZq+KvGLbjNVEp6xTRbGAEhi4yUzsW8Ess3o3NKkAOE95F2vOSdyhlEcznDyvv
         xWIqWX+5HZ4QLRhxnRt7fzGhBZa4c+Ajk0dju9VV38wAzvIA9M8anMy41hE5CJCzvwBg
         c5+JnLVr/aQTZoX0A+1JjZ4QhYcpUFm1qVW/f/D+wGe/TmQIsuVjaKeb/c3hSHeL4/rQ
         ufoupQW/yrA97DAebmIYhmreBqQP+BMggZbsvGxPifIVEyoan8dMPhjTceDK9vkatgAb
         W4og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y8CM/kRSfMkCLm6zorYMm+jmWg0Fr4K0UKURUwHLiI0=;
        b=h/p4P/nL4atA09pGDbnVvmL3njNVvf7880wfxR+Wp5/SFoUswiDwypGKD98luCisEJ
         fwiMRGmPOZ6f3/olfJorcsE+TCs4IHXKgyQmaxr30/UniXVfGYA1Zeq4RZ1S1Qb/AJLQ
         cEph1mO/CVnmykCUArVVm2tLz5yLRXoj8+0Zu4ezrjdComgZDWC7WFQh2IQZWK8w5Xwf
         gP5UsFYuvX/MFF94qVEfK6mcYwerMQ40GKj3WOeMMonouy0Y6X+niYqnHB1CMuYHhbJE
         ZhyMve26IgIEo/zly9wWljV2/c5aLYllX2LQKNOY3/C9CWqSIrhO/UpYX+oCcpKf44KN
         XQEg==
X-Gm-Message-State: APjAAAUCo+A/z9h2xDe55LeV2WyAyt4TbabGIVUy76gXBBJU3X6qz1n/
        Io02aXwA3pXbwEff8HzVzpYq25B0zLALDrYqlepcvg==
X-Google-Smtp-Source: APXvYqxPGdi5M83frYcEZkzIV4wjd1HSnqegfLcqSwdA8d9Vo+sKThli7P7OnkwgIwXWNWYlTAlgfzSDd8+mXHOWQbM=
X-Received: by 2002:a9d:39a6:: with SMTP id y35mr27461252otb.81.1562111509160;
 Tue, 02 Jul 2019 16:51:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190701104705.18271-1-narmstrong@baylibre.com> <20190701104705.18271-7-narmstrong@baylibre.com>
In-Reply-To: <20190701104705.18271-7-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Wed, 3 Jul 2019 01:51:38 +0200
Message-ID: <CAFBinCD8aBVo-WTaKTe7JyxqFyd=cVXDzHpwED4dx=rUtE3Uig@mail.gmail.com>
Subject: Re: [RFC 06/11] soc: amlogic: clk-measure: Add support for SM1
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     jbrunet@baylibre.com, khilman@baylibre.com,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Mon, Jul 1, 2019 at 12:49 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Add the clk-measurer clocks IDs for the Amlogic SM1 SoC family.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/soc/amlogic/meson-clk-measure.c | 134 ++++++++++++++++++++++++
>  1 file changed, 134 insertions(+)
>
> diff --git a/drivers/soc/amlogic/meson-clk-measure.c b/drivers/soc/amlogic/meson-clk-measure.c
> index f09b404b39d3..e32e97613000 100644
> --- a/drivers/soc/amlogic/meson-clk-measure.c
> +++ b/drivers/soc/amlogic/meson-clk-measure.c
> @@ -357,6 +357,136 @@ static struct meson_msr_id clk_msr_g12a[CLK_MSR_MAX] = {
>         CLK_MSR_ID(122, "audio_pdm_dclk"),
>  };
>
> +static struct meson_msr_id clk_msr_sm1[CLK_MSR_MAX] = {
> +       CLK_MSR_ID(0, "ring_osc_out_ee_0"),
> +       CLK_MSR_ID(1, "ring_osc_out_ee_1"),
> +       CLK_MSR_ID(2, "ring_osc_out_ee_2"),
> +       CLK_MSR_ID(3, "ring_osc_out_ee_3"),
> +       CLK_MSR_ID(4, "gp0_pll"),
> +       CLK_MSR_ID(5, "gp1_pll"),
> +       CLK_MSR_ID(6, "enci"),
> +       CLK_MSR_ID(7, "clk81"),
> +       CLK_MSR_ID(8, "encp"),
> +       CLK_MSR_ID(9, "encl"),
> +       CLK_MSR_ID(10, "vdac"),
> +       CLK_MSR_ID(11, "eth_tx"),
> +       CLK_MSR_ID(12, "hifi_pll"),
> +       CLK_MSR_ID(13, "mod_tcon"),
> +       CLK_MSR_ID(14, "fec_0"),
> +       CLK_MSR_ID(15, "fec_1"),
> +       CLK_MSR_ID(16, "fec_2"),
> +       CLK_MSR_ID(17, "sys_pll_div16"),
> +       CLK_MSR_ID(18, "sys_cpu_div16"),
> +       CLK_MSR_ID(19, "lcd_an_ph2"),
> +       CLK_MSR_ID(20, "rtc_osc_out"),
> +       CLK_MSR_ID(21, "lcd_an_ph3"),
> +       CLK_MSR_ID(22, "eth_phy_ref"),
> +       CLK_MSR_ID(23, "mpll_50m"),
> +       CLK_MSR_ID(24, "eth_125m"),
> +       CLK_MSR_ID(25, "eth_rmii"),
> +       CLK_MSR_ID(26, "sc_int"),
> +       CLK_MSR_ID(27, "in_mac"),
> +       CLK_MSR_ID(28, "sar_adc"),
> +       CLK_MSR_ID(29, "pcie_inp"),
> +       CLK_MSR_ID(30, "pcie_inn"),
> +       CLK_MSR_ID(31, "mpll_test_out"),
> +       CLK_MSR_ID(32, "vdec"),
> +       CLK_MSR_ID(34, "eth_mpll_50m"),
> +       CLK_MSR_ID(35, "mali"),
> +       CLK_MSR_ID(36, "hdmi_tx_pixel"),
> +       CLK_MSR_ID(37, "cdac"),
> +       CLK_MSR_ID(38, "vdin_meas"),
> +       CLK_MSR_ID(39, "bt656"),
> +       CLK_MSR_ID(40, "arm_ring_osc_out_4"),
> +       CLK_MSR_ID(41, "eth_rx_or_rmii"),
> +       CLK_MSR_ID(42, "mp0_out"),
> +       CLK_MSR_ID(43, "fclk_div5"),
> +       CLK_MSR_ID(44, "pwm_b"),
> +       CLK_MSR_ID(45, "pwm_a"),
> +       CLK_MSR_ID(46, "vpu"),
> +       CLK_MSR_ID(47, "ddr_dpll_pt"),
> +       CLK_MSR_ID(48, "mp1_out"),
> +       CLK_MSR_ID(49, "mp2_out"),
> +       CLK_MSR_ID(50, "mp3_out"),
> +       CLK_MSR_ID(51, "sd_emmc_c"),
> +       CLK_MSR_ID(52, "sd_emmc_b"),
> +       CLK_MSR_ID(53, "sd_emmc_a"),
> +       CLK_MSR_ID(54, "vpu_clkc"),
> +       CLK_MSR_ID(55, "vid_pll_div_out"),
> +       CLK_MSR_ID(56, "wave420l_a"),
> +       CLK_MSR_ID(57, "wave420l_c"),
> +       CLK_MSR_ID(58, "wave420l_b"),
> +       CLK_MSR_ID(59, "hcodec"),
> +       CLK_MSR_ID(40, "arm_ring_osc_out_5"),
is this index 40 or 60?

> +       CLK_MSR_ID(61, "gpio_msr"),
> +       CLK_MSR_ID(62, "hevcb"),
> +       CLK_MSR_ID(63, "dsi_meas"),
> +       CLK_MSR_ID(64, "spicc_1"),
> +       CLK_MSR_ID(65, "spicc_0"),
> +       CLK_MSR_ID(66, "vid_lock"),
> +       CLK_MSR_ID(67, "dsi_phy"),
> +       CLK_MSR_ID(68, "hdcp22_esm"),
> +       CLK_MSR_ID(69, "hdcp22_skp"),
> +       CLK_MSR_ID(70, "pwm_f"),
> +       CLK_MSR_ID(71, "pwm_e"),
> +       CLK_MSR_ID(72, "pwm_d"),
> +       CLK_MSR_ID(73, "pwm_c"),
> +       CLK_MSR_ID(74, "arm_ring_osc_out_6"),
> +       CLK_MSR_ID(75, "hevcf"),
> +       CLK_MSR_ID(74, "arm_ring_osc_out_7"),
is this index 74 or 76?
