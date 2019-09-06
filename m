Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1374BC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 08:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEC41207FC
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 08:20:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="BxwOBYJm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732459AbfIFIUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 04:20:51 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39959 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727915AbfIFIUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 04:20:50 -0400
Received: by mail-wm1-f68.google.com with SMTP id t9so5983822wmi.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 01:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bxSxCGTX5scDr5Ieq/9luU1LSOKlQMOwoIgSxeGJIjI=;
        b=BxwOBYJmNXdj15JKcfJ54A2tSTwEJYs/JSMdNCmjBwc5Kw8V8Z7WvPjzKC3fFtZdVt
         N1F5ptfReYpWfAHRMsQPN0i1LOnP4rPIpkLd/AVmVUQhFOKa3Hpc+w1pmZb07S/nwxO6
         ij1eIQmcF2YkModxrFGD+YrJvo2hRWF94cZkzMKfcQsj+7eacqXysLktD5qXD9boVMhB
         ea+SaKAbCSaFWsJ5GABBlFt5nxQWt+C0DfElyoGb5r0wU2WDIu6rH4m+IbGoRMxRJ14w
         AjDWtqMxSSs5Qq6Xnq2I/Lj2LDghv7kAX8w1lu9fpJZhj8zmI1HdnQCetnZD+IX7Bjnj
         yJ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bxSxCGTX5scDr5Ieq/9luU1LSOKlQMOwoIgSxeGJIjI=;
        b=hRZbqVylL7LJvycRObA23UmS+Xs0+QJwmt4k6B3hY7p6fd6nJoiSSWPx5nGoGvnli/
         X5PTgfrZUJlxLAOup3/QGZkR1VBrp2/ohJLLp9d2Z5Z9W5/cVFH5R7RWvHquSpzOXRrm
         8QynaVYEEuZ4Rx3M0e2rCuMHWhAD1TsEDzsw9pzhZKUIgQawbUDjuUaig93IoKpK2huU
         GmX0obwU11tbzPoNRPjGKjRFs6RhVxdp/Q4+Lq9G2/9jABMA5Vus9uKHkWkgGYz5mket
         tXzTzz5cwr1tt58O5SDbw8twCriiYkx3dEZq0BSohq8zXBgLlrbbjqrOqwHNJcS7/HcQ
         HqoQ==
X-Gm-Message-State: APjAAAVhIG+7XFCHOSJXB8Rjk1Kvc8hlGfnWiJumNNCRxvi7nhCxmJF6
        e/SaydvEXYhwMtAOBCMtClPleksjUaeth0Ck5ylXWQ==
X-Google-Smtp-Source: APXvYqwZIfv9LJKhtufyQXSyWXH70/rhsZbPefDxeePyf+2s1o31OMXC0fO5THfjyMBhnKyiz1uHRFCkrdsKyLyMISs=
X-Received: by 2002:a1c:5451:: with SMTP id p17mr6208237wmi.103.1567758048221;
 Fri, 06 Sep 2019 01:20:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190906071631.23695-1-clin@suse.com>
In-Reply-To: <20190906071631.23695-1-clin@suse.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 6 Sep 2019 13:50:37 +0530
Message-ID: <CAAhSdy3dyw_VsmP_x9NoWKhpmen6zC5EhTjxPRPHS-OizYgL-Q@mail.gmail.com>
Subject: Re: [PATCH] riscv: save space on the magic number field of image header
To:     Chester Lin <clin@suse.com>
Cc:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "merker@debian.org" <merker@debian.org>,
        "atish.patra@wdc.com" <atish.patra@wdc.com>,
        "Anup.Patel@wdc.com" <Anup.Patel@wdc.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rick@andestech.com" <rick@andestech.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 6, 2019 at 12:50 PM Chester Lin <clin@suse.com> wrote:
>
> Change the symbol from "RISCV" to "RSCV" so the magic number can be 32-bit
> long, which is consistent with other architectures.
>
> Signed-off-by: Chester Lin <clin@suse.com>
> ---
>  arch/riscv/include/asm/image.h | 9 +++++----
>  arch/riscv/kernel/head.S       | 5 ++---
>  2 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/arch/riscv/include/asm/image.h b/arch/riscv/include/asm/image.h
> index ef28e106f247..ec8bbfe86dde 100644
> --- a/arch/riscv/include/asm/image.h
> +++ b/arch/riscv/include/asm/image.h
> @@ -3,7 +3,8 @@
>  #ifndef __ASM_IMAGE_H
>  #define __ASM_IMAGE_H
>
> -#define RISCV_IMAGE_MAGIC      "RISCV"
> +#define RISCV_IMAGE_MAGIC      "RSCV"
> +
>
>  #define RISCV_IMAGE_FLAG_BE_SHIFT      0
>  #define RISCV_IMAGE_FLAG_BE_MASK       0x1
> @@ -39,9 +40,9 @@
>   * @version:           version
>   * @res1:              reserved
>   * @res2:              reserved
> - * @magic:             Magic number
>   * @res3:              reserved (will be used for additional RISC-V specific
>   *                     header)
> + * @magic:             Magic number
>   * @res4:              reserved (will be used for PE COFF offset)
>   *
>   * The intention is for this header format to be shared between multiple
> @@ -57,8 +58,8 @@ struct riscv_image_header {
>         u32 version;
>         u32 res1;
>         u64 res2;
> -       u64 magic;
> -       u32 res3;
> +       u64 res3;
> +       u32 magic;
>         u32 res4;
>  };
>  #endif /* __ASSEMBLY__ */
> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> index 0f1ba17e476f..1f8fffbecf68 100644
> --- a/arch/riscv/kernel/head.S
> +++ b/arch/riscv/kernel/head.S
> @@ -39,9 +39,8 @@ ENTRY(_start)
>         .word RISCV_HEADER_VERSION
>         .word 0
>         .dword 0
> -       .asciz RISCV_IMAGE_MAGIC
> -       .word 0
> -       .balign 4
> +       .dword 0
> +       .ascii RISCV_IMAGE_MAGIC
>         .word 0
>
>  .global _start_kernel
> --
> 2.22.0
>

This change is not at all backward compatible with
existing booti implementation in U-Boot.

It changes:
1. Magic offset
2. Magic value itself

We don't see this header changing much apart from
res1/res2 becoming flags in-future. The PE COFF header
will be append to this header in-future and it will have lot
more information.

Regards,
Anup
