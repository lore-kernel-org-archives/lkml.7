Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85058C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 20:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 500272166E
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 20:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565382074;
	bh=b5ZK9j4Wq2pvFD1iS1I1/Vw1KmYH7fCxHt95Sms61y8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=bHdfrGdaiP2TH2So0Y34wSadneTutEtv4hx6TUCXIcERnjTL+xDyWYPxaOTQS6N/2
	 nF/pXQ9Qlg0ojc3bxuQ9ZQW8mIgXpOmYqLmOl7OGamH6I6Kx1L5Lnbuk24PT63ppka
	 x3MJMiSg5Ulq/rNqBfc0IZXuTVPVd8afAEqU9ncU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfHIUVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 16:21:13 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46163 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfHIUVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 16:21:12 -0400
Received: by mail-lj1-f194.google.com with SMTP id v24so93345764ljg.13
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 13:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b+WuzQJ72s+s55WdGrB/VNoub8TGAPzVmj1NuZWRwNg=;
        b=e3coo6sSaC5j2muBs53ynP4CEu65iZmHkIOEmoMKYz8/sBgbKCa2qnMS1MbdVrAo1r
         nzrpKTbzY/TfaOxKeuqnLBzNpONk1xJ35/7xxGVRKnPoo00kWNMZ6Xzr/3smNvCy8yWh
         lLoAlVi5WeefZbFz22+OPpuVUJiIppTk3Xbio=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b+WuzQJ72s+s55WdGrB/VNoub8TGAPzVmj1NuZWRwNg=;
        b=HdukFzOWJEJVJv1Fgjz0uDQlmdZdbJhDGFznCzNjMA5yEh6WYO6nQy4RGTTVFrjwqG
         76uD+GsCQyoPEWggOMlkAyGPCM59WtYjRD+lm8a6EcSKFiZsQIk6EGRcNQZsE7Wd1ICq
         ANWfyNtmnST2cNxDfh3clRTWADtt4if8bEZ/bDD3yEtTVU1kK1J2DLa+vzJ1dsZ+z7FH
         ttXX6IIMiJJfw6o5eamT33304gBvsFpPip6DSYNPn0QGUX6e66OdOs6np67EMh9LLCAQ
         0Zcbgjgjv2XDU97JYMkBmGd/nQldrc1nreWdAe7OkE5JlFZ9ru+4/RLj/A0OdH4v9+gO
         qHxA==
X-Gm-Message-State: APjAAAUMGFQrAGJESdk1rtb3Z0c4RAfJdVi3Dwe6i7mOLU8ZhJMtgly6
        Pk18lQ2kNcQNAp1dllQcxD41lydg3uk=
X-Google-Smtp-Source: APXvYqzJlBjWhSrNAR9DbkmffzTKqDU2j6pgNQXrv1yAsSxe/otjtyhKPkDxGbIycXjwKLCGHjZELA==
X-Received: by 2002:a2e:9010:: with SMTP id h16mr12778425ljg.49.1565382069822;
        Fri, 09 Aug 2019 13:21:09 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id v17sm21979221ljg.36.2019.08.09.13.21.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Aug 2019 13:21:07 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id r9so93170463ljg.5
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 13:21:07 -0700 (PDT)
X-Received: by 2002:a2e:9192:: with SMTP id f18mr12296254ljg.52.1565382066715;
 Fri, 09 Aug 2019 13:21:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190807222634.1723-1-john.ogness@linutronix.de>
 <20190807222634.1723-10-john.ogness@linutronix.de> <CAHk-=wiKTn-BMpp4w645XqmFBEtUXe84+TKc6aRMPbvFwUjA=A@mail.gmail.com>
 <874l2rclmw.fsf@linutronix.de> <CAHk-=wiRN9v7UmhbTZgskh-MLyY2f0-8Zi3fUziy+GpZnj2i3w@mail.gmail.com>
 <20190808194523.6f83e087@gandalf.local.home> <CAHk-=wiRpvRg6dpEWqaB20QUFRq8or0-AGgkjvisygptRE64UA@mail.gmail.com>
 <20190808204841.5afcad46@gandalf.local.home> <CAHk-=whNcrysjJYPDFhKAc4tvd80XGAyh95oZeAY6bmzpv3G-A@mail.gmail.com>
 <alpine.DEB.2.21.1908091306520.21433@nanos.tec.linutronix.de>
 <CAHk-=wiDzz+KU-ArqpnzjYkvDtKWjUqMfiiJXpXhgYU+Wd0r-w@mail.gmail.com> <alpine.DEB.2.21.1908092141490.21433@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1908092141490.21433@nanos.tec.linutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 9 Aug 2019 13:20:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgTEs7AFTxQPsqpHS1JN9OU1eiY6eCdFjxnKSU_1POx=g@mail.gmail.com>
Message-ID: <CAHk-=wgTEs7AFTxQPsqpHS1JN9OU1eiY6eCdFjxnKSU_1POx=g@mail.gmail.com>
Subject: Re: [RFC PATCH v4 9/9] printk: use a new ringbuffer implementation
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 9, 2019 at 1:07 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> I'm all for it. I just tried it out and the ratio was 3 out of 5 retained
> the data +/- a few bitflips with ~2 seconds power off. The other two were
> the laptop and that server machine which wipes everything.

Perfect. That actually says "the theory works". My desktop worked only
on warm reboot - which isn't really the interesting case (it does
cover things like triple boots etc and "press reset button when it
hangs, so it *can* be helpful, but even on desktops reset buttons seem
to be getting less common).

But yes, the whole thing where BIOSes wipe everything is problematic,
but that's where I just need to ping the right people inside Intel
again.

I did send the patch to inside Intel earlier, but I think the timing
for that might have been bad (people were on vacation), so I should
just reach out to more Intel people.

It would be better to have a more polished patch (the whole "fixed
address at around 12GB physical" really is such a horrible hack), but
I dreaded actually parsing the e280 memory map to do some "static for
one particular configuration" thing.

I should just do that and have something that Intel HW and FW people
can test on any hardware.

> If that can be avoided with some ACPI tweak especially on the laptop, that
> would be great. I'm not so worried about the server case.

Yeah, the server case I think we have covered other ways. Plus people
running them tend to have serious developer resources anyway.

They might still use something like this for some convenient
first-order debugging if we end up having generally available, of
course, but the target really is "random laptop or home user that uses
a distro and can't be expected to even try to sanely report - much
less debug - a hung machine condition".

                     Linus
