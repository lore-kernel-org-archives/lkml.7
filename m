Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6868BC4CEC9
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 19:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39C1B208C2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 19:49:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="szixyBRl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389592AbfIMTtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 15:49:07 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38816 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729118AbfIMTtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 15:49:07 -0400
Received: by mail-wr1-f67.google.com with SMTP id l11so33157990wrx.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 12:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3F1+Vd20qQHEAMcsaqDBeShk2k2fZrIc64DNNthuGjM=;
        b=szixyBRl+Ziz3JuFg1c7zut06tg+5tBym303ch5PIVdtP3ToNDCecxq9r+lT6LRLKY
         JNxu3pMX9VLQAhngWbDKzdMVqMdiIuZgRR7c4YyyK18s/Y0OJXdY5tB9LmCry5iHR24Q
         d6KtnwaMQmk/Cs/PQVIU4WDlVduyqczq/vHFSSXiaJ0stkTD5ctl1dFQWqCeaZsm2HSb
         mm89C2XzWCvmpFyEtpc8/uDhE1gnzisBmxhOMNmZ/9LCO0DdZBCSIiD2KYcXRz+9UH+N
         lTeWQqUo1Ht/QGKF2EdfNtiolCMxdFXinquCv90bMrYrm50C4h+DIW/GxD169vdyE9RA
         l40Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3F1+Vd20qQHEAMcsaqDBeShk2k2fZrIc64DNNthuGjM=;
        b=W5n4yTWyVNtnQrU1Q3cQjZOlMwptrJEwBd4356Cs3jyMI+0/PoW7zxrRYTJVPsjebC
         5X4dAOIZBL8XWR2ZZ6x8hML97syYl+viFF7nBZlogfXbGwYvYqjzI5VfDwj+5M1c3CKM
         NYn6DrklUi209arugRLhcl25hKeU87+ycAmQPZFnB8lzkLbK40nK4/lCoDK5lSKXeRff
         CMvMfAzJ4Jk8MWVjYxrmQ2ZjonhqrybE56Kq1nUlanwhRCUL8r6gmbVBpnE+QMatX/aF
         fmf+sR9wArrfpXH/7diRNuTHtIzcLdWARUmtFGI2vkgWTLtaI2tk6nBw1dsYYzA+qS5o
         QCoA==
X-Gm-Message-State: APjAAAWDLGXLRCt+YB3AUnv+6g1eu6GrVeE2r/1KmkQ7Ra+/piwQohAc
        tlZ7p4iu8SXdX5bs7V1v+zmpB29AxS/tI3taP2usVA==
X-Google-Smtp-Source: APXvYqx8w1+GO1+fmabltVM+trq9DqeCKeWrLUAxVIW//lvPpzUqvWWtltEQb9WQQDrAT6HuUAOAOjUxrpjD0cbuyLs=
X-Received: by 2002:a5d:638f:: with SMTP id p15mr4492201wru.169.1568404143136;
 Fri, 13 Sep 2019 12:49:03 -0700 (PDT)
MIME-Version: 1.0
References: <156712993795.1616117.3781864460118989466.stgit@dwillia2-desk3.amr.corp.intel.com>
 <156712996407.1616117.11409311856083390862.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <156712996407.1616117.11409311856083390862.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 13 Sep 2019 20:48:39 +0100
Message-ID: <CAKv+Gu_Bg-siUDodOu26GQO2L0xEJXxPZehPJtd0FRhD=-ubJw@mail.gmail.com>
Subject: Re: [PATCH v5 05/10] x86, efi: Add efi_fake_mem support for EFI_MEMORY_SP
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Aug 2019 at 03:07, Dan Williams <dan.j.williams@intel.com> wrote:
>
...
> diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile
> index 4ac2de4dfa72..d7a6db03ea79 100644
> --- a/drivers/firmware/efi/Makefile
> +++ b/drivers/firmware/efi/Makefile
> @@ -20,13 +20,16 @@ obj-$(CONFIG_UEFI_CPER)                     += cper.o
>  obj-$(CONFIG_EFI_RUNTIME_MAP)          += runtime-map.o
>  obj-$(CONFIG_EFI_RUNTIME_WRAPPERS)     += runtime-wrappers.o
>  obj-$(CONFIG_EFI_STUB)                 += libstub/
> -obj-$(CONFIG_EFI_FAKE_MEMMAP)          += fake_mem.o
> +obj-$(CONFIG_EFI_FAKE_MEMMAP)          += fake_map.o
>  obj-$(CONFIG_EFI_BOOTLOADER_CONTROL)   += efibc.o
>  obj-$(CONFIG_EFI_TEST)                 += test/
>  obj-$(CONFIG_EFI_DEV_PATH_PARSER)      += dev-path-parser.o
>  obj-$(CONFIG_APPLE_PROPERTIES)         += apple-properties.o
>  obj-$(CONFIG_EFI_RCI2_TABLE)           += rci2-table.o
>
> +fake_map-y                             += fake_mem.o
> +fake_map-$(CONFIG_X86)                 += x86-fake_mem.o
> +

Please use

fake-mem-$(CONFIG_X86) := x86-fake_mem.o
obj-$(CONFIG_EFI_FAKE_MEMMAP) += fake_mem.o $(fake-mem-y)

instead, and please use either - or _ in filenames, not both.
