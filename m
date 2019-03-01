Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A21E0C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 19:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EDBC20857
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 19:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hS7SDb4h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbfCATVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 14:21:18 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:39966 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfCATVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 14:21:18 -0500
Received: by mail-ua1-f65.google.com with SMTP id c5so23587322uaq.7
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 11:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+eP/grKrw9nt161RMGaY9BGLxSOZU8qosqbEqlFsxTA=;
        b=hS7SDb4hb/qsJmg2PCvE+e6RK4yb4mXBHmfOssrTUxhtCXf+7Sh7w1bEjgua/AsefL
         cmYVWSfuwFG+bmIvM2ZjqaNihpq8r+HRNU9y8E9jBwrKd3z1NoA4FWBIleItvGZZkRVz
         jkET0XiJPe+TAPjOjQrs1S7mRfHUspih409l4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+eP/grKrw9nt161RMGaY9BGLxSOZU8qosqbEqlFsxTA=;
        b=XRJsaRwIer6I1jLrITW7SeKMRxhiVXyVVKtnJBYVO56J9CkQucpekTIy7N225cdJgw
         m/oXsAO1KdiW8GU83f2mEk834nTUM3FQEW5yiytcbchz+sWOLbC5l80Px/Nf/4qOEFRn
         706x/qhFKxNQjwwfjG56PSjggKu1m2Ii5dyCj2+UGbYKNF86okm8D8yChkFdn8fhDs1V
         wxU6rrZGbjSqtbuTBwDwPkTwfIFCLdkV8LDoJejwKUjpOrRr4xhhoJuiLFbg86KNkqLD
         2mQsiTw239Jpv1PG8Egb8ug6C1+zVTmNzhPKDy/PNS3rk1dkVOGvo10Nj9XjTibHgf58
         OhpQ==
X-Gm-Message-State: APjAAAV58BFD3SpZDcyqNnZkUYGrxECVshmiiW4Ek5kSEJWAqZERuKdH
        8xMzbo4EeXmpLha1aiG/pLlVWo+o7I8=
X-Google-Smtp-Source: APXvYqxppS0WiOFe3c4MROGFZ30//YPxXFk4f1foAgXgTWv9OSful7nrtqlQTyI1Fjhr07tHIb9HwA==
X-Received: by 2002:a67:768f:: with SMTP id r137mr3485463vsc.35.1551468076533;
        Fri, 01 Mar 2019 11:21:16 -0800 (PST)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id d73sm6657677vsc.24.2019.03.01.11.21.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Mar 2019 11:21:15 -0800 (PST)
Received: by mail-ua1-f46.google.com with SMTP id s15so23567862uap.6
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 11:21:15 -0800 (PST)
X-Received: by 2002:a67:d48e:: with SMTP id g14mr3814454vsj.111.1551468074954;
 Fri, 01 Mar 2019 11:21:14 -0800 (PST)
MIME-Version: 1.0
References: <20190214204433.155715-1-dianders@chromium.org>
 <4238ceb7-d286-9ef9-39b6-b2e0571f2981@arm.com> <CAD=FV=WeBD0bqxWPZcV1dz5Sdn47Ap=FZU3Y+YPbxsVCQEUcLQ@mail.gmail.com>
 <CAF6AEGsGc8g--3W_xpR8VUt778WR19v_HOemhd7Jv=f4QBqVgw@mail.gmail.com>
In-Reply-To: <CAF6AEGsGc8g--3W_xpR8VUt778WR19v_HOemhd7Jv=f4QBqVgw@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 1 Mar 2019 11:21:03 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WPPhJEVV6SS3tqA6M6Z2XeuhXwFz18_-mqNoezUd+42w@mail.gmail.com>
Message-ID: <CAD=FV=WPPhJEVV6SS3tqA6M6Z2XeuhXwFz18_-mqNoezUd+42w@mail.gmail.com>
Subject: Re: [PATCH] iommu/arm-smmu: Allow disabling bypass via kernel config
To:     Rob Clark <robdclark@gmail.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Evan Green <evgreen@chromium.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Feb 15, 2019 at 2:37 PM Rob Clark <robdclark@gmail.com> wrote:
>
> On Thu, Feb 14, 2019 at 7:40 PM Doug Anderson <dianders@chromium.org> wrote:
> >
> > Hi,
> >
> > On Thu, Feb 14, 2019 at 1:32 PM Robin Murphy <robin.murphy@arm.com> wrote:
> > >
> > > Hi Doug,
> > >
> > > On 2019-02-14 8:44 pm, Douglas Anderson wrote:
> > > > Right now the only way to disable the iommu bypass for the ARM SMMU is
> > > > with the kernel command line parameter 'arm-smmu.disable_bypass'.
> > > >
> > > > In general kernel command line parameters make sense for things that
> > > > someone would like to tweak without rebuilding the kernel or for very
> > > > basic communication between the bootloader and the kernel, but are
> > > > awkward for other things.  Specifically:
> > > > * Human parsing of the kernel command line can be difficult since it's
> > > >    just a big runon space separated line of text.
> > > > * If every bit of the system was configured via the kernel command
> > > >    line the kernel command line would get very large and even more
> > > >    unwieldly.
> > > > * Typically there are not easy ways in build systems to adjust the
> > > >    kernel command line for config-like options.
> > > >
> > > > Let's introduce a new config option that allows us to disable the
> > > > iommu bypass without affecting the existing default nor the existing
> > > > ability to adjust the configuration via kernel command line.
> > >
> > > I say let's just flip the default - for a while now it's been one of
> > > those "oh yeah, we should probably do that" things that gets instantly
> > > forgotten again, so some 3rd-party demand is plenty to convince me :)
> > >
> > > There are few reasons to allow unmatched stream bypass, and even fewer
> > > good ones, so I'd be happy to shift the command-line burden over to the
> > > esoteric cases at this point, and consider the config option in future
> > > if anyone from that camp pops up and screams hard enough.
> >
> > Sure, I can submit that patch if we want.  I presume I'll get lots of
> > screaming but I'm used to that.  ;-)
> >
> > ...specifically I found that when I turned on "disably bypass" on my
> > board (sdm845-cheza, which is not yet upstream) that a bunch of things
> > that used to work broke.  That's a good thing because all the things
> > that broke need to be fixed properly (by adding the IOMMUs) but
> > presumably my board is not special in relying on the old insecure
> > behavior.
>
> So one niggly bit, beyond the drivers that aren't but should be using
> iommu, is the case where bootloader lights up the display.  We
> actually still have a lot of work to do for this (in that clk and
> genpd drivers need to be aware of handover, in addition to just
> iommu)..  But I'd rather not make a hard problem harder just yet.
>
> (it gets worse, afaict so far on the windows-arm laptops since in that
> case uefi/edk is actually taking the iommu out of bypass and things go
> badly when arm-smmu disables clks after probe..)
>
> But I might recommend making the default a kconfig option for now, so
> in the distro kernel case, where display driver is a kernel module,
> you aren't making a hard problem harder.  For cases where bootloader
> isn't enabling display, things are much easier, and I think we could
> switch the default sooner.  But I fear for cases where bootloader is
> enabling display it is a much harder problem :-(

OK, so after thinking about this and playing with it a bit, here's
what I'm planning to do: I'm going to send out a v2 of my patch where
I basically just flip it to "default y".

Originally I was going to post a patch like Robin suggested that just
changed the default in the code without introducing a KConfig option.
Then I looked at all the things I needed to do on my own board to get
things working again once the IOMMU disallowed bypass and I just
couldn't bring myself to respond to everyone else I was about to break
"now figure out how to add a new kernel command line option until you
fix this more correctly".

In my mind a change that by default breaks all these insecure people
(effectively notifying them that they were insecure) but that allows
them to get back to the old state quickly seems like a good first
step.  In my commit message I'll mention that in a kernel version or
two we should probably fully take out the KConfig option since people
will have (presumably) had a chance to wean themselves off it.

One last thought on all of this is the question about the whole
"device tree as a stable ABI".  Presumably we're are supposed to make
some attempt to be able to run old device trees and presumably those
old device trees will break because the proper way to hook up the
IOMMU is by specifying it in the device tree.  Thus we shouldn't be
too quick to totally break all those old devices and we should make
sure that there is some easy path if someone comes up with an old
device tree that is "unfixable".  ;-)

Robin: hopefully it's OK that I'm co-opting a bit of your wording and
adding you as a "Suggested-by".  ;-)

-Doug
