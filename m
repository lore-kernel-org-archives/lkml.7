Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F8EAC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 14:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2296020823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 14:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553611305;
	bh=HQCVoUojr7k4IjtQ+Em4dpQz9gcN9auIrPWwfQew2bA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=s7Haz/ynstzM/PdbGWUE24dZITKy4ZzoH/F21z0qebvg+KOi5qDMkVEOl6MUewROl
	 LbTze9jQ2KaN/Lmp+3m9dAiZo3xlW/tgmKsiII4F7ZzsHT5iuDEzdWxu/NaaXKKDAV
	 gl9LcvVGN/sYEopFe5kKbtgdPv4Jx2618qcMBxhw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731795AbfCZOlo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 10:41:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:48114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbfCZOln (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 10:41:43 -0400
Received: from localhost (unknown [77.138.135.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFFA62075E;
        Tue, 26 Mar 2019 14:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553611302;
        bh=HQCVoUojr7k4IjtQ+Em4dpQz9gcN9auIrPWwfQew2bA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qrxl0qt6FZgvN2DUqUUdEaOyge1tKgg7FRohwHfJQUSJWSA3V753cZwwzZTwGIkrz
         jQWKSlu1WWvnSDusPYFMNLdA2bXdYWcfcBPUOjcQ04rymi4ZIt1rsX52sYJc01UNo6
         WIomSThnx9Kt2+kJOqIk/lVH4SmuHaI6KvwPiCyc=
Date:   Tue, 26 Mar 2019 16:41:37 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86 <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-pm <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] x86/apic: Reduce print level of CPU limit
 announcement
Message-ID: <20190326144137.GB22899@mtr-leonro.mtl.com>
References: <20190326120213.28633-1-leon@kernel.org>
 <CAJZ5v0jbb+fEWWHdnZEKNOhUy=ZTsDMxy7Rwahp8O-jpBy-K9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="VrqPEDrXMn8OVzN4"
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jbb+fEWWHdnZEKNOhUy=ZTsDMxy7Rwahp8O-jpBy-K9w@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VrqPEDrXMn8OVzN4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 26, 2019 at 01:29:54PM +0100, Rafael J. Wysocki wrote:
> On Tue, Mar 26, 2019 at 1:02 PM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > From: Leon Romanovsky <leonro@mellanox.com>
> >
> > Kernel is booted with less possible CPUs (possible_cpus kernel boot
> > option) than available CPUs will have prints like this:
> >
> > [    1.131039] APIC: NR_CPUS/possible_cpus limit of 8 reached. Processor 55/0x1f ignored.
> > [    1.132228] ACPI: Unable to map lapic to logical cpu number
> >
> > Those warnings are printed for every not-enabled CPU and on the systems
> > with large number of such CPUs, we see a lot of those prints for default
> > print level.
> >
> > Simple conversion of those prints to be in debug level removes them
> > while leaving the option to debug system.
>
> But generally dynamic debug must be enabled in order for pr_debug()
> prints to be visible which is kind of cumbersome to do via the command
> line.

It is doable and documented pretty well, which is uncommon :)
https://www.kernel.org/doc/html/latest/admin-guide/dynamic-debug-howto.html#debug-messages-during-boot-process

>
> > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> > ---
> >  arch/x86/kernel/acpi/boot.c | 2 +-
> >  arch/x86/kernel/apic/apic.c | 6 +++---
> >  2 files changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
> > index 8dcbf6890714..3ef8ab89c02d 100644
> > --- a/arch/x86/kernel/acpi/boot.c
> > +++ b/arch/x86/kernel/acpi/boot.c
> > @@ -770,7 +770,7 @@ int acpi_map_cpu(acpi_handle handle, phys_cpuid_t physid, u32 acpi_id,
> >
> >         cpu = acpi_register_lapic(physid, acpi_id, ACPI_MADT_ENABLED);
> >         if (cpu < 0) {
> > -               pr_info(PREFIX "Unable to map lapic to logical cpu number\n");
> > +               pr_debug(PREFIX "Unable to map lapic to logical cpu number\n");
>
> And this one is printed sometimes when something really goes wrong
> which may be really hard to debug otherwise, so there is value in the
> info level here.
>
> Would it be possible to avoid printing it just in some cases?

This can do the trick:

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 3ef8ab89c02d..00212b3991e0 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -770,7 +770,10 @@ int acpi_map_cpu(acpi_handle handle, phys_cpuid_t physid, u32 acpi_id,

 	cpu = acpi_register_lapic(physid, acpi_id, ACPI_MADT_ENABLED);
 	if (cpu < 0) {
-		pr_debug(PREFIX "Unable to map lapic to logical cpu number\n");
+		if (cpu == -ENOENT)
+			pr_debug(PREFIX "Unable to map lapic to logical cpu number\n");
+		else
+			pr_info(PREFIX "Unable to map lapic to logical cpu number\n");
 		return cpu;
 	}

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 8c2a487b5216..2704a2c57df1 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2299,7 +2299,7 @@ int generic_processor_info(int apicid, int version)
 			"  Processor %d/0x%x ignored.\n", max, thiscpu, apicid);

 		disabled_cpus++;
-		return -ENODEV;
+		return -ENOENT;
 	}

 	if (num_processors >= nr_cpu_ids) {>

> >                 return cpu;
> >         }
> >
> > diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
> > index b7bcdd781651..8c2a487b5216 100644
> > --- a/arch/x86/kernel/apic/apic.c
> > +++ b/arch/x86/kernel/apic/apic.c
> > @@ -2305,9 +2305,9 @@ int generic_processor_info(int apicid, int version)
> >         if (num_processors >= nr_cpu_ids) {
> >                 int thiscpu = max + disabled_cpus;
> >
> > -               pr_warning("APIC: NR_CPUS/possible_cpus limit of %i "
> > -                          "reached. Processor %d/0x%x ignored.\n",
> > -                          max, thiscpu, apicid);
> > +               pr_debug(
> > +                       "APIC: NR_CPUS/possible_cpus limit of %i reached. Processor %d/0x%x ignored.\n",
> > +                       max, thiscpu, apicid);
>
> I completely agree with this change, though.

Thanks

>
> >
> >                 disabled_cpus++;
> >                 return -EINVAL;
> > --

--VrqPEDrXMn8OVzN4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcmjohAAoJEORje4g2clin1scQAKo1/8JPRHsfbdPmKd2afMWN
U1Nditcwm4dYeZvsFJUCR+BN1XQNRY3Sue7U+ctNWGYYxiwqBhm5LHoMCGNw/cwh
hpGpYjEccp7CsZ4ZUmBag1DTTk5RzDGTxFldkybpjrJH6fHzQPFXqcW6k8YsGT79
SAGVQAQ2bojPyCdy2ZIpDrhMEeNsRr/rIILdoJYyqcTnnkPea26mKY7WBxiK6YJW
lpjnyYC7JXWdp4hlAOukt3AcPqOtVcBptnhgL54cHezt/IqUoMSJlPHtltQHesSf
HPMvFhaJN3UQuMTwAm3l+040+U9koWYIULe/i7CmuOqx6NmPse+BCeL39mDepVk2
EcvQBcBpGPiK0YIKg87YTykxjMri4A2v4VCEC85ajXEIOSp9j/ENNildWePzmMY+
jLChQK+tuyvY+qCrALchHsK6pmBgu94+Mb0HJXHeBtT3cYJ7G8YEgbVVyzVzc1mQ
u22/mVavlitSawQw4BfOqZcDMMZxzW/b7/dDHIar5Hv2HnOSFnSp8vzXXo3hU/Ab
AjUZn1pI+Hh5+jMT0TMJQRIDWgFT5agvNRGNxP4uuxh0J1v3TedICJYqiwyNffsl
l3nMukXZ5zC1bZ9cBT7IIQFp/sA36S+wBcLTGIfdmOY6ZDNJXU0VwgfrYygIAxAP
TYrhZUjyx8ZLmLdI1ZL+
=BHW9
-----END PGP SIGNATURE-----

--VrqPEDrXMn8OVzN4--
