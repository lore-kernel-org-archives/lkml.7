Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A669EC5B57A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 18:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B57420828
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 18:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561747239;
	bh=wA9zq4EpB5GqEIS9VlPDCB89AZFN6Q0nB2eYYfARfi0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=oWTA/fS+/Z/xwf+WAjbcOI6nMb8mgKHW+jgmYIyQf/Iyg1FEAbcgQqQKZbCBixamU
	 e0AONilOrauebo+lNffSlFnBFDrUIxvNq35bBCwV6AgyOhsQT5mVJNPmzy+NEc72LP
	 C0krO6B4liosL9TLHmdQpPBUavKlY4FxjT5YvZag=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfF1Ski (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 14:40:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:54344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726498AbfF1Skh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 14:40:37 -0400
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3D48214DA;
        Fri, 28 Jun 2019 18:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561747236;
        bh=wA9zq4EpB5GqEIS9VlPDCB89AZFN6Q0nB2eYYfARfi0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=z6HYNfmX9kFc4w+8yOcEA2a0W0JoABYa4XASgS/vCr3NcqtOsUJoi4DxceUc2z/H1
         bYZuRgQxI0fWjLLWiDbMAfMqr4xFGK048bbG4j2mX9gEM3223XSY4uHZnDxaSthnkO
         eCy8KUbzy/yToi1cM7qvO+8M3NhEfsc3vIxOGpCs=
Received: by mail-vs1-f53.google.com with SMTP id k9so4699699vso.5;
        Fri, 28 Jun 2019 11:40:35 -0700 (PDT)
X-Gm-Message-State: APjAAAUBHKEJrjbFwnxK65jYXRgqoq50OtHDkWqouCicT0BP3gr1rMeo
        F1eyden1D+EGqMoIGwnKIlhgXWSRn5nHTfAyUf8=
X-Google-Smtp-Source: APXvYqwI+s3J32kSzDN2Pf0FHVdBRudHvcqvrBkJn5WxInId0W1w+T/pntjZ252Ld9snZUKr/Hrfdry0i4qvBqqaix4=
X-Received: by 2002:a67:f2d3:: with SMTP id a19mr7217210vsn.240.1561747235159;
 Fri, 28 Jun 2019 11:40:35 -0700 (PDT)
MIME-Version: 1.0
References: <1471462023-119645-1-git-send-email-cristina.moraru09@gmail.com>
 <20160818175505.GM3296@wotan.suse.de> <20160825074313.GC18622@lst.de>
 <20160825201919.GE3296@wotan.suse.de> <CAB=NE6UfkNN5kES6QmkM-dVC=HzKsZEkevH+Y3beXhVb2gC5vg@mail.gmail.com>
 <CAB=NE6XEnZ1uH2nidRbn6myvdQJ+vArpTTT6iSJebUmyfdaLcQ@mail.gmail.com> <20190627045052.GA7594@lst.de>
In-Reply-To: <20190627045052.GA7594@lst.de>
From:   Luis Chamberlain <mcgrof@kernel.org>
Date:   Fri, 28 Jun 2019 11:40:22 -0700
X-Gmail-Original-Message-ID: <CAB=NE6Xa525g+3oWROjCyDT3eD0sw-6O+7o97HGX8zORJfYw4w@mail.gmail.com>
Message-ID: <CAB=NE6Xa525g+3oWROjCyDT3eD0sw-6O+7o97HGX8zORJfYw4w@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] Add CONFIG symbol as module attribute
To:     Christoph Hellwig <hch@lst.de>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
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
        "Theodore Ts'o" <tytso@mit.edu>,
        Daniel Jonsson <danijons@student.chalmers.se>,
        Andrzej Wasowski <wasowski@itu.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 9:51 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, Jun 26, 2019 at 03:21:08PM -0700, Luis Chamberlain wrote:
> > On Tue, Feb 5, 2019 at 2:07 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > > In lieu of no Luke Skywalker, if you will, for a large kconfig revamp
> > > on this, I'm inclined to believe *at least* having some kconfig_symb
> > > exposed for some modules is better than nothing. Christoph are you
> > > totally opposed to this effort until we get a non-reverse engineered
> > > effort in place? It just seems like an extraordinary amount of work
> > > and I'm not quite sure who's volunteering to do it.
> > >
> > > Other stakeholders may benefit from at least having some config -->
> > > module mapping for now. Not just backports or building slimmer
> > > kernels.
> >
> > Christoph, *poke*
>
> Yes, I'm still totally opposed to a half-backed hack like this.

The solution puts forward a mechanism to add a kconfig_symb where we
are 100% certain we have a direct module --> config mapping.

This is *currently* determined when the streamline_config.pl finds
that an object has only *one* associated config symbol associated. As
Cristina noted, of 62 modules on a running system 58 of them ended up
getting the kconfig_symb assigned, that is 93.5% of all modules on the
system being tested. For the other modules, if they did want this
association, we could allow a way for modules to define their own
KBUILD_KCONF variable so that this could be considered as well, or
they can look at their own kconfig stuff to try to fit the model that
does work. To be clear, the heuristics *can* be updated if there is
confidence in alternative methods for resolution. But since it is
reflective of our current situation, I cannot consider it a hack.

This implementation is a reflection of our reality in the kernel, and
as has been discussed in this thread, if we want to correct the gaps
we need to do a lot of work. And *no one* is working towards these
goals.

That said, even if you go forward with an intrusive solution like the
one you proposed we could still use the same kconfig_symb...

So no, I don't see this as a hack. It's a reflection as to our current
reality. And I cannot see how the kconfig_symb can lie or be
incorrect. So in fact I think that pushing this forward also makes the
problem statement clearer for the future of what semantics needs to be
addressed, and helps us even annotate the problematic areas of the
kernel.

What negative aspects do you see with this being merged in practice?

 Luis
