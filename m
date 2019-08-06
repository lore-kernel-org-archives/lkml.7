Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C5AC31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 23:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07B0E216F4
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 23:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="A1NCke0a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfHFX1c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 19:27:32 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34697 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbfHFX1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 19:27:32 -0400
Received: by mail-ot1-f67.google.com with SMTP id n5so97001638otk.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 16:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=V5E/vEU5l0XkioyuorxP6jKxsdFKokFL9ZSrtexRssk=;
        b=A1NCke0a/LjS9zvr7+/34vGTAEoKD6Z7pY809prBn3C4amAQe063I+j3pzu6tKiV6N
         zANesKaI6teNmSxD4Six9jmjo5ZWki6o2jPPLuzPBYmTsteU3evikYzBntcUrMCrwNih
         fMT7X4BH3MRi92FoB9FhEUSN2I8ak+MseNYgMRrK5gz7m5yvMjVIiYPxMZ8CJ+SOSc24
         WOApgJYr3w0NR6neMgEo2AKw3p1ESlkH8TbATHjL6sUvWxVwFcLMPiLAv9yN10H88Fq5
         VyjCqs4jI9gSActsyazLApeytbPoBB9RbFPpHL4om+y3U8GG4IiFtdcY+RMibJ0KGWM6
         C7zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=V5E/vEU5l0XkioyuorxP6jKxsdFKokFL9ZSrtexRssk=;
        b=HD9VvjR9NkdBn53K3bKDUrO+5tV4ifQ4BktraUU/MCWFWqyqzrrXIRHHjN8elezzv6
         z2DG7Vi0plA5o0G/fVtEjBGvcMmZSdK/TCro5yWTyubRa3qVZNk+2kNKMq/v/9/m1Dd/
         jRXyAb2dINtOlA31Z3JIUeq88w6nBMpbR0RjLUniyFnDYgsoyty/k+cITzJR2NRP2stT
         zLvalkrH7l3hhJ5dgQJL86OChgibDXpZKjXlXfprY5CXqUjLYsHsfzyeNur3vTG9ukzY
         3Ek0ydArOre2tmEaRJZNRMV0oSAO/ihzPO0wy4guCl39YAZ/CbuoJce8O8bXY4ARE41j
         ndBw==
X-Gm-Message-State: APjAAAWp6qd+qbzKLypDeyPQ1UyI3M4WAHN4d2wMGzoCnTGoPHmjO1w0
        3eYoMj9BKyN4fI8d71GlpVagkQ==
X-Google-Smtp-Source: APXvYqySNV0ICs40X1PhGp8WppnE7/Hq6YdPV4lbOreMMENDHsln4iW6yVs87f7uUjg5jNYUoSYPwA==
X-Received: by 2002:a6b:c081:: with SMTP id q123mr6295296iof.210.1565134051058;
        Tue, 06 Aug 2019 16:27:31 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id z19sm97593360ioh.12.2019.08.06.16.27.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 16:27:30 -0700 (PDT)
Date:   Tue, 6 Aug 2019 16:27:30 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Atish Patra <atish.patra@wdc.com>
cc:     linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Allison Randal <allison@lohutok.net>,
        Anup Patel <anup.patel@wdc.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        devicetree@vger.kernel.org, Enrico Weigelt <info@metux.net>,
        Gary Guo <gary@garyguo.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: Re: [PATCH v3 3/5] RISC-V: Fix unsupported isa string info.
In-Reply-To: <20190801005843.10343-4-atish.patra@wdc.com>
Message-ID: <alpine.DEB.2.21.9999.1908061625190.13971@viisi.sifive.com>
References: <20190801005843.10343-1-atish.patra@wdc.com> <20190801005843.10343-4-atish.patra@wdc.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jul 2019, Atish Patra wrote:

> Currently, kernel prints a info warning if any of the extensions
> from "mafdcsu" is missing in device tree. This is not entirely
> correct as Linux can boot with "f or d" extensions if kernel is
> configured accordingly. Moreover, it will continue to print the
> info string for future extensions such as hypervisor as well which
> is misleading. /proc/cpuinfo also doesn't print any other extensions
> except "mafdcsu".
> 
> Make sure that info log is only printed only if kernel is configured
> to have any mandatory extensions but device tree doesn't describe it.
> All the extensions present in device tree and follow the order
> described in the RISC-V specification (except 'S') are printed via
> /proc/cpuinfo always.
> 
> Signed-off-by: Atish Patra <atish.patra@wdc.com>

I tested this patch after dropping the CONFIG_ISA_RISCV_C test (see 
below).  Running "cat /proc/cpuinfo" generated the following kernel 
warnings:
          
[   73.412626] unsupported ISA extensions "su" in device tree for cpu [0]
[   73.418417] unsupported ISA extensions "su" in device tree for cpu [1]
[   73.424912] unsupported ISA extensions "su" in device tree for cpu [2]
[   73.431425] unsupported ISA extensions "su" in device tree for cpu [3]

Seems like the "su" should be dropped from mandatory_ext.  What do you 
think?

> ---
>  arch/riscv/kernel/cpu.c | 47 ++++++++++++++++++++++++++++++++---------
>  1 file changed, 37 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index 7da3c6a93abd..9b1d4550fbe6 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -7,6 +7,7 @@
>  #include <linux/seq_file.h>
>  #include <linux/of.h>
>  #include <asm/smp.h>
> +#include <asm/hwcap.h>
>  
>  /*
>   * Returns the hart ID of the given device tree node, or -ENODEV if the node
> @@ -46,11 +47,14 @@ int riscv_of_processor_hartid(struct device_node *node)
>  
>  #ifdef CONFIG_PROC_FS
>  
> -static void print_isa(struct seq_file *f, const char *orig_isa)
> +static void print_isa(struct seq_file *f, const char *orig_isa,
> +		      unsigned long cpuid)
>  {
> -	static const char *ext = "mafdcsu";
> +	static const char *mandatory_ext = "mafdcsu";
>  	const char *isa = orig_isa;
>  	const char *e;
> +	char unsupported_isa[26] = {0};
> +	int index = 0;
>  
>  	/*
>  	 * Linux doesn't support rv32e or rv128i, and we only support booting
> @@ -70,27 +74,50 @@ static void print_isa(struct seq_file *f, const char *orig_isa)
>  	isa += 5;
>  
>  	/*
> -	 * Check the rest of the ISA string for valid extensions, printing those
> -	 * we find.  RISC-V ISA strings define an order, so we only print the
> +	 * RISC-V ISA strings define an order, so we only print all the
>  	 * extension bits when they're in order. Hide the supervisor (S)
>  	 * extension from userspace as it's not accessible from there.
> +	 * Throw a warning only if any mandatory extensions are not available
> +	 * and kernel is configured to have that mandatory extensions.
>  	 */
> -	for (e = ext; *e != '\0'; ++e) {
> -		if (isa[0] == e[0]) {
> +	for (e = mandatory_ext; *e != '\0'; ++e) {
> +		if (isa[0] != e[0]) {
> +#if defined(CONFIG_ISA_RISCV_C)

There's no Kconfig option by this name, and we're requiring compressed 
instruction support as part of the RISC-V Linux baseline.  Could you share 
the rationale behind this?  Looks to me like this should be dropped.


> +			if (isa[0] == 'c')
> +				continue;
> +#endif
> +#if defined(CONFIG_FP)
> +			if ((isa[0] == 'f') || (isa[0] == 'd'))
> +				continue;
> +#endif
> +			unsupported_isa[index] = e[0];
> +			index++;
> +		}
> +		/* Only write if part of isa string */
> +		if (isa[0] != '\0') {
>  			if (isa[0] != 's')
>  				seq_write(f, isa, 1);
> -
>  			isa++;
>  		}
>  	}
> +	if (isa[0] != '\0') {
> +		/* Add remainging isa strings */
> +		for (e = isa; *e != '\0'; ++e) {
> +#if !defined(CONFIG_VIRTUALIZATION)
> +			if (e[0] != 'h')
> +#endif
> +				seq_write(f, e, 1);
> +		}
> +	}
>  	seq_puts(f, "\n");
>  
>  	/*
>  	 * If we were given an unsupported ISA in the device tree then print
>  	 * a bit of info describing what went wrong.
>  	 */
> -	if (isa[0] != '\0')
> -		pr_info("unsupported ISA \"%s\" in device tree\n", orig_isa);
> +	if (unsupported_isa[0])
> +		pr_info("unsupported ISA extensions \"%s\" in device tree for cpu [%ld]\n",
> +			unsupported_isa, cpuid);
>  }
>  
>  static void print_mmu(struct seq_file *f, const char *mmu_type)
> @@ -134,7 +161,7 @@ static int c_show(struct seq_file *m, void *v)
>  	seq_printf(m, "processor\t: %lu\n", cpu_id);
>  	seq_printf(m, "hart\t\t: %lu\n", cpuid_to_hartid_map(cpu_id));
>  	if (!of_property_read_string(node, "riscv,isa", &isa))
> -		print_isa(m, isa);
> +		print_isa(m, isa, cpu_id);
>  	if (!of_property_read_string(node, "mmu-type", &mmu))
>  		print_mmu(m, mmu);
>  	if (!of_property_read_string(node, "compatible", &compat)
> -- 
> 2.21.0
> 
> 


- Paul
