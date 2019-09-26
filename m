Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38FE6C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 17:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BA4321D56
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 17:04:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eekWS5lE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbfIZREJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 13:04:09 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33526 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727443AbfIZREJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 13:04:09 -0400
Received: by mail-oi1-f193.google.com with SMTP id e18so2768437oii.0;
        Thu, 26 Sep 2019 10:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=D+LB+cTP0kzVzafxVlKyUQOuNnEa52qRrfQZbeKZv2U=;
        b=eekWS5lE0DEQysy5LMYTYo7Y0ZzMtbnZiPmwZTS4naNU+utBj+QKWIesS1sNHebz6W
         kiPm4JsvCkwRxJ2Qyp+XfYRj48qNx2zCp3yheawU2JYak4QWtngTLpOG/3Lkwu2YhCbF
         WB3UkEQgqgFLdo8jgBvozlHLJb95vk9wWFd/PX800jxDsF4haTrd4K0kr5wmw2DjObP6
         fqcSFjSxNFzq160Z4l4LyEXMOtnw3zrnw1PcLcHuCUY+8kWAzksCTIXjgg1eIUWvDR4f
         VT+CfYzsfVOCnnT/UCNPHvkgRNCyyPP46gerUwmi1lgxfsoIysvW1I6HaX0RTNz+RVP/
         upRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D+LB+cTP0kzVzafxVlKyUQOuNnEa52qRrfQZbeKZv2U=;
        b=jZrB5wqfUXD57KBhwANtcPN6ZwEkmhFcI8kD1wpN2UhAzK0TfYL7CE9YrZvJb3QZfw
         gBRVuef8Ol57GVPb++asV3KGbEa3EhPhqR4gr3wY6wl/5QCqCYmFJVFroIpAzcUBvnnn
         bqfcUkntNFOOli7nFTE6zAy3oquyPAzHceiKtMN1Nhm75pHDbwMoWjw/z0Z+G/cjgGMv
         DRMBajizBwH52aGjrGtqVDJK5RLAGj4a/8njRBG0zastQgZYGMAzxqL9eZGzWZ8gZ2aQ
         22lLiQj3dpAgKOFm43cxKIq4NmjNT71CMcMUsr6Pbz7xmh9JSZVBA4wG5uFnzu0eJlN8
         PzvA==
X-Gm-Message-State: APjAAAW2QoaOqYJd5azapVZsh0msJhwJ6zCtXWNmcGqRRJhw9KTHhx0u
        ROLOCmRl9FYRW4Pk+xFGIoQ9sZKm
X-Google-Smtp-Source: APXvYqywEhZq0Xx3WldtoPkbK7Ztka7DxSjmPgb7/bZ+Y4ZuXoDcNgiezqv9mvFy9PUMLzLL8ENXjQ==
X-Received: by 2002:aca:c505:: with SMTP id v5mr3284814oif.79.1569517447893;
        Thu, 26 Sep 2019 10:04:07 -0700 (PDT)
Received: from [192.168.1.112] (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id y16sm803729otg.7.2019.09.26.10.04.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2019 10:04:06 -0700 (PDT)
Subject: Re: [PATCH v2] staging: rtl8188eu: fix possible null dereference
To:     Connor Kuehl <connor.kuehl@canonical.com>,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        devel@driverdev.osuosl.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20190926150317.5894-1-connor.kuehl@canonical.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <c0601b1f-9366-fbc7-7da8-9b00df94483a@lwfinger.net>
Date:   Thu, 26 Sep 2019 12:04:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190926150317.5894-1-connor.kuehl@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/26/19 10:03 AM, Connor Kuehl wrote:
> Inside a nested 'else' block at the beginning of this function is a
> call that assigns 'psta' to the return value of 'rtw_get_stainfo()'.
> If 'rtw_get_stainfo()' returns NULL and the flow of control reaches
> the 'else if' where 'psta' is dereferenced, then we will dereference
> a NULL pointer.
> 
> Fix this by checking if 'psta' is not NULL before reading its
> 'psta->qos_option' data member.
> 
> Addresses-Coverity: ("Dereference null return value")
> 
> Signed-off-by: Connor Kuehl <connor.kuehl@canonical.com>
> ---
> v1 -> v2:
>    - Add the same null check to line 779
> 
>   drivers/staging/rtl8188eu/core/rtw_xmit.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8188eu/core/rtw_xmit.c b/drivers/staging/rtl8188eu/core/rtw_xmit.c
> index 952f2ab51347..c37591657bac 100644
> --- a/drivers/staging/rtl8188eu/core/rtw_xmit.c
> +++ b/drivers/staging/rtl8188eu/core/rtw_xmit.c
> @@ -776,7 +776,7 @@ s32 rtw_make_wlanhdr(struct adapter *padapter, u8 *hdr, struct pkt_attrib *pattr
>   			memcpy(pwlanhdr->addr2, get_bssid(pmlmepriv), ETH_ALEN);
>   			memcpy(pwlanhdr->addr3, pattrib->src, ETH_ALEN);
>   
> -			if (psta->qos_option)
> +			if (psta && psta->qos_option)
>   				qos_option = true;
>   		} else if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) ||
>   			   check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE)) {
> @@ -784,7 +784,7 @@ s32 rtw_make_wlanhdr(struct adapter *padapter, u8 *hdr, struct pkt_attrib *pattr
>   			memcpy(pwlanhdr->addr2, pattrib->src, ETH_ALEN);
>   			memcpy(pwlanhdr->addr3, get_bssid(pmlmepriv), ETH_ALEN);
>   
> -			if (psta->qos_option)
> +			if (psta && psta->qos_option)
>   				qos_option = true;
>   		} else {
>   			RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("fw_state:%x is not allowed to xmit frame\n", get_fwstate(pmlmepriv)));
> 

Acked-by: Larry Finger <Larry.Finger@lwfinger.net>

Thanks,

Larry

