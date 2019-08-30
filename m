Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC63C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 16:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6567D23426
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 16:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pGTlljVr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbfH3Qyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 12:54:50 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35973 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbfH3Qyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 12:54:49 -0400
Received: by mail-pf1-f194.google.com with SMTP id w2so5005406pfi.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 09:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TLtKUMcZ42z6SQ7fFZYQzhafuLTfSIacwf+Jg2ZJWD4=;
        b=pGTlljVrFeEJOlFSQP4ZvNgmeu5O97WRA3veK3NwzcOrYtThSRGEbgDU1oyoE86MXz
         pdwiWqbMKmdUoR5WRWhOSeoysJzrexyFrTcvenruIalE5qD4BhuLqSjsEk2ZY+EVNvrS
         QkWUPiQbld3hzbf0jpxHiYMO2DGVEjx4iTgUC/BP0QTvpRDXKMl1Z8Ui9+RxRHDP+bEh
         rijXYhjsHVsZHqGVX4I21AlvzbrsaW85v7z7tyNEfe761C0rgZ1+8/2IiJ2ts00rhsxP
         Z8rOw4EgyEgRnlq5nocsPnrGZ4+eDlVRcELg39HIXhLHLTLx306AOaLmE9krltWokFrM
         5zVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=TLtKUMcZ42z6SQ7fFZYQzhafuLTfSIacwf+Jg2ZJWD4=;
        b=tmyI+YS7czuVDwiCKoaQcPmcxO2Gx6MJma9Q5TR5YvV/HVWrl4fJHRw2Yq1wmWPhUE
         arJH6LzvJdr593fKfbkxDJER0fzHiSvVHYTuj7gPg0ym6xjo6umiK3LMTO3TqNjc06MV
         RQVUxsJlAFCeHJar2Ud6CpEELtJpfaFfroN3ddFUupaY2RRtcAh+ff2LKCGWhcXUEy9I
         IOxsJ/lPyzTc8wTS4ebejJ7nU1NQdpWeQq8LVQ0Z+H2zZbvImIH6wEc+gHIGJO5s3Ryn
         7b5GAd+hHyaN6bbaV1+wsEPwx4YJwRey92Z/FIE6FoolDhMgswgTc+JMMpZg4R8SVJIZ
         CE/g==
X-Gm-Message-State: APjAAAU2RZOt+zoCVHF10FVbZOJFCbI5grxYuhOidZOeVubYQl1E2ZbH
        qlyIm5UhfYzsGMqpGZkaMq4=
X-Google-Smtp-Source: APXvYqzOkKYHA7f4mgLWQQPdXOXeJbNPSYdckBbp9HZUm2GvixXwB+4FdZ3tAlgZSI8WTKvl+uwWYQ==
X-Received: by 2002:a17:90a:5d98:: with SMTP id t24mr16574377pji.94.1567184089199;
        Fri, 30 Aug 2019 09:54:49 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o129sm7599435pfg.1.2019.08.30.09.54.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Aug 2019 09:54:48 -0700 (PDT)
Date:   Fri, 30 Aug 2019 09:54:47 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Hung-Te Lin <hungte@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Samuel Holland <samuel@sholland.org>,
        Allison Randal <allison@lohutok.net>,
        Colin Ian King <colin.king@canonical.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexios Zavras <alexios.zavras@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] firmware: google: check if size is valid when
 decoding VPD data
Message-ID: <20190830165447.GI7911@roeck-us.net>
References: <5d67e673.1c69fb81.5f13b.62ee@mx.google.com>
 <20190830022402.214442-1-hungte@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830022402.214442-1-hungte@chromium.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 10:23:58AM +0800, Hung-Te Lin wrote:
> The VPD implementation from Chromium Vital Product Data project used to
> parse data from untrusted input without checking if the meta data is
> invalid or corrupted. For example, the size from decoded content may
> be negative value, or larger than whole input buffer. Such invalid data
> may cause buffer overflow.
> 
> To fix that, the size parameters passed to vpd_decode functions should
> be changed to unsigned integer (u32) type, and the parsing of entry
> header should be refactored so every size field is correctly verified
> before starting to decode.
> 
> Fixes: ad2ac9d5c5e0 ("firmware: Google VPD: import lib_vpd source files")
> Signed-off-by: Hung-Te Lin <hungte@chromium.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Changes in v4:
> - Prevent changing indent in function prototype
> - Removed changes in function comments
> 
>  drivers/firmware/google/vpd.c        |  4 +-
>  drivers/firmware/google/vpd_decode.c | 55 ++++++++++++++++------------
>  drivers/firmware/google/vpd_decode.h |  6 +--
>  3 files changed, 37 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/firmware/google/vpd.c b/drivers/firmware/google/vpd.c
> index 0739f3b70347..db0812263d46 100644
> --- a/drivers/firmware/google/vpd.c
> +++ b/drivers/firmware/google/vpd.c
> @@ -92,8 +92,8 @@ static int vpd_section_check_key_name(const u8 *key, s32 key_len)
>  	return VPD_OK;
>  }
>  
> -static int vpd_section_attrib_add(const u8 *key, s32 key_len,
> -				  const u8 *value, s32 value_len,
> +static int vpd_section_attrib_add(const u8 *key, u32 key_len,
> +				  const u8 *value, u32 value_len,
>  				  void *arg)
>  {
>  	int ret;
> diff --git a/drivers/firmware/google/vpd_decode.c b/drivers/firmware/google/vpd_decode.c
> index 92e3258552fc..dda525c0f968 100644
> --- a/drivers/firmware/google/vpd_decode.c
> +++ b/drivers/firmware/google/vpd_decode.c
> @@ -9,8 +9,8 @@
>  
>  #include "vpd_decode.h"
>  
> -static int vpd_decode_len(const s32 max_len, const u8 *in,
> -			  s32 *length, s32 *decoded_len)
> +static int vpd_decode_len(const u32 max_len, const u8 *in,
> +			  u32 *length, u32 *decoded_len)
>  {
>  	u8 more;
>  	int i = 0;
> @@ -30,18 +30,39 @@ static int vpd_decode_len(const s32 max_len, const u8 *in,
>  	} while (more);
>  
>  	*decoded_len = i;
> +	return VPD_OK;
> +}
> +
> +static int vpd_decode_entry(const u32 max_len, const u8 *input_buf,
> +			    u32 *_consumed, const u8 **entry, u32 *entry_len)
> +{
> +	u32 decoded_len;
> +	u32 consumed = *_consumed;
> +
> +	if (vpd_decode_len(max_len - consumed, &input_buf[consumed],
> +			   entry_len, &decoded_len) != VPD_OK)
> +		return VPD_FAIL;
> +	if (max_len - consumed < decoded_len)
> +		return VPD_FAIL;
> +
> +	consumed += decoded_len;
> +	*entry = input_buf + consumed;
> +
> +	/* entry_len is untrusted data and must be checked again. */
> +	if (max_len - consumed < *entry_len)
> +		return VPD_FAIL;
>  
> +	consumed += decoded_len;
> +	*_consumed = consumed;
>  	return VPD_OK;
>  }
>  
> -int vpd_decode_string(const s32 max_len, const u8 *input_buf, s32 *consumed,
> +int vpd_decode_string(const u32 max_len, const u8 *input_buf, u32 *consumed,
>  		      vpd_decode_callback callback, void *callback_arg)
>  {
>  	int type;
> -	int res;
> -	s32 key_len;
> -	s32 value_len;
> -	s32 decoded_len;
> +	u32 key_len;
> +	u32 value_len;
>  	const u8 *key;
>  	const u8 *value;
>  
> @@ -56,26 +77,14 @@ int vpd_decode_string(const s32 max_len, const u8 *input_buf, s32 *consumed,
>  	case VPD_TYPE_STRING:
>  		(*consumed)++;
>  
> -		/* key */
> -		res = vpd_decode_len(max_len - *consumed, &input_buf[*consumed],
> -				     &key_len, &decoded_len);
> -		if (res != VPD_OK || *consumed + decoded_len >= max_len)
> +		if (vpd_decode_entry(max_len, input_buf, consumed, &key,
> +				     &key_len) != VPD_OK)
>  			return VPD_FAIL;
>  
> -		*consumed += decoded_len;
> -		key = &input_buf[*consumed];
> -		*consumed += key_len;
> -
> -		/* value */
> -		res = vpd_decode_len(max_len - *consumed, &input_buf[*consumed],
> -				     &value_len, &decoded_len);
> -		if (res != VPD_OK || *consumed + decoded_len > max_len)
> +		if (vpd_decode_entry(max_len, input_buf, consumed, &value,
> +				     &value_len) != VPD_OK)
>  			return VPD_FAIL;
>  
> -		*consumed += decoded_len;
> -		value = &input_buf[*consumed];
> -		*consumed += value_len;
> -
>  		if (type == VPD_TYPE_STRING)
>  			return callback(key, key_len, value, value_len,
>  					callback_arg);
> diff --git a/drivers/firmware/google/vpd_decode.h b/drivers/firmware/google/vpd_decode.h
> index cf8c2ace155a..8dbe41cac599 100644
> --- a/drivers/firmware/google/vpd_decode.h
> +++ b/drivers/firmware/google/vpd_decode.h
> @@ -25,8 +25,8 @@ enum {
>  };
>  
>  /* Callback for vpd_decode_string to invoke. */
> -typedef int vpd_decode_callback(const u8 *key, s32 key_len,
> -				const u8 *value, s32 value_len,
> +typedef int vpd_decode_callback(const u8 *key, u32 key_len,
> +				const u8 *value, u32 value_len,
>  				void *arg);
>  
>  /*
> @@ -44,7 +44,7 @@ typedef int vpd_decode_callback(const u8 *key, s32 key_len,
>   * If one entry is successfully decoded, sends it to callback and returns the
>   * result.
>   */
> -int vpd_decode_string(const s32 max_len, const u8 *input_buf, s32 *consumed,
> +int vpd_decode_string(const u32 max_len, const u8 *input_buf, u32 *consumed,
>  		      vpd_decode_callback callback, void *callback_arg);
>  
>  #endif  /* __VPD_DECODE_H */
> -- 
> 2.23.0.187.g17f5b7556c-goog
> 
