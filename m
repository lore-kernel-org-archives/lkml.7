Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 555E8C10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 09:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19FFB21855
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 09:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbfDFJrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 05:47:25 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34994 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbfDFJrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 05:47:25 -0400
Received: by mail-ed1-f65.google.com with SMTP id s39so7572663edb.2
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2019 02:47:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LcuR4nAQbGGhCKHp6GxzOlh9AEq6YAbVCqgH19rhQYU=;
        b=dszE5Sto64hmC4jXpNN8RlQpP4nbMYRPVjRAhoYr2RnbvG+veNTWRHLfsdGZ7N1yaf
         ga1fSLc9avIZtt25ZTTGDqPt048xEOHwHO31VC+xwM1rxb0rmRHYpod/SPXtOmCyWMP/
         N7VpDl9X7vPLmramgZi1a/opiZXwu3cgZ5EYm5YVog58Js5iGfRZa7OA1qFr0GK/9b2Z
         RKsLXBH6l5+UlM7eMqrENi5GkXJb3Bo5PukpRFdeQkcXZjGIRXbiLuVYe8ROA80P6sGf
         wcjT2kzzvxQZ0LiA8eeXDGGXSVA7eKVyAanEh88r7SU4RYYJ2sxB+RkyjH05c878ejnx
         4fVw==
X-Gm-Message-State: APjAAAXEjhpkHNZ4g/6mOSklQSdgxaxUzW1+wbiG5KpkovfnKfNBYjv/
        02Uipaz++0ryToyVFDXt8zn4bsy1LvU=
X-Google-Smtp-Source: APXvYqzIuBP7d1rgyqz6TBh4AtAAV50NSPT9JKHVpJrIJmaDukxrAUgv7CeVcf49qsy4TUEMrLtPKA==
X-Received: by 2002:a17:906:1984:: with SMTP id g4mr9890808ejd.260.1554544043313;
        Sat, 06 Apr 2019 02:47:23 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id y12sm2295370ejr.75.2019.04.06.02.47.22
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 02:47:22 -0700 (PDT)
Subject: Re: [PATCH] drm/vboxvideo: Avoid double check buffer_overflow in
 vbva_write()
To:     Sidong Yang <realwakka@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20190406081850.1906-1-realwakka@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <4f5fc992-f220-d7eb-6412-977c49b754ef@redhat.com>
Date:   Sat, 6 Apr 2019 11:47:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190406081850.1906-1-realwakka@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 06-04-19 10:18, Sidong Yang wrote:
> In vbva_write(), We do not need to double check available chunk size if
> chunk is smaller than available buffer. Put the second if clause in the
> first if clause and avoid check twice.
> 
> Signed-off-by: Sidong Yang <realwakka@gmail.com>

The code pattern of checking some condition, then fixing it up
and checking again without putting the second check inside the
first check's if block is quite normal and IMHO is more readable
then the nested version with all the extra indentation.

I"m sure the compiler is more then smart enough to just optimize
away the second check if the first one succeeds.

So I see no benefits to this patch, so nack from me.

Regards,

Hans


> ---
>   drivers/gpu/drm/vboxvideo/vbva_base.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vboxvideo/vbva_base.c b/drivers/gpu/drm/vboxvideo/vbva_base.c
> index 36bc9824ec3f..a0c185acf37a 100644
> --- a/drivers/gpu/drm/vboxvideo/vbva_base.c
> +++ b/drivers/gpu/drm/vboxvideo/vbva_base.c
> @@ -80,14 +80,14 @@ bool vbva_write(struct vbva_buf_ctx *vbva_ctx, struct gen_pool *ctx,
>   		if (chunk >= available) {
>   			vbva_buffer_flush(ctx);
>   			available = vbva_buffer_available(vbva);
> -		}
> -
> -		if (chunk >= available) {
> -			if (WARN_ON(available <= vbva->partial_write_tresh)) {
> -				vbva_ctx->buffer_overflow = true;
> -				return false;
> +			if (chunk >= available) {
> +				if (WARN_ON(available <= vbva->partial_write_tresh)) {
> +					vbva_ctx->buffer_overflow = true;
> +					return false;
> +				}
> +				chunk = available - vbva->partial_write_tresh;
>   			}
> -			chunk = available - vbva->partial_write_tresh;
> +
>   		}
>   
>   		vbva_buffer_place_data_at(vbva_ctx, p, chunk,
> 
