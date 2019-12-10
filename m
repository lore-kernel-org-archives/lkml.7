Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B704EC2D0BE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 05:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A7B420637
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 05:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="TbtQEbC2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbfLJFHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 00:07:07 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34422 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfLJFHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 00:07:07 -0500
Received: by mail-pl1-f193.google.com with SMTP id x17so1525380pln.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 21:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NWFQPyK+dIOMlCUbfgpUcnXmXdBuXytChyw+BNdtZU0=;
        b=TbtQEbC2AN7Vjifh/Yfn+zVfjCxYXqJPPRaWuRMOVgEhneVJzSbHfTvyG4A5GQK0x7
         7m/OprTB9MgF89Jhrj0lQ0k/d9ufINBKCVz2w2yg1HIsTUig6MAXqSylvE4GQeKNNVP8
         sSpbbURveFPtNvyBLgM85LYR6eMY+mWUhRtJwqrASR8V71hckAw8BQah/dQ4qjgVBzz8
         GsudjqcLbUJF31cXnuClWs8LFncGsXFtjLrK665lIiyXL0m79jqnWsRf215kHOXMoQ8i
         X8y0hrIk+trGymBPeZM/MgMVJOu0KYw7zVHrTS8h0+m0wHq16rlrHmksSfGTmVWTu5XK
         WwhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NWFQPyK+dIOMlCUbfgpUcnXmXdBuXytChyw+BNdtZU0=;
        b=Ax7zEqdWpN3p5VOAt8JUP2iYmZm6WHTrtv5SF61K6DKZYciWhQA8PiUKhOi0XAnEcw
         Cbt4oP7F/g0r+FFOnZB/uSYlhH18OjZAIqYIr1Zs5+H16Z8u+PSnOR3Ng65owAvOkj7L
         Lk42J6/QWczQGu4rs0UEbHE1am3nOUDEe0np/ysdk576JA4EjVofFZygkKYfOQNAcegk
         XHGisBGJNSaYOtbVGs/JG5/kPm1p1tAJg0G9dlUFxysLgqGDQft3xrLq/2+XbTn0bysK
         xo8iEQTYRrwcgurw7p5mhw1BRNSAoaJvYpYU7NoNkthFpYO3xgib8+JBSJNFoLvzBpIr
         kb2g==
X-Gm-Message-State: APjAAAUYkNBpAFuH45P84ADLD4h8CoR1LGZuBdf4DGLkpX9g6N4iQVLx
        QbVh6fYGZE0qt2cwmBUN/qYwsnvYKBI=
X-Google-Smtp-Source: APXvYqwzFfWL8+K9N21DY0++TNgTDgnKUVftnSn1tPShoZPTEG4GwyGjkZf9ySiyT7eKa6xve5/Tjw==
X-Received: by 2002:a17:90a:2223:: with SMTP id c32mr3419304pje.15.1575954426395;
        Mon, 09 Dec 2019 21:07:06 -0800 (PST)
Received: from ?IPv6:2620:10d:c081:1133::11c7? ([2620:10d:c090:180::240])
        by smtp.gmail.com with ESMTPSA id w12sm1257462pfd.58.2019.12.09.21.07.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2019 21:07:05 -0800 (PST)
Subject: Re: [PATCH] floppy: hide invalid floppy disk types
To:     =?UTF-8?Q?Moritz_M=c3=bcller?= <moritzm.mueller@posteo.de>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@i4.cs.fau.de
Cc:     "Philip K ." <philip@warpmail.net>
References: <20191208165900.25588-1-moritzm.mueller@posteo.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c5ded238-9954-d802-c180-5421a2816bdd@kernel.dk>
Date:   Mon, 9 Dec 2019 22:07:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191208165900.25588-1-moritzm.mueller@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/8/19 9:59 AM, Moritz Müller wrote:
> In some cases floppy disks are recognised even though no such device
> exists. In our case this has been caused by the CMOS-RAM having a few
> wrong bits. This caused a non-existent floppy disk with the type 13
> (for example) to be registered as an available device, even though it
> could not be mounted by any user.
> 
> We believe this to be an instance of this bug:
> 
>  https://bugzilla.kernel.org/show_bug.cgi?id=13486
>  https://bugs.launchpad.net/ubuntu/+source/linux/+bug/384579
> 
> This patch adds the option FLOPPY_ALLOW_UNKNOWN_TYPES to prevent the
> additional check that fixed the issue on our reference system, and
> increases the startup time of affected systems by over a minute.
> 
> Co-developed-by: Philip K. <philip@warpmail.net>
> Signed-off-by: Philip K. <philip@warpmail.net>
> Signed-off-by: Moritz Müller <moritzm.mueller@posteo.de>
> ---
>  drivers/block/Kconfig  | 10 ++++++++++
>  drivers/block/floppy.c |  6 ++++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
> index 1bb8ec575352..9e6b32c50b67 100644
> --- a/drivers/block/Kconfig
> +++ b/drivers/block/Kconfig
> @@ -72,6 +72,16 @@ config AMIGA_Z2RAM
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called z2ram.
>  
> +config FLOPPY_ALLOW_UNKNOWN_TYPES
> +	bool "Allow floppy disks of unknown type to be registered."
> +	default n
> +	help
> +	  Select this option if you want the Kernel to register floppy
> +	  disks of an unknown type.
> +
> +	  This should usually not be enabled, because of cases where the
> +	  system falsely recongizes a non-existent floppy disk as mountable.
> +
>  config CDROM
>  	tristate
>  	select BLK_SCSI_REQUEST
> diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
> index 485865fd0412..9439444d46d0 100644
> --- a/drivers/block/floppy.c
> +++ b/drivers/block/floppy.c
> @@ -3949,7 +3949,9 @@ static void __init config_types(void)
>  			} else
>  				allowed_drive_mask &= ~(1 << drive);
>  		} else {
> +#ifdef CONFIG_FLOPPY_ALLOW_UNKNOWN_TYPES
>  			params = &default_drive_params[0].params;
> +#ifdef

Please don't send patches that haven't even been compiled.

-- 
Jens Axboe

