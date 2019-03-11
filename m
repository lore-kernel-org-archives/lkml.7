Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD77DC10F06
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9908A2075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbfCKOUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 10:20:23 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44633 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727219AbfCKOUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 10:20:22 -0400
Received: by mail-qk1-f195.google.com with SMTP id u22so2766898qkj.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 07:20:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Y3MYVOh5XrWx8jyQqXUdSXlpmDeQ4BYs/m6bZ/MDUg=;
        b=RGen8QXON6bfwW5JixZ2FmVPXL/Gvk5CZCTUODjjqB6hT0Je4DtUpMzZu9k9hJ45qJ
         A7couNTES6ivZR5DVj0zpZ7mLIPrA2eDycgbEG9ZckIOTYrtvwQCn0j6LOx/7YqPCalN
         d03UfaXiYdkPe9y2D6xxxHW0IG4UuVQygQHIpKIb738Xv6Qy3QPhF6UM+htFPaw8aAMr
         Dp3yyeZL7YqIFAzl/PMJ/nKehGIutiEh3okVnNPJiOpZXLpuV2xojs5ZM4oVXLF5P94G
         FpEH9VHhDAsPWU8FB6jF1V+E7SyzAoERc5Q6sR4EAqR3Y3JnjEuhyAWmbA4df6pbue+z
         k6XQ==
X-Gm-Message-State: APjAAAXpqXid/+9lwVqebMFgunBFgCRSZjyPSvNX6+xLPPlD9JlldauD
        Kep/dislGKX63HR9UZc1aSfbEssDXk1BtJOM9z0=
X-Google-Smtp-Source: APXvYqwEkNkObrgu0s7jgf1NG7rEFN32sPNQ5/QbDS3VJOqC4lzuD8NgGXPrL7k6qfcPkHcn4TLzbDTZ2u/bnfvHI6s=
X-Received: by 2002:a05:620a:158c:: with SMTP id d12mr7991661qkk.173.1552314021843;
 Mon, 11 Mar 2019 07:20:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190310183051.87303-1-cai@lca.pw> <20190311035815.kq7ftc6vphy6vwen@linux-r8p5>
 <20190311122100.GF22862@mellanox.com> <1552312822.7087.11.camel@lca.pw>
In-Reply-To: <1552312822.7087.11.camel@lca.pw>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 11 Mar 2019 15:20:04 +0100
Message-ID: <CAK8P3a0QB7+oPz4sfbW_g2EGZZmC=LMEnkMNLCW_FD=fEZoQPA@mail.gmail.com>
Subject: Re: [PATCH] mm/debug: add a cast to u64 for atomic64_read()
To:     Qian Cai <cai@lca.pw>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 3:00 PM Qian Cai <cai@lca.pw> wrote:
>
> On Mon, 2019-03-11 at 12:21 +0000, Jason Gunthorpe wrote:
> > On Sun, Mar 10, 2019 at 08:58:15PM -0700, Davidlohr Bueso wrote:
> > > On Sun, 10 Mar 2019, Qian Cai wrote:
> >
> > Not saying this patch shouldn't go ahead..
> >
> > But is there a special reason the atomic64*'s on ppc don't use the u64
> > type like other archs? Seems like a better thing to fix than adding
> > casts all over the place.
> >
>
> A bit of history here,
>
> https://patchwork.kernel.org/patch/7344011/#15495901

Ah, I had already forgotten about that discussion.

At least the atomic_long part we discussed there has been resolved now
as part of commit b5d47ef9ea5c ("locking/atomics: Switch to generated
atomic-long").

Adding Mark Rutland to Cc, maybe he has some ideas of how to use
the infrastructure he added to use consistent types for atomic64()
on the remaining 64-bit architectures.

     Arnd
