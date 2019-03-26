Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C83C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E630520823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553613162;
	bh=Kst10kBUNOcpfZVHedOdkRGlj2JnX4i7mBAe4njpg4Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=EYGCw4Z58PGAgDm89elVKvl3QrKZzPjFN4h7Hv04Zb4HW+gQeHjLXwkBX926bh+Is
	 7eDv7Evd2M0SC9P10TMBgGz52yX20fepjg75fbZYgm87wSmRRwN02zdNQUT3O1x8sf
	 oxogy91kgr07P/ugnKTPcHmErLBXPU4mZ0turm0M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732004AbfCZPMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 11:12:40 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36363 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfCZPMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 11:12:40 -0400
Received: by mail-ot1-f68.google.com with SMTP id o74so11791843ota.3;
        Tue, 26 Mar 2019 08:12:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zHJPgjZ7NyjzAnEYR+g38o3PxXo5PLRgvA6l2ETOHXc=;
        b=obm5HtLMhf+IbHd1BOxcJdIi1tueyjQC490f7WltKm2JTb+gESm5lcLfcg3/qRv45F
         j3HL9i9IUGorbRRnc7bFBEEAAzctlfOAE65zJ9BHMl7350QL3NwK+w3yDBeq9f3KO1gw
         wh3EMSj+E42O0idZWDvShu+Q14neiF7rDIQZ7/czCzubJ9gS2eTfKHIDP5p3iEyTK+Q9
         BvfM5F/gDX3hq1WfByQj0HoWKtT+vTOPBS8Y0K37cUtxsbEqhIqz0Zx7W9DG8XGDx2q2
         jPACz5MBQ3WZZ8XwLMO6dbHIOsyAHtTJ9Lu1fcjRNAdv+3Adfm8R+AEnrvwWpmibKtGe
         5ERw==
X-Gm-Message-State: APjAAAUa1bwjpIs0NM/aCsoN2diHb/DOyELoPq+UrBDnm2hAkx9s6QMU
        EAdfSdQFrV+z45a8eKWVBgXbmg8lRKWLHS0FT6s=
X-Google-Smtp-Source: APXvYqySbJ5ht/hJgrRhPEEYToBjyju0ot6c64KP0mDCfAeEiX/j4gRHpAGq257AcGLeRrSs/nAqrD/7n8gZgI16o/E=
X-Received: by 2002:a9d:36a:: with SMTP id 97mr21318033otv.124.1553613159008;
 Tue, 26 Mar 2019 08:12:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190326120213.28633-1-leon@kernel.org> <CAJZ5v0jbb+fEWWHdnZEKNOhUy=ZTsDMxy7Rwahp8O-jpBy-K9w@mail.gmail.com>
 <20190326144137.GB22899@mtr-leonro.mtl.com>
In-Reply-To: <20190326144137.GB22899@mtr-leonro.mtl.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 26 Mar 2019 16:12:27 +0100
Message-ID: <CAJZ5v0h1w+ZWV24SnX0g9NZORuVWHnyOjZ9Jue2_yUvvFpJB6g@mail.gmail.com>
Subject: Re: [PATCH -next] x86/apic: Reduce print level of CPU limit announcement
To:     Leon Romanovsky <leon@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86 <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-pm <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 3:41 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Tue, Mar 26, 2019 at 01:29:54PM +0100, Rafael J. Wysocki wrote:
> > On Tue, Mar 26, 2019 at 1:02 PM Leon Romanovsky <leon@kernel.org> wrote:
> > >
> > > From: Leon Romanovsky <leonro@mellanox.com>
> > >
> > > Kernel is booted with less possible CPUs (possible_cpus kernel boot
> > > option) than available CPUs will have prints like this:
> > >
> > > [    1.131039] APIC: NR_CPUS/possible_cpus limit of 8 reached. Processor 55/0x1f ignored.
> > > [    1.132228] ACPI: Unable to map lapic to logical cpu number
> > >
> > > Those warnings are printed for every not-enabled CPU and on the systems
> > > with large number of such CPUs, we see a lot of those prints for default
> > > print level.
> > >
> > > Simple conversion of those prints to be in debug level removes them
> > > while leaving the option to debug system.
> >
> > But generally dynamic debug must be enabled in order for pr_debug()
> > prints to be visible which is kind of cumbersome to do via the command
> > line.
>
> It is doable and documented pretty well, which is uncommon :)
> https://www.kernel.org/doc/html/latest/admin-guide/dynamic-debug-howto.html#debug-messages-during-boot-process

I know.

That's what I mean by "kind of cumbersome", because you need to know
which debug messages to enable upfront.

> >
> > > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> > > ---
> > >  arch/x86/kernel/acpi/boot.c | 2 +-
> > >  arch/x86/kernel/apic/apic.c | 6 +++---
> > >  2 files changed, 4 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
> > > index 8dcbf6890714..3ef8ab89c02d 100644
> > > --- a/arch/x86/kernel/acpi/boot.c
> > > +++ b/arch/x86/kernel/acpi/boot.c
> > > @@ -770,7 +770,7 @@ int acpi_map_cpu(acpi_handle handle, phys_cpuid_t physid, u32 acpi_id,
> > >
> > >         cpu = acpi_register_lapic(physid, acpi_id, ACPI_MADT_ENABLED);
> > >         if (cpu < 0) {
> > > -               pr_info(PREFIX "Unable to map lapic to logical cpu number\n");
> > > +               pr_debug(PREFIX "Unable to map lapic to logical cpu number\n");
> >
> > And this one is printed sometimes when something really goes wrong
> > which may be really hard to debug otherwise, so there is value in the
> > info level here.
> >
> > Would it be possible to avoid printing it just in some cases?
>
> This can do the trick:
>
> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
> index 3ef8ab89c02d..00212b3991e0 100644
> --- a/arch/x86/kernel/acpi/boot.c
> +++ b/arch/x86/kernel/acpi/boot.c
> @@ -770,7 +770,10 @@ int acpi_map_cpu(acpi_handle handle, phys_cpuid_t physid, u32 acpi_id,
>
>         cpu = acpi_register_lapic(physid, acpi_id, ACPI_MADT_ENABLED);
>         if (cpu < 0) {
> -               pr_debug(PREFIX "Unable to map lapic to logical cpu number\n");
> +               if (cpu == -ENOENT)
> +                       pr_debug(PREFIX "Unable to map lapic to logical cpu number\n");

I don't think it is necessary to print this in the -ENOENT case, as
there is a message for that case that will be printed anyway.

> +               else
> +                       pr_info(PREFIX "Unable to map lapic to logical cpu number\n");
>                 return cpu;
>         }
>
