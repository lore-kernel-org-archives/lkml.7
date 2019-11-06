Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C61C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 08:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CB87206A3
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 08:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nrz8ddPk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730194AbfKFIAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 03:00:41 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46305 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729878AbfKFIAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 03:00:41 -0500
Received: by mail-pf1-f195.google.com with SMTP id 193so16938167pfc.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 00:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KuPVTVr4RYweQb+V3z56bkXkHnz53CjmsEHwNcAKPBA=;
        b=nrz8ddPkTcWqz4wbBXtX1ZVpAU55IYE7RYAUO6y5C3CA9bYv9NQ8EB6N1Mn1prJBdm
         pa/1N+2ErAAwWwcSLAH4+Q5E5BmC5oJAt7vBdKoFtZR68Yta1/Heo4pwtfPJPiQHopbV
         DzMsrrf+pPTLtHT3c01UvZaB/ryskTUdorhm1B4BVr2UJAVKMKpU7qsxdfBsLD6ZFI/U
         /MMZf4JIrpIM5EX9rHOoiKD+pZ/e5W9ZvGrVwN0RqQO1ycKkEYQFCiMyKyRVAnDajHCZ
         QOZ6XVv8FLfc9WDguFYQFgjQcObPl3WSnGX1rtXe6ZjMlnmOv5SNhfngzgzqyEw2Wknx
         nPpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KuPVTVr4RYweQb+V3z56bkXkHnz53CjmsEHwNcAKPBA=;
        b=i3SV9YhU3KHmKa0VJR6NK85HsKhm1fxCuHtqAM2b4Az+oZoJXMtmpXnMX/wkAC+HPY
         cutRFtmyNjYWKO+A7Dxypq20foZ6lVzk8S8JczGb0ssYKHW1rb/nt18uqPC1rqcy6Xnm
         IELaKkFm1W0ZbMvVg9p/noBZmaRtQBx6joX1Q0frOjnGWhEIvie+2VbA8CipZfx317YR
         Da8+ESXY2fjuV8ucz2TqnSf9222+WeEWOvZTHg2wK9aIqcW7w3MWMioIWlyxXlR/9m+b
         bCU8u5SGzJML2xkVfrGUEthB5qq3koLk7C2n7/HDlXwww2fQcpOk9qOD+RgW+vHYaItK
         IzGQ==
X-Gm-Message-State: APjAAAUvzZnYPXDoxO0hStdeKDTETSLsgibl6xAaIJCBK9qQtSy5HGx4
        LCvrnh98G22hSaeuA6m+vS0=
X-Google-Smtp-Source: APXvYqy6WTKqy9mtM9teFAhh5LwP4xmTEivvABPHoP3S/DIO3JEoUN6rh0CwbHefPFSoxTmIK/fKCA==
X-Received: by 2002:a62:108:: with SMTP id 8mr1688106pfb.53.1573027240908;
        Wed, 06 Nov 2019 00:00:40 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:250d:e71d:5a0a:9afe])
        by smtp.gmail.com with ESMTPSA id 13sm24968289pgq.72.2019.11.06.00.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 00:00:39 -0800 (PST)
Date:   Wed, 6 Nov 2019 17:00:37 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Ioannis Ilkos <ilkos@google.com>,
        minchan@google.com, primiano@google.com, fmayer@google.com,
        hjd@google.com, joaodias@google.com, joelaf@google.com,
        lalitm@google.com, rslawik@google.com, sspatil@google.com,
        timmurray@google.com, Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Changbin Du <changbin.du@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Joe Perches <joe@perches.com>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>, Petr Mladek <pmladek@suse.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] rss_stat: Add support to detect RSS updates of external
 mm
Message-ID: <20191106080037.GA59367@google.com>
References: <20191106024452.81923-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106024452.81923-1-joel@joelfernandes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (19/11/05 21:44), Joel Fernandes (Google) wrote:
[..]
> +++ b/lib/vsprintf.c
> @@ -761,11 +761,34 @@ static int __init initialize_ptr_random(void)
>  early_initcall(initialize_ptr_random);
>  
>  /* Maps a pointer to a 32 bit unique identifier. */
> +int ptr_to_hashval(const void *ptr, unsigned long *hashval_out)
> +{
> +	const char *str = sizeof(ptr) == 8 ? "(____ptrval____)" : "(ptrval)";
> +	unsigned long hashval;
> +
> +	if (static_branch_unlikely(&not_filled_random_ptr_key))
> +		return -EAGAIN;
> +
> +#ifdef CONFIG_64BIT
> +	hashval = (unsigned long)siphash_1u64((u64)ptr, &ptr_key);
> +	/*
> +	 * Mask off the first 32 bits, this makes explicit that we have
> +	 * modified the address (and 32 bits is plenty for a unique ID).
> +	 */
> +	hashval = hashval & 0xffffffff;
> +#else
> +	hashval = (unsigned long)siphash_1u32((u32)ptr, &ptr_key);
> +#endif
> +	*hashval_out = hashval;
> +	return 0;
> +}

Maybe we want to move this thing to more generic code - lib/siphash.c -
since it's going to have several users.

	-ss
