Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1695CC43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 20:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF60A2070B
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 20:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PJubyZXg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbfFVU0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 16:26:05 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40603 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbfFVU0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 16:26:04 -0400
Received: by mail-pl1-f196.google.com with SMTP id a93so4676806pla.7
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2019 13:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3LSJX+LSGEGQXGztmOIE004OfGh43169X3pcb5+bEdo=;
        b=PJubyZXgmBMF9k6yZxMLMCoxJX3lLbrfjE/x11wxvT4SyKzC7lqaSzwuAzKsdvRECT
         JX+yyONHgatgA52lc2VKENZDXJ0oJQJPvb4ClFK6LmUuGM2m096eJJ2k956gRVMIZcq1
         vzetQM/j9ky6lgW/ScwHIPlBGEHxdCZpSDcV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3LSJX+LSGEGQXGztmOIE004OfGh43169X3pcb5+bEdo=;
        b=cncNeYY1f4sEA2LVnKPZQMHtFSEJ78b8qLJWDit+P8rso3G5Jpfa9OuXsjZehTTnss
         1gWywKTWII7g1TjUFIJdEfVvS3IIuY8VjWZSrQl2HK7YUNWzhLWyyU1+NFbIlA172J/7
         ZPRim29A8Fek/ZGeHyOjRA653tl/oCajv1H5CvTHmNuOthOt5o/XfvUnsYQo1x3LrO6U
         Ctzh085awG6EZeRvJjuW7GmaywfAEifxThv8Hv1ec3uEPunDIe+Au3gQY80EmlTC6uUp
         ztm8cZHvScS1K19GW3arqOv4WbSm7uMoB/zBR7pef869CsLHNiGn0iiFr9kLxfKLjGoA
         Pnhg==
X-Gm-Message-State: APjAAAWfdPHkbEWzbguWu3hQUMcZ7ageQyv9dAy0jhxw0zds2brWOLTO
        LD5qT8oyDiQR6ivBcMFlmw5ZlA==
X-Google-Smtp-Source: APXvYqwsWh+Rhre5Q6lIWu0XK+GpHk0JyBbDpywnv/6/g83T3V7rSeoORcYPnSeq6m705DN4ZF+rnQ==
X-Received: by 2002:a17:902:2ae8:: with SMTP id j95mr96325450plb.276.1561235163946;
        Sat, 22 Jun 2019 13:26:03 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o74sm10129957pfg.91.2019.06.22.13.26.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Jun 2019 13:26:03 -0700 (PDT)
Date:   Sat, 22 Jun 2019 13:26:02 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Alexander Popov <alex.popov@linux.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] structleak: disable BYREF_ALL in combination with
 KASAN_STACK
Message-ID: <201906221324.C08C1EF@keescook>
References: <20190618094731.3677294-1-arnd@arndb.de>
 <201906201034.9E44D8A2A8@keescook>
 <CAK8P3a2uFcaGMSHRdg4NECHJwgAyhtMuYDv3U=z2UdBSL5U0Lw@mail.gmail.com>
 <CAKv+Gu-A_OWUQ_neUAprmQOotPA=LoUGQHvFkZ2tqQAg=us1jA@mail.gmail.com>
 <CAK8P3a2d3H-pdiLX_8aA4LNLOVTSyPW_jvwZQkv0Ey3SJS87Bg@mail.gmail.com>
 <CAKv+Gu9p017iPva85dPMdnKW_MSOUcthqcy7KDhGEYCN7=C_SA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu9p017iPva85dPMdnKW_MSOUcthqcy7KDhGEYCN7=C_SA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 03:50:02PM +0200, Ard Biesheuvel wrote:
> On Fri, 21 Jun 2019 at 15:44, Arnd Bergmann <arnd@arndb.de> wrote:
> > One pattern I have seen here is temporary variables from macros or
> > inline functions whose lifetime now extends over the entire function
> > rather than just the basic block in which they are defined, see e.g.
> > lpfc_debug_dump_qe() being inlined multiple times into
> > lpfc_debug_dump_all_queues(). Each instance of the local
> > "char line_buf[LPFC_LBUF_SZ];" seems to add on to the previous
> > one now, where the behavior without the structleak plugin is that
> > they don't.

Ewww.

> Right, that seems to be due to the fact that this code
> 
> /* split the first bb where we can put the forced initializers */
> gcc_assert(single_succ_p(ENTRY_BLOCK_PTR_FOR_FN(cfun)));
> bb = single_succ(ENTRY_BLOCK_PTR_FOR_FN(cfun));
> if (!single_pred_p(bb)) {
>     split_edge(single_succ_edge(ENTRY_BLOCK_PTR_FOR_FN(cfun)));
>     gcc_assert(single_succ_p(ENTRY_BLOCK_PTR_FOR_FN(cfun)));
> }
> 
> puts all the initializers at the beginning of the function rather than
> inside the scope of the definition.

Do you see a sane way to improve this? I hadn't noticed that this
actually moved it up to the start of the function. :(

-- 
Kees Cook
