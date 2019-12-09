Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9245C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 12:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D2832073D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 12:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q0eO0j9t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbfLIMYV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 07:24:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51533 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726687AbfLIMYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 07:24:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575894258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Om3e8U2zV0QaZB81qgLCidrh7Jm1jTyKjoRsq4wAO1A=;
        b=Q0eO0j9trDdYlBH+N5djComR9zXXOFh5QzSEOidW3mWMGsFqvyHvR/VFaQIrd99vtAo2R5
        TXLwr6sUcb+TStMwukCbjecer8KPk26JkdlDQ6T17UkdyDt7tdWN78iNZt1k/VNWR6ZqYk
        M1OLEo8R/d1a42BLKm/i+T5Iv49XXH0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-BAM8xrFbPMW4qMDZ__CMSw-1; Mon, 09 Dec 2019 07:24:17 -0500
Received: by mail-qk1-f199.google.com with SMTP id b9so9832562qkl.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 04:24:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R2wkCojmmyM/eMvArR6da0gzEriG+0Vl5wpoIupE6a0=;
        b=IwiZRCP72uA7VdVP/W2aZE+b/0IhuCrfAn7hgXK3jWWsKXsjTQKvyblbg4OfoDZuuz
         0sny4E+9fB7kK+3k+6i2NojpKgyJA0uYOfYNhFcDYeCX1pE6Td63K58egIwLuKPbaPO6
         RFFnMn4ulMLGIimPA9ldZI4DDNaRLoVn31QLkNJfFfo81I8LyF8bY6WogKJXrPtoMbZC
         85AgW+zTVZU3sKjhsVWvISALnGthZrcO1Bi4PbVD+Ln4OZFwVZ30u/oJNCGLaWjARst0
         Sbzy+cSgApIg4fg72SF35L1DmCuiWOxViQ+2e2SAwVguR5UNjHT0RIg2CwIoDhp38HpJ
         ZsPg==
X-Gm-Message-State: APjAAAVP/VU8qaArOkoBpJz01OKyC3z3sBGcgU3720PbqSCnGhf2iEKh
        ZSzC6rhZrf2Ie1r+M3zYijIjhqNgstf86SsGgVq/GjC3M+D3xWyWBhIXvGqvJWC3lQzCOJCOQvl
        F77yg8CagZDF1NHglQuq+L9/Ku1rKBHDv5TMDXZY9
X-Received: by 2002:a37:c57:: with SMTP id 84mr6830057qkm.157.1575894256892;
        Mon, 09 Dec 2019 04:24:16 -0800 (PST)
X-Google-Smtp-Source: APXvYqzuZX+dUghHi7wPyOkamBRcZ36z3Od2tRPaKnHnAmGQD/DMSGgIgQOLFSwroihlGD9ll8sjWxVfTu+lqQTAIVU=
X-Received: by 2002:a37:c57:: with SMTP id 84mr6830033qkm.157.1575894256520;
 Mon, 09 Dec 2019 04:24:16 -0800 (PST)
MIME-Version: 1.0
References: <CACO55ttTPi2XpRRM_NYJU5c5=OvG0=-YngFy1BiR8WpHkavwXw@mail.gmail.com>
 <CAJZ5v0h=7zu3A+ojgUSmwTH0KeXmYP5OKDL__rwkkWaWqcJcWQ@mail.gmail.com>
 <20191121112821.GU11621@lahna.fi.intel.com> <CAJZ5v0hQhj5Wf+piU11abC4pF26yM=XHGHAcDv8Jsgdx04aN-w@mail.gmail.com>
 <20191121114610.GW11621@lahna.fi.intel.com> <CACO55ttXJgXG32HzYP_uJDfQ6T-d8zQaGjXK_AZD3kF0Rmft4g@mail.gmail.com>
 <CAJZ5v0ibzcLEm44udUxW2uVgaF9NapdNBF8Ag+RE++u7gi2yNA@mail.gmail.com>
 <CACO55ttBkZD9dm0Y_jT931NnzHHtDFyLz28aoo+ZG0pnLzPgbA@mail.gmail.com>
 <CAJZ5v0jbh7jz+YQcw-gC5ztmMOc4E9+KFBCy4VGRsRFxBw-gnw@mail.gmail.com>
 <e0eeddf4214f54dfac08e428dfb30cbd39f20680.camel@redhat.com>
 <20191127114856.GZ11621@lahna.fi.intel.com> <CACO55tt5SAf24vk0XrKguhh2J=WuKirDsdY7T+u7PsGFCpnFxg@mail.gmail.com>
 <e7aec10d789b322ca98f4b250923b0f14f2b8226.camel@redhat.com>
 <CACO55tu+hT1WGbBn_nxLR=A-X6YWmeuz-UztJKw0QAFQDDV_xg@mail.gmail.com> <CAJZ5v0hcONxiWD+jpBe62H1SZ-84iNxT+QCn8mcesB1C7SVWjw@mail.gmail.com>
In-Reply-To: <CAJZ5v0hcONxiWD+jpBe62H1SZ-84iNxT+QCn8mcesB1C7SVWjw@mail.gmail.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Mon, 9 Dec 2019 13:24:04 +0100
Message-ID: <CACO55tu19-14nVnnCpWz3r3nf15j6tGWzHNBRmbbs2R6O4gMCA@mail.gmail.com>
Subject: Re: [PATCH v4] pci: prevent putting nvidia GPUs into lower device
 states on certain intel bridges
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Lyude Paul <lyude@redhat.com>,
        Mika Westerberg <mika.westerberg@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        Dave Airlie <airlied@gmail.com>,
        Mario Limonciello <Mario.Limonciello@dell.com>
X-MC-Unique: BAM8xrFbPMW4qMDZ__CMSw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 9, 2019 at 12:39 PM Rafael J. Wysocki <rafael@kernel.org> wrote=
:
>
> On Mon, Dec 9, 2019 at 12:17 PM Karol Herbst <kherbst@redhat.com> wrote:
> >
> > anybody any other ideas?
>
> Not yet, but I'm trying to collect some more information.
>
> > It seems that both patches don't really fix
> > the issue and I have no idea left on my side to try out. The only
> > thing left I could do to further investigate would be to reverse
> > engineer the Nvidia driver as they support runpm on Turing+ GPUs now,
> > but I've heard users having similar issues to the one Lyude told us
> > about... and I couldn't verify that the patches help there either in a
> > reliable way.
>
> It looks like the newer (8+) versions of Windows expect the GPU driver
> to prepare the GPU for power removal in some specific way and the
> latter fails if the GPU has not been prepared as expected.
>
> Because testing indicates that the Windows 7 path in the platform
> firmware works, it may be worth trying to do what it does to the PCIe
> link before invoking the _OFF method for the power resource
> controlling the GPU power.
>

ohh, that actually makes sense. Didn't think of that yet.

> If the Mika's theory that the Win7 path simply turns the PCIe link off
> is correct, then whatever the _OFF method tries to do to the link
> after that should not matter.
>

By the way, and I was only thinking about it after sending my last
email out, do you think we should fail the runtime resume path if the
device gets stuck in a power state?

Currently pci core always calls into the driver regardless, but maybe
for D3cold it really makes sense to just bail and refuse to resume? I
think I tried that as an early "fix" and might even have a patch
around. This should at least prevent crashes inside drivers trying to
access invalid memory or getting stuck in loops.

> > On Wed, Nov 27, 2019 at 8:55 PM Lyude Paul <lyude@redhat.com> wrote:
> > >
> > > On Wed, 2019-11-27 at 12:51 +0100, Karol Herbst wrote:
> > > > On Wed, Nov 27, 2019 at 12:49 PM Mika Westerberg
> > > > <mika.westerberg@intel.com> wrote:
> > > > > On Tue, Nov 26, 2019 at 06:10:36PM -0500, Lyude Paul wrote:
> > > > > > Hey-this is almost certainly not the right place in this thread=
 to
> > > > > > respond,
> > > > > > but this thread has gotten so deep evolution can't push the sub=
ject
> > > > > > further to
> > > > > > the right, heh. So I'll just respond here.
> > > > >
> > > > > :)
> > > > >
> > > > > > I've been following this and helping out Karol with testing her=
e and
> > > > > > there.
> > > > > > They had me test Bjorn's PCI branch on the X1 Extreme 2nd gener=
ation,
> > > > > > which
> > > > > > has a turing GPU and 8086:1901 PCI bridge.
> > > > > >
> > > > > > I was about to say "the patch fixed things, hooray!" but it see=
ms that
> > > > > > after
> > > > > > trying runtime suspend/resume a couple times things fall apart =
again:
> > > > >
> > > > > You mean $subject patch, no?
> > > > >
> > > >
> > > > no, I told Lyude to test the pci/pm branch as the runpm errors we s=
aw
> > > > on that machine looked different. Some BAR error the GPU reported
> > > > after it got resumed, so I was wondering if the delays were helping
> > > > with that. But after some cycles it still caused the same issue, th=
at
> > > > the GPU disappeared. Later testing also showed that my patch also
> > > > didn't seem to help with this error sadly :/
> > > >
> > > > > > [  686.883247] nouveau 0000:01:00.0: DRM: suspending object tre=
e...
> > > > > > [  752.866484] ACPI Error: Aborting method \_SB.PCI0.PEG0.PEGP.=
NVPO due
> > > > > > to previous error (AE_AML_LOOP_TIMEOUT) (20190816/psparse-529)
> > > > > > [  752.866508] ACPI Error: Aborting method \_SB.PCI0.PGON due t=
o
> > > > > > previous error (AE_AML_LOOP_TIMEOUT) (20190816/psparse-529)
> > > > > > [  752.866521] ACPI Error: Aborting method \_SB.PCI0.PEG0.PG00.=
_ON due
> > > > > > to previous error (AE_AML_LOOP_TIMEOUT) (20190816/psparse-529)
> > > > >
> > > > > This is probably the culprit. The same AML code fails to properly=
 turn
> > > > > on the device.
> > > > >
> > > > > Is acpidump from this system available somewhere?
> > >
> > > Attached it to this email
> > >
> > > > >
> > > --
> > > Cheers,
> > >         Lyude Paul
> >
>

