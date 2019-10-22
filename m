Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB5FCA9EB7
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 09:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51DA62064B
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 09:16:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388385AbfJVJQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 05:16:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36302 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388405AbfJVJQ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 05:16:27 -0400
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8C4B736961
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 09:16:26 +0000 (UTC)
Received: by mail-qt1-f200.google.com with SMTP id j18so9418261qtp.23
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 02:16:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1NaftjpZ7q0/7FUFVe9FC7tfQH1ZMRLJsGxSpJEAYR0=;
        b=SJ72QxCdM2bF6+34K1Lrrr3ILkRtt4e0BKo+qLQCdVLOF3SGTEVDYkJscMV/73Y63n
         zvxJ7xergnBumC1ZSY+CDsF+qi/SAEzzvdlQNF1Z+Ijq8KylqO4m9JZo1nda93okLv4H
         tVLE6ASRafu9rxxqcEfwZDjl+HcI/NQJJpSxzHVSuzjBW3YeupEaFhSO2UQYonE509pt
         DYQg+hDbsROL/Vs15j6F6JZ14AGchs6+uTTtT1TcDwB4Zvpgw8Zdx9UweQYLpEOaogrN
         D9prH5PmEDG6gnKm7exphb79PfMlmHtkr57LTJcRO8ulfzmjR5nPNtVzaSHZq1enklhk
         RqlA==
X-Gm-Message-State: APjAAAUz2qrop4Ml9vctTjIYWtev2A17yg32zGXu0z0mwgk4zLPI3sxo
        rubOqtfEHOeQ37CAYEa82Ns4Ay21cm5gMc1ADQaZ2zlqdrz45NToxK0fXT7scYltFc/6+AeygYR
        HUf2wGBlaqCxOsitIFovlB/Aw8czKBAk9qrMB106j
X-Received: by 2002:ac8:664b:: with SMTP id j11mr2246839qtp.137.1571735785692;
        Tue, 22 Oct 2019 02:16:25 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxh+htVaSt1EHk6f2pMjctNRL+6dMevykS1gSHbmTJ7kc2awbIl5sahcS8cpGCaPnstRND7kRjzMbWgqOesrio=
X-Received: by 2002:ac8:664b:: with SMTP id j11mr2246814qtp.137.1571735785316;
 Tue, 22 Oct 2019 02:16:25 -0700 (PDT)
MIME-Version: 1.0
References: <CACO55ttOJaXKWmKQQbMAQRJHLXF-VtNn58n4BZhFKYmAdfiJjA@mail.gmail.com>
 <20191016213722.GA72810@google.com> <CACO55tuXck7vqGVLmMBGFg6A2pr3h8koRuvvWHLNDH8XvBVxew@mail.gmail.com>
 <20191021133328.GI2819@lahna.fi.intel.com> <CACO55tujUZr+rKkyrkfN+wkNOJWdNEVhVc-eZ3RCXJD+G1z=7A@mail.gmail.com>
 <20191021140852.GM2819@lahna.fi.intel.com> <CACO55tvp6n2ahizwhc70xRJ1uTohs2ep962vwtHGQK-MkcLmsw@mail.gmail.com>
 <20191021154606.GT2819@lahna.fi.intel.com> <CACO55tsGhvG1qapRkdu_j7R534cFa5o=Gv2s4VZDrWUrxjBFwA@mail.gmail.com>
In-Reply-To: <CACO55tsGhvG1qapRkdu_j7R534cFa5o=Gv2s4VZDrWUrxjBFwA@mail.gmail.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Tue, 22 Oct 2019 11:16:14 +0200
Message-ID: <CACO55ts7hivYgN7=3bcAjWx2h8FfbR5UiKiOOExYY9m-TGRNfw@mail.gmail.com>
Subject: Re: [PATCH v3] pci: prevent putting nvidia GPUs into lower device
 states on certain intel bridges
To:     Mika Westerberg <mika.westerberg@intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Lyude Paul <lyude@redhat.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        Linux ACPI Mailing List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think there is something I totally forgot about:

When there was never a driver bound to the GPU, and if runtime power
management gets enabled on that device, runtime suspend/resume works
as expected (I am not 100% sure on if that always works, but I will
recheck that).
In the past I know that at some point I "bisected" the nouveau driver
to figure out what actually breaks it and found out that some script
executed with the help of an on-chip engine (signed script, signed
firmware, both vbios provided) makes it break. Debugging the script
lead me to the PCIe link speed changes done inside the script breaking
it.

But as "reverting" the speed change didn't make it work reliably
again, I think I need to get back on that and check if it's something
else. I will try to convert the script into C or python code to make
it more accessible to debug and hopefully I'll find something I
overlooked the last time.

On Mon, Oct 21, 2019 at 6:40 PM Karol Herbst <kherbst@redhat.com> wrote:
>
> On Mon, Oct 21, 2019 at 5:46 PM Mika Westerberg
> <mika.westerberg@intel.com> wrote:
> >
> > On Mon, Oct 21, 2019 at 04:49:09PM +0200, Karol Herbst wrote:
> > > On Mon, Oct 21, 2019 at 4:09 PM Mika Westerberg
> > > <mika.westerberg@intel.com> wrote:
> > > >
> > > > On Mon, Oct 21, 2019 at 03:54:09PM +0200, Karol Herbst wrote:
> > > > > > I really would like to provide you more information about such
> > > > > > workaround but I'm not aware of any ;-) I have not seen any issues like
> > > > > > this when D3cold is properly implemented in the platform.  That's why
> > > > > > I'm bit skeptical that this has anything to do with specific Intel PCIe
> > > > > > ports. More likely it is some power sequence in the _ON/_OFF() methods
> > > > > > that is run differently on Windows.
> > > > >
> > > > > yeah.. maybe. I really don't know what's the actual root cause. I just
> > > > > know that with this workaround it works perfectly fine on my and some
> > > > > other systems it was tested on. Do you know who would be best to
> > > > > approach to get proper documentation about those methods and what are
> > > > > the actual prerequisites of those methods?
> > > >
> > > > Those should be documented in the ACPI spec. Chapter 7 should explain
> > > > power resources and the device power methods in detail.
> > >
> > > either I looked up the wrong spec or the documentation isn't really
> > > saying much there.
> >
> > Well it explains those methods, _PSx, _PRx and _ON()/_OFF(). In case of
> > PCIe device you also want to check PCIe spec. PCIe 5.0 section 5.8 "PCI
> > Function Power State Transitions" has a picture about the supported
> > power state transitions and there we can find that function must be in
> > D3hot before it can be transitioned into D3cold so if the _OFF() for
> > example blindly assumes that the device is in D0 when it is called, it
> > is a bug in the BIOS.
> >
> > BTW, where can I find acpidump of such system?
>
> I am sure it's uploaded somewhere already. But it's not an issue of
> just one system. It's essentially hitting every single laptop with a
> skylake or kaby lake CPU + Nvidia GPU. I didn't see any system where
> it's actually working right now (and we are pestering nvidia about
> this issue for over a year already with no solution)
>
> I've attached an acpidump from my system.
