Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06014C4CEC9
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 18:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C780F2089F
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 18:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MmA+0wnt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387831AbfIMSzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 14:55:02 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40386 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbfIMSzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 14:55:01 -0400
Received: by mail-wm1-f68.google.com with SMTP id m3so3822696wmc.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 11:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LK6BcfTtlvKSYDJoPVw9VIzHwzJx79qINCD8VGMWxWw=;
        b=MmA+0wntAPGIhuRzsZ5stjnz8kCcV8qZhIAZw19rgAMirB34N4/enF2XQ1JAdGpyjs
         xNNjSyzcnyYrJYTVFL5jJG3jaz1FuHnN7w5fgTFek7glJI9pRyY52JhTK+ok1Wjkb2xC
         6Wsc7d+Yo9kGIH6tHhGWnnLw1xvBg1aP8q/w/s1uSrbZ5UDYFvqwZEE+z5NTEbyFpKLT
         XyRKAesgpn25gClGxJreqsTRDL0IVC0EytpHpqwjGXuH6S+If4rEAjgR0ogTs54it6O3
         TbYXUvk2UalXinfoC9iCNFSjfh7ACD6Sh2D2bVGbRAj76mEbNHz+SzhaMrlDgQdSUl08
         ykuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LK6BcfTtlvKSYDJoPVw9VIzHwzJx79qINCD8VGMWxWw=;
        b=OkVo2hZ0kWEHQ8gLBgeo2Cuu4yvJ0EB8C8iyR1f5qGJ3TEelnuUn4OLyn35O1DYZ67
         NaykhR5nsP43R5q6X2YhU5EVSwMcYGUh2TopvYcOwM/m+mb7tp4nYlnBuuGH4dr/Vhmx
         5MeYPG6q2M9mBBhuidh3VS3jU7+FyBNHMpFFfqI3wgcvrAFz1TFsvHW8FKLO4A9+sF7C
         hrMslM9nIlua5MINa3v5dCAgzzULCAPzKMb5Rc2pyJQkAU0WS+CV3w2rg1fG+OoEKfrV
         OzWPEp2FwVjtmTn1WGwI39n3VoazwOp/AlKQLt3ZeeEifScMTQmnAJmXxGWdJdlJyRAI
         tFWA==
X-Gm-Message-State: APjAAAVbtNfy5NHHGJGwDsFLc18vvxMBlMTogp3UzFAwojYDHInJk4R5
        ba90ySTLyfv29Z9tDjR+Bv1r9lV3pM97QTphXuA9GA==
X-Google-Smtp-Source: APXvYqxCj9N4NNCKFL/6ZHOZi7gwuHzjmOwekeuo+9krwBCVLkTk3eW+gzBirP6rO4QePKWZoTWH6bkRW8Jz0E5nZsY=
X-Received: by 2002:a7b:cc86:: with SMTP id p6mr4263466wma.136.1568400898823;
 Fri, 13 Sep 2019 11:54:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190829101119.7345-1-robert.bradford@intel.com>
 <alpine.DEB.2.21.1908291416560.1938@nanos.tec.linutronix.de> <caa320fa61d619a85d6237076f5ec8ed134d11b7.camel@intel.com>
In-Reply-To: <caa320fa61d619a85d6237076f5ec8ed134d11b7.camel@intel.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 13 Sep 2019 19:54:35 +0100
Message-ID: <CAKv+Gu-npaYDb438zRrWbCHaEVeULDuOJeFsnxg=cd+TMVdw7Q@mail.gmail.com>
Subject: Re: [PATCH] x86/reboot: Avoid EFI reboot when not running on EFI
To:     "Bradford, Robert" <robert.bradford@intel.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "jgross@suse.com" <jgross@suse.com>,
        "riel@surriel.com" <riel@surriel.com>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jian-hong@endlessm.com" <jian-hong@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Aug 2019 at 07:34, Bradford, Robert
<robert.bradford@intel.com> wrote:
>
> On Thu, 2019-08-29 at 14:18 +0200, Thomas Gleixner wrote:
> > On Thu, 29 Aug 2019, Rob Bradford wrote:
> >
> > CC+ Ard
> >
> > > Replace the check using efi_runtime_disabled() which only checks if
> > > EFI
> > > runtime was disabled on the kernel command line with a call to
> > > efi_enabled(EFI_RUNTIME_SERVICES) to check if EFI runtime services
> > > are
> > > available.
> > >
> > > In the situation where the kernel was booted without an EFI
> > > environment
> > > then only efi_enabled(EFI_RUNTIME_SERVICES) correctly represents
> > > that no
> > > EFI is available. Setting "noefi" or "efi=noruntime" on the
> > > commandline
> > > continue to have the same effect as
> > > efi_enabled(EFI_RUNTIME_SERVICES)
> > > will return false.
> > >
> > >
> > > Signed-off-by: Rob Bradford <robert.bradford@intel.com>
> > > ---
> > >  arch/x86/kernel/reboot.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
> > > index 09d6bded3c1e..0b0a7fccdb00 100644
> > > --- a/arch/x86/kernel/reboot.c
> > > +++ b/arch/x86/kernel/reboot.c
> > > @@ -500,7 +500,7 @@ static int __init reboot_init(void)
> > >      */
> > >     rv = dmi_check_system(reboot_dmi_table);
> > >
> > > -   if (!rv && efi_reboot_required() && !efi_runtime_disabled())
> > > +   if (!rv && efi_reboot_required() &&
> > > efi_enabled(EFI_RUNTIME_SERVICES))

This change by itself seems correct to me - efi_runtime_disabled()
only gives you whether EFI runtime services were disabled explicitly
command line rather than whether they are available at all.


> >
> > Why is efi_reboot_required() set at all in that situation?
> >
> Hi Thomas,
>
> This platform uses HW Reduced ACPI (
> https://github.com/intel/cloud-hypervisor) but also supports direct
> kernel boot without EFI.
>
> /*
>  * For most modern platforms the preferred method of powering off is
> via
>  * ACPI. However, there are some that are known to require the use of
>  * EFI runtime services and for which ACPI does not work at all.
>  *
>  * Using EFI is a last resort, to be used only if no other option
>  * exists.
>  */
> bool efi_reboot_required(void)
> {
>         if (!acpi_gbl_reduced_hardware)
>                 return false;
>
>         efi_reboot_quirk_mode = EFI_RESET_WARM;
>         return true;
> }
>
> This is a hardware workaround that assumes that all ACPI HW reduced
> platforms do not support ACPI reset:
>

I'm not that familiar with the situation on x86, but I did discuss
this with the MS Windows engineers back in April, and their policy is
to strongly prefer ACPI reboot, and so that is most likely to work on
arbitrary x86 hardware which was built to run Windows.

So I do think the patch below is overly broad, given that the ACPI
spec is unambiguous about the fact the FADT reset is also covered by
H/W reduced ACPI.

However, I do share Rob's reservation given how quirky x86 hardware
can be in this respect.

TL;DR:

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>



> commit 44be28e9dd9880dca3e2cbf7a844f2114e67f2cb
> Author: Matt Fleming <matt.fleming@intel.com>
> Date:   Fri Jun 13 12:39:55 2014 +0100
>
>     x86/reboot: Add EFI reboot quirk for ACPI Hardware Reduced flag
>
>     It appears that the BayTrail-T class of hardware requires EFI in
> order
>     to powerdown and reboot and no other reliable method exists.
>
>     This quirk is generally applicable to all hardware that has the
> ACPI
>     Hardware Reduced bit set, since usually ACPI would be the preferred
>     method.
>
>     Cc: Len Brown <len.brown@intel.com>
>     Cc: Mark Salter <msalter@redhat.com>
>     Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>     Signed-off-by: Matt Fleming <matt.fleming@intel.com>
>
> I'm reluctant to change the behaviour of efi_reboot_required() as it
> might break older hardware whereas checking if we have an EFI runtime
> is safer.
>
> Rob
