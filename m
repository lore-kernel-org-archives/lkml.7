Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A0A8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0611820811
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O4waJeIf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfC1PqQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 11:46:16 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:44212 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbfC1PqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 11:46:16 -0400
Received: by mail-ua1-f65.google.com with SMTP id p13so532637uaa.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 08:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x6GzVSdXwcNSNCg9EEYQa+SsIfpHQ6Oq/KbUmOCLIdw=;
        b=O4waJeIfvIIVxBS61Xt6UjiEiYIcswHjKWeZ/nwi5WanyTLFeGbiElz5aIvIZygWYV
         JolZT9tCdLwcdRQ3mPP51oQzOUFTBrEDDruKCAX25Mb+Jda22yC9ATgZia/mYBzqi5qW
         ++ofRGxwCc+2lRglf/MllKq/m8F4//J3sPUDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x6GzVSdXwcNSNCg9EEYQa+SsIfpHQ6Oq/KbUmOCLIdw=;
        b=ksPzl90TV6NrVsdCBt4gutCVWiZX0ULFR/+Fe9esSmVgEQfKWblc3fhKNEGLr+X5KE
         5177JAHyZHdslNkE1P4yhsiqiiM3aHExgpJp3EtGh5rbUV/bDbtOnnkqtUU9i4AnBQNc
         N9dg34WJpIt6RTaR/UCKi+/S/h1zIcitMBQ11Wn0Knqbm3SDnp5nXYfvcg6ZTlDKx1UM
         rzvE1NRinuHzbclop/ugjG/5RRLWmeV+F30B2NGOT+g2m/CBydIusMGu9BSW+OI0gXM+
         STC6xvwAqFpaXjEHnUVUUXWiaHhq8k+L8tldVwpJrpOja/WF6XVe+gKadggp7/IGpktO
         XF1w==
X-Gm-Message-State: APjAAAW6kVqC6AENu3ygrbYoAhYn1Tw7Xp4p5pUGNCsGTKFoFTA0PmZ0
        ndDMNZOlhwd+vUbUqFZklYbWpRZeHAw=
X-Google-Smtp-Source: APXvYqwF2ORiVOkDh2yq7uMiuh9b0OXxJJkhMiKDmMVawIo3RK/C8VRCccq/khdJcTh7dyC6r1eYpw==
X-Received: by 2002:ab0:a97:: with SMTP id d23mr22922268uak.99.1553787974117;
        Thu, 28 Mar 2019 08:46:14 -0700 (PDT)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com. [209.85.221.175])
        by smtp.gmail.com with ESMTPSA id z79sm7956656vkd.18.2019.03.28.08.46.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 08:46:11 -0700 (PDT)
Received: by mail-vk1-f175.google.com with SMTP id x2so4602904vkx.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 08:46:10 -0700 (PDT)
X-Received: by 2002:a1f:2e07:: with SMTP id u7mr12513305vku.44.1553787970183;
 Thu, 28 Mar 2019 08:46:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190318094128.1488-1-elena.reshetova@intel.com>
 <CALCETrUxhzHyUQCAjPQcPNWwAw5UTxUX4ZaeGxpbf9VSCDdcPg@mail.gmail.com>
 <CAGXu5jLQaa2FYMOpQPLdRPmUPNY8jq7whM6Wa_YGjfH7oHwx4Q@mail.gmail.com>
 <2236FBA76BA1254E88B949DDB74E612BA4C19A55@IRSMSX102.ger.corp.intel.com> <CALCETrXnfk5zYWmpdLvYbcJ7hhFM13+LPq14MF7s99iqtS4-jg@mail.gmail.com>
In-Reply-To: <CALCETrXnfk5zYWmpdLvYbcJ7hhFM13+LPq14MF7s99iqtS4-jg@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 28 Mar 2019 08:45:57 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+r-NH5+QY=siE+6RTkUKoRF0Rso6KHM4NOMsCvpcjW5g@mail.gmail.com>
Message-ID: <CAGXu5j+r-NH5+QY=siE+6RTkUKoRF0Rso6KHM4NOMsCvpcjW5g@mail.gmail.com>
Subject: Re: [RFC PATCH] x86/entry/64: randomize kernel stack offset upon syscall
To:     Andy Lutomirski <luto@kernel.org>
Cc:     "Reshetova, Elena" <elena.reshetova@intel.com>,
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

On Tue, Mar 26, 2019 at 9:31 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> On Tue, Mar 26, 2019 at 3:35 AM Reshetova, Elena
> <elena.reshetova@intel.com> wrote:
> >
> > > On Mon, Mar 18, 2019 at 1:16 PM Andy Lutomirski <luto@kernel.org> wrote:
> > > > On Mon, Mar 18, 2019 at 2:41 AM Elena Reshetova
> > > > <elena.reshetova@intel.com> wrote:
> > > > > Performance:
> > > > >
> > > > > 1) lmbench: ./lat_syscall -N 1000000 null
> > > > >     base:                     Simple syscall: 0.1774 microseconds
> > > > >     random_offset (rdtsc):     Simple syscall: 0.1803 microseconds
> > > > >     random_offset (rdrand): Simple syscall: 0.3702 microseconds
> > > > >
> > > > > 2)  Andy's tests, misc-tests: ./timing_test_64 10M sys_enosys
> > > > >     base:                     10000000 loops in 1.62224s = 162.22 nsec / loop
> > > > >     random_offset (rdtsc):     10000000 loops in 1.64660s = 164.66 nsec / loop
> > > > >     random_offset (rdrand): 10000000 loops in 3.51315s = 351.32 nsec / loop
> > > > >
> > > >
> > > > Egads!  RDTSC is nice and fast but probably fairly easy to defeat.
> > > > RDRAND is awful.  I had hoped for better.
> > >
> > > RDRAND can also fail.
> > >
> > > > So perhaps we need a little percpu buffer that collects 64 bits of
> > > > randomness at a time, shifts out the needed bits, and refills the
> > > > buffer when we run out.
> > >
> > > I'd like to avoid saving the _exact_ details of where the next offset
> > > will be, but if nothing else works, this should be okay. We can use 8
> > > bits at a time and call prandom_u32() every 4th call. Something like
> > > prandom_bytes(), but where it doesn't throw away the unused bytes.
> >
> > Actually I think this would make the end result even worse security-wise
> > than simply using rdtsc() on every syscall. Saving the randomness in percpu
> > buffer, which is probably easily accessible and can be probed if needed,
> > would supply attacker with much more knowledge about the next 3-4
> > random offsets that what he would get if we use "weak" rdtsc. Given
> > that for a successful exploit, an attacker would need to have stack aligned
> > once only, having a knowledge of 3-4 next offsets sounds like a present to an
> > exploit writer...  Additionally it creates complexity around the code that I
> > have issues justifying with "security" argument because of above...

That certainly solidifies my concern against saving randomness. :)

> > I have the patch now with alloca() and rdtsc() working, I can post it
> > (albeit it is very simple), but I am really hesitating on adding the percpu
> > buffer randomness storage to it...
> >
>
> Hmm.  I guess it depends on what types of attack you care about.  I
> bet that, if you do a bunch of iterations of mfence;rdtsc;syscall,
> you'll discover that the offset between the user rdtsc and the
> syscall's rdtsc has several values that occur with high probability.

How about rdtsc xor with the middle word of the stack canary? (to
avoid the 0-byte) Something like:

    rdtsc
    xorl [%gs:...canary....], %rax
    andq  $__MAX_STACK_RANDOM_OFFSET, %rax

I need to look at the right way to reference the canary during that
code. Andy might know off the top of his head. :)

-Kees

-- 
Kees Cook
