Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE73C3A59E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 07:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97E82216F4
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 07:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DcPV47hl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729418AbfHTHUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 03:20:49 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39012 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729364AbfHTHUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 03:20:49 -0400
Received: by mail-pf1-f193.google.com with SMTP id f17so2825739pfn.6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 00:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OStUPKo5sN9egAemPnPnKeBI2FmMQ5/hY6tft1KYiXk=;
        b=DcPV47hlMeDiDYc/zFnnkUIz4niwFiL0MMwy40hlKCp8341i8StydIXRMol8VP79LX
         rjtYzExU7TFxH/M32x/5x+ZHloiYg73XxwBOh+jVSzmI3HdnXHzhWLfDkArDNrLw1fks
         ju5LKkVbfpQOjNOyhjwAVWgyuHRFRy9+YDDhY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OStUPKo5sN9egAemPnPnKeBI2FmMQ5/hY6tft1KYiXk=;
        b=gP/TyF5WuYcIm/AVdM4rieU+EGhJeH09uW8mZm9NeS1Rm/iBOlUeRxH0eFlTyr3rc9
         kHN/tbg94tfk2tWX3mUgxgLpTaQru3YyVsUDnMGg/dmPf+TCyMGyzE1lQnjPbZ/OSSuL
         I8iusvyoIsm/LE5/FxoFbwc919K29tSKhquwkNhLGUfAidG7wCLZ7iNwsYzDHEbJWzFO
         UlQ+gaqG5k1G4GnaWoFUU1DK++pmPBnHcBflkeLA3VW7BIZRhz9P8PXkZ2SLD1cQeo6j
         j6dJOB2Mk1zHVeC+QXL9d1gEOglDpBoqqpYR/TG7svAuTv0/1gIp4hczqBgtfajtGoDA
         FKnA==
X-Gm-Message-State: APjAAAWPx8FENM54n+ByzBWCv3zXzcO1VGuibVSCumuEbhttkJ2bms+j
        sVYg3mcG6AlM2s0Ip1Mi9nmJug==
X-Google-Smtp-Source: APXvYqwWUcjmVD0TwhGffPY2cJEQgD5exrALleD++McO3Q/ZZguhV4uJRUS979nQEXLo9MxExzpSGw==
X-Received: by 2002:aa7:8b11:: with SMTP id f17mr28566271pfd.19.1566285648592;
        Tue, 20 Aug 2019 00:20:48 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t7sm15240967pgp.68.2019.08.20.00.20.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Aug 2019 00:20:47 -0700 (PDT)
Date:   Tue, 20 Aug 2019 00:20:46 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, y2038@lists.linaro.org,
        arnd@arndb.de, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com
Subject: Re: [PATCH v8 19/20] pstore: fs superblock limits
Message-ID: <201908200018.8C876788@keescook>
References: <20190818165817.32634-1-deepa.kernel@gmail.com>
 <20190818165817.32634-20-deepa.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190818165817.32634-20-deepa.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 18, 2019 at 09:58:16AM -0700, Deepa Dinamani wrote:
> Leaving granularity at 1ns because it is dependent on the specific
> attached backing pstore module. ramoops has microsecond resolution.
> 
> Fix the readback of ramoops fractional timestamp microseconds,
> which has incorrectly been reporting the value as nanoseconds since
> 3f8f80f0 ("pstore/ram: Read and write to the 'compressed' flag of pstore").

As such, this should also have:

Fixes: 3f8f80f0cfeb ("pstore/ram: Read and write to the 'compressed' flag of pstore")

> Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
> Acked-by: Kees Cook <keescook@chromium.org>

Also: this is going via some other tree, yes? (Or should I pick this up
for the pstore tree?)

Thanks!

-Kees

> Cc: anton@enomsg.org
> Cc: ccross@android.com
> Cc: keescook@chromium.org
> Cc: tony.luck@intel.com
> ---
>  fs/pstore/ram.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
> index 2bb3468fc93a..8caff834f002 100644
> --- a/fs/pstore/ram.c
> +++ b/fs/pstore/ram.c
> @@ -144,6 +144,7 @@ static int ramoops_read_kmsg_hdr(char *buffer, struct timespec64 *time,
>  	if (sscanf(buffer, RAMOOPS_KERNMSG_HDR "%lld.%lu-%c\n%n",
>  		   (time64_t *)&time->tv_sec, &time->tv_nsec, &data_type,
>  		   &header_length) == 3) {
> +		time->tv_nsec *= 1000;
>  		if (data_type == 'C')
>  			*compressed = true;
>  		else
> @@ -151,6 +152,7 @@ static int ramoops_read_kmsg_hdr(char *buffer, struct timespec64 *time,
>  	} else if (sscanf(buffer, RAMOOPS_KERNMSG_HDR "%lld.%lu\n%n",
>  			  (time64_t *)&time->tv_sec, &time->tv_nsec,
>  			  &header_length) == 2) {
> +		time->tv_nsec *= 1000;
>  		*compressed = false;
>  	} else {
>  		time->tv_sec = 0;
> -- 
> 2.17.1
> 

-- 
Kees Cook
