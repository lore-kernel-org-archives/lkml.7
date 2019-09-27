Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17826C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 05:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7EB920872
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 05:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="yYUj7D4P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbfI0FtG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 01:49:06 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51060 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbfI0FtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 01:49:06 -0400
Received: by mail-wm1-f67.google.com with SMTP id 5so5127973wmg.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 22:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UboR/3YoY3uTd5/yIfcblxD1BtRwPtrq5UhbmXqOZRE=;
        b=yYUj7D4PSMFA1n+LtIatN5JEcAhdVXpZv8gEi6XuagNF1rAWPeLPjX7zE3JOzv+asu
         wX0oPV5zu8J5L/m2/HMwGsz63ARQtjxB5sjqcmAmlkUCLeIvSngTIRjn3PS5BtGvcxha
         9cUmW4n7owYW1KZY4R5SlD7rkqrtoHyp72KMXpO2lkvjcpnqdYyQkbvp4r0cMtk3I9bB
         NiRfU90eGTTMro/NLsCPfoncmhrg/fBG522aQO6Ms1hHd6JaC3tpOJ2SE775hERPK3Iz
         8MDMB57p8gLH/Es8dWfv18J5m1iRTNcvVj7onrb5KYYGnEuSiPGGfSYh4jUIkwmIf6F5
         /cxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UboR/3YoY3uTd5/yIfcblxD1BtRwPtrq5UhbmXqOZRE=;
        b=tqiyKphkgx634QfY9oEEJtrC0CPyesVTDpNAZ09lyPup6lNuikrrZsF9rI1GWOv/6x
         kwoKnWFGS0fbjWEJO6mCDVtQRkKlpMDmhL3ADsfg4kiwjvJAvzVLpvUWcagskhBm3Apk
         JeOpc5vj5eLSSWiEiTUNaDn9Ukq+fosUDj8/1/ikfAImn3JqUc/gUGSXZl3lXvDsvTY4
         QqKmo747Td4h86+hFNikTFh4XlWfdIYM1s0c7oMb9WECIAYkWfdpOSExYexwhQTG9EQ5
         IS+cikiP51lRCn/QfNYOaXRZv3AJUssh7oHxbBquX8NNQr0V6XEnCKViINsbXRHYFbIT
         hDxA==
X-Gm-Message-State: APjAAAWOSrbpzMZXRjCimKxuSVWd11RK/LqHSsiUwoK0VE6oCC4FOuxB
        cbWytIPkFDe0Gb9YB3cbg8HgKpR+GbjXyhcZlRD6G0ap
X-Google-Smtp-Source: APXvYqwrgS6X27cpmFXFQT8dGHRdLPSw5ysJcsErb54qaLGxHup3jGQ7yvxxDx/9gzIBnh756Yl5NpcBmrfXGTnHxKU=
X-Received: by 2002:a7b:c84f:: with SMTP id c15mr5891041wml.52.1569563343446;
 Thu, 26 Sep 2019 22:49:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190927000915.31781-1-atish.patra@wdc.com> <20190927000915.31781-4-atish.patra@wdc.com>
In-Reply-To: <20190927000915.31781-4-atish.patra@wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 27 Sep 2019 11:18:52 +0530
Message-ID: <CAAhSdy0u1_oBgH2o56BC7V_kJcqmYE9a7oyENnuGf18LiwjnLw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] RISC-V: Move SBI related macros under uapi.
To:     Atish Patra <atish.patra@wdc.com>
Cc:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Alan Kao <alankao@andestech.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Allison Randal <allison@lohutok.net>,
        Gary Guo <gary@garyguo.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2019 at 5:39 AM Atish Patra <atish.patra@wdc.com> wrote:
>
> All SBI related macros can be reused by KVM RISC-V and userspace tools
> such as kvmtool, qemu-kvm. SBI calls can also be emulated by userspace
> if required. Any future vendor extensions can leverage this to emulate
> the specific extension in userspace instead of kernel.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/include/asm/sbi.h      | 37 +-----------------------
>  arch/riscv/include/uapi/asm/sbi.h | 48 +++++++++++++++++++++++++++++++
>  2 files changed, 49 insertions(+), 36 deletions(-)
>  create mode 100644 arch/riscv/include/uapi/asm/sbi.h
>
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index 279b7f10b3c2..902b83041111 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -7,42 +7,7 @@
>  #define _ASM_RISCV_SBI_H
>
>  #include <linux/types.h>
> -
> -enum sbi_ext_id {
> -       SBI_EXT_0_1_SET_TIMER = 0x0,
> -       SBI_EXT_0_1_CONSOLE_PUTCHAR = 0x1,
> -       SBI_EXT_0_1_CONSOLE_GETCHAR = 0x2,
> -       SBI_EXT_0_1_CLEAR_IPI = 0x3,
> -       SBI_EXT_0_1_SEND_IPI = 0x4,
> -       SBI_EXT_0_1_REMOTE_FENCE_I = 0x5,
> -       SBI_EXT_0_1_REMOTE_SFENCE_VMA = 0x6,
> -       SBI_EXT_0_1_REMOTE_SFENCE_VMA_ASID = 0x7,
> -       SBI_EXT_0_1_SHUTDOWN = 0x8,
> -       SBI_EXT_BASE = 0x10,
> -};
> -
> -enum sbi_ext_base_fid {
> -       SBI_BASE_GET_SPEC_VERSION = 0,
> -       SBI_BASE_GET_IMP_ID,
> -       SBI_BASE_GET_IMP_VERSION,
> -       SBI_BASE_PROBE_EXT,
> -       SBI_BASE_GET_MVENDORID,
> -       SBI_BASE_GET_MARCHID,
> -       SBI_BASE_GET_MIMPID,
> -};
> -
> -#define SBI_SPEC_VERSION_DEFAULT       0x1
> -#define SBI_SPEC_VERSION_MAJOR_OFFSET  24
> -#define SBI_SPEC_VERSION_MAJOR_MASK    0x7f
> -#define SBI_SPEC_VERSION_MINOR_MASK    0xffffff
> -
> -/* SBI return error codes */
> -#define SBI_SUCCESS            0
> -#define SBI_ERR_FAILURE                -1
> -#define SBI_ERR_NOT_SUPPORTED  -2
> -#define SBI_ERR_INVALID_PARAM   -3
> -#define SBI_ERR_DENIED         -4
> -#define SBI_ERR_INVALID_ADDRESS -5
> +#include <uapi/asm/sbi.h>
>
>  extern unsigned long sbi_spec_version;
>  struct sbiret {
> diff --git a/arch/riscv/include/uapi/asm/sbi.h b/arch/riscv/include/uapi/asm/sbi.h
> new file mode 100644
> index 000000000000..2e09ee52c346
> --- /dev/null
> +++ b/arch/riscv/include/uapi/asm/sbi.h
> @@ -0,0 +1,48 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Common SBI related defines and macros to be used by RISC-V kernel,
> + * RISC-V KVM and userspace.
> + *
> + * Copyright (c) 2019 Western Digital Corporation or its affiliates.
> + */
> +
> +#ifndef _UAPI_ASM_RISCV_SBI_H
> +#define _UAPI_ASM_RISCV_SBI_H
> +
> +enum sbi_ext_id {
> +       SBI_EXT_0_1_SET_TIMER = 0x0,
> +       SBI_EXT_0_1_CONSOLE_PUTCHAR = 0x1,
> +       SBI_EXT_0_1_CONSOLE_GETCHAR = 0x2,
> +       SBI_EXT_0_1_CLEAR_IPI = 0x3,
> +       SBI_EXT_0_1_SEND_IPI = 0x4,
> +       SBI_EXT_0_1_REMOTE_FENCE_I = 0x5,
> +       SBI_EXT_0_1_REMOTE_SFENCE_VMA = 0x6,
> +       SBI_EXT_0_1_REMOTE_SFENCE_VMA_ASID = 0x7,
> +       SBI_EXT_0_1_SHUTDOWN = 0x8,
> +       SBI_EXT_BASE = 0x10,
> +};
> +
> +enum sbi_ext_base_fid {
> +       SBI_BASE_GET_SPEC_VERSION = 0,
> +       SBI_BASE_GET_IMP_ID,
> +       SBI_BASE_GET_IMP_VERSION,
> +       SBI_BASE_PROBE_EXT,
> +       SBI_BASE_GET_MVENDORID,
> +       SBI_BASE_GET_MARCHID,
> +       SBI_BASE_GET_MIMPID,
> +};
> +
> +#define SBI_SPEC_VERSION_DEFAULT       0x1
> +#define SBI_SPEC_VERSION_MAJOR_OFFSET  24
> +#define SBI_SPEC_VERSION_MAJOR_MASK    0x7f
> +#define SBI_SPEC_VERSION_MINOR_MASK    0xffffff
> +
> +/* SBI return error codes */
> +#define SBI_SUCCESS            0
> +#define SBI_ERR_FAILURE                -1
> +#define SBI_ERR_NOT_SUPPORTED  -2
> +#define SBI_ERR_INVALID_PARAM   -3
> +#define SBI_ERR_DENIED         -4
> +#define SBI_ERR_INVALID_ADDRESS -5
> +
> +#endif
> --
> 2.21.0
>

Thanks for considering KVM user-space SBI emulation.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
