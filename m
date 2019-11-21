Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C09C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 12:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71BF920731
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 12:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i1RTeidH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfKUMxO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 07:53:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37643 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726293AbfKUMxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 07:53:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574340793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rYVd9Wx7thzZZDxf1X7Bt3zWOGy3VRzz5kqCnYWG4J0=;
        b=i1RTeidHFJg7Y+ObWgDcLaBzzqbD7u+AWOD/vxwUAw4EfFuLyIY4JJaUtNy9hm9i3Sw2so
        UMGaPZDjFrt6wh1F+EuBExv1azPsqy1uoSbEQ9+ZyjB+sKIb+dYIFPx1T8Hhyj6yWevrGR
        cngzlUB0YHzGHSFaFPFo4qvmMHgzUmo=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-LvMIdFHdNCqRLZYzSXTXxw-1; Thu, 21 Nov 2019 07:53:11 -0500
Received: by mail-qk1-f197.google.com with SMTP id o11so1898980qkk.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 04:53:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CEM0PnaeoKHLdOkLMiZXYw1vcMAsLpGiAJp9uLo00xA=;
        b=OBV1DWqv8Of0k6DQ66u0OI5MTh8Sj502FIwOC65p928yVAC5v7bvYb+GARX1Pq3Icr
         PylYCn3WArqy0TTXRE4jSYGrKRLsw677SuKoHUcOROl4lmdBDm/2gYGjQGee4qA+HfCR
         2NLEYK070mj1E20V+vhS+P8r4J2gqrKTlEbnOkTxJnL4mN9HbU0pf2BrhK5YAonUlChw
         lHWg9ROzTDcZ7DDduvgvBoIYAGGxQi4Z37b4s/QZIPMfgkBjkKtXRaYLYStdyZA4HMNX
         YCfP2zG+GynaQF7LdPkwTp7Wlto6Oa4hES8h9AqJViv77qqV3QRhWIapLh8gKCForW6H
         hOSg==
X-Gm-Message-State: APjAAAUrwgmEElquM0VJQuVJo/YxV2Nb+T+VEu30zEF57nj98q5XQhNt
        Yv8RUf9LHXM/63UBsHWlnhBAUyjY2negPz27pYzCIQtzDVO5YYIFl0gfYv7bNoVTkiVJ3XfhFlJ
        48hyp5ip8W9bOvyWfxcP64fDDvsvzpUwXxmwf+uQL
X-Received: by 2002:ac8:5557:: with SMTP id o23mr8377459qtr.378.1574340791044;
        Thu, 21 Nov 2019 04:53:11 -0800 (PST)
X-Google-Smtp-Source: APXvYqw52DQ6/+PFF1D7ZWko3HUNgikWPVpBkNz+T6JsTEqXPznpS5K5F7R1sz/hNMU3oG6dRHsmVibiYzYtcy2E5Vc=
X-Received: by 2002:ac8:5557:: with SMTP id o23mr8377430qtr.378.1574340790766;
 Thu, 21 Nov 2019 04:53:10 -0800 (PST)
MIME-Version: 1.0
References: <20191120120913.GE11621@lahna.fi.intel.com> <CACO55tsHy6yZQZ8PkdW8iPA7+uc5rdcEwRJwYEQ3iqu85F8Sqg@mail.gmail.com>
 <20191120151542.GH11621@lahna.fi.intel.com> <CACO55tvo3rbPtYJcioEgXCEQqVXcVAm-iowr9Nim=bgTdMjgLw@mail.gmail.com>
 <20191120155301.GL11621@lahna.fi.intel.com> <CAJZ5v0hkT-fHFOQKzp2qYPyR+NUa4c-G-uGLPZuQxqsG454PiQ@mail.gmail.com>
 <CACO55ttTPi2XpRRM_NYJU5c5=OvG0=-YngFy1BiR8WpHkavwXw@mail.gmail.com>
 <CAJZ5v0h=7zu3A+ojgUSmwTH0KeXmYP5OKDL__rwkkWaWqcJcWQ@mail.gmail.com>
 <20191121112821.GU11621@lahna.fi.intel.com> <CAJZ5v0hQhj5Wf+piU11abC4pF26yM=XHGHAcDv8Jsgdx04aN-w@mail.gmail.com>
 <20191121114610.GW11621@lahna.fi.intel.com>
In-Reply-To: <20191121114610.GW11621@lahna.fi.intel.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Thu, 21 Nov 2019 13:52:57 +0100
Message-ID: <CACO55ttXJgXG32HzYP_uJDfQ6T-d8zQaGjXK_AZD3kF0Rmft4g@mail.gmail.com>
Subject: Re: [PATCH v4] pci: prevent putting nvidia GPUs into lower device
 states on certain intel bridges
To:     Mika Westerberg <mika.westerberg@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lyude Paul <lyude@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        Dave Airlie <airlied@gmail.com>,
        Mario Limonciello <Mario.Limonciello@dell.com>
X-MC-Unique: LvMIdFHdNCqRLZYzSXTXxw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 12:46 PM Mika Westerberg
<mika.westerberg@intel.com> wrote:
>
> On Thu, Nov 21, 2019 at 12:34:22PM +0100, Rafael J. Wysocki wrote:
> > On Thu, Nov 21, 2019 at 12:28 PM Mika Westerberg
> > <mika.westerberg@intel.com> wrote:
> > >
> > > On Wed, Nov 20, 2019 at 11:29:33PM +0100, Rafael J. Wysocki wrote:
> > > > > last week or so I found systems where the GPU was under the "PCI
> > > > > Express Root Port" (name from lspci) and on those systems all of =
that
> > > > > seems to work. So I am wondering if it's indeed just the 0x1901 o=
ne,
> > > > > which also explains Mikas case that Thunderbolt stuff works as de=
vices
> > > > > never get populated under this particular bridge controller, but =
under
> > > > > those "Root Port"s
> > > >
> > > > It always is a PCIe port, but its location within the SoC may matte=
r.
> > >
> > > Exactly. Intel hardware has PCIe ports on CPU side (these are called
> > > PEG, PCI Express Graphics, ports), and the PCH side. I think the IP i=
s
> > > still the same.
> > >

yeah, I meant the bridge controller with the ID 0x1901 is on the CPU
side. And if the Nvidia GPU is on a port on the PCH side it all seems
to work just fine.

> > > > Also some custom AML-based power management is involved and that ma=
y
> > > > be making specific assumptions on the configuration of the SoC and =
the
> > > > GPU at the time of its invocation which unfortunately are not known=
 to
> > > > us.
> > > >
> > > > However, it looks like the AML invoked to power down the GPU from
> > > > acpi_pci_set_power_state() gets confused if it is not in PCI D0 at
> > > > that point, so it looks like that AML tries to access device memory=
 on
> > > > the GPU (beyond the PCI config space) or similar which is not
> > > > accessible in PCI power states below D0.
> > >
> > > Or the PCI config space of the GPU when the parent root port is in D3=
hot
> > > (as it is the case here). Also then the GPU config space is not
> > > accessible.
> >
> > Why would the parent port be in D3hot at that point?  Wouldn't that be
> > a suspend ordering violation?
>
> No. We put the GPU into D3hot first, then the root port and then turn
> off the power resource (which is attached to the root port) resulting
> the topology entering D3cold.
>

If the kernel does a D0 -> D3hot -> D0 cycle this works as well, but
the power savings are way lower, so I kind of prefer skipping D3hot
instead of D3cold. Skipping D3hot doesn't seem to make any difference
in power savings in my testing.

> > > I took a look at the HP Omen ACPI tables which has similar problem an=
d
> > > there is also check for Windows 7 (but not Linux) so I think one
> > > alternative workaround would be to add these devices into
> > > acpi_osi_dmi_table[] where .callback is set to dmi_disable_osi_win8 (=
or
> > > pass 'acpi_osi=3D"!Windows 2012"' in the kernel command line).
> >
> > I'd like to understand the facts that have been established so far
> > before deciding what to do about them. :-)
>
> Yes, I agree :)
>

Yeah.. and I think those would be too many as we know of several
models with this laptops from Lenovo, Dell and HP and random other
models from random other OEMs. I think we won't ever be able to
blacklist all models if we go that way as those might be just way too
many. Also I know from some reports on bumblebee bugs (hitting the
same issue essentially) that the acpi_osi overwrite didn't help every
user.

