Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D6DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 19:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD5E820823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 19:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d1pKwYUu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732543AbfCZTx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 15:53:26 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42666 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbfCZTx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 15:53:26 -0400
Received: by mail-lj1-f193.google.com with SMTP id v22so12255927lje.9;
        Tue, 26 Mar 2019 12:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QlaTdYWvG+WCAOE3wzX5MphhWaKUUxDm2PjB3wKgpcg=;
        b=d1pKwYUuF31ZcHlqnBQtGrve+uHG81tALZ/PJf4FO+QvshRxOGy8SXiuws/AXQ6Kgs
         KDwRcPOdnGQROG4hEWfwbJPEz1+NeIDY/ENoB7/J6YyH5jlvkPEMPLjYgVVSjg4LST8h
         IXyPaHPbs3o8iIEYzUCXFfv0V3e7vEsBU2OT9WoPKsuunPZSBdeFVw0l96mz/kdNDSLw
         itraKFpOxHZXL5pNOgilzo51na2RbFjSkFuOLZU1PXU8EFsslDXvIWpR59Tb7rldoJaf
         SMWKmhL+FEL+9rSpHRtrVnW27MpMa4ePUjyORu9WO5nsjr/ctTsjcDcZ6KscUh14/UIh
         YxoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QlaTdYWvG+WCAOE3wzX5MphhWaKUUxDm2PjB3wKgpcg=;
        b=YSd5QLsuhTpyu8D3jtRCtIq3W3ntiZXXdbm+wc4e6bx5DhkHcCCBPQHI2Avgy/OGyU
         6uNz3rxYBEJBxScZx0nMXl7Lr3HXSsELnx4CijRik6Gyf0wIm8MlX/4/O3/8kj9vBRcX
         megGM35pWNaTEa+qQcpCtlwnQezseVax+xf58VV1MCU4vwRLWRvumLcUksueiN9Cij8Q
         BP/WSLXbHN4ieXClPDRby8NPo6vIQA2G0veWDUOnOMvAIvWXP4Jwqgqmmnm176GMYujX
         XosAsFrACb134yN49rPvUnp1jSndSyjIeTEAgebf0S4DluI/hSXFbkZC87l52Zezicsd
         MiZA==
X-Gm-Message-State: APjAAAUWmKyNJeS3Wm3n/r3MYJqb+X4QHD17teWntIHMrRTChuRc0wxz
        3/IYndIYHOlzfniCZEXLUMSKeJh6
X-Google-Smtp-Source: APXvYqy7uwJvYlc98x4i7IgkyqCkkEzaulCqtjnWiyS/U1ocoCtaARndrw/LMmW8HPFTx8fsXKtVHw==
X-Received: by 2002:a2e:9013:: with SMTP id h19mr18395015ljg.136.1553630003609;
        Tue, 26 Mar 2019 12:53:23 -0700 (PDT)
Received: from [192.168.1.19] (ckd248.neoplus.adsl.tpnet.pl. [83.31.79.248])
        by smtp.gmail.com with ESMTPSA id c64sm710697lfg.70.2019.03.26.12.53.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 12:53:22 -0700 (PDT)
Subject: Re: [PATCH v2 1/6] leds: netdev trigger: use memcpy in
 device_name_store
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Pavel Machek <pavel@ucw.cz>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-leds@vger.kernel.org
References: <20190313202615.22883-1-linux@rasmusvillemoes.dk>
 <20190314140619.3309-1-linux@rasmusvillemoes.dk>
 <20190314140619.3309-2-linux@rasmusvillemoes.dk>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <987c3e60-edb3-44f0-be28-434c70bb8659@gmail.com>
Date:   Tue, 26 Mar 2019 20:53:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190314140619.3309-2-linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rasmus,

Thank you for the patch.

On 3/14/19 3:06 PM, Rasmus Villemoes wrote:
> If userspace doesn't end the input with a newline (which can easily
> happen if the write happens from a C program that does write(fd,
> iface, strlen(iface))), we may end up including garbage from a
> previous, longer value in the device_name. For example
> 
> # cat device_name
> 
> # printf 'eth12' > device_name
> # cat device_name
> eth12
> # printf 'eth3' > device_name
> # cat device_name
> eth32
> 
> I highly doubt anybody is relying on this behaviour, so switch to
> simply copying the bytes (we've already checked that size is <
> IFNAMSIZ) and unconditionally zero-terminate it; of course, we also
> still have to strip a trailing newline.
> 
> This is also preparation for future patches.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>   drivers/leds/trigger/ledtrig-netdev.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/leds/trigger/ledtrig-netdev.c b/drivers/leds/trigger/ledtrig-netdev.c
> index 3dd3ed46d473..8d476b92f58c 100644
> --- a/drivers/leds/trigger/ledtrig-netdev.c
> +++ b/drivers/leds/trigger/ledtrig-netdev.c
> @@ -122,7 +122,8 @@ static ssize_t device_name_store(struct device *dev,
>   		trigger_data->net_dev = NULL;
>   	}
>   
> -	strncpy(trigger_data->device_name, buf, size);
> +	memcpy(trigger_data->device_name, buf, size);
> +	trigger_data->device_name[size] = 0;
>   	if (size > 0 && trigger_data->device_name[size - 1] == '\n')
>   		trigger_data->device_name[size - 1] = 0;
>   
> 

Added tag:

Fixes: 06f502f57d0d ("leds: trigger: Introduce a NETDEV trigger")

and applied to the fixes-for-5.1-rc3 branch.

-- 
Best regards,
Jacek Anaszewski
