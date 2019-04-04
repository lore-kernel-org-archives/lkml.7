Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F28DFC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 00:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B257A2147C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 00:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ctjDSbf4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbfDDA7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 20:59:52 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37927 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfDDA7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 20:59:51 -0400
Received: by mail-lj1-f195.google.com with SMTP id p14so507407ljg.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 17:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uXQGxQZinWrnMCiWA2S7QXRloz0xy6tXq6rsugaCmg8=;
        b=ctjDSbf4b49GrAytJtaMYnr84IQw2GmPnb4HQ+eOHBSRHTSsLHdb36lsouCvJY/cQg
         Qn+cSu6kzyMgWcydTmmasE5cyM3/XyxxoiDeaMOp3LKq4D/qF041mXtLaCiH9faX2VEZ
         DAMoOBn9Et8X/K6lcPDPpOn24ZlEGGkKQn71lgvq/riXTwEB0M0EOYIWn8vr2sbnxCkR
         h+ndP28VWq1u9wQd4CxG1vXyQDb8zMqq07yGwzLaUJmQo+2SrDRr4oBia5fK7/j4n+Wq
         unouWbjEH7FusafrvA8DqNh9P385iTe0O9xeZBkaZskWrwWegyeZea8FWA/N9FLhAoR3
         GlTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uXQGxQZinWrnMCiWA2S7QXRloz0xy6tXq6rsugaCmg8=;
        b=XZzhpVcSRhJWTaU1Ta9sujrin5RorqiPDWIoCK8GUx/jWX+oq6KHUHsE+VPuDPl+Y+
         0ErAfypP5FtihzZB+9Re7juR0cNp45r6qETJEa3lxmzagqEBPMyI2L7Zj3DPfsWQbTou
         uB9CPcRadu/h6+qn2F6596e0CU4EzM18j9rQx8Yj1g8Cvur4wBIQg9GPQba2+WljAm3V
         QozdlEqiuK2+hme+Sh2wZkpbCAm39WIaB/jloPE2ddh+/hKg4y/xrBhJC4KSMZThz5Tt
         YXCo/fd5GrIroQZ4Frzi3v9fRcN8ZWCe67eq0ap5iJRdCrYTgkjyE6b8+mF1ev8ZuJSg
         caBw==
X-Gm-Message-State: APjAAAX91+1ZNfWrKdvQFeRoViCvnGzK1qWASKnednCzODgEX2BXMVIX
        H30YTvd7BFWRnuqawY1AH3iwZqxj/RRZMM7s7l8cxg==
X-Google-Smtp-Source: APXvYqyXiDesSMAsj9G2aolwI0R8f8/qzcCSz1p5AYUq+VVfxN071++k2BoGA6mCUXbwE4C9xaGm6Ea4YPQYEDNWUu4=
X-Received: by 2002:a2e:8149:: with SMTP id t9mr1681872ljg.2.1554339588563;
 Wed, 03 Apr 2019 17:59:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190313222124.229371-1-rajatja@google.com> <20190316081752.GA21812@raj-desk2.iind.intel.com>
 <CAA93t1qoQx2B9=KuNpuXL_PvdpgGJPzZk8N-KWqS4XyO8qrS5g@mail.gmail.com>
 <3fc03e60-492a-e9b5-ac9b-caa17f8a8e27@linux.intel.com> <CACK8Z6HGEeM_0AnM1eJcUgNPwFz6_wsT8oFAG2rkV4UZczDi3g@mail.gmail.com>
 <c98af2ef-5800-0dee-7b58-3be48f612d07@linux.intel.com> <CACK8Z6HQ1QMRygSVgWabO9kUSA3tTL9Uh0Lhw6wv3Vyb4aaFKA@mail.gmail.com>
 <30c3eff209246cc184cbddb0ec60e9acd9dd1d6b.camel@linux.intel.com>
 <CAA93t1p915ofjgzLeW3n+tsKrDWU0wDjf7QXu1fwTao0U-bqLQ@mail.gmail.com> <0fc21af78c41e49aea452f971b5afe1271a09f3f.camel@linux.intel.com>
In-Reply-To: <0fc21af78c41e49aea452f971b5afe1271a09f3f.camel@linux.intel.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Wed, 3 Apr 2019 17:59:10 -0700
Message-ID: <CACK8Z6EMcfLqu=FWky_z+FSfd93t1yk0T6EftOzQkNfJCiAxyg@mail.gmail.com>
Subject: Re: [PATCH 1/2] platform/x86: intel_pmc_core: Convert to a platform_driver
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Rajat Jain <rajatxjain@gmail.com>,
        "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@linux.intel.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Vishwanath Somayaji <vishwanath.somayaji@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Furquan Shaikh <furquan@google.com>,
        Evan Green <evgreen@google.com>,
        "Box, David E" <david.e.box@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 8:53 AM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Thu, 2019-03-28 at 22:29 -0700, Rajat Jain wrote:
> > Hi Srinivas,
> >
> >
>
> [...]
>
> > So if everyone here thinks we should completely switch to using
> > > > the
> > > > ACPI HID "INT33A1" for attaching to the device, sure, we can do
> > > > that.
> > > > Yes, for Chromeos, we can put in a work around internally that
> > > > ensures
> > > > that shipping chromebooks (Kabylake etc) can work fine without
> > > > that
> > > > ACPI ID. What I do not know is if that will cause any regressions
> > > > outside of Chromeos. Can you discuss with Rafael, Andy, Srinivas
> > > > internally and let me know on how they'd like to proceed on this.
> > > >
> > > > The other option is to apply this patch as-is so we know that
> > > > there
> > > > is
> > > > no "functional change" and thus no possible regression (so the
> > > > driver
> > > > continues to attach to those and only those systems that s it
> > > > used
> > > > to,
> > > > before this patch). And then introduce the ACPI ID Change as a
> > > > new
> > > > independent patch.
> > >
> > > Use INT33A1 to enumerate, if this id doesn't exist then fallback to
> > > the
> > > cpuid style.

OK, I got to down to implement this and have a few questions.

The intel_pmc_driver does need some way to determine whether to choose
between spt_reg_map / cnp_reg_map / icl_reg_map. How should it choose
between these?

 1) For ACPI based enumeration, I don't think the ACPI nodes on the
current systems will have anything to offer to help the driver
differentiate between these. So it will still need to choose one of
the above maps based on the CPU model. I assume that is OK. I expect
something like:

        switch (boot_cpu_data.x86_model) {
        case INTEL_FAM6_SKYLAKE_MOBILE:
        case INTEL_FAM6_SKYLAKE_DESKTOP:
        case INTEL_FAM6_KABYLAKE_MOBILE:
        case INTEL_FAM6_KABYLAKE_DESKTOP:
                pmcdev->map =3D &spt_reg_map;
                break;

        case INTEL_FAM6_CANONLAKE_DESKTOP:
                pmcdev->map =3D &cnp_reg_map;
                break;

        case INTEL_FAM6_ICELAKE_DESKTOP:
                pmcdev->map =3D &icl_reg_map;
                break;
        default:
                /* Which map should we use by default? */
        }


 2) For the ACPI based enumeration, what should be the default map
chosen by the driver, for CPUs other than what is in that list today
(Or do we expect to keep adding to this switch/case for new CPU
models)?

3) For the fallback option, i.e. manually creating platform devices
using a new file, yes, we can pass a value in platform_data to
indicate which map to choose from, which is what I think should be
done. However, I am wondering if all this fallback might be an
overkill / over engineering. Do we know of any platforms that do not
have this ACPI device, and still are actually using this
intel_pmc_core driver? If not, may be we don't need this fallback
option?

Thanks,

Rajat

> > > The aim should be that we don't have to add any more
> > > CPU
> > > model to enumerate. But most probably register map will differ so
> > > we
> > > still may end up adding some CPU model relationship.
> >
> > Thanks for the guidance. Just to reconfirm my understanding of your
> > suggestion:
> >
> > Here is the suggestive code Rajneesh provided, and I intend to do it
> > similarly:
> >
> > +static const struct acpi_device_id pmc_acpi_ids[] =3D {
> > +             {"INT33A1", 0}, /* _HID for Intel Power Engine, _CID
> > PNP0D80*/
> > +             { }
> > +};
> >
> > +static struct platform_driver pmc_plat_driver =3D {
> > +             .remove =3D pmc_plat_remove,
> > +             .probe =3D pmc_plat_probe,
> > +             .driver =3D {
> > +                             .name =3D "pmc_core_driver",
> > +                             .acpi_match_table =3D
> > ACPI_PTR(pmc_acpi_ids),
> > +             },
> > +};
> >
> > My understanding is that with this, the kernel would use
> > acpi_match_table to automatically create the platform_device on a
> > platform where ACPI tables contain the INT33A1 HID, and thus we don't
> > need to create the platform_device in module_init time on such
> > platforms.
> Yes. There will be /sys/bus/platform/devices/INT33A1:00.
>
>
> >  So are you saying that during init, I should check if the
> > ACPI HID INT33A1 is not present on the platform, then use the cpu_id
> > table to create the platform_device? Thus newer platforms will not
> > need an entry in the table.
> Yes. Preferably in a different file as Andy would like. So the the
> current driver only implements platform driver for INT33A1. The other dri=
ver which will enumerate on CPUID and create INT33A1 platform device  if th=
ere is no ACPI match via acpi_match_device() or similar API, for INT33A1. W=
hen you create a platform device the pmc driver will be probed.
>
> Thanks,
> Srinivas
>
>
