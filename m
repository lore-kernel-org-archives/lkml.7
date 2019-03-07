Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A5DC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 14:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A54B720835
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 14:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nOzc0ZgH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbfCGOQD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 09:16:03 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35812 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfCGOQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 09:16:03 -0500
Received: by mail-pf1-f194.google.com with SMTP id j5so11533310pfa.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 06:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i3YjevPKe5ryG7PMnJzvSuvrHQ1PFxESlOhxwKo3nhU=;
        b=nOzc0ZgH5uBvLhDiaQpMFbb/5GWPBuo71xtt4Bt1Q6e/NTXq2bifX2/B8e76Pc09FF
         vnCCNg+5x5cegGV2n3ASoANsCHcjsS/Wx4k3IVg6PV1Png88HX2afdBJSVTaDjpnfIbr
         Sp0OiyXIy8mN2vHPZM4lAabasxlbEOVk3mzPIImZQ62SBedija96gCyAMJYAGULpPRla
         +FBAzTxnVa03jndOInQ5jRZEsT2fWM/MQLRXM3j1BEyMAShatYombYd75IfkjuhUyLLx
         KIc7C3buq3ZKqoGbXOCqC0+zdffbKMsQKy5Z/QzkM7k+3RcObCv2ZrbynEEACj/teBLQ
         O61Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i3YjevPKe5ryG7PMnJzvSuvrHQ1PFxESlOhxwKo3nhU=;
        b=uh9AeFtIuyKPVl3l51/sWHSX8rDbddkujv09gz1KyXY60p+ZuMjrcZXMt7pOhMBP+Z
         cWkNRmTyPfM101jduU8WNoVRIQoDQpTbOckF6/m0zwkVUBlh7BJXXOiprOsnXw8ITOgh
         tXdiAwHgimR0k9Y/3lG/hQWEEIeBkxG9gnwVI8IMjMttkLIDGqbi9G7O2XyfJpwPNp9G
         aUkgc3oakQ4aPxQDl8HOc3/pbqRUmqi+bN6RD612RBsMTtH7G+DcLdcJLCD9yKcgkWbB
         c+vGWv2IzEBF5RlsNwIj6/rPrKulF3DSDyEN69vpICuRgobddRv1IAoVEjZRCGTscDl4
         /rYw==
X-Gm-Message-State: APjAAAVEZvJr25RaeEwhu7FBUNnKnSCodUAI92WblsdPg0fuRCFFZTus
        RQA8SEEp2nIhOMJQk0SBe0XaMNz5REx7aA5yEKMqQ6+sKaU=
X-Google-Smtp-Source: APXvYqwPFLUEovt7Ku8gsXn9f+OFSQuf4QYU0WTFTFWbzXz/Gzjw8CmzBUbXZsS5Pk5oCo1qq7772OyvE43vnbl9TBQ=
X-Received: by 2002:a17:902:8303:: with SMTP id bd3mr13313098plb.10.1551968161942;
 Thu, 07 Mar 2019 06:16:01 -0800 (PST)
MIME-Version: 1.0
References: <20190307075124.3424302-1-arnd@arndb.de>
In-Reply-To: <20190307075124.3424302-1-arnd@arndb.de>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 7 Mar 2019 15:15:50 +0100
Message-ID: <CAAeHK+zf8PWWURcrKe-G6HrpL=1w96fF+5zHkDr5AEJUOXAv=Q@mail.gmail.com>
Subject: Re: [PATCH] page flags: prioritize kasan bits over last-cpuid
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 7, 2019 at 8:51 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> ARM64 randdconfig builds regularly run into a build error, especially
> when NUMA_BALANCING and SPARSEMEM are enabled but not SPARSEMEM_VMEMMAP:
>
>  #error "KASAN: not enough bits in page flags for tag"
>
> The last-cpuid bits are already contitional on the available space,
> so the result of the calculation is a bit random on whether they
> were already left out or not.
>
> Adding the kasan tag bits before last-cpuid makes it much more likely
> to end up with a successful build here, and should be reliable for
> randconfig at least, as long as that does not randomize NR_CPUS
> or NODES_SHIFT but uses the defaults.
>
> Fixes: 2813b9c02962 ("kasan, mm, arm64: tag non slab memory allocated via pagealloc")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/linux/page-flags-layout.h | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/page-flags-layout.h b/include/linux/page-flags-layout.h
> index 1dda31825ec4..9bc0751e68b2 100644
> --- a/include/linux/page-flags-layout.h
> +++ b/include/linux/page-flags-layout.h
> @@ -76,21 +76,23 @@
>  #define LAST_CPUPID_SHIFT 0
>  #endif
>
> -#if SECTIONS_WIDTH+ZONES_WIDTH+NODES_SHIFT+LAST_CPUPID_SHIFT <= BITS_PER_LONG - NR_PAGEFLAGS
> +#ifdef CONFIG_KASAN_SW_TAGS
> +#define KASAN_TAG_WIDTH 8
> +#else
> +#define KASAN_TAG_WIDTH 0
> +#endif
> +
> +#if SECTIONS_WIDTH+ZONES_WIDTH+NODES_SHIFT+LAST_CPUPID_SHIFT+KASAN_TAG_WIDTH \
> +       <= BITS_PER_LONG - NR_PAGEFLAGS
>  #define LAST_CPUPID_WIDTH LAST_CPUPID_SHIFT
>  #else
>  #define LAST_CPUPID_WIDTH 0
>  #endif
>
> -#ifdef CONFIG_KASAN_SW_TAGS
> -#define KASAN_TAG_WIDTH 8
>  #if SECTIONS_WIDTH+NODES_WIDTH+ZONES_WIDTH+LAST_CPUPID_WIDTH+KASAN_TAG_WIDTH \
>         > BITS_PER_LONG - NR_PAGEFLAGS
>  #error "KASAN: not enough bits in page flags for tag"
>  #endif
> -#else
> -#define KASAN_TAG_WIDTH 0
> -#endif
>
>  /*
>   * We are going to use the flags for the page to node mapping if its in
> --
> 2.20.0
>

Reviewed-by: Andrey Konovalov <andreyknvl@google.com>

Thanks!
