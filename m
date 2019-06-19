Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67487C31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 15:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24AD021721
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 15:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="xsyBW9KO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729695AbfFSPbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 11:31:20 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:40405 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbfFSPbT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 11:31:19 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id ec707413
        for <linux-kernel@vger.kernel.org>;
        Wed, 19 Jun 2019 14:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=w8y7eK0gVXHkM1cVaxVMErYvvqU=; b=xsyBW9
        KOz4qEpl9uSATvc2OFtNLrg8oRCJLKhF15N784Cmlzvmfcj066WuTpJXytVFhHAy
        D+msNk0cvg0h0kglREJtxYQzkiWC9lSAzFIwI8TjL3b9RbKG6migxtStAySVmcWL
        cU0TzkiIawQs8PsqMYM3Wss0f6ZEevYWQYUKmfeEDUF+KgpJOaNAkqOuQRIl0Pb5
        1L3Pp0Rm1RVBoCFEYCUpZKApsQSxsE6NipUdg0YD8XZy1fe+IlYDLYo999lvd3EO
        Zd1sbzcuUY0iX8OzQh+5NiOZG4zFH91UB0JROhJ0tLYyLKn4rqhtnD8yyfoRWFNy
        u90ZHNkYn2q6WkwA==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 0ac3de95 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Wed, 19 Jun 2019 14:58:07 +0000 (UTC)
Received: by mail-ot1-f41.google.com with SMTP id s20so19722462otp.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 08:31:16 -0700 (PDT)
X-Gm-Message-State: APjAAAUWlqVLKCsy+JdRnkAVmt3HIG9a1zczsnvtYBZvyDk/3X3SuuTX
        4p5M9RYxq3vQYUo6Y41EaeQ/K2OVdN5tZIuiFgQ=
X-Google-Smtp-Source: APXvYqyfw4ZVlo60FlVyqNYz5xzxMIXNGpzXGGxUIYNTkQmPXihsmO6CDl56Fxpa0mkKltcza+pecaT9i1llY8r1KpE=
X-Received: by 2002:a05:6830:2148:: with SMTP id r8mr19880801otd.179.1560958275697;
 Wed, 19 Jun 2019 08:31:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190619142350.1985-1-Jason@zx2c4.com> <CAK8P3a10PfTOhLA9d3vMTV_YXqymKLNeqCg6r7dLiNA1BwJbmA@mail.gmail.com>
In-Reply-To: <CAK8P3a10PfTOhLA9d3vMTV_YXqymKLNeqCg6r7dLiNA1BwJbmA@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 19 Jun 2019 17:31:04 +0200
X-Gmail-Original-Message-ID: <CAHmME9rYgKxNyLH4MFJwaj4188O5N6vjseQRHwF0n5pZhU8kuw@mail.gmail.com>
Message-ID: <CAHmME9rYgKxNyLH4MFJwaj4188O5N6vjseQRHwF0n5pZhU8kuw@mail.gmail.com>
Subject: Re: [PATCH v2] timekeeping: get_jiffies_boot_64() for jiffies that
 include sleep time
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Wed, Jun 19, 2019 at 5:08 PM Arnd Bergmann <arnd@arndb.de> wrote:
> Can you quantify how much this gains you over ktime_get_coarse_boottime
> in practice? You are effectively adding yet another abstraction for time,
> which is something I'd hope to avoid unless you have a strong reason other
> than it being faster in theory.

Excellent idea. It turns out to be precisely 0 (see below). A
motivation still remains, though: this allows comparison with units
specified in terms of jiffies, which means that the unit being
compared matches the exact tick of the clock, making those comparisons
as precise as possible, for what they are. I suppose you could argue,
on the other hand, that nanoseconds give so much precision already,
that approximations using them amount practically to the same thing.
I'm not sure which way to reason about that.

For interest, here are a few comparisons taken with kbench9000:

get_jiffies_boot_64 26
ktime_get_coarse_boottime 26
ktime_get_boot_fast_ns with tsc 70
ktime_get_boot_fast_ns with hpet 4922
ktime_get_boot_fast_ns with acpi_pm 1884

As expected, hpet is really quite painful.

Jason
