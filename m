Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10CF0C282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 17:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C02D020883
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 17:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZDsESsh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728521AbfDTRHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 13:07:55 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46731 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfDTRHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 13:07:54 -0400
Received: by mail-wr1-f67.google.com with SMTP id t17so10566628wrw.13;
        Sat, 20 Apr 2019 10:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=AElsZmM6i7jRmvmI+K3cLkKViKNEqQOS+Y1M1nW/3x8=;
        b=ZZDsESshtiPPocPLf46ZIq1XX2/fqDan/lF71LJDIVAXZ2310mgrZHrZoxGFWmhtJQ
         2EnEuATzOmnmlneq3lSz/ypX65VhyqM3Ln+Ei+lAgc9zCLA+Mwi5g6Ojv9BR/WdiK5I9
         Fi16b/mNJQX+jC9w4eqi8ohNRteDinF5e3ENgonyERDKKHa/NM522pYd+/rlwU2hGhb2
         4myB/+jXEUiAqrZV5kOUVNvM9s2KIQJuceK6i8qAiD2l9eEer8POAWfvhOvQUvbrfiky
         gtDDkimBQkNNH4XlJ8ZJuJvE4Mwq09g0hpC1cSQdN9f7w2y6xfY3Vyxy8F2cJ2U+aUhl
         74Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=AElsZmM6i7jRmvmI+K3cLkKViKNEqQOS+Y1M1nW/3x8=;
        b=tzX6YR96gBLzt4YY8+pvP7OOj9rKkljR6Ycrsz22vg0Qo9wMSXGJnaT6sE7u25R5nu
         i1+FM0gRoEjs16L7O7ZeUTRWeDfV8uidOza7qQvkhYnI+ltaTHeC0xsR4P/w1OrPQODw
         EoUGhMHEtvGPFEIRDJWD8po5NSea9goSDvDNTGeRGGzFgWle12NR6Eb1Lpfhr4j+4o1e
         qtUbVnEBwBOoGVvtxLCAdJYY0eKs6Uj0740k59bFCk6GlGFKxJBX4OVmHsvqsuhhdnI1
         HmRjO05/8zUVOQwyWghjtuLWPdA3IyaFaNIRjYoaFG1XYroUYKSRlj07AlkbLyujNB+I
         UUow==
X-Gm-Message-State: APjAAAUuOjLZsBoSXFcoYYSdRCo+AnGt33SD7wdZO69xBKFwATOWh+Zx
        dbqkBhBnXjxVHM/rI4J5XmgcpJe8
X-Google-Smtp-Source: APXvYqwWKGFGLFm2ZO8dKTggUvZ8ZS8lzK/BAnsO6HQcZsjCV2sr18XK7G9yVozzw3KiV4v4hsFILw==
X-Received: by 2002:a5d:634c:: with SMTP id b12mr7606056wrw.203.1555780072946;
        Sat, 20 Apr 2019 10:07:52 -0700 (PDT)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id u6sm10475226wrg.72.2019.04.20.10.07.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Apr 2019 10:07:52 -0700 (PDT)
Date:   Sat, 20 Apr 2019 19:07:50 +0200
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     fenghua.yu@intel.com, tony.luck@intel.com
Cc:     linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ia64: agp: Replace empty define with do while
Message-ID: <20190420170750.GA23311@Red>
References: <20171220191613.7827-1-clabbe.montjoie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20171220191613.7827-1-clabbe.montjoie@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 20, 2017 at 08:16:13PM +0100, Corentin Labbe wrote:
> It's dangerous to use empty code define.
> Furthermore it lead to the following warning:
> drivers/char/agp/generic.c: In function « agp_generic_destroy_page »:
> drivers/char/agp/generic.c:1266:28: attention : suggest braces around empty body in an « if » statement [-Wempty-body]
> 
> So let's replace emptyness by "do {} while(0)"
> 
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>

Hello

Gentle ping

Regards

> ---
>  arch/ia64/include/asm/agp.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/ia64/include/asm/agp.h b/arch/ia64/include/asm/agp.h
> index 2b451c4496da..0261507dc264 100644
> --- a/arch/ia64/include/asm/agp.h
> +++ b/arch/ia64/include/asm/agp.h
> @@ -14,8 +14,8 @@
>   * in coherent mode, which lets us map the AGP memory as normal (write-back) memory
>   * (unlike x86, where it gets mapped "write-coalescing").
>   */
> -#define map_page_into_agp(page)		/* nothing */
> -#define unmap_page_from_agp(page)	/* nothing */
> +#define map_page_into_agp(page)		do { } while (0)
> +#define unmap_page_from_agp(page)	do { } while (0)
>  #define flush_agp_cache()		mb()
>  
>  /* GATT allocation. Returns/accepts GATT kernel virtual address. */
> -- 
> 2.13.6
> 
