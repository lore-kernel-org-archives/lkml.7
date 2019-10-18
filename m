Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3BACA9ECB
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E06F222BD
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="oT+ec34Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390061AbfJRF0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 01:26:55 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33997 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbfJRF0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 01:26:55 -0400
Received: by mail-wr1-f66.google.com with SMTP id j11so4766438wrp.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 22:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h73TqF5SoJ6GAIIKRG22eugF7D1cochNYSQVPWgygxk=;
        b=oT+ec34QQePEIN8AhUZGIGxnIWGt8bBJbEIgZPVeAawhIgHnNshdKFCxck2vhENTAr
         vbr2hWswQdFMhAFRLwWwvlEls+zsASyOIedKdO/I9WSbxqBIry0+LhvKUULxL+e/Tfuz
         l3dWDY9QlsHdcrJNMVeJkWCVuDUbu+n8Czh+/KZivTKW0pF0qJx3p44zF7ZYc0Fffiuk
         zj7uOIb5BcqssmkN44Hmde4nPeNCu0KnzWItOzKgfqz8/ZS4wDzatknooeMs8PcbDJ64
         kiawb0PA8ePO9j31VtLaA2f16BXSL76nj/kQw8d3ySbGRDO9iKoGDTyuE85HmlXupXdt
         f/rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h73TqF5SoJ6GAIIKRG22eugF7D1cochNYSQVPWgygxk=;
        b=oiCHXoaIQN6pIBFXx+hdmM3FjK+JGYoGu3AEm6HZGbams/9eiD8/FmFwhfmccbiasB
         oWGUowsB+kgmkSevT/PX8dbhxsRDVHrgCm2cM0CssloOnyjR6REAWBMZngLN8Be4pxcq
         9O0dqDGt28EA2yLOwg0e6xa2b5Dhly5wGFAmb7GjFnBVDbUAXfftmxAFw4I1dWEoMfak
         ZuAW8ehbqI5iC8RA2AlwqKcVOojPXaA0ZlxgNpAfHX3UldD44Xne2Rt57nngU8Ixz07O
         Jerk2uBoH5adLQ2/wXU7VFlb+NevPKqX2Vng0f95U7us+k+haZ0r9wLLGctBCRkAgpqq
         S/Ew==
X-Gm-Message-State: APjAAAUZiUbELsga3ninKMZtdjlIfPVQmyDCt6oOUKqWm8Wi0/diAAJU
        L2mdyNyJ0jOMl4LmKgFhDInb46CPDGDASECz7B0eY63RAfQ=
X-Google-Smtp-Source: APXvYqzKRMy1STi+JQe3ZerDLgemp6MoY0u4gJnfJOMrrFsiaL70l/OsymsbOB47n6U96qOe+1clLwmxcheZ4TNEnKk=
X-Received: by 2002:adf:a109:: with SMTP id o9mr5299771wro.96.1571367250161;
 Thu, 17 Oct 2019 19:54:10 -0700 (PDT)
MIME-Version: 1.0
References: <20191017173743.5430-1-hch@lst.de> <20191017173743.5430-7-hch@lst.de>
In-Reply-To: <20191017173743.5430-7-hch@lst.de>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 18 Oct 2019 08:23:59 +0530
Message-ID: <CAAhSdy1DotXOmo472pXDmRny1Zt11eSH4soG_tYaAALrYzVgBw@mail.gmail.com>
Subject: Re: [PATCH 06/15] riscv: cleanup the default power off implementation
To:     Christoph Hellwig <hch@lst.de>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Atish Patra <atish.patra@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 11:08 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Move the sbi poweroff to a separate function and file that is only
> compiled if CONFIG_SBI is set.  Provide a new default fallback
> power off that just sits in a wfi loop to save some power.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/kernel/Makefile |  1 +
>  arch/riscv/kernel/reset.c  |  5 ++---
>  arch/riscv/kernel/sbi.c    | 17 +++++++++++++++++
>  3 files changed, 20 insertions(+), 3 deletions(-)
>  create mode 100644 arch/riscv/kernel/sbi.c
>
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index 696020ff72db..d8c35fa93cc6 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -41,5 +41,6 @@ obj-$(CONFIG_DYNAMIC_FTRACE)  += mcount-dyn.o
>  obj-$(CONFIG_PERF_EVENTS)      += perf_event.o
>  obj-$(CONFIG_PERF_EVENTS)      += perf_callchain.o
>  obj-$(CONFIG_HAVE_PERF_REGS)   += perf_regs.o
> +obj-$(CONFIG_RISCV_SBI)                += sbi.o
>
>  clean:
> diff --git a/arch/riscv/kernel/reset.c b/arch/riscv/kernel/reset.c
> index d0fe623bfb8f..5e4e69859af1 100644
> --- a/arch/riscv/kernel/reset.c
> +++ b/arch/riscv/kernel/reset.c
> @@ -4,12 +4,11 @@
>   */
>
>  #include <linux/reboot.h>
> -#include <asm/sbi.h>
>
>  static void default_power_off(void)
>  {
> -       sbi_shutdown();
> -       while (1);
> +       while (1)
> +               wait_for_interrupt();
>  }
>
>  void (*pm_power_off)(void) = default_power_off;
> diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> new file mode 100644
> index 000000000000..f6c7c3e82d28
> --- /dev/null
> +++ b/arch/riscv/kernel/sbi.c
> @@ -0,0 +1,17 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/init.h>
> +#include <linux/pm.h>
> +#include <asm/sbi.h>
> +
> +static void sbi_power_off(void)
> +{
> +       sbi_shutdown();
> +}
> +
> +static int __init sbi_init(void)
> +{
> +       pm_power_off = sbi_power_off;
> +       return 0;
> +}
> +early_initcall(sbi_init);
> --
> 2.20.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
