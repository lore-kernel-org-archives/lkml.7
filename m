Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D91C32767
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 00:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01EBA2464B
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 00:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gRnVfA7F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbgADAVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 19:21:41 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39668 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbgADAVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 19:21:40 -0500
Received: by mail-lj1-f196.google.com with SMTP id l2so45394192lja.6
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 16:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a25MTBnzC/TY/vt8zz8+qKKJTGhY6mCF1CmPfY1tykI=;
        b=gRnVfA7FDAgs73jNy22XumTxemh0aYDjK9B1YAV7aDhmr0DazAVJiMp4WVw1bkv31/
         bcATx1sRwYkcsu4O0LQVmlmjSHW5VtsN8kArTfZitHm7x//5M6K3YcSNLlNrU4k2nXBM
         yt6DH6rszExsqnVul0yZCOGTl1phucIVvqvK/Gcklh4kjZC6VQ1xu9ZmRNx0Ik5oj39W
         PUCHY1sxyw3q0Pr498xt9akwnDTU17FpPWdhZ0+b30zgWzvbnxDXRO1SyZ+eSC73LL7M
         4bTSAi5L7Qao6/+sTppkChYPciZ16A05vGdttDOmIm7Rn2KAj85O40F9gtCbP1HMl69m
         XGZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a25MTBnzC/TY/vt8zz8+qKKJTGhY6mCF1CmPfY1tykI=;
        b=X/RxxpbG54Pzr8xmX2qmXQCulUlROMIh/90585+qrnxeMhMxE6Dgc86H1h6pmlKlaj
         QecaYweWsjxQ8LSXDRvXLrVf1xtSOYaRIAiGv65vA99nsMD1V7xA0hNP8e39CDdu8Iru
         dNAPrfyfCeUg9BePqQRQolSo1xqspdqhGSiHCVqxMDbAeXZhA46IeL3V2Daw+gPalidh
         s9GazFm89MLVDP8ooGNfLdE5mLNqIhMpFN3t5kRZSieEZNmkqv54sGn6E48B/tLWZy4v
         BUn4MjDKNHWTXisFyKcWPtCiUa5pLMPpOkZXhnjqWEZ3x/oSci5f0NOVqdBGgDZPKUIL
         g+uw==
X-Gm-Message-State: APjAAAWvWOaOZWJwTqwOiQtGxNxZrBCJtOWFVAKQdtd4aK/23dUt4sQE
        c0PdLmuu7fx5RO46uRaUk43KQKYpTROLTC4vEs/pnA==
X-Google-Smtp-Source: APXvYqxHT5NBcGXP7l31r/rUzGwxDXqF6xPcQ35bsC0BAshJRd7O7pJFod6OutyDNvKjGim9p9LsFYX1ulkLOKLmCGs=
X-Received: by 2002:a2e:85cd:: with SMTP id h13mr51946653ljj.191.1578097298469;
 Fri, 03 Jan 2020 16:21:38 -0800 (PST)
MIME-Version: 1.0
References: <20191127084253.16356-1-geert+renesas@glider.be>
 <20191127084253.16356-7-geert+renesas@glider.be> <CACRpkdb1XZAeSThxWmJtnm80T4aPufXV2UvJdVdgnw-TJe3trg@mail.gmail.com>
 <CAMuHMdV+Ww5Y9G7+bS-SyHtm4dC89V37yuaYvrS3kYW=PRTkFA@mail.gmail.com>
In-Reply-To: <CAMuHMdV+Ww5Y9G7+bS-SyHtm4dC89V37yuaYvrS3kYW=PRTkFA@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 4 Jan 2020 01:21:27 +0100
Message-ID: <CACRpkdZwos9Dtt9E3OkxWf4rqMALNTge5NGduzGm-7MhQyLZuQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] docs: gpio: Add GPIO Aggregator/Repeater documentation
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Harish Jenny K N <harish_kandiga@mentor.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Alexander Graf <graf@amazon.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Phil Reid <preid@electromag.com.au>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 3:48 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Thu, Dec 12, 2019 at 3:42 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> > On Wed, Nov 27, 2019 at 9:43 AM Geert Uytterhoeven
> > <geert+renesas@glider.be> wrote:
> > > +The GPIO Aggregator allows access control for individual GPIOs, by aggregating
> > > +them into a new gpio_chip, which can be assigned to a group or user using
> > > +standard UNIX file ownership and permissions.  Furthermore, this simplifies and
> > > +hardens exporting GPIOs to a virtual machine, as the VM can just grab the full
> > > +GPIO controller, and no longer needs to care about which GPIOs to grab and
> > > +which not, reducing the attack surface.
> > > +
> > > +Aggregated GPIO controllers are instantiated and destroyed by writing to
> > > +write-only attribute files in sysfs.
> >
> > I suppose virtual machines will have a lengthy config file where
> > they specify which GPIO lines to pick and use for their GPIO
> > aggregator, and that will all be fine, the VM starts and the aggregator
> > is there and we can start executing.
> >
> > I would perhaps point out a weakness as with all sysfs and with the current
> > gpio sysfs: if a process creates an aggregator device, and then that
> > process crashes, what happens when you try to restart the process and
> > run e.g. your VM again?
> >
> > Time for a hard reboot? Or should we add some design guidelines for
> > these machines so that they can cleanly tear down aggregators
> > previously created by the crashed VM?
>
> No, the VM does not create the aggregator.
>
> The idea is for the user to create one or more aggregators, set up
> permissions on /dev/gpiochipX, and launch the VM, passing the aggregated
> /dev/gpiochipX as parameters.
> If the VM crashes, just launch it again.
>
> Destroying the aggregators is a manual and independent process, after
> the VM has exited.

I'm thinking about someone making some industrial application for some
control of a machinery say a robotic arm.

And do make sure this VM is only controlling these GPIOs related to
this robotic arm, they create a GPIO aggregator. And we care about
cases like that since we provide this security argument.

Surely that machine will be rebooted.

Surely they don't have a printed paper with all the commands lying
at the console, and asking whoever powers it back on to manually
type it all in again. That feels a bit 1981.

So they will have a script for this I suppose. Possibly in some
initscript so it is set up on boot. And this script echos stuff
all over the place to set up the aggregator.

Is this the use case you're thinking of?

I just like to have the whole picture here.

Yours,
Linus Walleij
