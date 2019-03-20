Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7EEC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A2172184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:21:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WmTZqpnN";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cb0Zc0Pg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbfCTUVI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 16:21:08 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57312 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbfCTUVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 16:21:07 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 55EC8606DB; Wed, 20 Mar 2019 20:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553113266;
        bh=3BjbflmQPy16cGBTSX86pdlD4+p2tJqCACScwTp+0No=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=WmTZqpnNY7AxhAJ3QicQzWGYIxemYdMz5i4woj+q8eL9YpfUKCHn06tbb6Lv6cnuY
         s/7lFoXe7flEWrGmUGMH6lugC+gFwapxaKIBjMKOG9097hcURYbnGac3Ak/KaIzGsX
         /p3GVkZ6nr/UaAaJ2slI4k8CGVE5e2BULHqZkxa0=
Received: from [10.79.162.149] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E78C96044E;
        Wed, 20 Mar 2019 20:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553113264;
        bh=3BjbflmQPy16cGBTSX86pdlD4+p2tJqCACScwTp+0No=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=cb0Zc0Pg/jJ4qX4AAGu92+PmNKBJfuqNv+NisAU73sNNLR16nq6eA1Wuk5+nclF0c
         e9/8b6SR1oDE/sXBkKUER7j0cNvS3M/c5Gu2KhrozRgl+TKdr1o7flGrH+8vxBlXyj
         DFxQysdBnDX60II3WtU6lJAZ7nD0NgKgBqi6ZB84=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E78C96044E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH v3] staging: rtl8188eu: Fix potential NULL pointer
 dereference of kcalloc
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Hardik Singh Rathore <hardiksingh.k@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20190320172142.1305-1-pakki001@umn.edu>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <15d1e6c7-01c7-bff6-59de-1dcafb9af082@codeaurora.org>
Date:   Thu, 21 Mar 2019 01:50:50 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190320172142.1305-1-pakki001@umn.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/20/2019 10:51 PM, Aditya Pakki wrote:
> hwxmits is allocated via kcalloc and not checked for failure before its

No need to mention  kcalloc as the other place allocates the memory 
through kmalloc.

Otherwise looks good.
Acked-by: Mukesh Ojha <mojha@codeaurora.org>

> dereference. The patch fixes this problem by returning error upstream
> in rtl8723bs, rtl8188eu.
>
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
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
