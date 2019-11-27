Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4EEC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 05:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A335220665
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 05:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JKElq1i+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfK0FFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 00:05:55 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40913 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbfK0FFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 00:05:54 -0500
Received: by mail-pg1-f196.google.com with SMTP id e17so10168814pgd.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 21:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XvNVu/uxQ2bwAvnJO0AtZKOZlH8bAr0gKirilLX2ElI=;
        b=JKElq1i+eF+N8Qbps3+sC4ksrLxP7ATD3oiUFKayQU/oYwpi+ub3XlRVW2euzGDCon
         LKw7Lr4uQgj1TgWgs+ypsHjL+t9K8S4q/bITQRiiCRglBWzVdLpWqkVlu6ll3P+k8dwE
         hPH0k5d/35WuvqEWMz9WvyRBmZxPZHYV5eEBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XvNVu/uxQ2bwAvnJO0AtZKOZlH8bAr0gKirilLX2ElI=;
        b=OvqJH8PoEsKeHduLPbA7i9bfDxAkzdnfMTR5hU5FcnhzKU+z31YkgiWApMTCCjWWFZ
         yugYnhIKRqa8VmK6a6+W/bSJM10i2BH/uh42CDkpEMs4U0StnZWSGOU5kz3KG7CWXkjZ
         ht3tE2hq6W28eUspffmUEy9mcuQn7pyoNAn09lgXQBoOJ2fve+BBHrZRASarqVeQOAWn
         d6L0inIzuWschP13qEnvtYmbT9UUlPv3xXlXr0IU94s0TEnx1M1ek4OIAd51BkrYYADL
         HkSYlwoTrI5LzKT1pMJFH9xMCypb5DoUYj1kcIk6N+2laS4d46ejDyW3Ai9O3E7ZeMet
         nkBg==
X-Gm-Message-State: APjAAAXCvM3dkRzzffsiE3tdO9jUILYU/FlVJeLJ1PTLEaKd1MZ90JVI
        unjOMWaekjTAhR/Ft8SPUe9OhyjN9kQ=
X-Google-Smtp-Source: APXvYqzNIOoWNIdF4TIclIoqbbUkrOfff9i5PScMFQZoXHRuSpYZU306XIQJMP0sSv4PKYobl9CkHA==
X-Received: by 2002:a62:e81a:: with SMTP id c26mr45445867pfi.246.1574831153560;
        Tue, 26 Nov 2019 21:05:53 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t8sm4829866pjr.25.2019.11.26.21.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 21:05:52 -0800 (PST)
Date:   Tue, 26 Nov 2019 21:05:51 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Phong Tran <tranmanphong@gmail.com>
Cc:     Larry.Finger@lwfinger.net, jakub.kicinski@netronome.com,
        kvalo@codeaurora.org, Wright.Feng@cypress.com,
        arend.vanspriel@broadcom.com, davem@davemloft.net,
        emmanuel.grumbach@intel.com, franky.lin@broadcom.com,
        johannes.berg@intel.com, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, luciano.coelho@intel.com,
        netdev@vger.kernel.org, p.figiel@camlintechnologies.com,
        pieter-paul.giesberts@broadcom.com, pkshih@realtek.com,
        rafal@milecki.pl, sara.sharon@intel.com,
        shahar.s.matityahu@intel.com, yhchuang@realtek.com,
        yuehaibing@huawei.com
Subject: Re: [Patch v2 4/4] rtlwifi: rtl_pci: Fix -Wcast-function-type
Message-ID: <201911262105.2EFD1E998@keescook>
References: <20191125150215.29263-1-tranmanphong@gmail.com>
 <20191126175529.10909-1-tranmanphong@gmail.com>
 <20191126175529.10909-5-tranmanphong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191126175529.10909-5-tranmanphong@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 12:55:29AM +0700, Phong Tran wrote:
> correct usage prototype of callback in tasklet_init().
> Report by https://github.com/KSPP/linux/issues/20
> 
> Signed-off-by: Phong Tran <tranmanphong@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/net/wireless/realtek/rtlwifi/pci.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtlwifi/pci.c b/drivers/net/wireless/realtek/rtlwifi/pci.c
> index f88d26535978..25335bd2873b 100644
> --- a/drivers/net/wireless/realtek/rtlwifi/pci.c
> +++ b/drivers/net/wireless/realtek/rtlwifi/pci.c
> @@ -1061,13 +1061,15 @@ static irqreturn_t _rtl_pci_interrupt(int irq, void *dev_id)
>  	return ret;
>  }
>  
> -static void _rtl_pci_irq_tasklet(struct ieee80211_hw *hw)
> +static void _rtl_pci_irq_tasklet(unsigned long data)
>  {
> +	struct ieee80211_hw *hw = (struct ieee80211_hw *)data;
>  	_rtl_pci_tx_chk_waitq(hw);
>  }
>  
> -static void _rtl_pci_prepare_bcn_tasklet(struct ieee80211_hw *hw)
> +static void _rtl_pci_prepare_bcn_tasklet(unsigned long data)
>  {
> +	struct ieee80211_hw *hw = (struct ieee80211_hw *)data;
>  	struct rtl_priv *rtlpriv = rtl_priv(hw);
>  	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
>  	struct rtl_mac *mac = rtl_mac(rtl_priv(hw));
> @@ -1193,10 +1195,10 @@ static void _rtl_pci_init_struct(struct ieee80211_hw *hw,
>  
>  	/*task */
>  	tasklet_init(&rtlpriv->works.irq_tasklet,
> -		     (void (*)(unsigned long))_rtl_pci_irq_tasklet,
> +		     _rtl_pci_irq_tasklet,
>  		     (unsigned long)hw);
>  	tasklet_init(&rtlpriv->works.irq_prepare_bcn_tasklet,
> -		     (void (*)(unsigned long))_rtl_pci_prepare_bcn_tasklet,
> +		     _rtl_pci_prepare_bcn_tasklet,
>  		     (unsigned long)hw);
>  	INIT_WORK(&rtlpriv->works.lps_change_work,
>  		  rtl_lps_change_work_callback);
> -- 
> 2.20.1
> 

-- 
Kees Cook
