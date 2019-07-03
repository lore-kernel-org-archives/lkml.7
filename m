Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3ABFC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 11:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B114B218A3
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 11:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="008PJMdw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbfGCLo7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 07:44:59 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52792 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfGCLo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 07:44:59 -0400
Received: by mail-wm1-f67.google.com with SMTP id s3so1875275wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 04:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=xRM3DVh9DsuQz16USxYQS7Smf9h6SGJQ053F4dMRpRU=;
        b=008PJMdwKFL2Oxdt2I5iMPhyZ3qVvnb5aME0kmmtc0GTVVxzy1c8mMdK1Ev5ILA5O2
         55KzKDHcgmyPERgyfBQdCIpl7i34/xMgWGtyI1n2GDG5u8+qzUceCoCaRL10e+8gVihE
         QBSlmpptkADAqWWgyTOn8qpsNjo1ivBNFObhwjr5QQxRA5YbPIUoB0ysw824tvFNqv3g
         ABqJNiB1kB0PaDZew2/r3ZzQYBG56gBJ3INrF4e4EJkbYQaGU9FC6OY60lP0tU/qfhWi
         8nsbvzCSQjI3oY4gVKcRFtifPn+RALASmAkRkh9oGFuomkGj50d/13S4V+kk+imEbSBe
         g8OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=xRM3DVh9DsuQz16USxYQS7Smf9h6SGJQ053F4dMRpRU=;
        b=Io4qYPxvVUQ8pg+ozDgg3KZ7JlZWHECs9NYKnuMFVqBalb49xWj/kRAh1ojc/RblTN
         e/b49TDkCjw1/uXDk9yEf+QZkp7UgBawBo+pzeER4a/vAFEUgl1f8+y37S4kQTJiP7DT
         NTHq3HSirUbwX3tP5g8KfoZbB5dQO1mtEcDjplEPrpAFWwhLPGvUOaqzDjDMc2yYZZPe
         2Oc1zwn69tzZ+61FMCl1Kw6/FXpG+UpR1xnTGVFX7JS3jBDZXEu3glfD/CYmT7rK89s/
         e4iqahVChuMaGin27Bhr/Ly1m0lC7Jaqh31Kl57kodzXlgZih4oNWdqwgTdTUn3dajlj
         hvSg==
X-Gm-Message-State: APjAAAV4JDK80vhqMOihlpvPWKuAD933DsGUKKSVZZ1U2/EJkXFJBcPX
        JXlgCQ5wOmiFE1ey3BY1kfEEeEaEkO8=
X-Google-Smtp-Source: APXvYqxDoWWv8HvVXmL+edDBfuGwhfZa/FRH6SaeQwpQNUT+YtGlMokLtVzi9wOEdoQLYaytnzb4NQ==
X-Received: by 2002:a1c:b707:: with SMTP id h7mr7699725wmf.45.1562154295737;
        Wed, 03 Jul 2019 04:44:55 -0700 (PDT)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id t63sm1870384wmt.6.2019.07.03.04.44.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 04:44:55 -0700 (PDT)
Subject: Re: [RFC 06/11] soc: amlogic: clk-measure: Add support for SM1
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     jbrunet@baylibre.com, khilman@baylibre.com,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20190701104705.18271-1-narmstrong@baylibre.com>
 <20190701104705.18271-7-narmstrong@baylibre.com>
 <CAFBinCD8aBVo-WTaKTe7JyxqFyd=cVXDzHpwED4dx=rUtE3Uig@mail.gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <eebfb5d6-21bf-f759-c74e-3eb7d04820e4@baylibre.com>
Date:   Wed, 3 Jul 2019 13:44:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAFBinCD8aBVo-WTaKTe7JyxqFyd=cVXDzHpwED4dx=rUtE3Uig@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/07/2019 01:51, Martin Blumenstingl wrote:
> Hi Neil,
> 
> On Mon, Jul 1, 2019 at 12:49 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> Add the clk-measurer clocks IDs for the Amlogic SM1 SoC family.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  drivers/soc/amlogic/meson-clk-measure.c | 134 ++++++++++++++++++++++++
>>  1 file changed, 134 insertions(+)
>>
>> diff --git a/drivers/soc/amlogic/meson-clk-measure.c b/drivers/soc/amlogic/meson-clk-measure.c
>> index f09b404b39d3..e32e97613000 100644
>> --- a/drivers/soc/amlogic/meson-clk-measure.c
>> +++ b/drivers/soc/amlogic/meson-clk-measure.c
>> @@ -357,6 +357,136 @@ static struct meson_msr_id clk_msr_g12a[CLK_MSR_MAX] = {
>>         CLK_MSR_ID(122, "audio_pdm_dclk"),
>>  };
>>
>> +static struct meson_msr_id clk_msr_sm1[CLK_MSR_MAX] = {
>> +       CLK_MSR_ID(0, "ring_osc_out_ee_0"),
>> +       CLK_MSR_ID(1, "ring_osc_out_ee_1"),
>> +       CLK_MSR_ID(2, "ring_osc_out_ee_2"),
>> +       CLK_MSR_ID(3, "ring_osc_out_ee_3"),
>> +       CLK_MSR_ID(4, "gp0_pll"),
>> +       CLK_MSR_ID(5, "gp1_pll"),
>> +       CLK_MSR_ID(6, "enci"),
>> +       CLK_MSR_ID(7, "clk81"),
>> +       CLK_MSR_ID(8, "encp"),
>> +       CLK_MSR_ID(9, "encl"),
>> +       CLK_MSR_ID(10, "vdac"),
>> +       CLK_MSR_ID(11, "eth_tx"),
>> +       CLK_MSR_ID(12, "hifi_pll"),
>> +       CLK_MSR_ID(13, "mod_tcon"),
>> +       CLK_MSR_ID(14, "fec_0"),
>> +       CLK_MSR_ID(15, "fec_1"),
>> +       CLK_MSR_ID(16, "fec_2"),
>> +       CLK_MSR_ID(17, "sys_pll_div16"),
>> +       CLK_MSR_ID(18, "sys_cpu_div16"),
>> +       CLK_MSR_ID(19, "lcd_an_ph2"),
>> +       CLK_MSR_ID(20, "rtc_osc_out"),
>> +       CLK_MSR_ID(21, "lcd_an_ph3"),
>> +       CLK_MSR_ID(22, "eth_phy_ref"),
>> +       CLK_MSR_ID(23, "mpll_50m"),
>> +       CLK_MSR_ID(24, "eth_125m"),
>> +       CLK_MSR_ID(25, "eth_rmii"),
>> +       CLK_MSR_ID(26, "sc_int"),
>> +       CLK_MSR_ID(27, "in_mac"),
>> +       CLK_MSR_ID(28, "sar_adc"),
>> +       CLK_MSR_ID(29, "pcie_inp"),
>> +       CLK_MSR_ID(30, "pcie_inn"),
>> +       CLK_MSR_ID(31, "mpll_test_out"),
>> +       CLK_MSR_ID(32, "vdec"),
>> +       CLK_MSR_ID(34, "eth_mpll_50m"),
>> +       CLK_MSR_ID(35, "mali"),
>> +       CLK_MSR_ID(36, "hdmi_tx_pixel"),
>> +       CLK_MSR_ID(37, "cdac"),
>> +       CLK_MSR_ID(38, "vdin_meas"),
>> +       CLK_MSR_ID(39, "bt656"),
>> +       CLK_MSR_ID(40, "arm_ring_osc_out_4"),
>> +       CLK_MSR_ID(41, "eth_rx_or_rmii"),
>> +       CLK_MSR_ID(42, "mp0_out"),
>> +       CLK_MSR_ID(43, "fclk_div5"),
>> +       CLK_MSR_ID(44, "pwm_b"),
>> +       CLK_MSR_ID(45, "pwm_a"),
>> +       CLK_MSR_ID(46, "vpu"),
>> +       CLK_MSR_ID(47, "ddr_dpll_pt"),
>> +       CLK_MSR_ID(48, "mp1_out"),
>> +       CLK_MSR_ID(49, "mp2_out"),
>> +       CLK_MSR_ID(50, "mp3_out"),
>> +       CLK_MSR_ID(51, "sd_emmc_c"),
>> +       CLK_MSR_ID(52, "sd_emmc_b"),
>> +       CLK_MSR_ID(53, "sd_emmc_a"),
>> +       CLK_MSR_ID(54, "vpu_clkc"),
>> +       CLK_MSR_ID(55, "vid_pll_div_out"),
>> +       CLK_MSR_ID(56, "wave420l_a"),
>> +       CLK_MSR_ID(57, "wave420l_c"),
>> +       CLK_MSR_ID(58, "wave420l_b"),
>> +       CLK_MSR_ID(59, "hcodec"),
>> +       CLK_MSR_ID(40, "arm_ring_osc_out_5"),
> is this index 40 or 60?

Exact it's 60, thanks for spotting

> 
>> +       CLK_MSR_ID(61, "gpio_msr"),
>> +       CLK_MSR_ID(62, "hevcb"),
>> +       CLK_MSR_ID(63, "dsi_meas"),
>> +       CLK_MSR_ID(64, "spicc_1"),
>> +       CLK_MSR_ID(65, "spicc_0"),
>> +       CLK_MSR_ID(66, "vid_lock"),
>> +       CLK_MSR_ID(67, "dsi_phy"),
>> +       CLK_MSR_ID(68, "hdcp22_esm"),
>> +       CLK_MSR_ID(69, "hdcp22_skp"),
>> +       CLK_MSR_ID(70, "pwm_f"),
>> +       CLK_MSR_ID(71, "pwm_e"),
>> +       CLK_MSR_ID(72, "pwm_d"),
>> +       CLK_MSR_ID(73, "pwm_c"),
>> +       CLK_MSR_ID(74, "arm_ring_osc_out_6"),
>> +       CLK_MSR_ID(75, "hevcf"),
>> +       CLK_MSR_ID(74, "arm_ring_osc_out_7"),
> is this index 74 or 76?
> 

Exact, it's 76 !

Neil
