Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C3B9C43613
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 20:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 765FB206BF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 20:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730103AbfFSUC3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 16:02:29 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43295 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfFSUCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 16:02:25 -0400
Received: by mail-qk1-f194.google.com with SMTP id m14so349372qka.10
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 13:02:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Jp00XoiVvGbGlEluLFIXyTXkAggQEZTk36BNSSi00I=;
        b=iqDUZ+ZV8rQn3Mm9g5EyM4+rrBwiLKizSA76VstCyLsEWiletxiDlo9FFuZbBmCC9t
         kE34zck9XE80SOit1dRWqAWrzyjxNzOn1+8JWyhDZ/dPKNKGyrAnQy5zxrOypJLIf3wQ
         wjX1IlA4CEaKLYPfqYkTuktkvILtXpG+yLg32O70AKqNbBlS7PH49U6FkJPHSo9gJjIb
         uERyQSOw5IrHkh/RtCAN0IuoRD4bfODthfMvvxwt8RJ0Dc8zDjh9ytc/oZxjAtAqm2FK
         ZmIoFdUHqBk1j1tV2xVnpYYtE6z6rB7Yyyg288ZAIzefOYdWWzbuLDfxfGNK2Em0AfPN
         mLaQ==
X-Gm-Message-State: APjAAAUDc6EIXSjdcRMsWKY5RC88SlHsg25KfN/81AOTKq1yUmDI9uQH
        15vOMj72hwIRpphaKGEE61Om8SlsmRgTbkUSYpNU9G8e
X-Google-Smtp-Source: APXvYqx4FzKkNpfMVs1Y/1dVTHfAfGLNC0mnAy2KZoNX2en8RfEpPMlR3YrGpas5Ii8+mt3Tk8RwAjlT3JBWeB08Las=
X-Received: by 2002:ae9:c106:: with SMTP id z6mr80901779qki.285.1560974544874;
 Wed, 19 Jun 2019 13:02:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190619142350.1985-1-Jason@zx2c4.com> <CAK8P3a10PfTOhLA9d3vMTV_YXqymKLNeqCg6r7dLiNA1BwJbmA@mail.gmail.com>
 <CAHmME9rYgKxNyLH4MFJwaj4188O5N6vjseQRHwF0n5pZhU8kuw@mail.gmail.com>
In-Reply-To: <CAHmME9rYgKxNyLH4MFJwaj4188O5N6vjseQRHwF0n5pZhU8kuw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 19 Jun 2019 22:02:07 +0200
Message-ID: <CAK8P3a1Wirao3s4Xz4Rgkc1FkpT4isMNuuPv7X7orwX4fcotXg@mail.gmail.com>
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

On Wed, Jun 19, 2019 at 5:31 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Hi Arnd,
>
> On Wed, Jun 19, 2019 at 5:08 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > Can you quantify how much this gains you over ktime_get_coarse_boottime
> > in practice? You are effectively adding yet another abstraction for time,
> > which is something I'd hope to avoid unless you have a strong reason other
> > than it being faster in theory.
>
> Excellent idea. It turns out to be precisely 0 (see below). A
> motivation still remains, though: this allows comparison with units
> specified in terms of jiffies, which means that the unit being
> compared matches the exact tick of the clock, making those comparisons
> as precise as possible, for what they are. I suppose you could argue,
> on the other hand, that nanoseconds give so much precision already,
> that approximations using them amount practically to the same thing.
> I'm not sure which way to reason about that.
>
> For interest, here are a few comparisons taken with kbench9000:
>
> get_jiffies_boot_64 26
> ktime_get_coarse_boottime 26
> ktime_get_boot_fast_ns with tsc 70
> ktime_get_boot_fast_ns with hpet 4922
> ktime_get_boot_fast_ns with acpi_pm 1884
>
> As expected, hpet is really quite painful.

I would prefer not to add the new interface then. We might in
fact move users of get_jiffies_64() to ktime_get_coarse() for
consistency given the small overhead of that function.

      Arnd
