Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B021C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00E3F20857
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbfCTTm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 15:42:58 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43708 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbfCTTm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 15:42:58 -0400
Received: by mail-wr1-f65.google.com with SMTP id d17so4102533wre.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 12:42:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MW6nomkf8Lyg3u6hM52Ypxlyzf2mlUfZPFreMfGGt2g=;
        b=bEwnYoSWrV96KoQOBk8m/0j25OVj6Kfur3zUVqKTdSCuGC+1p+sYHFW7lkh5i2a1F7
         Odc6cKFyQ9t50xzlfNJVAt2b93TnPDsTWHwmX0K5H4KVlm68APkjewOqZRfvDyKZNJ70
         T/p4bjrCdOTuol+pmc/tdIVuzNBWVHJB/9I6ZTGT1j7mMgAkAM2zoNiw7wuTErAARe4v
         FePcSO87vySRNtLsOIeCb3rsN/Kfe8sgST5K+0aJ5leBfLXo9eRFkFS2XKkP7BhYJJtL
         v2rYkKo/auODJsOtQ+fAuMEkYOMF/duoPA5bJcvmQ4Us2Ra8Itu7V/XRVhE5F3Y9ZQ48
         sCXg==
X-Gm-Message-State: APjAAAX6k6dqGP2OPzomDNPQa4xaaK3zG8oYeItwZda07AFGEyUTOc7L
        viN8/DajSj4z02aoSxqDi+Vdj2IuCFg=
X-Google-Smtp-Source: APXvYqzVAVQMpbbP1zWCFGge/3TKEYtc+5HnoQJugwj+AbGQeQgs1ynhwS7sxGiP4uT5RNpQfb8o9w==
X-Received: by 2002:adf:f48f:: with SMTP id l15mr2498805wro.248.1553110975383;
        Wed, 20 Mar 2019 12:42:55 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id l4sm8370146wrf.35.2019.03.20.12.42.54
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 12:42:54 -0700 (PDT)
Subject: Re: [PATCH v3] staging: rtl8188eu: Fix potential NULL pointer
 dereference of kcalloc
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Hardik Singh Rathore <hardiksingh.k@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20190320172142.1305-1-pakki001@umn.edu>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <30b65780-e9b8-3c82-6a8c-1f6fbdc01baf@redhat.com>
Date:   Wed, 20 Mar 2019 20:42:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190320172142.1305-1-pakki001@umn.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 20-03-19 18:21, Aditya Pakki wrote:
> hwxmits is allocated via kcalloc and not checked for failure before its
> dereference. The patch fixes this problem by returning error upstream
> in rtl8723bs, rtl8188eu.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>

Patch look good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

> 
> ---
> v2: Move signed off above version change log.
> v1: Return error and remove print in case of failure, per Greg
> ---
>   drivers/staging/rtl8188eu/core/rtw_xmit.c    |  9 +++++++--
>   drivers/staging/rtl8188eu/include/rtw_xmit.h |  2 +-
>   drivers/staging/rtl8723bs/core/rtw_xmit.c    | 14 +++++++-------
>   drivers/staging/rtl8723bs/include/rtw_xmit.h |  2 +-
>   4 files changed, 16 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/staging/rtl8188eu/core/rtw_xmit.c b/drivers/staging/rtl8188eu/core/rtw_xmit.c
> index 1723a47a96b4..952f2ab51347 100644
> --- a/drivers/staging/rtl8188eu/core/rtw_xmit.c
> +++ b/drivers/staging/rtl8188eu/core/rtw_xmit.c
> @@ -174,7 +174,9 @@ s32 _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
>   
>   	pxmitpriv->free_xmit_extbuf_cnt = num_xmit_extbuf;
>   
> -	rtw_alloc_hwxmits(padapter);
> +	res = rtw_alloc_hwxmits(padapter);
> +	if (res == _FAIL)
> +		goto exit;
>   	rtw_init_hwxmits(pxmitpriv->hwxmits, pxmitpriv->hwxmit_entry);
>   
>   	for (i = 0; i < 4; i++)
> @@ -1503,7 +1505,7 @@ s32 rtw_xmit_classifier(struct adapter *padapter, struct xmit_frame *pxmitframe)
>   	return res;
>   }
>   
> -void rtw_alloc_hwxmits(struct adapter *padapter)
> +s32 rtw_alloc_hwxmits(struct adapter *padapter)
>   {
>   	struct hw_xmit *hwxmits;
>   	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
> @@ -1512,6 +1514,8 @@ void rtw_alloc_hwxmits(struct adapter *padapter)
>   
>   	pxmitpriv->hwxmits = kcalloc(pxmitpriv->hwxmit_entry,
>   				     sizeof(struct hw_xmit), GFP_KERNEL);
> +	if (!pxmitpriv->hwxmits)
> +		return _FAIL;
>   
>   	hwxmits = pxmitpriv->hwxmits;
>   
> @@ -1519,6 +1523,7 @@ void rtw_alloc_hwxmits(struct adapter *padapter)
>   	hwxmits[1] .sta_queue = &pxmitpriv->vi_pending;
>   	hwxmits[2] .sta_queue = &pxmitpriv->be_pending;
>   	hwxmits[3] .sta_queue = &pxmitpriv->bk_pending;
> +	return _SUCCESS;
>   }
>   
>   void rtw_free_hwxmits(struct adapter *padapter)
> diff --git a/drivers/staging/rtl8188eu/include/rtw_xmit.h b/drivers/staging/rtl8188eu/include/rtw_xmit.h
> index 788f59c74ea1..ba7e15fbde72 100644
> --- a/drivers/staging/rtl8188eu/include/rtw_xmit.h
> +++ b/drivers/staging/rtl8188eu/include/rtw_xmit.h
> @@ -336,7 +336,7 @@ s32 rtw_txframes_sta_ac_pending(struct adapter *padapter,
>   void rtw_init_hwxmits(struct hw_xmit *phwxmit, int entry);
>   s32 _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter);
>   void _rtw_free_xmit_priv(struct xmit_priv *pxmitpriv);
> -void rtw_alloc_hwxmits(struct adapter *padapter);
> +s32 rtw_alloc_hwxmits(struct adapter *padapter);
>   void rtw_free_hwxmits(struct adapter *padapter);
>   s32 rtw_xmit(struct adapter *padapter, struct sk_buff **pkt);
>   
> diff --git a/drivers/staging/rtl8723bs/core/rtw_xmit.c b/drivers/staging/rtl8723bs/core/rtw_xmit.c
> index 094d61bcb469..b87f13a0b563 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_xmit.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_xmit.c
> @@ -260,7 +260,9 @@ s32 _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
>   		}
>   	}
>   
> -	rtw_alloc_hwxmits(padapter);
> +	res = rtw_alloc_hwxmits(padapter);
> +	if (res == _FAIL)
> +		goto exit;
>   	rtw_init_hwxmits(pxmitpriv->hwxmits, pxmitpriv->hwxmit_entry);
>   
>   	for (i = 0; i < 4; i++) {
> @@ -2144,7 +2146,7 @@ s32 rtw_xmit_classifier(struct adapter *padapter, struct xmit_frame *pxmitframe)
>   	return res;
>   }
>   
> -void rtw_alloc_hwxmits(struct adapter *padapter)
> +s32 rtw_alloc_hwxmits(struct adapter *padapter)
>   {
>   	struct hw_xmit *hwxmits;
>   	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
> @@ -2155,10 +2157,8 @@ void rtw_alloc_hwxmits(struct adapter *padapter)
>   
>   	pxmitpriv->hwxmits = rtw_zmalloc(sizeof(struct hw_xmit) * pxmitpriv->hwxmit_entry);
>   
> -	if (pxmitpriv->hwxmits == NULL) {
> -		DBG_871X("alloc hwxmits fail!...\n");
> -		return;
> -	}
> +	if (!pxmitpriv->hwxmits)
> +		return _FAIL;
>   
>   	hwxmits = pxmitpriv->hwxmits;
>   
> @@ -2204,7 +2204,7 @@ void rtw_alloc_hwxmits(struct adapter *padapter)
>   
>   	}
>   
> -
> +	return _SUCCESS;
>   }
>   
>   void rtw_free_hwxmits(struct adapter *padapter)
> diff --git a/drivers/staging/rtl8723bs/include/rtw_xmit.h b/drivers/staging/rtl8723bs/include/rtw_xmit.h
> index 1b38b9182b31..37f42b2f22f1 100644
> --- a/drivers/staging/rtl8723bs/include/rtw_xmit.h
> +++ b/drivers/staging/rtl8723bs/include/rtw_xmit.h
> @@ -487,7 +487,7 @@ s32 _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter);
>   void _rtw_free_xmit_priv (struct xmit_priv *pxmitpriv);
>   
>   
> -void rtw_alloc_hwxmits(struct adapter *padapter);
> +s32 rtw_alloc_hwxmits(struct adapter *padapter);
>   void rtw_free_hwxmits(struct adapter *padapter);
>   
>   
> 
