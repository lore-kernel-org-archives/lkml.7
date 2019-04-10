Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CA6C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 07:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91F412083E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 07:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729075AbfDJHsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 03:48:37 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48443 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbfDJHsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 03:48:35 -0400
Received: from mail-pf1-f199.google.com ([209.85.210.199])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hE7x2-0003af-4Q
        for linux-kernel@vger.kernel.org; Wed, 10 Apr 2019 07:47:20 +0000
Received: by mail-pf1-f199.google.com with SMTP id s26so1131179pfm.18
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 00:47:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ViMjY7PFbqRtxvpgQpNuM4u1Ocd6CPy/4jR+WCCjcQQ=;
        b=UI16bfxT0ZGaH1v82mC5ifOwpH3T5CzfhxligJocx6GpiXgoTP8oRZklgasI0w3tLC
         juqCYFV1f5WpD818JL6Dvnt2TRHEoPTTkH+br2NTfv77fCyhpyqsG1f/mv13lramxYMG
         GoU7Bb//lcKsLDd3rkjUl16ZatrLv1WBiZ5u7gABbnQeABNCbNNk0XmBVe83irIAm7YJ
         Tr6HCi3Pf5HTqGSvT0wBEK5gHOfYwaiUhMDbcOxPDscV70AAmbmYKQfB9KFK/I3zbaaF
         whISw3h3DI+v/onq8UKOzRzOYVEVgAHUFdyXwpuE4LgyrpPM8iOCt7sbgo16nWDHovxp
         bvRg==
X-Gm-Message-State: APjAAAUmEwx54YIJpzSSmZKoeRkvDBUvCUPISNLePHYeiDB8BNx4DnKq
        hCuP1ShNkOb9BKymNUy+Hfd7jGBjIoUtjiv8FnQie9arc3UQ6Odu5tZtcWWY9tFN3sk25Ac3lPX
        XzwTFkxrQkFln0j7kVmOxXXFcRx17KbQwD05rCzY+vA==
X-Received: by 2002:a17:902:9341:: with SMTP id g1mr4301962plp.81.1554882438549;
        Wed, 10 Apr 2019 00:47:18 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzMnIivDerv4p4wTPPZ5qt77UOPCDk7AwcUdrBlIpkPw7scZlFBV9jwyBMrrOP9qWCSZh86nA==
X-Received: by 2002:a17:902:9341:: with SMTP id g1mr4301928plp.81.1554882438035;
        Wed, 10 Apr 2019 00:47:18 -0700 (PDT)
Received: from 2001-b011-380f-14b9-2457-7651-7496-9966.dynamic-ip6.hinet.net (2001-b011-380f-14b9-2457-7651-7496-9966.dynamic-ip6.hinet.net. [2001:b011:380f:14b9:2457:7651:7496:9966])
        by smtp.gmail.com with ESMTPSA id a8sm59129305pfo.144.2019.04.10.00.47.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 00:47:17 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH] misc: rtsx: Fixed rts5260 power saving parameter and sd
 glitch
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20190402085607.32165-1-ricky_wu@realtek.com>
Date:   Wed, 10 Apr 2019 15:47:14 +0800
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <9B165235-7B33-44C1-80C5-49E28E9873A8@canonical.com>
References: <20190402085607.32165-1-ricky_wu@realtek.com>
To:     =?utf-8?B?5ZCz5piK5r6EIFJpY2t5?= <ricky_wu@realtek.com>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at 16:56, ricky_wu@realtek.com wrote:

> From: RickyWu <ricky_wu@realtek.com>
>
> this patch fixes rts5260 power saving parameter
> make power saving function work on L1.1, L1.2
>
> Signed-off-by: RickyWu <ricky_wu@realtek.com>
> ---
>  drivers/misc/cardreader/rts5260.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/misc/cardreader/rts5260.c  
> b/drivers/misc/cardreader/rts5260.c
> index da22bcb62b04..b510d3f46587 100644
> --- a/drivers/misc/cardreader/rts5260.c
> +++ b/drivers/misc/cardreader/rts5260.c
> @@ -195,7 +195,7 @@ static int sd_set_sample_push_timing_sd30(struct  
> rtsx_pcr *pcr)
>  		| SD_ASYNC_FIFO_NOT_RST, SD_30_MODE | SD_ASYNC_FIFO_NOT_RST);
>  	rtsx_pci_write_register(pcr, CLK_CTL, CLK_LOW_FREQ, CLK_LOW_FREQ);
>  	rtsx_pci_write_register(pcr, CARD_CLK_SOURCE, 0xFF,
> -			CRC_VAR_CLK0 | SD30_FIX_CLK | SAMPLE_VAR_CLK1);
> +		CRC_VAR_CLK0 | SD30_FIX_CLK | SAMPLE_VAR_CLK1);

Just a nit, seems to be an unnecessary change.

>  	rtsx_pci_write_register(pcr, CLK_CTL, CLK_LOW_FREQ, 0);
>
>  	return 0;
> @@ -238,8 +238,8 @@ static int rts5260_card_power_on(struct rtsx_pcr  
> *pcr, int card)
>  	/* Reset SD_CFG3 register */
>  	rtsx_pci_write_register(pcr, SD_CFG3, SD30_CLK_END_EN, 0);
>  	rtsx_pci_write_register(pcr, REG_SD_STOP_SDCLK_CFG,
> -			SD30_CLK_STOP_CFG_EN | SD30_CLK_STOP_CFG1 |
> -			SD30_CLK_STOP_CFG0, 0);
> +				SD30_CLK_STOP_CFG_EN | SD30_CLK_STOP_CFG1 |
> +				SD30_CLK_STOP_CFG0, 0);

Ditto.

>
>  	rtsx_pci_write_register(pcr, REG_PRE_RW_MODE, EN_INFINITE_MODE, 0);
>
> @@ -315,12 +315,12 @@ static void rts5260_init_ocp(struct rtsx_pcr *pcr)
>
>
>  		rtsx_pci_write_register(pcr, RTS5260_DVCC_CTRL,
> -				RTS5260_DVCC_OCP_THD_MASK,
> -				option->sd_800mA_ocp_thd);
> +					RTS5260_DVCC_OCP_THD_MASK,
> +					option->sd_800mA_ocp_thd);

Ditto.

>
>  		rtsx_pci_write_register(pcr, RTS5260_DV331812_CFG,
> -				RTS5260_DV331812_OCP_THD_MASK,
> -				RTS5260_DV331812_OCP_THD_270);
> +					RTS5260_DV331812_OCP_THD_MASK,
> +					RTS5260_DV331812_OCP_THD_270);

Ditto.

That said, the patch works,
Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

>
>  		mask = SD_OCP_GLITCH_MASK;
>  		val = pcr->hw_param.ocp_glitch;
> @@ -451,6 +451,7 @@ static void rts5260_pwr_saving_setting(struct  
> rtsx_pcr *pcr)
>  	lss_l1_2 = rtsx_check_dev_flag(pcr, ASPM_L1_2_EN)
>  			| rtsx_check_dev_flag(pcr, PM_L1_2_EN);
>
> +	rtsx_pci_write_register(pcr, ASPM_FORCE_CTL, 0xFF, 0);
>  	if (lss_l1_2) {
>  		pcr_dbg(pcr, "Set parameters for L1.2.");
>  		rtsx_pci_write_register(pcr, PWR_GLOBAL_CTRL,
> @@ -573,10 +574,10 @@ static int rts5260_extra_init_hw(struct rtsx_pcr  
> *pcr)
>  	 * to drive low, and we forcibly request clock.
>  	 */
>  	if (option->force_clkreq_0)
> -		rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, PETXCFG,
> +		rtsx_pci_write_register(pcr, PETXCFG,
>  				 FORCE_CLKREQ_DELINK_MASK, FORCE_CLKREQ_LOW);
>  	else
> -		rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, PETXCFG,
> +		rtsx_pci_write_register(pcr, PETXCFG,
>  				 FORCE_CLKREQ_DELINK_MASK, FORCE_CLKREQ_HIGH);
>
>  	return 0;
> @@ -704,7 +705,7 @@ void rts5260_init_params(struct rtsx_pcr *pcr)
>  	option->ocp_en = 1;
>  	if (option->ocp_en)
>  		hw_param->interrupt_en |= SD_OC_INT_EN;
> -	hw_param->ocp_glitch =  SDVIO_OCP_GLITCH_800U | SDVIO_OCP_GLITCH_800U;
> +	hw_param->ocp_glitch =  SD_OCP_GLITCH_100U | SDVIO_OCP_GLITCH_800U;
>  	option->sd_400mA_ocp_thd = RTS5260_DVCC_OCP_THD_550;
>  	option->sd_800mA_ocp_thd = RTS5260_DVCC_OCP_THD_970;
>  }
> -- 
> 2.17.1


