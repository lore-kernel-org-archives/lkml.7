Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21380C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 12:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC7D120731
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 12:57:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IJjLyLmf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfKUM5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 07:57:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53953 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726293AbfKUM5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 07:57:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574341031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nVnuS3G07UEp6AIL04Xz4q+Tzbj4PQPwyBSCk9uHGkw=;
        b=IJjLyLmfUKo+7eHjcuvWWSQBr+5Vu6Tpmpx4vcIwd+0hY6t5kNQX+CA54HCeKDy6MR0pL6
        GN2MBCFVGnbVSvBlJTiRq8fm3j8rkwWvuDBl9ok4te1Bv6m7Kstt00CZg2yZYEk1X9mTM/
        q/Y8JlQvSelYzr5dPBXkUv3iK06KN20=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-IdTq9dY6NIWP4AC8byP3cg-1; Thu, 21 Nov 2019 07:57:10 -0500
Received: by mail-qt1-f200.google.com with SMTP id o13so2214096qtr.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 04:57:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QH9raaSEy0ZT3Ng+Xr/UbfMvZg5iClSyjL5MYEeeB0o=;
        b=AkCsA34uzO8iE7U9Qvv5VayE7VDC4lUhqziUx6epWEbYPmab5A7aCCom9TOOdEBKdc
         VMVz3st7UD8t1ehHBUHsU3Q5R+f4+500yf3h1yZf7Xqkgw8CVELyuXLERySaAeNABVnZ
         ZOozey25LBWqRKUhQRt0oInCunIRldUMZ4/XY/hvdpjcfJLnRBbnxIFv7IffOnvBLdEb
         JtNrj2awewpQCMtW1TQrDgqfPHR/UzHnvm9G9AS4/oyApSu57FVueNKdQfDjVfczYeuT
         nU5VSvP4B1G9HPGGYcdMF6N2o3GclLp8dphgcGLpWYFZu/gnkXKEooeyIcnlizykc+eE
         Lzpw==
X-Gm-Message-State: APjAAAWnFTz5Pwl/Ayum6MmkeCloOnfgTO/FgPvU+KGRxS2MN4IvZpzo
        Fu6ZlUyk+oTDn9ekfAfzmEVNrruHWNroFWVH2Dd8QhVdNFXWIONBeoss54ssd+WGx5qFkCbtede
        fQiYMKNNlLmtm78REtr8p7XvYOG6bIz8ofQbtUGMI
X-Received: by 2002:ac8:7550:: with SMTP id b16mr8247883qtr.286.1574341029753;
        Thu, 21 Nov 2019 04:57:09 -0800 (PST)
X-Google-Smtp-Source: APXvYqzCB3+oy9LxTLupf+9fIdsK0rCf/DUfxOcnQaIfyPvrUsIjLHSyzhlMj9XMgXerrNXcdpm7ZYcN/G4r6b/xReI=
X-Received: by 2002:ac8:7550:: with SMTP id b16mr8247859qtr.286.1574341029535;
 Thu, 21 Nov 2019 04:57:09 -0800 (PST)
MIME-Version: 1.0
References: <CACO55tsHy6yZQZ8PkdW8iPA7+uc5rdcEwRJwYEQ3iqu85F8Sqg@mail.gmail.com>
 <20191120151542.GH11621@lahna.fi.intel.com> <CACO55tvo3rbPtYJcioEgXCEQqVXcVAm-iowr9Nim=bgTdMjgLw@mail.gmail.com>
 <20191120155301.GL11621@lahna.fi.intel.com> <CAJZ5v0hkT-fHFOQKzp2qYPyR+NUa4c-G-uGLPZuQxqsG454PiQ@mail.gmail.com>
 <CACO55ttTPi2XpRRM_NYJU5c5=OvG0=-YngFy1BiR8WpHkavwXw@mail.gmail.com>
 <CAJZ5v0h=7zu3A+ojgUSmwTH0KeXmYP5OKDL__rwkkWaWqcJcWQ@mail.gmail.com>
 <20191121112821.GU11621@lahna.fi.intel.com> <CAJZ5v0hQhj5Wf+piU11abC4pF26yM=XHGHAcDv8Jsgdx04aN-w@mail.gmail.com>
 <20191121114610.GW11621@lahna.fi.intel.com> <20191121125236.GX11621@lahna.fi.intel.com>
In-Reply-To: <20191121125236.GX11621@lahna.fi.intel.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Thu, 21 Nov 2019 13:56:57 +0100
Message-ID: <CACO55ttOgx=jyCh_uZLH4t8C5SW0f2u3BSrw93vPmusM98p0Mg@mail.gmail.com>
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
X-MC-Unique: IdTq9dY6NIWP4AC8byP3cg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 1:52 PM Mika Westerberg
<mika.westerberg@intel.com> wrote:
>
> On Thu, Nov 21, 2019 at 01:46:14PM +0200, Mika Westerberg wrote:
> > On Thu, Nov 21, 2019 at 12:34:22PM +0100, Rafael J. Wysocki wrote:
> > > On Thu, Nov 21, 2019 at 12:28 PM Mika Westerberg
> > > <mika.westerberg@intel.com> wrote:
> > > >
> > > > On Wed, Nov 20, 2019 at 11:29:33PM +0100, Rafael J. Wysocki wrote:
> > > > > > last week or so I found systems where the GPU was under the "PC=
I
> > > > > > Express Root Port" (name from lspci) and on those systems all o=
f that
> > > > > > seems to work. So I am wondering if it's indeed just the 0x1901=
 one,
> > > > > > which also explains Mikas case that Thunderbolt stuff works as =
devices
> > > > > > never get populated under this particular bridge controller, bu=
t under
> > > > > > those "Root Port"s
> > > > >
> > > > > It always is a PCIe port, but its location within the SoC may mat=
ter.
> > > >
> > > > Exactly. Intel hardware has PCIe ports on CPU side (these are calle=
d
> > > > PEG, PCI Express Graphics, ports), and the PCH side. I think the IP=
 is
> > > > still the same.
> > > >
> > > > > Also some custom AML-based power management is involved and that =
may
> > > > > be making specific assumptions on the configuration of the SoC an=
d the
> > > > > GPU at the time of its invocation which unfortunately are not kno=
wn to
> > > > > us.
> > > > >
> > > > > However, it looks like the AML invoked to power down the GPU from
> > > > > acpi_pci_set_power_state() gets confused if it is not in PCI D0 a=
t
> > > > > that point, so it looks like that AML tries to access device memo=
ry on
> > > > > the GPU (beyond the PCI config space) or similar which is not
> > > > > accessible in PCI power states below D0.
> > > >
> > > > Or the PCI config space of the GPU when the parent root port is in =
D3hot
> > > > (as it is the case here). Also then the GPU config space is not
> > > > accessible.
> > >
> > > Why would the parent port be in D3hot at that point?  Wouldn't that b=
e
> > > a suspend ordering violation?
> >
> > No. We put the GPU into D3hot first, then the root port and then turn
> > off the power resource (which is attached to the root port) resulting
> > the topology entering D3cold.
>
> I don't see that happening in the AML though.
>
> Basically the difference is that when Windows 7 or Linux (the _REV=3D=3D5
> check) then we directly do link disable whereas in Windows 8+ we invoke
> LKDS() method that puts the link into L2/L3. None of the fields they
> access seem to touch the GPU itself.
>
> LKDS() for the first PEG port looks like this:
>
>    P0L2 =3D One
>    Sleep (0x10)
>    Local0 =3D Zero
>    While (P0L2)
>    {
>         If ((Local0 > 0x04))
>         {
>             Break
>         }
>
>         Sleep (0x10)
>         Local0++
>    }
>
> One thing that comes to mind is that the loop can end even if P0L2 is
> not cleared as it does only 5 iterations with 16 ms sleep between. Maybe
> Sleep() is implemented differently in Windows? I mean Linux may be
> "faster" here and return prematurely and if we leave the port into D0
> this does not happen, or something. I'm just throwing out ideas :)
>

keep in mind, that I am able to hit this bug with my python script:
https://raw.githubusercontent.com/karolherbst/pci-stub-runpm/master/nv_runp=
m_bug_test.py

