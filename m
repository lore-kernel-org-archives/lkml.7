Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3546C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 12:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEE8B20823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 12:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553603408;
	bh=nG+AjfW2v/WigS6GEWf326+mLXC24GNNmUiAjqH2PNQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=l2/liDLCG61ZSWg9LDAouxRc/vy5sSYYCVK075hc46xl3iDyx2Il8e/EGAR4XcdTA
	 S591dkNJ/F9Os9CgVpy/yPlNqurtsCb8o0rSAHG+iiWaqtO2oSH27xfyu8KeDs1LD8
	 +BgGBRN6xkb0p4pgUgNEH1p04aVBzV+LRrGyQRGE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731466AbfCZMaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 08:30:07 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34100 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbfCZMaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 08:30:06 -0400
Received: by mail-oi1-f193.google.com with SMTP id v10so5383174oib.1;
        Tue, 26 Mar 2019 05:30:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bKFsGo/ttivgOKUNw4rZdOkvZUPF43wnTAj2jqCStXQ=;
        b=YtfHH+SH4qnGdEoMJ3+BtAwiCcjKG/b7L5gz5wRyh89aGR5nJRbSbTUO/7CcAKTBAY
         Mx99o+U0LGriKNg4YfHSB6bNVWKbln+zWQelrMV8uWr607l3scsD/kRSNg6nPM725EfZ
         sRaUUhjmEUQUeHUWLi4UI7/5lVe+WISZ2Sh488CDQBwKVrIjmEdY0iW8EZtBKESyAkxE
         lyayH+S9BYHXJ1LQ8RbGxL3En6n8GVSZ1FgBQpAlvf0+tIUmmihwLRjQmt0OrIrQOF2t
         p9KNVsgifNh4HKD7SYfX0NVcE5SyUg+ojVWLdNreh+sf180CFq3h2pEwII3Qh+sgJAd4
         DUcA==
X-Gm-Message-State: APjAAAVw+JacVa8lWhVHjsdZR0uZ5CMTgWAbowf0aLI8QG/Xg0z4EipT
        1VCJVm0DqPNeh0W+rKxgv6aAObBXaNHeb2c042A=
X-Google-Smtp-Source: APXvYqwSMeRZLa0ioYVYEfgka3lDoxmsvTntKTC1njH2Yw61dhvZrCz4E2BeFRIDn8X3GnnHKqYwf8y207Z7lJhCQ4Q=
X-Received: by 2002:aca:355:: with SMTP id 82mr15543265oid.30.1553603405803;
 Tue, 26 Mar 2019 05:30:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190326120213.28633-1-leon@kernel.org>
In-Reply-To: <20190326120213.28633-1-leon@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 26 Mar 2019 13:29:54 +0100
Message-ID: <CAJZ5v0jbb+fEWWHdnZEKNOhUy=ZTsDMxy7Rwahp8O-jpBy-K9w@mail.gmail.com>
Subject: Re: [PATCH -next] x86/apic: Reduce print level of CPU limit announcement
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86 <x86@kernel.org>, Leon Romanovsky <leonro@mellanox.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-pm <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 1:02 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> From: Leon Romanovsky <leonro@mellanox.com>
>
> Kernel is booted with less possible CPUs (possible_cpus kernel boot
> option) than available CPUs will have prints like this:
>
> [    1.131039] APIC: NR_CPUS/possible_cpus limit of 8 reached. Processor 55/0x1f ignored.
> [    1.132228] ACPI: Unable to map lapic to logical cpu number
>
> Those warnings are printed for every not-enabled CPU and on the systems
> with large number of such CPUs, we see a lot of those prints for default
> print level.
>
> Simple conversion of those prints to be in debug level removes them
> while leaving the option to debug system.

But generally dynamic debug must be enabled in order for pr_debug()
prints to be visible which is kind of cumbersome to do via the command
line.

> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  arch/x86/kernel/acpi/boot.c | 2 +-
>  arch/x86/kernel/apic/apic.c | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
> index 8dcbf6890714..3ef8ab89c02d 100644
> --- a/arch/x86/kernel/acpi/boot.c
> +++ b/arch/x86/kernel/acpi/boot.c
> @@ -770,7 +770,7 @@ int acpi_map_cpu(acpi_handle handle, phys_cpuid_t physid, u32 acpi_id,
>
>         cpu = acpi_register_lapic(physid, acpi_id, ACPI_MADT_ENABLED);
>         if (cpu < 0) {
> -               pr_info(PREFIX "Unable to map lapic to logical cpu number\n");
> +               pr_debug(PREFIX "Unable to map lapic to logical cpu number\n");

And this one is printed sometimes when something really goes wrong
which may be really hard to debug otherwise, so there is value in the
info level here.

Would it be possible to avoid printing it just in some cases?

>                 return cpu;
>         }
>
> diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
> index b7bcdd781651..8c2a487b5216 100644
> --- a/arch/x86/kernel/apic/apic.c
> +++ b/arch/x86/kernel/apic/apic.c
> @@ -2305,9 +2305,9 @@ int generic_processor_info(int apicid, int version)
>         if (num_processors >= nr_cpu_ids) {
>                 int thiscpu = max + disabled_cpus;
>
> -               pr_warning("APIC: NR_CPUS/possible_cpus limit of %i "
> -                          "reached. Processor %d/0x%x ignored.\n",
> -                          max, thiscpu, apicid);
> +               pr_debug(
> +                       "APIC: NR_CPUS/possible_cpus limit of %i reached. Processor %d/0x%x ignored.\n",
> +                       max, thiscpu, apicid);

I completely agree with this change, though.

>
>                 disabled_cpus++;
>                 return -EINVAL;
> --
