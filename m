Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5558C06511
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 17:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B42E121882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 17:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562175361;
	bh=wa2wgftb0Glpe1atnrfeCeeDK1sxy7+2l733KeJ5zHU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=b4ZrmGP9z72Y97yBeOmfxSFIMghZuJQg1QiE1rkEgGutHq62RBykACId4qR1dtKYk
	 rHYwgEq0WprfBepiK9qAW3JofMsTO89XT9vXn+aR7e2zk2KujZaBNp+s5xNa7Id0gR
	 ewn00aPvAbkQvGVBjww9Rt6IiswA6MPZKE0qe7Bk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfGCRgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 13:36:00 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35680 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbfGCRf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 13:35:59 -0400
Received: by mail-pf1-f195.google.com with SMTP id u14so432231pfn.2;
        Wed, 03 Jul 2019 10:35:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wLs0B87VrRocDw8TqX6WgFmlXaTzPPe7N7Klaqcmn/c=;
        b=ZGcz/OgumTeJw/rL+GZEk4xMugOOSg3ZhFts87od6JEz2RLDflKa40wcSG9id/79iC
         XXdSbbIvAvya1i1dLbA7XV0k1DoQth8jgRQctKwuNf7qynOdA2eEbOSkaiGlFybjZ5YV
         teDq4vGLpFpzqaKM3DFstrTLO9IY8SNm/bkWykoFlQz6yEkxJQlwbopSTij7P3s+F4h3
         QzTP0sfSixMMhodfLE8RXt78ECKkeYPLQq2UfJd94VGUfBzkVAbN9w6a4xDZqGrFCUk2
         Ei85EHK4v9kw0lqS1Fm0Ek6/5dWfWGMPpWGtwlTn2GI0mSOQ48Oy5EzVuR6g68dX0R7g
         OEWA==
X-Gm-Message-State: APjAAAXybSP6yticC3qxqtzDAZd/MZZh5OWswgXkHyTUEoe8FPTumm50
        YziSL8sBojHQC3QcEMCukZA=
X-Google-Smtp-Source: APXvYqwf+Fffb1eDXe54RXh9N6cqFXSr3h3AE/hbEjjz1Z/eT6nWPQ+SPrp9vieYozlt4UGGYKkS0g==
X-Received: by 2002:a17:90a:9b08:: with SMTP id f8mr14210734pjp.103.1562175358483;
        Wed, 03 Jul 2019 10:35:58 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id u16sm2839751pjb.2.2019.07.03.10.35.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Jul 2019 10:35:56 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id E52C9402AC; Wed,  3 Jul 2019 17:35:55 +0000 (UTC)
Date:   Wed, 3 Jul 2019 17:35:55 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     Christoph Hellwig <hch@lst.de>,
        Brendan Higgins <brendanhiggins@google.com>,
        Cristina Moraru <cristina.moraru09@gmail.com>,
        "vegard.nossum@gmail.com" <vegard.nossum@gmail.com>,
        Valentin Rothberg <valentinrothberg@gmail.com>,
        Hannes Reinecke <hare@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <mmarek@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tom Gundersen <teg@jklm.no>, Kay Sievers <kay@vrfy.org>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        backports@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "rafael.j.wysocki" <rafael.j.wysocki@intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Takashi Iwai <tiwai@suse.de>,
        Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Paul Bolle <pebolle@tiscali.nl>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Laurence Oberman <loberman@redhat.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Tejun Heo <tj@kernel.org>,
        Jej B <James.Bottomley@hansenpartnership.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Daniel Jonsson <danijons@student.chalmers.se>,
        Andrzej Wasowski <wasowski@itu.dk>
Subject: Re: [RFC PATCH 0/5] Add CONFIG symbol as module attribute
Message-ID: <20190703173555.GW19023@42.do-not-panic.com>
References: <1471462023-119645-1-git-send-email-cristina.moraru09@gmail.com>
 <20160818175505.GM3296@wotan.suse.de>
 <20160825074313.GC18622@lst.de>
 <20160825201919.GE3296@wotan.suse.de>
 <CAB=NE6UfkNN5kES6QmkM-dVC=HzKsZEkevH+Y3beXhVb2gC5vg@mail.gmail.com>
 <CAB=NE6XEnZ1uH2nidRbn6myvdQJ+vArpTTT6iSJebUmyfdaLcQ@mail.gmail.com>
 <20190627045052.GA7594@lst.de>
 <CAB=NE6Xa525g+3oWROjCyDT3eD0sw-6O+7o97HGX8zORJfYw4w@mail.gmail.com>
 <40f70582-c16a-7de0-cfd6-c7d5ff9ead71@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40f70582-c16a-7de0-cfd6-c7d5ff9ead71@metux.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 03, 2019 at 02:16:44PM +0200, Enrico Weigelt, metux IT consult wrote:
> On 28.06.19 20:40, Luis Chamberlain wrote:
> 
> Hi folks,
> 
> > The solution puts forward a mechanism to add a kconfig_symb where
> > we are 100% certain we have a direct module --> config mapping.
> Okay, but IIRC this will add more boilerplate those modules.

Just one module attribute.

> And I wonder whether target binaries are the right place for those
> things at all - IMHO that's something one wants to derive from the
> source code  / .config's.

For the use cases mentioned for why the module attribute is being
suggested it would help to not have to download kernel sources. The
only question we want to answer is: for the hardware components
present on this system, which configs options do I need to enable
to support these components?

> At least in the cases I'm imagining, I don't
> even have an actual kernel running on the corresponding target yet.
> (eg. in crosscompile situations)

Right, so this is a different use case. A *running* kernel provides
*more* information, specially if it had enabled on it modules which
enable hardware.

> OTOH, a more pressing problem for me is identifying the right drivers
> and corresponding config options (usually plural, as certain subsystems
> have to be enabled, too) by hardware information like DT, ACPI, DMI,
> PCI, etc.

Right, I'm familiar with the problem.

At least for virtualization we decided to support at least these two to
help:

  * make kvmconfig
  * make xenconfig

I'm not suggesting we need a respective target per major component you
have described. I'm mentioning these as examples of ways to also address
similar problems.

> For now, I have to do that manually, which is pretty time
> consuming.

Yes...

Similar problem would be found if one wanted to find a desirable kernel
config for a remote system. One should be able to somehow scrape some
hardware information, dump that to a file, and then somehow generate
a working config for that system.

The module attribute being suggested would enable at least one way
to gather some of the required config symbols: symbols for *hardware*
and where one can run a modern kernel, with many features / hardware
enabled already.

Addressing the problem of obtaining a kernel config for a system where
one cannot run any kernel should be possible, however this *is* a very
different problem.

However, folks producing embedded systems *do* / *should* have a lot of
knowledge of their systems, and so the type of scheme you have devised
seems sensible for it.

> In embedded world, we often have scenarios where we want a really
> minimal kernel, but need to enable/disable certain hi-level peripherals
> in the middle of the project (eg. "oh, we also need ethernet, but we
> wanna drop usb"). There we'll have to find out what actual chip is,
> its corresponding driver, required subsystems, etc, and also kick off
> everything we don't need anymore.

Right. One *should* be able to tell some tool, hey, here is the list of
my desirable .config options. Go and figure out what I need to make that
work and give me a resulting .config. Its not easy.

> I've thought about implementing some actual dependency tracking
> (at least recording the auto-enabled symbols), but didn't expect that
> to become practically usable anytime soon,

The ability to easily ask the kernel to enable the components needed
for a respective config option *is* very useful but indeed not easy.

This is not the only space where this problem exists. Similar problem
exists for distribution packages, and dependencies. Challenges have
been made for proper research towards these problems, and such research
has lead distributions to opt to enable some of these algorithms.

This begs the question if we could learn from similar efforts on Linux
for these sorts of questions. One possibility here is to evaluate the
prospect of using a SAT solver with Minimally Unsatisfiable Subformulas
(MUSes) support, which should be be able to address thir problem. This
prospect is ongoing and currrent R&D is active, for details refer to:

https://kernelnewbies.org/KernelProjects/kconfig-sat

I'd recommend the mailing list, as that is where folks are following up
on, and there seems to be a call scheduled next Wednesday at 8:30am PST
about some new developments.

> so I went for a different
> approach: writing a little tool that allows modeling hilevel features
> and corresponding (potentially board-specific) config syms, so the whole
> .config for certain board and usecase can be autogenerated by just some
> small meta-configuration:
> 
>    https://github.com/metux/kmct
> 
> Maybe this could also help for your usecase ?

It certainly can be useful for components, ie, not hardware. But for
hardware a one-to-one mapping of one driver to one config would be of
much more use.

Based on a quick glance, I'd suggest that it would be great if could
have something similar upstream on linux. It would be unclear yet how to
structure this though. It would be wonderful if for instance kconfig
supported a way to group a major set of components under *one* config
symbol and then say: "I want this major component enabled" and then it'd
go and enable all the defaults which would be required for it. Its not
an easy problem, given though that there may be certain other symbols
which may conflict with your target component. An example is if you
wanted to enable PCI on a system which didn't support it. Because of
this, it seems you'd want *all* desirable configs and let a piece of
software figure out what you need / can enable. And.. this is precisely
where the SAT solver with MUSes could help...

  Luis
