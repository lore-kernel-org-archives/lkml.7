Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45AE2C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D26B205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:54:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WjV4znFK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390768AbfC0SyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:54:02 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:55984 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390208AbfC0SyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:54:01 -0400
Received: by mail-it1-f196.google.com with SMTP id z126so1826142itd.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 11:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VlZH7IEC2Dp2BRtg77O0FlWDe1SeEtM/KhrAFCQzaqo=;
        b=WjV4znFKalFh4LS3/vWlDpk55CrR0WJ3ELVHR85dJAEyoGWGnPmL+shLntLIw6dXab
         q+aIUq1SMr+Rkff33ZDdbm2/6UVfudzRyqb40uFwwYcTTbCc9PH5yrEA7OsdoDErYlBW
         n1EkJQmF2sy2TSTe/qIGpXkQONErHDEZ7wQ5F4iA2km1+rtGa0LVteC58+3PwOxLXw54
         Llf/CXMRXqsJ3umF9GiA6zQmKZI2yo/N0nJAqWwgYA03Wb05MlxBWMKcg7+hTq24ttY1
         ZrkAp/YwjiTlP4qNMxJ6C1/LTalZ4/dwOIGYCbiWBoAuss14Gn5+/Oo6I8Qdlz/8GxdZ
         yH+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VlZH7IEC2Dp2BRtg77O0FlWDe1SeEtM/KhrAFCQzaqo=;
        b=GWDzGPPrvp+yLeNm72t9QcwxznBQ/YH7d/wq1QZIIUFexn/+rqhEISV2Gh2Qgf9QZt
         iHWy0o7HmKytj6lb259RRHKQU9kxMuMXwLuO7uRAYQsf6lB7gUWiKM3RSvb+KewcZQBq
         fmNPDj0hGHD7T/t39Dg35qjyMf+xamGZ79L+3gwovu1hioDp497bW0edO++zAGKz+PFx
         U3+mfPyoVOqAxz9l3dI3SNIcr8fXBX0AcbJuXitRfndpYkPxMqFGmml4YYU5HSBmXmXt
         lVQ7pztRWH3Wjzh8mJMRga7t2M8PV6Av1L8YtH/y3HPFC6mglfczWUdVBC5nLLTxVnHP
         iORg==
X-Gm-Message-State: APjAAAWLWv3oboPF9vPWDehttIZ1nSzXZSZEwBppHjllEFvacNeMYnbP
        Y31910H2xSpVP6OhKUGLIc4uUBEHnDQQj46sPqc4Cg==
X-Google-Smtp-Source: APXvYqzhudVWvph+/dMDDUkK/ftXEjL0MkOq4w4KkT/YNrneN2VSJXK8+DBNwDyJR3dco724O3cec6d0dUt2Q8bmsCE=
X-Received: by 2002:a05:660c:7d1:: with SMTP id e17mr5142323itl.158.1553712839620;
 Wed, 27 Mar 2019 11:53:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190320130502.16667-1-rrichter@marvell.com> <20190320131607.vgst3r7ynha55ikw@rric.localdomain>
 <20190320152240.2eun63wqkbqmuqkg@rric.localdomain>
In-Reply-To: <20190320152240.2eun63wqkbqmuqkg@rric.localdomain>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 27 Mar 2019 19:53:47 +0100
Message-ID: <CAKv+Gu8ta4ZSKwcFGOaf7XCam29ZrHkNowDjfdCpfQas=Xo7Fg@mail.gmail.com>
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

Could you please resend this as a proper patch? I am having trouble applying it.


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
