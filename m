Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC02C606CA
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94CA7216FD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:13:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390449AbfGHTNP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 15:13:15 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37739 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731475AbfGHTNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 15:13:14 -0400
Received: by mail-oi1-f195.google.com with SMTP id t76so13503473oih.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 12:13:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=f/iAZk8KBALEXe3ofIcdjPtZ381Z/qPq9/MkPNAVFqo=;
        b=OSxU/xA8Yxia4FbjLvzAY8TI0Koco+PgCYOp+1kz5UDUJn0G+8lPlTEBIxcN0R8dzn
         HRfKtrG+gGy3MezkadPYVzQ/yzfwU+QMlQ3cp6X99QJw6ZipW48RKOFl71k+8dCGQfXj
         K2O0dMVajt81cH4ger8Su5Kx5aC8lC/I8iO7RwCnI26hgwEUXbg+I8A53WEKwtkNiHPz
         ufp5wzyRyQVN9lFHPnpNktHry4zUE0C4e7eh4nTtR3urtQ7yXo0wJKlw0jR0EQmix7PI
         74+bzENEe+bB92NjwOXsLbq/ECn6ANQM+YOSSQRGRmEX7ytUqU7d+Kv0DSkvgLSFDHL3
         6kkg==
X-Gm-Message-State: APjAAAVfRQ2Cu1SVDJTpcKdsUfG8CdA0FNWL5pOVWYw8ayyP8SN2gAx1
        4eYjW4wCsDDpC42vIESlVU+K0JwG64F9j2LjW3U=
X-Google-Smtp-Source: APXvYqymhb0R3YqY/8XLBja5zCuNRUxFv1wtunf5a3ohwI0qLU+ALtM04jLiTqu2Fr75SOJJ2YGfZJKd/xKLfZ9p2Zs=
X-Received: by 2002:aca:bd43:: with SMTP id n64mr9540644oif.148.1562613193671;
 Mon, 08 Jul 2019 12:13:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190708170647.GA12313@roeck-us.net>
In-Reply-To: <20190708170647.GA12313@roeck-us.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 8 Jul 2019 21:13:02 +0200
Message-ID: <CAMuHMdUnSqKHA7EN1S8U7eBODs4gi-raw4P3FxnR_afhb2Zd5g@mail.gmail.com>
Subject: Re: m68k build failures in -next: undefined reference to `arch_dma_prep_coherent'
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Günter,

On Mon, Jul 8, 2019 at 7:06 PM Guenter Roeck <linux@roeck-us.net> wrote:
> I see the following build error in -next:
>
> kernel/dma/direct.o: In function `dma_direct_alloc_pages':
> direct.c:(.text+0x4d8): undefined reference to `arch_dma_prep_coherent'
>
> Example: m68k:allnoconfig.
>
> Bisect log is ambiguous and points to the merge of m68k/for-next into
> -next. Yet, I think the problem is with commit 69878ef47562 ("m68k:
> Implement arch_dma_prep_coherent()") which is supposed to introduce
> the function. The problem is likely that arch_dma_prep_coherent()
> is only declared if CONFIG_MMU is enabled, but it is called from code
> outside CONFIG_MMU.

Thanks, one more thing to fix in m68k-allnoconfig (did it really build
before?)...

Given you say "example", does it fail in real configs, too?

Thanks again!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
