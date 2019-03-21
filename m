Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9799BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 10:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66025218D4
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 10:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iZ9dzSsR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbfCUKOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 06:14:30 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:55463 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727903AbfCUKO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 06:14:28 -0400
Received: by mail-it1-f194.google.com with SMTP id z126so3387027itd.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 03:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LnIQeHysyAh4OxVAmTIp1275+Y0XXOOAyU6zmVXxNnk=;
        b=iZ9dzSsR+BWgDp1GDW46mSihLI8eskSDOkDD5sFB5JfGes9Oz4RHxF0f2dbPSfOBrw
         UFVSDN4h1cW6eXunP0lGDCxPwbHwOnrfuUKaCAPNHNof2sqX1v17d+yFB8sUp8Ok2Bh3
         g4PEX3lyJR4pykAm11GzKuXH19Tub4AiBH5L+tnKGDlwMyiH/7emHt8TdENbNeaiHSHU
         K4mZMr4v3ZvMBnW9+vSy6Z5E+0r1SJww5TGylTEk+nfjaD8eImOuWepCxesCzupyz5eB
         gyx14EYSh2P+b0hS0YvyvUAWFSdopqPIFe+nOjTFdvyMCcJevXxwhAJoKdu01VDXC1On
         9mAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LnIQeHysyAh4OxVAmTIp1275+Y0XXOOAyU6zmVXxNnk=;
        b=oEqAON4jts9jXQqcAiLCeUl2Kf2HfDAeF2ETxLpS3+hP6HXPoihK27cdI63BoSo5A8
         omUIEbbZI4ij5LKTBtRwH3yeHMCKqRIAzGKwRVyasSggeHr1EkjZo+yz1Y/Acv6ia+qv
         RxYIB8jZh+UkQNW3W/1NjILxXRActlUJrXxFJnACNrWU2SbaRwn+ZjMcG1JHfgF76zf0
         LtgSixLGwI94SXGIcpKzjKvaR7fyqP8g5lhTO+ATjfTEwuCXtehfuyTrHEbEVrZDCVzC
         HsXYwI0GNu9zDMbdW8CxPlgpwqTA09Z2gouARGsRAMM0+NvMyMAxga0eXZrTlcyPGD4G
         4U8w==
X-Gm-Message-State: APjAAAVeYF8NuPg0fcWCfC9ak8RO/Lq8bv06vEAxHBWPyNB5WaHvivqT
        o+9CsSmJsZNXn0o79z5QNlOHBAXLJkHrslGILs4Lsg==
X-Google-Smtp-Source: APXvYqyBlcJGqZ/i+PW0aqFhJOCWM5PkC4gpD7+gONiuULghhEqP55MsUorgaN8UCakrhBbaLqEUdD0lRUToMip3XVg=
X-Received: by 2002:a05:660c:7d1:: with SMTP id e17mr2224586itl.158.1553163266977;
 Thu, 21 Mar 2019 03:14:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190320130502.16667-1-rrichter@marvell.com> <20190320131607.vgst3r7ynha55ikw@rric.localdomain>
 <20190320152240.2eun63wqkbqmuqkg@rric.localdomain> <CAKv+Gu8HKUQPr7TaUm7EwdVFasUitAPBJFotpG43nNAKMBvxdA@mail.gmail.com>
 <20190321093920.beng2d3tbfvydbud@rric.localdomain> <CAKv+Gu899a5FpMqOzF5EVgsHRk37_PBxW8kVicgc8ST3=R_VUA@mail.gmail.com>
 <1553163110.5084.11.camel@suse.de>
In-Reply-To: <1553163110.5084.11.camel@suse.de>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 21 Mar 2019 11:14:16 +0100
Message-ID: <CAKv+Gu9RbNUc0hqQ=8hzF=taEu03ywB1gVFswObKKDH2DP+sNw@mail.gmail.com>
Subject: Re: [PATCH v2] efi: Unify dmi setup code over architectures
 arm/arm64, io64 and x86
To:     Jean Delvare <jdelvare@suse.de>
Cc:     Robert Richter <rrichter@marvell.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Marcin Benka <mbenka@marvell.com>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Mar 2019 at 11:11, Jean Delvare <jdelvare@suse.de> wrote:
>
> On Thu, 2019-03-21 at 10:51 +0100, Ard Biesheuvel wrote:
> > On Thu, 21 Mar 2019 at 10:39, Robert Richter <rrichter@marvell.com> wrote:
> > >
> > > On 20.03.19 23:02:09, Ard Biesheuvel wrote:
> > > > On Wed, 20 Mar 2019 at 16:23, Robert Richter <rrichter@marvell.com> wrote:
> > > > >
> > > > > On 20.03.19 14:16:07, Robert Richter wrote:
> > > > > > On 20.03.19 13:05:37, Robert Richter wrote:
> > > > > > > @@ -167,6 +167,7 @@ static int __init arm_dmi_init(void)
> > > > > > >      * itself, depends on dmi_scan_machine() having been called already.
> > > > > > >      */
> > > > > > >     dmi_scan_machine();
> > > > > > > +   dmi_memdev_walk();
> > > > > > >     if (dmi_available)
> > > > > > >             dmi_set_dump_stack_arch_desc();
> > > > > > >     return 0;
> > > > > >
> > > > > > After
> > > > > >
> > > > > >  [PATCH] efi/arm: Show SMBIOS bank/device location in cper and
> > > > > >   ghes error logs
> > > > > >
> > > > > > wents in for arm/arm64, we can unify the code. See patch below.
> > > > >
> > > > > V2 with the fix in arm_dmi_init() below.
> > > > >
> > > > > -Robert
> > > > >
> > > > >
> > > > > -- >8 --
> > > > > From: Robert Richter <rrichter@marvell.com>
> > > > > Subject: [PATCH v2] efi: Unify dmi setup code over architectures arm/arm64,
> > > > >  io64 and x86
> > > > >
> > > > > All architectures (arm/arm64, io64 and x86) do the same here, so unify
> > > > > the code.
> > > > >
> > > > > Note: We do not need to call dump_stack_set_arch_desc() in case of
> > > > > !dmi_available. Both strings, dmi_ids_string and dump_stack_arch_
> > > > > desc_str are initialized zero and thus nothing would change.
> > > > >
> > > >
> > > > I don't understand the last sentence - we do not need to call
> > > > dump_stack_set_arch_desc() when !dmi_available, but we do so anyway,
> > > > right? Doesn't that wipe the arch description we set based on the DT
> > > > machine name?
> > >
> > > No, in dmi_setup() we exit early when !dmi_available. So for arm/arm64
> > > nothing changed. But for x86 and ia64 we no longer call dump_stack_
> > > set_arch_desc() in this case. This is ok since both strings,
> > > dmi_ids_string and dump_stack_arch_desc_str, are initialized zero and
> > > copying one to the other does not change anything.
> > >
> >
> > Ah, of course. Apologies for not reading more carefully.
> >
> > I'll take this patch via the EFI tree.
>
> I like the idea. If this is not going through my tree then:
>
> Reviewed-by: Jean Delvare <jdelvare@suse.de>
>

Thanks Jean.
