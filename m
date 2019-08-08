Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBD3C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 23:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEEF621479
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 23:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565307222;
	bh=aYYKyu24ioatkVHHxoo036vaYtdPOB2oMxD5+k4EE+U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Jf6qhxI5uiRbRIaTcHlubX4SO+yTejbadOub4xPc4AZL0NEaDxIHy/rWugkDKEMcf
	 G9I4bCcd/OvtInFbpmrDHXbBwihnYDV0AQ9/8vMYxgoNdQX3Z6e0PY8lHck1X/9HyE
	 IKeY7UvoYOXOiIGBY0Z8btB4Azm05xs15S5o9ljI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390463AbfHHXdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 19:33:41 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43568 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbfHHXdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 19:33:40 -0400
Received: by mail-lf1-f67.google.com with SMTP id c19so68119701lfm.10
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 16:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R4mB7KEnTk0oXsSTN7hE/ftaT2dIWlU90vfeoQXM6Js=;
        b=fe8z2V6zR8ZqZ4+v2B61wan+Iv8qRYf8aBIryr47YF5IObucwDxeAtbVSmO7zACK++
         hTgt7w1O/0rYwlmFacv/P/dYU8Bqv9plC046U8k3ei4ICmOLGqbCJUJ2JymhO7K7e8hI
         VzKXt2SjxernMM+hKny+bpLCrdlhwxpBl5ekg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R4mB7KEnTk0oXsSTN7hE/ftaT2dIWlU90vfeoQXM6Js=;
        b=MSuzoXkdBApLuapE7+Y8TN1lblKpJWvJNKsmwTqn5bvlSRrJ21Ok9LkByKwyilC7ix
         yJB7j+30FVpigfwrBa2a4ngH0i/Qx4CzVsWFDOSsLkEK24PC/Ot17+ycfPraGbyyzpZi
         autZMXvDIgUZhoT6xgJC9FLm0l83u0JGNCAmfUZT+XoeM9gvqnVD4ugVgl8bT2jPiWDz
         g80/DGq/Hb+xggkLRO06v65rTImz3FPhWbxgTySvjQyAt5Pu74Myj4Zq6mGBQYUQrE0a
         DLJZGFbQYmcn9furzQfsxk0YwKtCy4XJvBuqk7NXhZrStx6/kD/sO56t6tiaAYtv0Slx
         J+bQ==
X-Gm-Message-State: APjAAAVi1rjIbUBT5F6hpma610lbAwgW1jf++isbB27vI2CH3tU87FVr
        XaHrosg1x7kDHlKZ2rDcWqUFIU/ppck=
X-Google-Smtp-Source: APXvYqwzLmIe08LiOMWxQVZdGVCOQvQ3qoY9MqTiVHc6zYT3DijZVN70MofXTpFRq3WLeDZYfC44Hg==
X-Received: by 2002:a19:ca0d:: with SMTP id a13mr10473739lfg.110.1565307218026;
        Thu, 08 Aug 2019 16:33:38 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id e62sm19175792ljf.82.2019.08.08.16.33.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Aug 2019 16:33:36 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id z15so63840404lfh.13
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 16:33:36 -0700 (PDT)
X-Received: by 2002:ac2:5976:: with SMTP id h22mr10722221lfp.79.1565307216136;
 Thu, 08 Aug 2019 16:33:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190807222634.1723-1-john.ogness@linutronix.de>
 <20190807222634.1723-10-john.ogness@linutronix.de> <CAHk-=wiKTn-BMpp4w645XqmFBEtUXe84+TKc6aRMPbvFwUjA=A@mail.gmail.com>
 <874l2rclmw.fsf@linutronix.de>
In-Reply-To: <874l2rclmw.fsf@linutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 8 Aug 2019 16:33:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiRN9v7UmhbTZgskh-MLyY2f0-8Zi3fUziy+GpZnj2i3w@mail.gmail.com>
Message-ID: <CAHk-=wiRN9v7UmhbTZgskh-MLyY2f0-8Zi3fUziy+GpZnj2i3w@mail.gmail.com>
Subject: Re: [RFC PATCH v4 9/9] printk: use a new ringbuffer implementation
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 8, 2019 at 3:56 PM John Ogness <john.ogness@linutronix.de> wrote:
>
> On a side note, I'm not sure sure if we want kernel code to do the ASCII
> dump of the raw buffer. A userspace application grabbing from /dev/mem
> might be more desirable.

So there are two major issues here.

One obvious one is that the *current* boot must not overwrite the previous data.

With the separate stupid ring buffer, that isn't an issue. We just
won't start logging into it at all until after it's been registered,
so the solution is "read it out before registering it again" - and
that can indeed be done at almost any point (including by a user space
thing).

But with your suggestion of just using the native ring buffer you
already have, that's not an option. The current boot will have started
using it already and is overwriting the data we wanted from the
previous boot.

To which the obvious solution is "just use a different buffer for the
next boot". But that brings up the *second* big issue with a
reboot-safe buffer: it can't just be anywhere. Not only do you have to
have some way to find the old one, the actual location may end up
being basically fixed by hardware or firmware.

The reason for that is that while the patch I sent out actually works
fine on lots of machines in practice, it has a serious issue: it only
works for a nice warm reset, and only when the BIOS doesn't overwrite
memory at reset. Both of those are problems.

Most BIOSes don't overwrite all memory for a warm reset, simply
because booting fast is an issue. But some BIOSes _do_ re-initialize
everything. And in particular, they tend to do so after cold boots,
particularly on server machines where you may have "oh, ECC needs to
be re-initialized".

End result: in reality, my hacky patch is a "look, if we had firmware
support for not re-initializing a small piece of RAM, we could use
this". I've asked Intel for a fast logging facility in hardware for
basically two decades by now, and it's not happening. But I'm hoping
that I _can_ ask them for "hey, can you make your firmware not reinit
a small 64kB buffer at boot, so that it will survive even a cold boot
as long as the power-off was very short".

(And the "64kB" above is just a random number. Maybe it's 4kB.
Something fairly small, and something that the BIOS would not reinit,
and in the presense of ECC it would possibly just scrub - read old
contents without ECC, write them back with ECC).

See? That basically fixes the reboot-safe buffer at a particular
memory area, and means that you can't share the same buffer for the
basic logging as for the reboot-safe case..

That's why I also reacted to your POWER NVDIMM thing - it actually has
some of the same issues. It's fixed by external forces, and not a
generic random piece of memory.

           Linus
