Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02804C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 22:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C089D2087C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 22:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfCMWCT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 18:02:19 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:41175 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbfCMWCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 18:02:18 -0400
Received: by mail-vs1-f65.google.com with SMTP id z25so710713vsk.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 15:02:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gnzaZMIFvG+8ej4dZ83Ov5j2OW1dyEDUrvODpUFkCzM=;
        b=ijZt8H0AnTqFIEIbngwipLWZSyotEyqs+gc0CDj0H5iE9hecx95RtY2RmBh+xgBI3w
         5HLWRL7/2pAh58oZRmIparpFCa6hW1yRR3S9vysezcjv428mET6xmloy+/DjnCWEv/XJ
         m0RRgsxJh2jDpZIYisWJaU+CcUJNYllIh/RerSRrLm/D70+EZco8TCCM8cnkenhp1B+o
         AiINBMViTOis9phPcRynfGGJIs+7dfu2iVyhgD7nbnOl45/p3cDpr8xHY9cfs7l3Vxnx
         YH4oS+niVK1KvKEglU+w8awWb0XbQOGTiRpmOqZGgMe5TRBw+OhAWbCvGuKnzLOFeNzX
         WpPw==
X-Gm-Message-State: APjAAAXWOv8X4xBLtWoXaVTbw3F2G3QYTbu0VMxVZWRlGnfN3O8lEGKP
        m3S7YtdhcxwIfdTsBsr7OYbDiVNVcA0EeKysNuE=
X-Google-Smtp-Source: APXvYqw2+2NJoFV4CDhzXkwpgQNMyG266PBjp+0FjE8X35X+QEoIJjygbNFM3oclv4NCxNmYg9vwSa1c1mBct6WFPWM=
X-Received: by 2002:a67:8588:: with SMTP id h130mr23145104vsd.11.1552514537877;
 Wed, 13 Mar 2019 15:02:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1552097842.git.lkml@sdf.org> <dc6cc09e71f8687ff2ef4cbfc2b11accc9aba8aa.1552097842.git.lkml@sdf.org>
 <6e08375f-6960-546b-39a6-26ff24a0ce0e@rasmusvillemoes.dk>
In-Reply-To: <6e08375f-6960-546b-39a6-26ff24a0ce0e@rasmusvillemoes.dk>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 13 Mar 2019 23:02:06 +0100
Message-ID: <CAMuHMdVj43Kd7Pm7t4oZZBbe-rJi_-wAmiY9HxR73zkdb8ypoQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] lib/sort: Make swap functions more generic
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     George Spelvin <lkml@sdf.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Abramov <st5pub@yandex.ru>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Don Mullis <don.mullis@gmail.com>,
        Dave Chinner <dchinner@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 10:23 PM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
> On 21/02/2019 07.30, George Spelvin wrote:
> > +#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> > +     (void)base;
> > +#else
> > +     lsbits |= (unsigned int)(size_t)base;
>
> The kernel usually casts pointers to long or unsigned long. If some
> oddball arch has size_t something other than unsigned long, this would
> give a "warning: cast from pointer to integer of different size". So
> just cast to unsigned long, and drop the cast to unsigned int.

The proper integer equivalent of a pointer is uintptr_t, so please use
that instead of size_t.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
