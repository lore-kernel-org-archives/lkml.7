Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8130BC43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ECF0205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="mj7u0XCT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730743AbfDYT5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:57:14 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:36163 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729259AbfDYT5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:57:13 -0400
Received: by mail-it1-f195.google.com with SMTP id y10so2184639itc.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 12:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=gvwc2z4S6BD6uWlEMi4IucZ2NoOc2SvZD8TjjoytUcY=;
        b=mj7u0XCTY89HpkX0rB6pEM6G9cN6dFJV7R66tTAw7uYiAQtFjBSVi9RLv6syTFdrnY
         YLUwYsQhOY7lyffrxcjZSQOZRcNQH09RuuG+25zPhuTKCmzkYfiC0txxsoyV/knfI8Nm
         mKKoAJTXoikIsAV4Ei8d4YW3PHr/tPNZc2CbzRJBkILzC4/3OchxfNDU9tbm9GH4KHOK
         RvT8z24Nha/ML2F/mkcPW1+YBgCyg3xi4q2EqEJUswisH59HQ5G6rP7/XsdBw0dYMJaX
         pukbWyejRCZWSheiE83PzWJjqKY1+th3lCOH33QEV5y5Ad7HsEomdNC3Um7p5kIsefoH
         Qdzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=gvwc2z4S6BD6uWlEMi4IucZ2NoOc2SvZD8TjjoytUcY=;
        b=ecPXFnOc2PcRZ6hDE/8FvOjb0+hj9H39m7oG4rKEsGEflP7+l5SOH3hgHfcRtPeVo9
         84ek1jZufm6SeK1+NoeIf+9WnpaDrEOmA9yW+sNiUmVTr0h4e7DLhFjzYW5uI4Ecu7Ni
         G6zVle3Qa436leTGjDkvbIYOp3kc1oQj5wK48QBPaPtAkxUd/LVm3+pcu18j2mJY/1hu
         zt8zQ5rFuNdQxaCbibvOuK/uyQQHbdgKOLLheZtLcflHvrptoJmnhy9hlQjh23qIHMs5
         6zhG5a0UGnvGki498hqpfAdovv2OypJ0pLH3ZC5/TOjJc5BpGlZCkbZ75YivjqAm7NH0
         l1Nw==
X-Gm-Message-State: APjAAAVF7+O8zy2cfbaw5bzDL/Ft+Fvl+US4PTPbzwigYFeoh5ZXr8Hy
        /Bh8XFYJQl3Wig8ILHQEVfBMLA==
X-Google-Smtp-Source: APXvYqwZ/YflD4xyz9LUJg/gRo5Ytqr+BO/vOnfgsaQnT15Lt7D91H3JJVgMIt7YTQxhP4jEcCWaMQ==
X-Received: by 2002:a05:660c:3c7:: with SMTP id c7mr4972199itl.2.1556222232601;
        Thu, 25 Apr 2019 12:57:12 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id t67sm11013344ita.35.2019.04.25.12.57.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 12:57:11 -0700 (PDT)
Date:   Thu, 25 Apr 2019 12:57:11 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Christoph Hellwig <hch@lst.de>
cc:     Palmer Dabbelt <palmer@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 9/9] riscv: call pm_power_off from machine_halt /
 machine_power_off
In-Reply-To: <20190411115623.5749-10-hch@lst.de>
Message-ID: <alpine.DEB.2.21.9999.1904251227220.17442@viisi.sifive.com>
References: <20190411115623.5749-1-hch@lst.de> <20190411115623.5749-10-hch@lst.de>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Apr 2019, Christoph Hellwig wrote:

> This way any override of pm_power_off also affects the halt path and
> we don't need additional infrastructure for it.
> 
> Also remove the pm_power_off export - at least for now we don't have
> any modular drivers overriding it.

I'd propose that we keep the pm_power_off export - both to align with 
other architectures:

$ fgrep -r pm_power_off arch/ | grep EXPORT
arch/s390/kernel/setup.c:EXPORT_SYMBOL_GPL(pm_power_off);
arch/m68k/kernel/process.c:EXPORT_SYMBOL(pm_power_off);
arch/hexagon/kernel/reset.c:EXPORT_SYMBOL(pm_power_off);
arch/ia64/kernel/process.c:EXPORT_SYMBOL(pm_power_off);
arch/sparc/kernel/process_32.c:EXPORT_SYMBOL(pm_power_off);
arch/sparc/kernel/reboot.c:EXPORT_SYMBOL(pm_power_off);
arch/sh/kernel/reboot.c:EXPORT_SYMBOL(pm_power_off);
arch/um/kernel/reboot.c:EXPORT_SYMBOL(pm_power_off);
arch/openrisc/kernel/process.c:EXPORT_SYMBOL(pm_power_off);
arch/nios2/kernel/process.c:EXPORT_SYMBOL(pm_power_off);
arch/arc/kernel/reset.c:EXPORT_SYMBOL(pm_power_off);
arch/arm/kernel/reboot.c:EXPORT_SYMBOL(pm_power_off);
arch/nds32/kernel/process.c:EXPORT_SYMBOL(pm_power_off);
arch/csky/kernel/power.c:EXPORT_SYMBOL(pm_power_off);
arch/alpha/kernel/process.c:EXPORT_SYMBOL(pm_power_off);
arch/arm64/kernel/process.c:EXPORT_SYMBOL_GPL(pm_power_off);
arch/unicore32/kernel/process.c:EXPORT_SYMBOL(pm_power_off);
arch/c6x/kernel/process.c:EXPORT_SYMBOL(pm_power_off);
arch/xtensa/kernel/process.c:EXPORT_SYMBOL(pm_power_off);
arch/h8300/kernel/process.c:EXPORT_SYMBOL(pm_power_off);
arch/powerpc/kernel/setup-common.c:EXPORT_SYMBOL_GPL(pm_power_off);
arch/mips/kernel/reset.c:EXPORT_SYMBOL(pm_power_off);
arch/riscv/kernel/reset.c:EXPORT_SYMBOL(pm_power_off);
arch/microblaze/kernel/process.c:EXPORT_SYMBOL(pm_power_off);
arch/x86/kernel/reboot.c:EXPORT_SYMBOL(pm_power_off);
arch/parisc/kernel/process.c:EXPORT_SYMBOL(pm_power_off);
$

and to make sure there's no hassle with the drivers that expect to assign 
something to it:

$ fgrep -r pm_power_off drivers/ | fgrep =  | cut -f1 -d:  | sort -u | wc -l
39
$

For what it's worth, I agree with the implied criticism that reassigning 
pm_power_off is not a good interface.  There is the obvious problem that 
more than one chunk of independent code could all try to assign to 
pm_power_off.  However, to avoid creating a RISC-V-specific mess when 
someone uses a TI PMIC driver on a RISC-V board, or tries to use ACPI with 
RISC-V, fixing that seems best done as a separate tree-wide series.

...

Replacing machine_power_off() with a call to your default_power_off() 
looks fine to me.  However I think it makes sense to change our existing 
machine_halt() (which was not added by your patch).  Looking at other 
major architectures - x86, ARM64, and ARM - they don't actually try to 
power down the system in machine_halt(), instead just entering an 
infinite loop, WFI, or calling into firmware or a hypervisor.  I'd propose 
that we align with that approach.


- Paul

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/riscv/kernel/reset.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/riscv/kernel/reset.c b/arch/riscv/kernel/reset.c
> index 2a53d26ffdd6..ed637aee514b 100644
> --- a/arch/riscv/kernel/reset.c
> +++ b/arch/riscv/kernel/reset.c
> @@ -12,11 +12,15 @@
>   */
>  
>  #include <linux/reboot.h>
> -#include <linux/export.h>
>  #include <asm/sbi.h>
>  
> -void (*pm_power_off)(void) = machine_power_off;
> -EXPORT_SYMBOL(pm_power_off);
> +static void default_power_off(void)
> +{
> +	sbi_shutdown();
> +	while (1);
> +}
> +
> +void (*pm_power_off)(void) = default_power_off;
>  
>  void machine_restart(char *cmd)
>  {
> @@ -26,11 +30,10 @@ void machine_restart(char *cmd)
>  
>  void machine_halt(void)
>  {
> -	machine_power_off();
> +	pm_power_off();
>  }
>  
>  void machine_power_off(void)
>  {
> -	sbi_shutdown();
> -	while (1);
> +	pm_power_off();
>  }
> -- 
> 2.20.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 
