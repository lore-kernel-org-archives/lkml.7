Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D030BC3A5A6
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 20:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5CEB2343B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 20:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BLGMZDX1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbfH3Urb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 16:47:31 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41605 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728145AbfH3Urb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 16:47:31 -0400
Received: by mail-pf1-f194.google.com with SMTP id 196so5363149pfz.8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 13:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=b8u2magLfJVwljZAGYTURbma2mpmy7TrJLGdd0rfPWc=;
        b=BLGMZDX18kpe0sWfZwyNEN/x3wCg+PtSQX4ScBTDAaLkBAWub1CujNM5iGHBliKpEU
         ZrPu9ZzDjWPu5GHyQ7cmon0yZhz9fIJ+8H+HoH7SsGtQ4F++HJxCiy/VyWKWt+Xzw1WX
         O1OneofCTD2sRQcU4Aw0RD+89IEooAKz8I5pI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b8u2magLfJVwljZAGYTURbma2mpmy7TrJLGdd0rfPWc=;
        b=titPgnizg04l68KfosfaL5ebRjeKYuT4Vn6icd+XBztQAWI8W5c2YAQubdedpHXX+k
         5QOx4u908KJA1v7pnA+rWmiulGWi7dy5lVNd1lOPF8PWp8buAdfMJvueMjCFeR5AQ1L3
         QYaWA4V++rwaCgb/y5aXKcEErfSNe7pIzOaedenHxrcQvCAu+9boFislWUcH13/Iwdur
         iBZRLWGtkfQ1j3+0Mvo9qi4UOAGD25NGpENy12K9WTpmKzqtkvY+qShzYGGcFGawHOb2
         7Oj8oJP07s3i+04vYEtsxRQ5ChDDZDSp1WBqt48yBsMsb0y3Sm0Cgky0QA3oNL9gcSSM
         LciA==
X-Gm-Message-State: APjAAAUPReKxyDBlniL5kcfENj06C1XlfEMUCPZzFhQ7x11+JmBzwJ3z
        oVHuJZ6GQtqbhN4z2rV0pS/TmA==
X-Google-Smtp-Source: APXvYqxMOrhTqkjdQCttFc7yV364Iys+Pb9Un4josyE2DbcbQpgmEtzeoZMjp+DQvlyXdnZOZftg4g==
X-Received: by 2002:aa7:9d8d:: with SMTP id f13mr5969012pfq.196.1567198050541;
        Fri, 30 Aug 2019 13:47:30 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t4sm8770187pfd.109.2019.08.30.13.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 13:47:29 -0700 (PDT)
Date:   Fri, 30 Aug 2019 13:47:28 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Denis Efremov <efremov@linux.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] asm-generic: add unlikely to default BUG_ON(x)
Message-ID: <201908301347.60905D1675@keescook>
References: <20190828210934.17711-1-efremov@linux.com>
 <CAK8P3a3T3r3b2uW977HiuMi0uYKs4V_d4e=PDnkWDpqs+wrLww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3T3r3b2uW977HiuMi0uYKs4V_d4e=PDnkWDpqs+wrLww@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 10:08:49PM +0200, Arnd Bergmann wrote:
> On Wed, Aug 28, 2019 at 11:09 PM Denis Efremov <efremov@linux.com> wrote:
> >
> > Add unlikely to default BUG_ON(x) in !CONFIG_BUG. It makes
> > the define consistent with BUG_ON(x) in CONFIG_BUG.
> >
> > Signed-off-by: Denis Efremov <efremov@linux.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: <linux-arch@vger.kernel.org>
> 
> This makes sense, I've applied it to the asm-generic tree for now.
> 
> Two concerns though:
> 
> - adding unlikely() can cause new (usually false-postive) compile time
>   warnings to show up in random configurations, so we'll have to see what
>   the build bots think
> 
> - Kees Cook has recently sent a series for asm/bug.h that was merged by
>   Andrew Morton. If there are is a conflict with your patch, it may be better
>   to merge both through the same tree, either linux-mm or asm-generic.

FWIW, this patch looks sensible to me. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
