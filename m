Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62498C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 18:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3063C20B1F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 18:36:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730306AbfHESf7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 14:35:59 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36819 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729334AbfHESf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 14:35:58 -0400
Received: by mail-qt1-f196.google.com with SMTP id z4so81999783qtc.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 11:35:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SJt95lVEMWbOQzeIVnWpAPhRtXn6s7j3xTt4f8Xfjb4=;
        b=EOYug4iDgwPXqhNKCbkB8i8rYB4bP6TdM/cAbuqvOOLZiOInYRP4c6eF+HH/iSXKAe
         NCmQJvkWWMTCtd2MUm3EjJAIhpGK23jab1yB4125BN4/4T+rPo9b6EBTqVdDHoCE4D3W
         /QzcwQ7cjIVYaf4vOAB1krWnPDK+Y9L6i0tbVjRl9zmh1ya+jwaNdR/DfJBLVh/1C93R
         5Xl09XoEX/48ZXzS+x2Ckxc7L5L1qipdhNNTy4AGVORYrJicha4SeEXYGqo9BrgurLtr
         Uu2abrpjEwCShvtSRy6oP+o4nXGH9eveDwlIrjMmO64bTsq2XdWvSz+PrAIlGdng8xDC
         Qa7w==
X-Gm-Message-State: APjAAAUyKFv/4bm73svSw7tl9QdUyhkPK0Y7x1Td/iNJY0cCwDgZfM+y
        Fs1o/0uLJBLsZ99Lz/92TRf5Y54wU9oAKt5CaW0esBSvgZA=
X-Google-Smtp-Source: APXvYqxduPIUALS8ra5feDUTyNPl1HIRaaXQE7f++LTEhaL6s5DnZ8WzF0/Zaz2CKVfkU+mH5UdtWD9E3HR512Y0P5s=
X-Received: by 2002:aed:3363:: with SMTP id u90mr107701528qtd.7.1565030157615;
 Mon, 05 Aug 2019 11:35:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190805165128.GA23762@roeck-us.net>
In-Reply-To: <20190805165128.GA23762@roeck-us.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 5 Aug 2019 20:35:40 +0200
Message-ID: <CAK8P3a1MLMu0qh-j9fZXmG10-q2SZrtFm9JGT_xOuuZHQm31qw@mail.gmail.com>
Subject: Re: [PATCH] page flags: prioritize kasan bits over last-cpuid
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 5, 2019 at 6:51 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Fri, Aug 02, 2019 at 09:49:02PM -0700, Arnd Bergmann wrote:
> > ARM64 randdconfig builds regularly run into a build error, especially
> > when NUMA_BALANCING and SPARSEMEM are enabled but not SPARSEMEM_VMEMMAP:
> >
> >   #error "KASAN: not enough bits in page flags for tag"
> >
> > The last-cpuid bits are already contitional on the available space, so
> > the result of the calculation is a bit random on whether they were
> > already left out or not.
> >
> > Adding the kasan tag bits before last-cpuid makes it much more likely to
> > end up with a successful build here, and should be reliable for
> > randconfig at least, as long as that does not randomize NR_CPUS or
> > NODES_SHIFT but uses the defaults.
> >
> > In order for the modified check to not trigger in the x86 vdso32 code
> > where all constants are wrong (building with -m32), enclose all the
> > definitions with an #ifdef.
> >
>
> This results in
>
> ./include/linux/page-flags-layout.h:95:2: error: #error "Not enough bits in page flags"
>  #error "Not enough bits in page flags"
>
> when trying to build mipsel64:fuloong2e_defconfig.

Do you have my follow-up fix applied?

https://ozlabs.org/~akpm/mmots/broken-out/page-flags-prioritize-kasan-bits-over-last-cpuid-fix.patch

       Arnd
