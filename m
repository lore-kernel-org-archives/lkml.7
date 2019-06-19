Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B64C43613
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 20:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2878F21537
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 20:57:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730496AbfFSU5b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 16:57:31 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42374 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbfFSU5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 16:57:31 -0400
Received: by mail-qt1-f194.google.com with SMTP id s15so721673qtk.9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 13:57:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fSlw55/yld93e59Rd2Ook8YKv0PG/dKQ65z+baUlLDo=;
        b=qJ7tuuyp8baYcr3DGTuhqvQ1n738OFUS+JYBT2YwVJzAkMsaKZxCrf8DQHQsyBSqKW
         tQQw9Suz9jIouDOnqROb+PDQ4BQDGkWIO/RDkxQm//NVVk7bSTBSHjd7XksCAawMpQ30
         DIShozNoqUN9samQtmjmzBdENZgdRWz1FJs1HJQo/J2Ry1t11kQUJ2iqvEIcqf1phbhZ
         W3aSmZTbqDKJcSEHHVKQzqnf4gxtXBp8+Wt1Nxyl9Gesfze1NxqgMWyDoC2Ki0QWdXu+
         QDcVnsCOqdiV/wEsfmzTH7PsaloGPLTCI4ze9U486QwCZoOhR7Yc/Sz/YJONnU4mWQb6
         xk4g==
X-Gm-Message-State: APjAAAXedh4Cx9SONEOvfdTf/BV4O64JBuok1jWI6bjxOiMZE49UMZ75
        KVOdbTTM6gLAhkIuth1cOO+upztxBBkwmHEif+BNi+3mzPE=
X-Google-Smtp-Source: APXvYqwZ8sStOlMVHCI7mwULzEszJBdAKxYheaUsQJG07pcvJKh35ofmykH68/g27jT0Iv9gy7L0WjmTtuynYl9/F0c=
X-Received: by 2002:a0c:b758:: with SMTP id q24mr35709378qve.45.1560977850467;
 Wed, 19 Jun 2019 13:57:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190619142350.1985-1-Jason@zx2c4.com> <CAK8P3a10PfTOhLA9d3vMTV_YXqymKLNeqCg6r7dLiNA1BwJbmA@mail.gmail.com>
 <CAHmME9rYgKxNyLH4MFJwaj4188O5N6vjseQRHwF0n5pZhU8kuw@mail.gmail.com>
 <CAK8P3a1Wirao3s4Xz4Rgkc1FkpT4isMNuuPv7X7orwX4fcotXg@mail.gmail.com> <CAHmME9pk7zXMSGiofPMppzA=dy__qttg00LtwqU7oSz032jtWQ@mail.gmail.com>
In-Reply-To: <CAHmME9pk7zXMSGiofPMppzA=dy__qttg00LtwqU7oSz032jtWQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 19 Jun 2019 22:57:11 +0200
Message-ID: <CAK8P3a2oLUKjY+3Qki59ruygzSb1Vsaoo5Et3BecGzpG8-=tOA@mail.gmail.com>
Subject: Re: [PATCH v2] timekeeping: get_jiffies_boot_64() for jiffies that
 include sleep time
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 10:07 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> On Wed, Jun 19, 2019 at 10:02 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > get_jiffies_boot_64 26
> > > ktime_get_coarse_boottime 26
> > > ktime_get_boot_fast_ns with tsc 70
> > > ktime_get_boot_fast_ns with hpet 4922
> > > ktime_get_boot_fast_ns with acpi_pm 1884
> > >
> > > As expected, hpet is really quite painful.
> >
> > I would prefer not to add the new interface then. We might in
> > fact move users of get_jiffies_64() to ktime_get_coarse() for
> > consistency given the small overhead of that function.
>
> In light of the measurements, that seems like a good plan to me.
>
> One thing to consider with moving jiffies users over that way is
> ktime_t. Do you want to introduce helpers like
> ktime_get_boot_coarse_ns(), just like there is already with the other
> various functions like ktime_get_boot_ns(), ktime_get_boot_fast_ns(),
> etc? (I'd personally prefer using the _ns variants, at least.) I can
> send a patch for this.

That sounds reasonable, but then I think we should have the full
set of coarse_*_ns() functions, again for consistency:

                u64 ktime_get_coarse_ns(void)
                u64 ktime_get_coarse_boottime_ns(void)
                u64 ktime_get_coarse_real_ns(void)
                u64 ktime_get_coarse_clocktai_ns(void)

and document them in Documentation/core-api/timekeeping.rst.

We seem to also be lacking the basic ktime_get_coarse(), which
seems like a major omission.
Both ktime_get_coarse_ns and ktime_get_coarse can be wrappers
around ktime_get_coarse_ts64() then, while the others would
use ktime_get_coarse_with_offset().

       Arnd
