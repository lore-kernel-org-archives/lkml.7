Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0351C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEE0520709
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MCM6LDn3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729156AbfKTPhe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 10:37:34 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39584 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728445AbfKTPhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 10:37:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574264249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/C9gUt9cyA76AzLuivaEWyzrhcrqWJ0lBzJ30P+LXYs=;
        b=MCM6LDn32Q4K+NrSFNN2985PKABcP3GJjhJKWil5gIxAFLAKvYmcazSxpXEXlnjG0dls/6
        bL9SUGO46RRfgREq4+SFLGPd0Y/WeAkqSLPCiz8PbVUTSuY9eOiDNuier06wrNyibzCzD+
        kjA4RBTohe/Q0fVrQjIITsxRONwfBY4=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-iVvNkIJQM3K309Al5z9gbw-1; Wed, 20 Nov 2019 10:37:26 -0500
Received: by mail-qt1-f200.google.com with SMTP id g5so104442qtc.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 07:37:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BksgvfivWT5oEKOsVtU2jjsSwTJ8rcltyxFUj+I5xNY=;
        b=f+J4UjHlEXwHGe8BtE0Cg5uYfP/65j2+h24qfXznAMatOKC9f8Q6ghqTen+J2TmwAp
         SIINYwQHjZkpRSpvYUM3hueNoAhuVMLYCkZZv8eofQrwcOgzePyGWJqCPjMehdHbt2Bk
         +7H/3Fc6DLmPvFj/zZOcUzzl00f+x5dOjf0h3hbsUnhbZG9GIQiHI6VJWzhC40JvWnT9
         tt7YvRh56QEdmaCEMAGdzQ9TdIkI4pHgaeUgW8fO9TUON7Xf7Ua48AqdXr5KoORfjfAz
         v0l5YUiidjiCFjtNajGOyhs3tK/rinHrCf5moPtyNBjp9wrjHuwQvWSmJFzsXuynGDdE
         F+mw==
X-Gm-Message-State: APjAAAXrXTcFfw4Nm5apcD60dfgUgdZV9ro44rqK9syDpD3DBUolILtr
        1j3+5T/GMC8UhweOVPcsNNmbfwtlPGSlI2VcVywTmNLnyuHTNeWD4wlRXEutmLKt/b2880N9pOt
        Jresxcthl0WgfGE24PAKhRrpaw6cwgo8JsG7I8qQE
X-Received: by 2002:a37:6811:: with SMTP id d17mr3082060qkc.102.1574264245968;
        Wed, 20 Nov 2019 07:37:25 -0800 (PST)
X-Google-Smtp-Source: APXvYqzt0K/ijAMXYP756+k75llJT5zszZ47OfQZKFovlD4ZwaMaT169d/nRHiPSAwI9CqrdON3hSsUsT8pA85i0bCE=
X-Received: by 2002:a37:6811:: with SMTP id d17mr3082027qkc.102.1574264245623;
 Wed, 20 Nov 2019 07:37:25 -0800 (PST)
MIME-Version: 1.0
References: <20191119214955.GA223696@google.com> <CACO55tu+8VeyMw1Lb6QvNspaJm9LDgoRbooVhr0s3v9uBt=feg@mail.gmail.com>
 <20191120101816.GX11621@lahna.fi.intel.com> <CAJZ5v0g4vp1C+zHU5nOVnkGsOjBvLaphK1kK=qAT6b=mK8kpsA@mail.gmail.com>
 <20191120112212.GA11621@lahna.fi.intel.com> <20191120115127.GD11621@lahna.fi.intel.com>
 <CACO55tsfNOdtu5SZ-4HzO4Ji6gQtafvZ7Rm19nkPcJAgwUBFMw@mail.gmail.com>
 <CACO55tscD_96jUVts+MTAUsCt-fZx4O5kyhRKoo4mKoC84io8A@mail.gmail.com>
 <20191120120913.GE11621@lahna.fi.intel.com> <CACO55tsHy6yZQZ8PkdW8iPA7+uc5rdcEwRJwYEQ3iqu85F8Sqg@mail.gmail.com>
 <20191120151542.GH11621@lahna.fi.intel.com>
In-Reply-To: <20191120151542.GH11621@lahna.fi.intel.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Wed, 20 Nov 2019 16:37:14 +0100
Message-ID: <CACO55tvo3rbPtYJcioEgXCEQqVXcVAm-iowr9Nim=bgTdMjgLw@mail.gmail.com>
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
X-MC-Unique: iVvNkIJQM3K309Al5z9gbw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 4:15 PM Mika Westerberg
<mika.westerberg@intel.com> wrote:
>
> On Wed, Nov 20, 2019 at 01:11:52PM +0100, Karol Herbst wrote:
> > On Wed, Nov 20, 2019 at 1:09 PM Mika Westerberg
> > <mika.westerberg@intel.com> wrote:
> > >
> > > On Wed, Nov 20, 2019 at 12:58:00PM +0100, Karol Herbst wrote:
> > > > overall, what I really want to know is, _why_ does it work on windo=
ws?
> > >
> > > So do I ;-)
> > >
> > > > Or what are we doing differently on Linux so that it doesn't work? =
If
> > > > anybody has any idea on how we could dig into this and figure it ou=
t
> > > > on this level, this would probably allow us to get closer to the ro=
ot
> > > > cause? no?
> > >
> > > Have you tried to use the acpi_rev_override parameter in your system =
and
> > > does it have any effect?
> > >
> > > Also did you try to trace the ACPI _ON/_OFF() methods? I think that
> > > should hopefully reveal something.
> > >
> >
> > I think I did in the past and it seemed to have worked, there is just
> > one big issue with this: it's a Dell specific workaround afaik, and
> > this issue plagues not just Dell, but we've seen it on HP and Lenovo
> > laptops as well, and I've heard about users having the same issues on
> > Asus and MSI laptops as well.
>
> Maybe it is not a workaround at all but instead it simply determines
> whether the system supports RTD3 or something like that (IIRC Windows 8
> started supporting it). Maybe Dell added check for Linux because at that
> time Linux did not support it.
>

the point is, it's not checking it by default, so by default you still
run into the windows 8 codepath.

> In case RTD3 is supported it invokes LKDS() which probably does the L2
> or L3 entry and this is for some reason does not work the same way in
> Linux than it does with Windows 8+.
>
> I don't remember if this happens only with nouveau or with the
> proprietary driver as well but looking at the nouveau runtime PM suspend
> hook (assuming I'm looking at the correct code):
>
> static int
> nouveau_pmops_runtime_suspend(struct device *dev)
> {
>         struct pci_dev *pdev =3D to_pci_dev(dev);
>         struct drm_device *drm_dev =3D pci_get_drvdata(pdev);
>         int ret;
>
>         if (!nouveau_pmops_runtime()) {
>                 pm_runtime_forbid(dev);
>                 return -EBUSY;
>         }
>
>         nouveau_switcheroo_optimus_dsm();
>         ret =3D nouveau_do_suspend(drm_dev, true);
>         pci_save_state(pdev);
>         pci_disable_device(pdev);
>         pci_ignore_hotplug(pdev);
>         pci_set_power_state(pdev, PCI_D3cold);
>         drm_dev->switch_power_state =3D DRM_SWITCH_POWER_DYNAMIC_OFF;
>         return ret;
> }
>
> Normally PCI drivers leave the PCI bus PM things to PCI core but here
> the driver does these. So I wonder if it makes any difference if we let
> the core handle all that:
>
> static int
> nouveau_pmops_runtime_suspend(struct device *dev)
> {
>         struct pci_dev *pdev =3D to_pci_dev(dev);
>         struct drm_device *drm_dev =3D pci_get_drvdata(pdev);
>         int ret;
>
>         if (!nouveau_pmops_runtime()) {
>                 pm_runtime_forbid(dev);
>                 return -EBUSY;
>         }
>
>         nouveau_switcheroo_optimus_dsm();
>         ret =3D nouveau_do_suspend(drm_dev, true);
>         pci_ignore_hotplug(pdev);
>         drm_dev->switch_power_state =3D DRM_SWITCH_POWER_DYNAMIC_OFF;
>         return ret;
> }
>
> and similar for the nouveau_pmops_runtime_resume().
>

yeah, I tried that at some point and it didn't help either. The reason
we call those from inside Nouveau is to support systems pre _PR where
nouveau invokes custom _DSM calls on its own. We could potentially
check for that though.

