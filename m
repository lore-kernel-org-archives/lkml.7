Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D7CC10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 04:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB2EC2186A
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 04:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jagFMzES"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbfDFEVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 00:21:12 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:55953 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfDFEVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 00:21:12 -0400
Received: by mail-it1-f194.google.com with SMTP id y134so6276952itc.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 21:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qz+8OqDkF24TbcUTJDyBgOK2AmCiu/Pftke8BYCkCxo=;
        b=jagFMzESs6y4nl0fr+uRpN380vD8IlLOw0tjgNbw5X2gsP2KBakWazmHKLwb8JrZ1o
         cEIaYLWIvi+XNAO7tUeHqnwSBP/F3Bw4WhHMLWqEORp1fNekr2+feU3QwjEQwDXapioH
         3GQj5L99v86WPDbryWKTMfgPnwfgUBrjIonPrdlifus5QQhiBKSwLGCUbYlPBobKMbol
         Zj7EpPQcXzhSmOkZJsZA2hP2W6ox791da8QlJQzq9XkvOo2zDHuu+4fpxy7r1TGP8KfX
         6gUbUBHANGNJbxBLkL4gUjzRfQhFNg/abLRNeX56suFtJOmbABJw14xRxVdEU4zM6pYc
         crNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qz+8OqDkF24TbcUTJDyBgOK2AmCiu/Pftke8BYCkCxo=;
        b=l2D2KN67KQVg7uTCBwmjW7qsxCSKOL2CUPTNF9gHBktz+UGKNhlP9Q/B9LcdH8q7TU
         bOr4KlQ51A9tdnziZU4NsmIQBk63fNmTgHVH6eehyIAnEjS8N7dD2f2EuJLeUgMdD8Lt
         f+oe5B5Kys43r6M8p0L07YirVqSWq6/HFVgg2o0wzZUfSC27iNVMTpq1XO86YNk7brVX
         1zbRFB7MPcg1xKrP8rkTgbZrQo47fnYY9CK/z7XajfIy6OuIMfUDe7KO66FYcbma/P6g
         6IYq6zwAEFKRxmLhSKeSFnUmFyxtBjRA0Uo0CpbLSmHJnCUHhor4waJiKyWvewJDKl1b
         W+Ng==
X-Gm-Message-State: APjAAAU6rVsP+n3Nx4gKrbt5O2v5yf6yckizVEJAvqxn1ge/PCTlBQvb
        sy0UYtparl6lwAn4qUsottllbCTYngAUzn7ZE5hwKA==
X-Google-Smtp-Source: APXvYqyVIdmCHaSw6XfTZj9niiHeSauqfPJjg3rvY7asfH7IMjVPsRiQSciJ/M7WTPCpNTKpwiRqfGH59UH+WoderLU=
X-Received: by 2002:a24:a70f:: with SMTP id a15mr5372975itf.117.1554524470893;
 Fri, 05 Apr 2019 21:21:10 -0700 (PDT)
MIME-Version: 1.0
References: <155440490809.3190322.15060922240602775809.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155440491334.3190322.44013027330479237.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <155440491334.3190322.44013027330479237.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sat, 6 Apr 2019 06:21:00 +0200
Message-ID: <CAKv+Gu8ocQGxTAapfjb5WufhL=Qj54LythHcPHsyy+wUnVBnfA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] efi: Detect UEFI 2.8 Special Purpose Memory
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>, vishal.l.verma@intel.com,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux-MM <linux-mm@kvack.org>, keith.busch@intel.com,
        linux-nvdimm@lists.01.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On Thu, 4 Apr 2019 at 21:21, Dan Williams <dan.j.williams@intel.com> wrote:
>
> UEFI 2.8 defines an EFI_MEMORY_SP attribute bit to augment the
> interpretation of the EFI Memory Types as "reserved for a special
> purpose".
>
> The proposed Linux behavior for special purpose memory is that it is
> reserved for direct-access (device-dax) by default and not available for
> any kernel usage, not even as an OOM fallback. Later, through udev
> scripts or another init mechanism, these device-dax claimed ranges can
> be reconfigured and hot-added to the available System-RAM with a unique
> node identifier.
>
> A follow-on patch integrates parsing of the ACPI HMAT to identify the
> node and sub-range boundaries of EFI_MEMORY_SP designated memory. For
> now, arrange for EFI_MEMORY_SP memory to be reserved.
>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Darren Hart <dvhart@infradead.org>
> Cc: Andy Shevchenko <andy@infradead.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  arch/x86/Kconfig                  |   18 ++++++++++++++++++
>  arch/x86/boot/compressed/eboot.c  |    5 ++++-
>  arch/x86/boot/compressed/kaslr.c  |    2 +-
>  arch/x86/include/asm/e820/types.h |    9 +++++++++
>  arch/x86/kernel/e820.c            |    9 +++++++--
>  arch/x86/platform/efi/efi.c       |   10 +++++++++-
>  include/linux/efi.h               |   14 ++++++++++++++
>  include/linux/ioport.h            |    1 +
>  8 files changed, 63 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index c1f9b3cf437c..cb9ca27de7a5 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1961,6 +1961,24 @@ config EFI_MIXED
>
>            If unsure, say N.
>
> +config EFI_SPECIAL_MEMORY
> +       bool "EFI Special Purpose Memory Support"
> +       depends on EFI
> +       ---help---
> +         On systems that have mixed performance classes of memory EFI
> +         may indicate special purpose memory with an attribute (See
> +         EFI_MEMORY_SP in UEFI 2.8). A memory range tagged with this
> +         attribute may have unique performance characteristics compared
> +         to the system's general purpose "System RAM" pool. On the
> +         expectation that such memory has application specific usage
> +         answer Y to arrange for the kernel to reserve it for
> +         direct-access (device-dax) by default. The memory range can
> +         later be optionally assigned to the page allocator by system
> +         administrator policy. Say N to have the kernel treat this
> +         memory as general purpose by default.
> +
> +         If unsure, say Y.
> +

EFI_MEMORY_SP is now part of the UEFI spec proper, so it does not make
sense to make any understanding of it Kconfigurable.

Instead, what I would prefer is to implement support for EFI_MEMORY_SP
unconditionally (including the ability to identify it in the debug
dump of the memory map etc), in a way that all architectures can use
it. Then, I think we should never treat it as ordinary memory and make
it the firmware's problem not to use the EFI_MEMORY_SP attribute in
cases where it results in undesired behavior in the OS.

Also, sInce there is a generic component and a x86 component, can you
please split those up?

You only cc'ed me on patch #1 this time, but could you please cc me on
the entire series for v2? Thanks.


>  config SECCOMP
>         def_bool y
>         prompt "Enable seccomp to safely compute untrusted bytecode"
> diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
> index 544ac4fafd11..9b90fae21abe 100644
> --- a/arch/x86/boot/compressed/eboot.c
> +++ b/arch/x86/boot/compressed/eboot.c
> @@ -560,7 +560,10 @@ setup_e820(struct boot_params *params, struct setup_data *e820ext, u32 e820ext_s
>                 case EFI_BOOT_SERVICES_CODE:
>                 case EFI_BOOT_SERVICES_DATA:
>                 case EFI_CONVENTIONAL_MEMORY:
> -                       e820_type = E820_TYPE_RAM;
> +                       if (is_efi_special(d))
> +                               e820_type = E820_TYPE_SPECIAL;
> +                       else
> +                               e820_type = E820_TYPE_RAM;
>                         break;
>
>                 case EFI_ACPI_MEMORY_NVS:
> diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
> index 2e53c056ba20..897e46eb9714 100644
> --- a/arch/x86/boot/compressed/kaslr.c
> +++ b/arch/x86/boot/compressed/kaslr.c
> @@ -757,7 +757,7 @@ process_efi_entries(unsigned long minimum, unsigned long image_size)
>                  *
>                  * Only EFI_CONVENTIONAL_MEMORY is guaranteed to be free.
>                  */
> -               if (md->type != EFI_CONVENTIONAL_MEMORY)
> +               if (md->type != EFI_CONVENTIONAL_MEMORY || is_efi_special(md))
>                         continue;
>
>                 if (efi_mirror_found &&
> diff --git a/arch/x86/include/asm/e820/types.h b/arch/x86/include/asm/e820/types.h
> index c3aa4b5e49e2..0ab8abae2e8b 100644
> --- a/arch/x86/include/asm/e820/types.h
> +++ b/arch/x86/include/asm/e820/types.h
> @@ -28,6 +28,15 @@ enum e820_type {
>          */
>         E820_TYPE_PRAM          = 12,
>
> +       /*
> +        * Special-purpose / application-specific memory is indicated to
> +        * the system via the EFI_MEMORY_SP attribute. Define an e820
> +        * translation of this memory type for the purpose of
> +        * reserving this range and marking it with the
> +        * IORES_DESC_APPLICATION_RESERVED designation.
> +        */
> +       E820_TYPE_SPECIAL       = 0xefffffff,
> +
>         /*
>          * Reserved RAM used by the kernel itself if
>          * CONFIG_INTEL_TXT=y is enabled, memory of this type
> diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
> index 2879e234e193..9f50dd0bbb04 100644
> --- a/arch/x86/kernel/e820.c
> +++ b/arch/x86/kernel/e820.c
> @@ -176,6 +176,7 @@ static void __init e820_print_type(enum e820_type type)
>         switch (type) {
>         case E820_TYPE_RAM:             /* Fall through: */
>         case E820_TYPE_RESERVED_KERN:   pr_cont("usable");                      break;
> +       case E820_TYPE_SPECIAL:         /* Fall through: */
>         case E820_TYPE_RESERVED:        pr_cont("reserved");                    break;
>         case E820_TYPE_ACPI:            pr_cont("ACPI data");                   break;
>         case E820_TYPE_NVS:             pr_cont("ACPI NVS");                    break;
> @@ -1023,6 +1024,7 @@ static const char *__init e820_type_to_string(struct e820_entry *entry)
>         case E820_TYPE_UNUSABLE:        return "Unusable memory";
>         case E820_TYPE_PRAM:            return "Persistent Memory (legacy)";
>         case E820_TYPE_PMEM:            return "Persistent Memory";
> +       case E820_TYPE_SPECIAL:         /* Fall-through: */
>         case E820_TYPE_RESERVED:        return "Reserved";
>         default:                        return "Unknown E820 type";
>         }
> @@ -1038,6 +1040,7 @@ static unsigned long __init e820_type_to_iomem_type(struct e820_entry *entry)
>         case E820_TYPE_UNUSABLE:        /* Fall-through: */
>         case E820_TYPE_PRAM:            /* Fall-through: */
>         case E820_TYPE_PMEM:            /* Fall-through: */
> +       case E820_TYPE_SPECIAL:         /* Fall-through: */
>         case E820_TYPE_RESERVED:        /* Fall-through: */
>         default:                        return IORESOURCE_MEM;
>         }
> @@ -1050,6 +1053,7 @@ static unsigned long __init e820_type_to_iores_desc(struct e820_entry *entry)
>         case E820_TYPE_NVS:             return IORES_DESC_ACPI_NV_STORAGE;
>         case E820_TYPE_PMEM:            return IORES_DESC_PERSISTENT_MEMORY;
>         case E820_TYPE_PRAM:            return IORES_DESC_PERSISTENT_MEMORY_LEGACY;
> +       case E820_TYPE_SPECIAL:         return IORES_DESC_APPLICATION_RESERVED;
>         case E820_TYPE_RESERVED_KERN:   /* Fall-through: */
>         case E820_TYPE_RAM:             /* Fall-through: */
>         case E820_TYPE_UNUSABLE:        /* Fall-through: */
> @@ -1065,13 +1069,14 @@ static bool __init do_mark_busy(enum e820_type type, struct resource *res)
>                 return true;
>
>         /*
> -        * Treat persistent memory like device memory, i.e. reserve it
> -        * for exclusive use of a driver
> +        * Treat persistent memory and other special memory ranges like
> +        * device memory, i.e. reserve it for exclusive use of a driver
>          */
>         switch (type) {
>         case E820_TYPE_RESERVED:
>         case E820_TYPE_PRAM:
>         case E820_TYPE_PMEM:
> +       case E820_TYPE_SPECIAL:
>                 return false;
>         case E820_TYPE_RESERVED_KERN:
>         case E820_TYPE_RAM:
> diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
> index e1cb01a22fa8..d227751f331b 100644
> --- a/arch/x86/platform/efi/efi.c
> +++ b/arch/x86/platform/efi/efi.c
> @@ -139,7 +139,9 @@ static void __init do_add_efi_memmap(void)
>                 case EFI_BOOT_SERVICES_CODE:
>                 case EFI_BOOT_SERVICES_DATA:
>                 case EFI_CONVENTIONAL_MEMORY:
> -                       if (md->attribute & EFI_MEMORY_WB)
> +                       if (is_efi_special(md))
> +                               e820_type = E820_TYPE_SPECIAL;
> +                       else if (md->attribute & EFI_MEMORY_WB)
>                                 e820_type = E820_TYPE_RAM;
>                         else
>                                 e820_type = E820_TYPE_RESERVED;
> @@ -753,6 +755,12 @@ static bool should_map_region(efi_memory_desc_t *md)
>         if (IS_ENABLED(CONFIG_X86_32))
>                 return false;
>
> +       /*
> +        * Special purpose memory is not mapped by default.
> +        */
> +       if (is_efi_special(md))
> +               return false;
> +
>         /*
>          * Map all of RAM so that we can access arguments in the 1:1
>          * mapping when making EFI runtime calls.
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index 54357a258b35..cecbc2bda1da 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -112,6 +112,7 @@ typedef     struct {
>  #define EFI_MEMORY_MORE_RELIABLE \
>                                 ((u64)0x0000000000010000ULL)    /* higher reliability */
>  #define EFI_MEMORY_RO          ((u64)0x0000000000020000ULL)    /* read-only */
> +#define EFI_MEMORY_SP          ((u64)0x0000000000040000ULL)    /* special purpose */
>  #define EFI_MEMORY_RUNTIME     ((u64)0x8000000000000000ULL)    /* range requires runtime mapping */
>  #define EFI_MEMORY_DESCRIPTOR_VERSION  1
>
> @@ -128,6 +129,19 @@ typedef struct {
>         u64 attribute;
>  } efi_memory_desc_t;
>
> +#ifdef CONFIG_EFI_SPECIAL_MEMORY
> +static inline bool is_efi_special(efi_memory_desc_t *md)
> +{
> +       return md->type == EFI_CONVENTIONAL_MEMORY
> +               && (md->attribute & EFI_MEMORY_SP);
> +}
> +#else
> +static inline bool is_efi_special(efi_memory_desc_t *md)
> +{
> +       return false;
> +}
> +#endif
> +
>  typedef struct {
>         efi_guid_t guid;
>         u32 headersize;
> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> index da0ebaec25f0..2d79841ee9b9 100644
> --- a/include/linux/ioport.h
> +++ b/include/linux/ioport.h
> @@ -133,6 +133,7 @@ enum {
>         IORES_DESC_PERSISTENT_MEMORY_LEGACY     = 5,
>         IORES_DESC_DEVICE_PRIVATE_MEMORY        = 6,
>         IORES_DESC_DEVICE_PUBLIC_MEMORY         = 7,
> +       IORES_DESC_APPLICATION_RESERVED         = 8,
>  };
>
>  /* helpers to define resources */
>
