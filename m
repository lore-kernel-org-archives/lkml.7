Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C214C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 22:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E064C218AE
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 22:02:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ogP/Xpu9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbfCTWCW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 18:02:22 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:43948 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727276AbfCTWCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 18:02:21 -0400
Received: by mail-io1-f68.google.com with SMTP id x3so3512506iol.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 15:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nVbfPjMO0icmvR4uBkVFDwWFF/mfWncIWcSpN4c2qsI=;
        b=ogP/Xpu9a9GZ0VJU4uA7WG2in6zyShKbv103UraUA7AU3f+0OslJOqNP+f/8dmo4LZ
         DFySveL7amAkstWcaoRuLNXL8NrDnKtFjUIIPpwvHxo9eM9w3XQgylrMdd5v0xvhv8b/
         ia6zBrqF0kRJcI8Mv51ZAI3X9Pqu6RpPN1sO/+83RaL8ih784gS/JePUKsR5nA2ZJZF6
         GBmc5SkT2FIgDzg/qcjhbQbJ/z9yiRjXNl2103MYrSOy2py0BftnLeEcAsT3LhbmJisY
         mNoPuPO9S31OH0ThHHfCeYSO3gg94Cz7j0/FZPJpfUeNLzwArcTBgdYe49ZkYj2hdxJ+
         DtDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nVbfPjMO0icmvR4uBkVFDwWFF/mfWncIWcSpN4c2qsI=;
        b=XhU7t6Zjc6LqlLYRhbQIkZutzB7bSmzZASoH1P3AKrxduE/RNDTBtKOYMSIQOs5KcW
         qp8zXR9GQvQMLsfBRCEUEIOHTvc0p30i9G69AdZZqztCeqUYGI1zFB1t1Dbzeu+eY96T
         jmoAtMoeYT2i+ITQtRdHKfd6MXOZdWbG+OOeTWpTi5AYdq/FmXc+42vZ7PKIbsjdgk/c
         TUJkwsQe8njofzmrgy0cItNihONclvW71XKorv1x6ayubzb9eWIp8kuvD+Qx5crm7Mcc
         nQ0jSAXgrbCQGB0vXKWwEUgVq2CCzgvUNqwRyaXM/Y68OOVGmKyVey1bUJElM/51OBs9
         vXzw==
X-Gm-Message-State: APjAAAXHk3bROFbsaX/sJhtiP8/4SyybPCQ+2TQ3gD9/unpzE6MzKFLz
        ZfJgZUVJvDFFBpe/IzTHPpCixsR3fEdwdVuOrJNoYA==
X-Google-Smtp-Source: APXvYqyjgf3iXaldkJQagua/6rah4w4Bj3cMf14E9ET4Hiik+/Vj4YPCkiPQ5B83fKUGgvJVBTLwuhJQFgZd3IcOjXM=
X-Received: by 2002:a5e:9b17:: with SMTP id j23mr380257iok.60.1553119340701;
 Wed, 20 Mar 2019 15:02:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190320130502.16667-1-rrichter@marvell.com> <20190320131607.vgst3r7ynha55ikw@rric.localdomain>
 <20190320152240.2eun63wqkbqmuqkg@rric.localdomain>
In-Reply-To: <20190320152240.2eun63wqkbqmuqkg@rric.localdomain>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 20 Mar 2019 23:02:09 +0100
Message-ID: <CAKv+Gu8HKUQPr7TaUm7EwdVFasUitAPBJFotpG43nNAKMBvxdA@mail.gmail.com>
Subject: Re: [PATCH v2] efi: Unify dmi setup code over architectures
 arm/arm64, io64 and x86
To:     Robert Richter <rrichter@marvell.com>
Cc:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Marcin Benka <mbenka@marvell.com>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Mar 2019 at 16:23, Robert Richter <rrichter@marvell.com> wrote:
>
> On 20.03.19 14:16:07, Robert Richter wrote:
> > On 20.03.19 13:05:37, Robert Richter wrote:
> > > @@ -167,6 +167,7 @@ static int __init arm_dmi_init(void)
> > >      * itself, depends on dmi_scan_machine() having been called already.
> > >      */
> > >     dmi_scan_machine();
> > > +   dmi_memdev_walk();
> > >     if (dmi_available)
> > >             dmi_set_dump_stack_arch_desc();
> > >     return 0;
> >
> > After
> >
> >  [PATCH] efi/arm: Show SMBIOS bank/device location in cper and
> >   ghes error logs
> >
> > wents in for arm/arm64, we can unify the code. See patch below.
>
> V2 with the fix in arm_dmi_init() below.
>
> -Robert
>
>
> -- >8 --
> From: Robert Richter <rrichter@marvell.com>
> Subject: [PATCH v2] efi: Unify dmi setup code over architectures arm/arm64,
>  io64 and x86
>
> All architectures (arm/arm64, io64 and x86) do the same here, so unify
> the code.
>
> Note: We do not need to call dump_stack_set_arch_desc() in case of
> !dmi_available. Both strings, dmi_ids_string and dump_stack_arch_
> desc_str are initialized zero and thus nothing would change.
>

I don't understand the last sentence - we do not need to call
dump_stack_set_arch_desc() when !dmi_available, but we do so anyway,
right? Doesn't that wipe the arch description we set based on the DT
machine name?

> Signed-off-by: Robert Richter <rrichter@marvell.com>
> ---
>  arch/ia64/kernel/setup.c           |  4 +---
>  arch/x86/kernel/setup.c            |  6 ++----
>  drivers/firmware/dmi_scan.c        | 28 +++++++++++++++-------------
>  drivers/firmware/efi/arm-runtime.c |  7 ++-----
>  include/linux/dmi.h                |  8 ++------
>  5 files changed, 22 insertions(+), 31 deletions(-)
>
> diff --git a/arch/ia64/kernel/setup.c b/arch/ia64/kernel/setup.c
> index 583a3746d70b..c9cfa760cd57 100644
> --- a/arch/ia64/kernel/setup.c
> +++ b/arch/ia64/kernel/setup.c
> @@ -1058,9 +1058,7 @@ check_bugs (void)
>
>  static int __init run_dmi_scan(void)
>  {
> -       dmi_scan_machine();
> -       dmi_memdev_walk();
> -       dmi_set_dump_stack_arch_desc();
> +       dmi_setup();
>         return 0;
>  }
>  core_initcall(run_dmi_scan);
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 3d872a527cd9..3773905cd2c1 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -1005,13 +1005,11 @@ void __init setup_arch(char **cmdline_p)
>         if (efi_enabled(EFI_BOOT))
>                 efi_init();
>
> -       dmi_scan_machine();
> -       dmi_memdev_walk();
> -       dmi_set_dump_stack_arch_desc();
> +       dmi_setup();
>
>         /*
>          * VMware detection requires dmi to be available, so this
> -        * needs to be done after dmi_scan_machine(), for the boot CPU.
> +        * needs to be done after dmi_setup(), for the boot CPU.
>          */
>         init_hypervisor_platform();
>
> diff --git a/drivers/firmware/dmi_scan.c b/drivers/firmware/dmi_scan.c
> index 099d83e4e910..fae2d5c43314 100644
> --- a/drivers/firmware/dmi_scan.c
> +++ b/drivers/firmware/dmi_scan.c
> @@ -416,11 +416,8 @@ static void __init save_mem_devices(const struct dmi_header *dm, void *v)
>         nr++;
>  }
>
> -void __init dmi_memdev_walk(void)
> +static void __init dmi_memdev_walk(void)
>  {
> -       if (!dmi_available)
> -               return;
> -
>         if (dmi_walk_early(count_mem_devices) == 0 && dmi_memdev_nr) {
>                 dmi_memdev = dmi_alloc(sizeof(*dmi_memdev) * dmi_memdev_nr);
>                 if (dmi_memdev)
> @@ -614,7 +611,7 @@ static int __init dmi_smbios3_present(const u8 *buf)
>         return 1;
>  }
>
> -void __init dmi_scan_machine(void)
> +static void __init dmi_scan_machine(void)
>  {
>         char __iomem *p, *q;
>         char buf[32];
> @@ -769,15 +766,20 @@ static int __init dmi_init(void)
>  subsys_initcall(dmi_init);
>
>  /**
> - * dmi_set_dump_stack_arch_desc - set arch description for dump_stack()
> + *     dmi_setup - scan and setup DMI system information
>   *
> - * Invoke dump_stack_set_arch_desc() with DMI system information so that
> - * DMI identifiers are printed out on task dumps.  Arch boot code should
> - * call this function after dmi_scan_machine() if it wants to print out DMI
> - * identifiers on task dumps.
> + *     Scan the DMI system information. This setups DMI identifiers
> + *     (dmi_system_id) for printing it out on task dumps and prepares
> + *     DIMM entry information (dmi_memdev_info) from the SMBIOS table
> + *     for using this when reporting memory errors.
>   */
> -void __init dmi_set_dump_stack_arch_desc(void)
> +void __init dmi_setup(void)
>  {
> +       dmi_scan_machine();
> +       if (!dmi_available)
> +               return;
> +
> +       dmi_memdev_walk();
>         dump_stack_set_arch_desc("%s", dmi_ids_string);
>  }
>
> @@ -841,7 +843,7 @@ static bool dmi_is_end_of_table(const struct dmi_system_id *dmi)
>   *     returns non zero or we hit the end. Callback function is called for
>   *     each successful match. Returns the number of matches.
>   *
> - *     dmi_scan_machine must be called before this function is called.
> + *     dmi_setup must be called before this function is called.
>   */
>  int dmi_check_system(const struct dmi_system_id *list)
>  {
> @@ -871,7 +873,7 @@ EXPORT_SYMBOL(dmi_check_system);
>   *     Walk the blacklist table until the first match is found.  Return the
>   *     pointer to the matching entry or NULL if there's no match.
>   *
> - *     dmi_scan_machine must be called before this function is called.
> + *     dmi_setup must be called before this function is called.
>   */
>  const struct dmi_system_id *dmi_first_match(const struct dmi_system_id *list)
>  {
> diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-runtime.c
> index 4a0dfe4ab829..e2ac5fa5531b 100644
> --- a/drivers/firmware/efi/arm-runtime.c
> +++ b/drivers/firmware/efi/arm-runtime.c
> @@ -162,14 +162,11 @@ void efi_virtmap_unload(void)
>  static int __init arm_dmi_init(void)
>  {
>         /*
> -        * On arm64/ARM, DMI depends on UEFI, and dmi_scan_machine() needs to
> +        * On arm64/ARM, DMI depends on UEFI, and dmi_setup() needs to
>          * be called early because dmi_id_init(), which is an arch_initcall
>          * itself, depends on dmi_scan_machine() having been called already.
>          */
> -       dmi_scan_machine();
> -       dmi_memdev_walk();
> -       if (dmi_available)
> -               dmi_set_dump_stack_arch_desc();
> +       dmi_setup();
>         return 0;
>  }
>  core_initcall(arm_dmi_init);
> diff --git a/include/linux/dmi.h b/include/linux/dmi.h
> index c46fdb36700b..8de8c4f15163 100644
> --- a/include/linux/dmi.h
> +++ b/include/linux/dmi.h
> @@ -102,9 +102,7 @@ const struct dmi_system_id *dmi_first_match(const struct dmi_system_id *list);
>  extern const char * dmi_get_system_info(int field);
>  extern const struct dmi_device * dmi_find_device(int type, const char *name,
>         const struct dmi_device *from);
> -extern void dmi_scan_machine(void);
> -extern void dmi_memdev_walk(void);
> -extern void dmi_set_dump_stack_arch_desc(void);
> +extern void dmi_setup(void);
>  extern bool dmi_get_date(int field, int *yearp, int *monthp, int *dayp);
>  extern int dmi_get_bios_year(void);
>  extern int dmi_name_in_vendors(const char *str);
> @@ -122,9 +120,7 @@ static inline int dmi_check_system(const struct dmi_system_id *list) { return 0;
>  static inline const char * dmi_get_system_info(int field) { return NULL; }
>  static inline const struct dmi_device * dmi_find_device(int type, const char *name,
>         const struct dmi_device *from) { return NULL; }
> -static inline void dmi_scan_machine(void) { return; }
> -static inline void dmi_memdev_walk(void) { }
> -static inline void dmi_set_dump_stack_arch_desc(void) { }
> +static inline void dmi_setup(void) { }
>  static inline bool dmi_get_date(int field, int *yearp, int *monthp, int *dayp)
>  {
>         if (yearp)
> --
> 2.20.1
>
