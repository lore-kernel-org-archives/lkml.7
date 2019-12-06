Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB5B6C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 15:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DB652173E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 15:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="FeMCmgTx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfLFP5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 10:57:35 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:35047 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbfLFP5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 10:57:34 -0500
Received: by mail-io1-f66.google.com with SMTP id v18so7845970iol.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 07:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oYj/cY+IkQcABP/RHpbzk07W4m53qLPa7pbqG3/gsVc=;
        b=FeMCmgTxO2XRIuqCt2y7vZTJL3AmoxCJwXwYGcmcnhXds5E4lwp6kZXlvcHvRz49e1
         LoM8XMuo5BZ6Dtm+LlpVMtbSYTf1TVZxbuxQoU3SNo9YThRNZ+cqO3BgNT13yEUNQc7N
         RG4o6U4lmt55i8dmqLhlUfSyam+zPxLEoxkBGvNltgP73MuapvUSsRGk/tXaZmn60QjD
         JxfLZrcUdsuj5Nb/svaY3elLeiNHrfRh6kpjYLIDFarfp06BLJq7Aaj8Iar+rGJVWDFI
         3SSV64UKJyypL8gdxXxaMncDT8mtE6ossa48o02EER2Dr1quEh1qP0FRiFAbOsjhkE9v
         L6Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oYj/cY+IkQcABP/RHpbzk07W4m53qLPa7pbqG3/gsVc=;
        b=mPkGUQibO2T6K+A1/w14NfNd1HIlUiQTjaTS6Rb2oKKMKQ2PLHqKR99AqILs9CEOdM
         tJMtSk90N8i8ahg3Neun0CQQBBSVWJXDA/1w4lkdb5u+C9IEPssDWQCMIReMmwKPxElB
         btqEIFYYjeQ9CSNtRCtUCNehNUPvzYoHF38xeS14Ay1wb5kLeImiDfzpy+ruzP9wprF7
         p4hL92WS8/a/7zMt7lY8tVdC2uhAsuUR9PLGkCppH/Qwv3z7yymynX+6ZNmD5F9jIr+q
         ShsuR8byn06C1YigGyKB+h69YDw3Scnq4HzO+KI3k5B1cSbyinbjJgmEwv2vrBsu89gl
         BxtQ==
X-Gm-Message-State: APjAAAVbB6Lf7cS5KFPKLSeQFnvNy8tHjyadOy9j5ow1FpuR1bTrS5XF
        h3q25fmoV/un1R6OM6OGoOkq5vUmNFoOL+/53jsedw==
X-Google-Smtp-Source: APXvYqyGyhUsvefq4YSTfs5lrMltP3arltw1tNx57NEnp74DB3h0rZIFJNink1+NYa3QS6J1cveyRbzyqwno0f6JjcU=
X-Received: by 2002:a5e:9314:: with SMTP id k20mr6149061iom.6.1575647853075;
 Fri, 06 Dec 2019 07:57:33 -0800 (PST)
MIME-Version: 1.0
References: <20191127133510.10614-1-brgl@bgdev.pl> <CACRpkdZ6e0GaE9KBJ1-E+cS_KnPY-EKLNxJFqjArr28hYMQqOg@mail.gmail.com>
 <CAMRc=McH6m3Lsvz8g1JSD_c-QNdb-Kh0+8BH5EKcEW2vM2VYJA@mail.gmail.com>
 <0058e57c-5765-3944-3137-10b780985a36@metux.net> <CAMRc=McHdtrvkLvT67ew1+88iPtRpd+MO1+5Tr3YsuLceQor1A@mail.gmail.com>
 <569d7017-fe19-2f4f-a402-a1f28b3c9e84@metux.net>
In-Reply-To: <569d7017-fe19-2f4f-a402-a1f28b3c9e84@metux.net>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 6 Dec 2019 16:57:21 +0100
Message-ID: <CAMRc=MegWJsSfRWuRDSpn+tO_VyLYKgQkBZ54rXW5sqG6WzjhA@mail.gmail.com>
Subject: Re: [PATCH 0/8] gpiolib: add an ioctl() for monitoring line status changes
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pt., 6 gru 2019 o 13:53 Enrico Weigelt, metux IT consult
<lkml@metux.net> napisa=C5=82(a):
>
> Hi,
>
> >> Oh, no, I've been afraid that this would be coming ... desktop bus in
> >> embedded system is a real nightmare. (yes, some people are even insane
> >> enough to put that thing on an public IP interface and so make critica=
l
> >> machinery like cards easily remote controllable by average school kids=
)
> >
> > Nah, you're overreacting, nobody is putting anything on the network.
>
> Maybe you've just missed that (maybe better for mental health ;-)), but
> people actually do put desktop bus on open networks. Chrysler/Harmann
> are an famous example (rendering the cars easily remote-controllable)
> I've had lots of similar cases w/ my clients. Whats going on in critical
> industries like automotive or medical often is a real nightmare. One of
> the reasons why I only buy old cars and do a careful inspection of
> physicians before allowing them to treat me or my family.
>

I admit - I mostly work in consumer electronics. The two times I
contracted for automotive companies I was actually surprised by how
seriously security was approached. Nothing like your stories. Maybe I
was just lucky though.

> IMHO, we should be careful about not encouraging folks out there to do
> silly things, just because they look so easy. (embedded development
> isn't entirely easy)
>
> > Most of my work isn't in upstream kernel development - it's actually
> > launching CE products. And it's been a long time since I've worked
> > with a client that could be convinced not to use systemd and dbus on
> > an embedded system.
>
> Yeah, same problem here. But actually, it's easier than one might think:
> let them run into a scenario where that malware really does horrible
> things and let the client drive against the wall. Some will learn,
> others won't - just let evolution optimize that :p
>
> > This just makes things so easy for people writing
> > high-level application code that it's become de-facto standard -
> > whether we like it or not.
>
> Yeah, "hilevel" code, that completely ignores vital aspects of the
> machine it then runs on, eg. RT or memory constraints. Seen that so
> many times. Emperical experience tells: sooner or later it will go
> nuts and things go horribly wrong. The unplesant question just is: how
> many people have get hurt or killed in the process.
>
> Lennartware isn't the only problem here, but also ancient and completely
> unmaintained vendor kernels, patched-to-deah by rookies (eg. ublox).
> OTOH, the positive side, eg. if I really need to get a *new* car, I'd
> pick one where I can disable surveillance stuff like "ecall" easily :p
>
> In general, what those industries completely ignore is maintainability
> and stability. There, this only exists on the paper (cubic meters of
> papers that formally look nice, but don't really tell anything about
> the *actual* important facts) - formally proven bullshit.
>
> I've made the personal decision that I don't wanna become yet another
> Edward Teller, neither do I wanna allow some BSG-type scenario. That's
> the reason I'm spending so much time in this discussion.
>

So I'm going through this e-mail for the third time now and I'm under
the impression it's mostly just an unrelated rant. I'm not even sure
how to respond.

> > This is just your personal anecdote. I could bring up several examples
> > of good implementations of event-based, dbus-oriented systems all
> > right. Bad programmers don't make tools they're using bad.
>
> Problem is: good programmers who can really deal with those concepts
> are hard to find. And those systems usually are hard to test. Desktop
> bus is magnitudes more complex than isolated FSMs.
>
> Within the last decades, I never had a single case where desktop bus had
> been the superior choice (actually, only few cases where purely event-
> driven architecture was a good idea).
>

It depends on what you're hired to do. Most of the time our clients
will have the entire applicative layer done by the time they reach out
to us. What they need is the BSP, OTA updates, provisioning and
factory tests. Good luck signing a deal if you start your pitch by
saying "your architecture is bad and you should feel bad". :)

> > I want to add this
> > new feature to allow for creating a central entity controlling GPIO
> > lines in the user-space. In case of sysfs - IT IS such a central
> > entity except that it lives in the kernel. It doesn't need to be
> > notified about changes in line properties.
>
> I'm still wondering why exactly one would want such an central entity
> in userspace and then letting it talk to others via desktop bus. At
> least in critical embedded systems, not talking about self-knittet
> hobby projects. Seems those ideas originate from people who don't know
> what the OS/Kernel is for :p
>
> Actually, I had a case where somebody attemted to do so (folks who tried
> linux embedded development from a windows machine :o). Fortunately,
> before they could write their planned "GPIO HAL" (several 10kLoc for
> just doing some trivial sysfs ops), I've configured the lines to the
> proper drivers in DT (basically, just some LEDs, inputs, rs485 signal
> lines, etc). Later on they started to write some "HAL" for LEDs,
> inputs, rs485 ... the manager of neighboring department on the other
> end of the room then ask me: "don't they know that they've got an
> operating system" ;-)
>
> Seriously, we shouldn't do everything that some strange folks are asking
> for, just to make them happy. We don't wanna desktop bus in the kernel,
> do we ? :p
>
> By the way: we *do* need some improvements for PLC-like applications:
> Highlevel provisioning of platform devices, eg. configure which devices
> are attached to certain interfaces in an specific installation, so the
> applications don't ever need any knowledge about that, but just talk
> to specific devices.
>
> Most of what's needed (on kernel side) is already there: DT overlays.
> Just yet have to get this working on non-DT (eg. ACPI platform).
>

Sure, but this has been discussed a lot already on linux-gpio. Linus
has just pointed out where GPIOs are used from user-space.

Bart

> In fact that's already in my pipeline, also for other purposes, eg.
> replace simple board or mfd drivers by just a DT snippet. Yet lacked the
> time to work out a suitable way for mixing DT and ACPI and allowing DT
> to override ACPI. But that's a topic for a completely different thread.
>
>
> --mtx--
>
> ---
> Enrico Weigelt, metux IT consult
> Free software and Linux embedded engineering
> info@metux.net -- +49-151-27565287
