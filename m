Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4095BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 21:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 068452133D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 21:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LC0eWcDs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbfCRVIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 17:08:14 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:46658 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbfCRVIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 17:08:14 -0400
Received: by mail-vs1-f68.google.com with SMTP id w26so7922008vsk.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 14:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ewue4iLQcqCU/D+3xpcgmp49XIxCEkCpFULXlCGIWEc=;
        b=LC0eWcDsrQESkH+odyGHuaL+lmflxcBH7qIQ9x6gQISH5E07dD84iwjAQ2pEkpolsa
         yHnodbzKBVRzB66kgAc2/uz9WzUphHHMdDmXSMb4CzOsb2e6G+CX74QVV8iO4Ac766mc
         lgQ0dGvL9eYmqFZzxBZdl/ohGu21kOYKf0uaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ewue4iLQcqCU/D+3xpcgmp49XIxCEkCpFULXlCGIWEc=;
        b=IqRiAgaNpaXc1XbQygE5VB6yXQqs59agUuBbh7hrMi6t12IW33ivt12eJivVKH70ib
         aFmR4mhDNJLeMfH7Ns/oCdyZZ4kcJ5bfHQqfZpvq+LWzy82LUKrh2mmRU1Vw5cdhPshr
         /xDM2jDi6lj8qX8rpxHWvhHBL0lNYk4CRaESRAuXF5Yxpm1NTYfvyQdopqJsuawbd7wd
         +DTXjYFrDLfP+oyJRL1N9kA+2vrX/mfvMP8TxF9Zz+KPuNwcb2qVqFOZrW/MX6FrY1/m
         HpSZAdJiaHn3fLD81cmCERzUjyJ8+Bi5U8/LpTbsbFnkVJQfPTjFqUKf8JFqwGFuf1r2
         geeQ==
X-Gm-Message-State: APjAAAUIvHc9wBINzc1F9fwAdwzuCLz/bPRVNSOqlK+8j0laQ+r83nyt
        DaS+YDFeYWx9sNHGj1uDSAzv/Bgo5wk=
X-Google-Smtp-Source: APXvYqwyJhRAEi3KelZADIuS05Uu7kc013A6a1MJjfaLO7FF3FGZRVLbu3l61IB1NTO0nJv0Sba06g==
X-Received: by 2002:a67:76d7:: with SMTP id r206mr6263962vsc.25.1552943291796;
        Mon, 18 Mar 2019 14:08:11 -0700 (PDT)
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com. [209.85.221.169])
        by smtp.gmail.com with ESMTPSA id b186sm4029346vke.17.2019.03.18.14.08.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 14:08:10 -0700 (PDT)
Received: by mail-vk1-f169.google.com with SMTP id k64so4135485vke.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 14:08:09 -0700 (PDT)
X-Received: by 2002:a1f:2acb:: with SMTP id q194mr9920042vkq.92.1552943289236;
 Mon, 18 Mar 2019 14:08:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190318094128.1488-1-elena.reshetova@intel.com> <CALCETrUxhzHyUQCAjPQcPNWwAw5UTxUX4ZaeGxpbf9VSCDdcPg@mail.gmail.com>
In-Reply-To: <CALCETrUxhzHyUQCAjPQcPNWwAw5UTxUX4ZaeGxpbf9VSCDdcPg@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 18 Mar 2019 14:07:57 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLQaa2FYMOpQPLdRPmUPNY8jq7whM6Wa_YGjfH7oHwx4Q@mail.gmail.com>
Message-ID: <CAGXu5jLQaa2FYMOpQPLdRPmUPNY8jq7whM6Wa_YGjfH7oHwx4Q@mail.gmail.com>
Subject: Re: [RFC PATCH] x86/entry/64: randomize kernel stack offset upon syscall
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Elena Reshetova <elena.reshetova@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jann Horn <jannh@google.com>,
        "Perla, Enrico" <enrico.perla@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 1:16 PM Andy Lutomirski <luto@kernel.org> wrote:
> On Mon, Mar 18, 2019 at 2:41 AM Elena Reshetova
> <elena.reshetova@intel.com> wrote:
> > Performance:
> >
> > 1) lmbench: ./lat_syscall -N 1000000 null
> >     base:                     Simple syscall: 0.1774 microseconds
> >     random_offset (rdtsc):     Simple syscall: 0.1803 microseconds
> >     random_offset (rdrand): Simple syscall: 0.3702 microseconds
> >
> > 2)  Andy's tests, misc-tests: ./timing_test_64 10M sys_enosys
> >     base:                     10000000 loops in 1.62224s = 162.22 nsec / loop
> >     random_offset (rdtsc):     10000000 loops in 1.64660s = 164.66 nsec / loop
> >     random_offset (rdrand): 10000000 loops in 3.51315s = 351.32 nsec / loop
> >
>
> Egads!  RDTSC is nice and fast but probably fairly easy to defeat.
> RDRAND is awful.  I had hoped for better.

RDRAND can also fail.

> So perhaps we need a little percpu buffer that collects 64 bits of
> randomness at a time, shifts out the needed bits, and refills the
> buffer when we run out.

I'd like to avoid saving the _exact_ details of where the next offset
will be, but if nothing else works, this should be okay. We can use 8
bits at a time and call prandom_u32() every 4th call. Something like
prandom_bytes(), but where it doesn't throw away the unused bytes.

-- 
Kees Cook
