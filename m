Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CAA8C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 09:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA0C6205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 09:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="LAMWBzbT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfDLJgc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 05:36:32 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37460 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbfDLJgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 05:36:31 -0400
Received: by mail-lj1-f193.google.com with SMTP id v13so8250318ljk.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 02:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rP6B5gEYGXtK5rR2H8KZKeoPQ0EP/B4IFVH2yMaLFdI=;
        b=LAMWBzbTHQOid3zEnZroud8oHQ3dtwkrHSAMA3c7mTZZlvN9wiILz6HmmwR8bPin7X
         nMc1Ap8bS7rAHVwitOBZO1cTsK+meSxhRK/6yt7iesyOqaakZDVCEZLpVH/bOYObIuZa
         aeCCulnByXwn2ugX6a8gls1b9El+WumgyYyK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rP6B5gEYGXtK5rR2H8KZKeoPQ0EP/B4IFVH2yMaLFdI=;
        b=A1Rs61AzKFd17NB2COUa9DDjkVlQZvqaY8+5ThkyEB+3bkIUsRaVnNOBAAcMqA/od9
         x2zS2dAYOS4TFruqoUEzJNG2fVVz17ZnnFslMO5Fz4RIo75WPI7HPwPqoitV/bANZ9LQ
         7pvJNNz3vPQsg0F3ho0Kce3dUma8YcULFHGE9AQl430OWgqEnD5ber4QqsTWuj6QPY1D
         Oz9WhzgQZRtzW8Zyy9I/w0rtBtPnBIwSRr6IQor9GHhe/VTE62Yy4qQ46IizeO7LMnd1
         73Pd7vEf6TEEJfXjwOCxxI2+Scoh8zBjipoZ89XHh4jRs3x+C64HZzx+PuREEENGqjiz
         o92g==
X-Gm-Message-State: APjAAAXvnajonoiNYeHF/xnZjK5/onVepV0cgnIDBQbfOIQqZ45SnI83
        Go79G9kVcBUgSWqr6O82UHEEWaQ+8/r4rf7l
X-Google-Smtp-Source: APXvYqwlNJsMqCiIlqZtI50LamrQng6x2nW5HuU0EQyKF8UwPKWBJWKynqszZSWfcXffYlhiqGb9Fw==
X-Received: by 2002:a2e:42cf:: with SMTP id h76mr28705045ljf.95.1555061789199;
        Fri, 12 Apr 2019 02:36:29 -0700 (PDT)
Received: from [172.16.11.26] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id q5sm7989954lfm.16.2019.04.12.02.36.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 02:36:28 -0700 (PDT)
Subject: Re: [PATCH] scsi: qedf: replace memset/memcpy with safer strscpy
To:     Colin King <colin.king@canonical.com>,
        QLogic-Storage-Upstream@cavium.com,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190412090552.26925-1-colin.king@canonical.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <1f51ff1c-bd1a-2b77-fd5f-77fb873111e9@rasmusvillemoes.dk>
Date:   Fri, 12 Apr 2019 11:36:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190412090552.26925-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/2019 11.05, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently the qedf_dbg_* family of functions can overrun the end
> of the source string if it is less than the destination buffer
> length because of the use of a fixed sized memcpy. Replace the
> memset/memcpy calls with the safer strscpy as this won't overrun
> the end of the source string and it ensures the destination
> string is always terminated with NUL.
> 
> Addresses-Coverity: ("Out-of-bounds access")
> Fixes: 61d8658b4a43 ("scsi: qedf: Add QLogic FastLinQ offload FCoE driver framework.")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/scsi/qedf/qedf_dbg.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/scsi/qedf/qedf_dbg.c b/drivers/scsi/qedf/qedf_dbg.c
> index f2397ee9ba69..b491bebeaca9 100644
> --- a/drivers/scsi/qedf/qedf_dbg.c
> +++ b/drivers/scsi/qedf/qedf_dbg.c
> @@ -17,8 +17,7 @@ qedf_dbg_err(struct qedf_dbg_ctx *qedf, const char *func, u32 line,
>  	struct va_format vaf;
>  	char nfunc[32];
>  
> -	memset(nfunc, 0, sizeof(nfunc));
> -	memcpy(nfunc, func, sizeof(nfunc) - 1);
> +	strscpy(nfunc, func, sizeof(nfunc));

Why not drop the pointless nfunc and stack copying and just pass func as
the %s parameter; these are only called via macros that pass __func__ as
the func argument, and that is always a proper nul-terminated string.

Rasmus
