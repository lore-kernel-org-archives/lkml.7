Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0928C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 10:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4D982184E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 10:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbfCNKlj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 06:41:39 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:39612 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727118AbfCNKlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 06:41:39 -0400
Received: by mail-vs1-f67.google.com with SMTP id w14so2911123vso.6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 03:41:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+VdadYvm6Sa2vP4FE+nW7Ys/0QPsgT0201wmAWSuKUs=;
        b=PeS+5bhNhaUhQ/8IA7UnCXg8DnWp0ayYkmPI40PF+7zA01Ywg4ZFwS2H50XGF1HJcs
         Yk0c+6SkEjBTHbwNj7s9URXRpGbwQaEW2JGMjmtyzwvNbi1SiU9tYgDXeIpjRI5tqe4R
         Wgir6vmShsyDQCpxFaCOmaUMylxNrOKALoKtLOA+snSahT+/Na9uYXmrvN9HPyBx2cAV
         567Emf6ZpHBW6/fPTPP6/uWY1iPnsHb8zrF56BbjzJrLFNieyOG+FJI3MWHWn3FDvY56
         3rFjraSrNi85GX87nC/AATNQydoD+ztv5CHgDkvJQcMnqBlIxOuknTx1sZlWMETuG3l6
         c8PA==
X-Gm-Message-State: APjAAAV+/zB5XQQpKVf21EdrfOe0n2/PJ4lcV2yM/cVGTbAbUm20lAUS
        LH7V4ZirdANSjj6u6riBQ+neqTGt4JNeYAqrSok=
X-Google-Smtp-Source: APXvYqyAaCMl9w+VP4wN3uvAPhrtMNDm8f/jvcQlI8hpuMxp+xl52Aq/0CQCfQqgYyq8aWgi4AyMcv62QW4uJ2rlbNA=
X-Received: by 2002:a67:7dd1:: with SMTP id y200mr22926680vsc.96.1552560098345;
 Thu, 14 Mar 2019 03:41:38 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1552097842.git.lkml@sdf.org> <dc6cc09e71f8687ff2ef4cbfc2b11accc9aba8aa.1552097842.git.lkml@sdf.org>
 <20190309140653.GO9224@smile.fi.intel.com> <201903091553.x29FrfMR018600@sdf.org>
 <20190314092958.GV9224@smile.fi.intel.com> <201903141009.x2EA9q1Z025888@sdf.org>
In-Reply-To: <201903141009.x2EA9q1Z025888@sdf.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 14 Mar 2019 11:41:26 +0100
Message-ID: <CAMuHMdW0jd-oNtgBf=aHfzVoBbVh0OJYC6ELhDv3VrcGwUECwA@mail.gmail.com>
Subject: Re: [PATCH 1/5] lib/sort: Make swap functions more generic
To:     George Spelvin <lkml@sdf.org>
Cc:     13@sdf.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrey Abramov <st5pub@yandex.ru>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Dave Chinner <dchinner@redhat.com>,
        Don Mullis <don.mullis@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi George,

On Thu, Mar 14, 2019 at 11:10 AM George Spelvin <lkml@sdf.org> wrote:
> On Sat, 09 Mar 2019 at 23:19:49 +0300, Andrey Abramov wrote:
> >> How about one of:
> >> swap_bytes / swap_ints / swap_longs
> >> swap_1 / swap_4 / swap_8
> >
> > longs are ambiguous, so I would prefer bit-sized types.
>
> I already implemented Andrey's suggestions, which were the exact
> opposite of yours.
>
> Pistols at dawn?

Prepared to fix all future long vs. int bugs?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
