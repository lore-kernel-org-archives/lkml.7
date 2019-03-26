Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C84BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 312D720823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553623702;
	bh=iGrNBLip8BNaprCMebZrE4RDBI5/BH98O4FOBoZVvYg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=MHMvt4DMoDR2fnSfF5ExhdIXrgkCY1jOwCNTLphwCXPMiyqY7S+fC9JMNM2LEgYD6
	 b41NfINA5VI7Fx+05Gg4UmAi3EilXWUTigB9UfgTqbWggPdwK9TxOelZNpFrSbXM9c
	 WBEb3paZ5H5ltxfGwUvlYe1F3jl6goGUIcwm5C78=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732454AbfCZSIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:08:21 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38920 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732147AbfCZSIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 14:08:20 -0400
Received: by mail-ot1-f66.google.com with SMTP id f10so12363331otb.6;
        Tue, 26 Mar 2019 11:08:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZbMBM2s5SKzp/uwJXXHcsP3hARhUOS6bzJsvAZ3Pago=;
        b=Yxe62LHpKm+jXNDxcoWLmogoHa92EYabZ/cjD0N5QRuTtXzdJwMmesIHD785YXw1Mg
         l806wKrVS5Ko0psNuF1jvZqeX923ckF0U9XOU0PGXCCsrEmu7kogYcA6l++NRXFKTxJa
         ac3MnA78HB/nzXy5Hqd596sCH899skn8qVCduYEBoqUIjLl4s8/MshPQqNc0/TrP1ka1
         izwOmD862Pb25Cu4EHBD1zccyEtLqUhB1voPEnqbo1PyESZt2Ossa37pyDlCsSWtFx8L
         SNC7fKZio2MjfXvo3kY39llVpfYyrR+a2KrL4lNXmdEUYb961vrjytQS6ZGGyFqhRXoY
         rg2A==
X-Gm-Message-State: APjAAAXsDGYpH2Z6mK0GTSqAcBtz2q9VHGA8066ZLB1QNmRiM17IROYe
        lYSUA7iRmi/TyXabKEn30dDNuiK+HTWNrlejmgc=
X-Google-Smtp-Source: APXvYqwsV0TmLCYxKLU70SNccqCJKEr2tsaKCbm0EcrInwUbxEC31ValknZuYm2bnMJxynjboRg4VmRHqWE3PNG24LA=
X-Received: by 2002:a05:6830:13cd:: with SMTP id e13mr24250358otq.139.1553623699397;
 Tue, 26 Mar 2019 11:08:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190326120213.28633-1-leon@kernel.org> <CAJZ5v0jbb+fEWWHdnZEKNOhUy=ZTsDMxy7Rwahp8O-jpBy-K9w@mail.gmail.com>
 <20190326144137.GB22899@mtr-leonro.mtl.com> <CAJZ5v0h1w+ZWV24SnX0g9NZORuVWHnyOjZ9Jue2_yUvvFpJB6g@mail.gmail.com>
 <20190326153235.GH22899@mtr-leonro.mtl.com> <CAJZ5v0i2FKvKHZMttJjZR+FY_UGkku-C3=fg9FhNv-OWpu7ayA@mail.gmail.com>
 <20190326175338.GK22899@mtr-leonro.mtl.com>
In-Reply-To: <20190326175338.GK22899@mtr-leonro.mtl.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 26 Mar 2019 19:08:07 +0100
Message-ID: <CAJZ5v0iEfZKBGemHfc1iMK-qyo6t+h_yG-QOtmWY5ip0g21kdQ@mail.gmail.com>
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

On Tue, Mar 26, 2019 at 6:53 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Tue, Mar 26, 2019 at 05:30:22PM +0100, Rafael J. Wysocki wrote:
> > On Tue, Mar 26, 2019 at 4:32 PM Leon Romanovsky <leon@kernel.org> wrote:
> > >
> > > On Tue, Mar 26, 2019 at 04:12:27PM +0100, Rafael J. Wysocki wrote:
> > > > On Tue, Mar 26, 2019 at 3:41 PM Leon Romanovsky <leon@kernel.org> wrote:
> > > > >
> > > > > On Tue, Mar 26, 2019 at 01:29:54PM +0100, Rafael J. Wysocki wrote:
> > > > > > On Tue, Mar 26, 2019 at 1:02 PM Leon Romanovsky <leon@kernel.org> wrote:
> > > > > > >
> > > > > > > From: Leon Romanovsky <leonro@mellanox.com>
> > > > > > >
> > > > > > > Kernel is booted with less possible CPUs (possible_cpus kernel boot
> > > > > > > option) than available CPUs will have prints like this:
> > > > > > >
> > > > > > > [    1.131039] APIC: NR_CPUS/possible_cpus limit of 8 reached. Processor 55/0x1f ignored.
> > > > > > > [    1.132228] ACPI: Unable to map lapic to logical cpu number
> > > > > > >
> > > > > > > Those warnings are printed for every not-enabled CPU and on the systems
> > > > > > > with large number of such CPUs, we see a lot of those prints for default
> > > > > > > print level.
> > > > > > >
> > > > > > > Simple conversion of those prints to be in debug level removes them
> > > > > > > while leaving the option to debug system.
> > > > > >
> > > > > > But generally dynamic debug must be enabled in order for pr_debug()
> > > > > > prints to be visible which is kind of cumbersome to do via the command
> > > > > > line.
> > > > >
> > > > > It is doable and documented pretty well, which is uncommon :)
> > > > > https://www.kernel.org/doc/html/latest/admin-guide/dynamic-debug-howto.html#debug-messages-during-boot-process
> > > >
> > > > I know.
> > > >
> > > > That's what I mean by "kind of cumbersome", because you need to know
> > > > which debug messages to enable upfront.
> > > >
> > > > > >
> > > > > > > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> > > > > > > ---
> > > > > > >  arch/x86/kernel/acpi/boot.c | 2 +-
> > > > > > >  arch/x86/kernel/apic/apic.c | 6 +++---
> > > > > > >  2 files changed, 4 insertions(+), 4 deletions(-)
> > > > > > >
> > > > > > > diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
> > > > > > > index 8dcbf6890714..3ef8ab89c02d 100644
> > > > > > > --- a/arch/x86/kernel/acpi/boot.c
> > > > > > > +++ b/arch/x86/kernel/acpi/boot.c
> > > > > > > @@ -770,7 +770,7 @@ int acpi_map_cpu(acpi_handle handle, phys_cpuid_t physid, u32 acpi_id,
> > > > > > >
> > > > > > >         cpu = acpi_register_lapic(physid, acpi_id, ACPI_MADT_ENABLED);
> > > > > > >         if (cpu < 0) {
> > > > > > > -               pr_info(PREFIX "Unable to map lapic to logical cpu number\n");
> > > > > > > +               pr_debug(PREFIX "Unable to map lapic to logical cpu number\n");
> > > > > >
> > > > > > And this one is printed sometimes when something really goes wrong
> > > > > > which may be really hard to debug otherwise, so there is value in the
> > > > > > info level here.
> > > > > >
> > > > > > Would it be possible to avoid printing it just in some cases?
> > > > >
> > > > > This can do the trick:
> > > > >
> > > > > diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
> > > > > index 3ef8ab89c02d..00212b3991e0 100644
> > > > > --- a/arch/x86/kernel/acpi/boot.c
> > > > > +++ b/arch/x86/kernel/acpi/boot.c
> > > > > @@ -770,7 +770,10 @@ int acpi_map_cpu(acpi_handle handle, phys_cpuid_t physid, u32 acpi_id,
> > > > >
> > > > >         cpu = acpi_register_lapic(physid, acpi_id, ACPI_MADT_ENABLED);
> > > > >         if (cpu < 0) {
> > > > > -               pr_debug(PREFIX "Unable to map lapic to logical cpu number\n");
> > > > > +               if (cpu == -ENOENT)
> > > > > +                       pr_debug(PREFIX "Unable to map lapic to logical cpu number\n");
> > > >
> > > > I don't think it is necessary to print this in the -ENOENT case, as
> > > > there is a message for that case that will be printed anyway.
> > >
> > > Agree, how do you want me to progress? Should I resend patch?
> >
> > Yes, please.
>
> I looked in the code and seems like there is one place only in acpi_register_lapic() which returns
> EINVAL without any debug prints and that flow can't be because we are providing ACPI_MADT_ENABLED
> as an input.
>
> It looks like that we can safely remove the print from acpi_map_cpu().

What about generic_processor_info()?  That may return -EINVAL too silently.
