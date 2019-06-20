Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E3CC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E644921530
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oV9KeU7f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbfFTSNj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:13:39 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42986 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729284AbfFTSNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:13:34 -0400
Received: by mail-pl1-f193.google.com with SMTP id ay6so1695175plb.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 11:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RmdL4r6TvJ+oKourpQb+LBst9Fomwh98eeYZGetnRvY=;
        b=oV9KeU7fuBkBdNRgFANyfh0fcXSl4wDv8kbA4/2xYSLmTm8D40QNMvO/CQH/+cDxK7
         GbW9f/ukXyTOqWTO2qrk4Tff8D13y9JHIJMsHsnmCAXLnEngZl922vBjaJ4Phu50pSyF
         pE8CYKHUOKZwcRKjRd0O9tRtzDNgGbDGVRcmw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RmdL4r6TvJ+oKourpQb+LBst9Fomwh98eeYZGetnRvY=;
        b=Y8Fno+z82EWuOjrzjhAkSFLGC22ijYwwFWybdaQw8EJPwT5Biq+8nB34+YIzg0OAum
         Sry7riSviAcfNgSa6oK3ylcUnQjhUnehaPUuFd75Pj3bzo8tv59OdK+KyQUXsVzLcMeF
         ynAMHFzi2RhD4SQ6UVPflrW2YjEHo3Q+pddyTLzTExIosJtDM0meylPfn83fqKXfjHh7
         Wa8r+rUKtTv8I7jiTvMKpCum4pgajGK6ZwK/UbTDYm59zmVo5GJ/CECmEQBLIPw6OpQi
         yxh7hX9v+cEMMaeRM+QuJVAKZHbrWnA30l8uh32XN/xHr07OJJvu7qxfeniki6kAVHJV
         KY8Q==
X-Gm-Message-State: APjAAAXOGLnVWI16jScHVsEjBVuo6xIRFx2lh7Z3mcpJAj/NUfbOAPvY
        fiMaNfBCqCkP07GCa+e+H7cXMg==
X-Google-Smtp-Source: APXvYqwRqHmHiOefZUkjtzQ5hzlVB17R/dzjZKqG93Hc2P9UkalWcaAo2ZuXfBOPjxAeefIn2Ir5zA==
X-Received: by 2002:a17:902:d707:: with SMTP id w7mr8966934ply.128.1561054413761;
        Thu, 20 Jun 2019 11:13:33 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b6sm311008pgd.5.2019.06.20.11.13.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Jun 2019 11:13:32 -0700 (PDT)
Date:   Thu, 20 Jun 2019 11:13:32 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Colin King <colin.king@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] lkdtm: remove redundant initialization of ret
Message-ID: <201906201112.AE06471@keescook>
References: <20190614094311.24024-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614094311.24024-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 10:43:11AM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The variable ret is being initialized with the value -EINVAL however
> this value is never read and ret is being re-assigned later on. Hence
> the initialization is redundant and can be removed.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Thanks!

Acked-by: Kees Cook <keescook@chromium.org>

Greg, can you take this please?

-Kees

> ---
>  drivers/misc/lkdtm/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
> index bba093224813..92df35fdeab0 100644
> --- a/drivers/misc/lkdtm/core.c
> +++ b/drivers/misc/lkdtm/core.c
> @@ -390,7 +390,7 @@ static int __init lkdtm_module_init(void)
>  {
>  	struct crashpoint *crashpoint = NULL;
>  	const struct crashtype *crashtype = NULL;
> -	int ret = -EINVAL;
> +	int ret;
>  	int i;
>  
>  	/* Neither or both of these need to be set */
> -- 
> 2.20.1
> 

-- 
Kees Cook
