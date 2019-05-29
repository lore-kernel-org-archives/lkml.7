Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6788EC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 11:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CCAD2081C
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 11:40:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xmJMKT2j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfE2Lkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 07:40:49 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36548 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfE2Lkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 07:40:49 -0400
Received: by mail-wr1-f68.google.com with SMTP id s17so1541282wru.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 04:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=R/ybEZYJx9L5gstwNmUBOZDipfPhMff15CJyfuNZs9M=;
        b=xmJMKT2jY49cTQEWaZwqfim84XibWhGi5wKW8mj9KX2e7Zn5B2PtN4xrfRZeneo5Iz
         E7mha2hYbFWWrwMmEbleRD4qTClUduXVUxo5tSwttbjvl7HQolGbpEvSk790KR19CKm2
         BXz9fuMc89cj6GcHnStWS3rKwmoyabu7TgWNxow26ICFXRgNTk3fru5+Qc9gatCqsDfr
         9ehF1Vkiau5Pmcw8PK4YalcJHhUhtn+3iEJgptjQE1iTi1pwfPIxVD+U7MYlcYioyh/g
         nb89SC8wABDqu6WfCWLOjRs4XqlsvSlDkIZk6yACZ7yHtW5AGsR2BY+H1Dzu4cIH4SWr
         sH3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=R/ybEZYJx9L5gstwNmUBOZDipfPhMff15CJyfuNZs9M=;
        b=CeGaXSVh2S0YFVbqjVHncLNIf7P9QyF0Z1iMBLoHvqTFkuHLUUNdueMfwpvUbiSiNg
         VKhinhKwqlKkGI+A5OTT3aznrTYyhSufjB9/DrR/3ebHf7Vz0ViytFwwgUD3UeZEfs8W
         PhW1pQTcJUv62wJRfT22sCKE22mgn/JF03JYcq4DakOlkDuXU/IGeZAN6c6b/pxtE/2g
         2+8RnOe0Ss+cWMUZv6fXvFz8gs8r+25VLFQD7+czcs4AnUocCVDEKE3rX+DK0i/GJD6s
         JjrfokAtWW6sY7+KzvXo/VSnQxqMr6QvrA2IpafP4qaidrFW5y5JE1dWDk+/UIPZ2Pe8
         xgfQ==
X-Gm-Message-State: APjAAAWyo8C6xatHK5+rvXzqXmf3cO6i0JRUweGRcUtpvtNkmjZVsaEj
        g1aFQV6XvIrErczPs5rhBg2fDQ==
X-Google-Smtp-Source: APXvYqwgdQ7bjEGnWWxkk5S/5ADrffCPJ8mJTC+tkY+MY9Oku9d0sJrdTzQIdSLW7ceJ4QttwvNw1g==
X-Received: by 2002:adf:f246:: with SMTP id b6mr8369479wrp.92.1559130041455;
        Wed, 29 May 2019 04:40:41 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id a124sm8113980wmh.3.2019.05.29.04.40.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 04:40:40 -0700 (PDT)
Date:   Wed, 29 May 2019 12:40:38 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
Subject: Re: cross-merges with MFD tree (was: Re: GFS2: Pull Request)
Message-ID: <20190529114038.GI4574@dell>
References: <CAHc6FU5Yd9EVju+kY8228n-Ccm7F2ZBRJUbesT-HYsy2YjKc_w@mail.gmail.com>
 <CAHk-=wj_L9d8P0Kmtb5f4wudm=KGZ5z0ijJ-NxTY-CcNcNDP5A@mail.gmail.com>
 <61f6987a-5502-f119-6595-fc6badb864fb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <61f6987a-5502-f119-6595-fc6badb864fb@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 May 2019, Jacek Anaszewski wrote:

> Hi Linus,
> 
> On 5/8/19 7:55 PM, Linus Torvalds wrote:
> > On Wed, May 8, 2019 at 4:49 AM Andreas Gruenbacher <agruenba@redhat.com> wrote:
> > > 
> > > There was a conflict with commit 2b070cfe582b ("block: remove the i
> > > argument to bio_for_each_segment_all") on Jens's block layer changes
> > > which you've already merged. I've resolved that by merging those block
> > > layer changes; please let me know if you want this done differently.
> > 
> > PLEASE.
> > 
> > I say this to somebody pretty much every single merge window: don't do
> > merges for me.
> > 
> > You are actually just hurting, not helping. I want to know what the
> > conflicts are, not by being told after-the-fact, but by just seeing
> > them and resolving them.
> > 
> > Yes, I like being _warned_ ahead of time - partly just as a heads up
> > to me, but partly also to show that the maintainers are aware of the
> > notifications from linux-next, and that linux-next is working as
> > intended, and people aren't just ignoring what it reports.
> > 
> > But I do *NOT* want to see maintainers cross-merging each others trees.
> 
> I would like to clarify if this applies to immutable integration
> branches that are usually created for MFD subsystem. That subsystem
> is somehow specific since changes made to MFD drivers are often a part
> of bigger patch sets that add drivers of MFD cells to the other
> subsystems.
> 
> Like in my area of interest an addition of a driver for LED cell
> of MFD device must be followed by addition of a corresponding entry to
> struct mfd_cell array in the related MFD driver.
> 
> And sometimes even another subsystem is involved, like e.g. regulator
> framework in case of recent extension of ti-lmu driver.
> 
> So far you haven't complained about this specific workflow, but I'd like
> to make sure how you see it.

After you bought this conversation to my attention last week, I took
the initiative and spoke to a few senior maintainers (Mark Brown,
Linus Walleij, etc) for their views.  I choose these guys because they
are commonly on the receiving end of my Pull Requests when we need to
do this.

Due to its inherent nature, MFD usually finds itself interacting with
other subsystems in ways which deal with both physical merge conflicts
and build dependencies.  For some time now the vast majority of the
other maintainers I work with and I have believed, and still do, that
the best way to mitigate these issues is to produce small, succinct,
immutable topic branches.  These branches only usually contain a few 
patches and serve to solve a specific potential issue - usually
build-time problems, but also have the added bonus of preventing merge
conflicts and keeping us out of the forefront of Linus' mind (and out
of trouble!)

We've been doing this for some time and have interacted with many
subsystems (ACPI, ASoC, ARM-SoC, Clocksource, Excon, GPIO, Hwmon, I2C,
IIO, Input, IRQChip, LED, PWM, Media, Net, Pinctrl, Platform, Power,
Regulator, RTC, USB, Video, Watchdog, etc, etc) over the years [0].

In my mind, small, immutable topic branches is still the cleanest way
to deal with the issues facing MFD currently.  And is not what Linus
is detailing in his recent mail(s) on the subject.  We are not "doing
merges on his behalf", we are ensuring; buildable, bisectable,
error-free branches/history that will also merge cleanly.

[0] `git log --oneline --grep ib-mfd mainline/master`

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
