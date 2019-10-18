Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5949DCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 08:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28DBF222BD
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 08:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="TcVOUj8o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2632927AbfJRIne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 04:43:34 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:40065 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727903AbfJRIne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 04:43:34 -0400
Received: by mail-il1-f193.google.com with SMTP id o16so4814302ilq.7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 01:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=CIt+hFG6ZbxuG3Tl39oW4lR5XbeTOmjy7F8raJZ4AuA=;
        b=TcVOUj8ozZ8UtKg6Fi9IPAmiBMEiSRVn/XOBg2tqztcxP4SCuFhH5TrW289kUD/62Q
         UTTuZE92s/AttcaVm7apLIPBmX4iLzzvk16OhhRNS6iq/vVjSpqT8vnPqvYiZ6PW756c
         VDiY0OZXgJaMQ+FkOEoBIj1uJGUIKSGgvUqQr2bO9bUfVvqZYvTOHwcEG4dSqFRZPVAN
         HYpFuOJ1YXvdi9GeFw+4Jxm6QSMbBz74ZAgGoPhWWJbwr65L44P/rwCbAAqmRzdW8kVY
         UoHFZ4V1cpZ63L+oBPfosxY20z2CzTtRj2YdPwMq3uvpVuH+oB8qpdFLj4eIKI4XrW3U
         khkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=CIt+hFG6ZbxuG3Tl39oW4lR5XbeTOmjy7F8raJZ4AuA=;
        b=Z36fmgCeGrlS2NqIdz+o8/EyuVM1af/s4SqthbaE8n0zoEdt4GqDWULCyovc5doZHF
         O39Yy6zEvc+UYasUFYgjgscwZyTgpfxXSHBG+YhET3Dez4Y5D4sMwYxIbGB2hLlbfIwy
         kkRLFktEN46YHXeEZ0dneCqUf2+33h9S8k7mXSwyW5XzDxPzSL+/d3+qqGzMVKSIPQ57
         rwC/pyBiIYKGut1cczcg7TCgGKmRLRHLCxWWUlebxh4nAf2epl/ROnyr/2dZwCKmOSaq
         c0WyK/8PWcKktFtEvjoYlTXf8pNqv7Tl1wm5BjhRLq/0AfUiUr2unK72SJ/MzJAT1v/V
         LL1Q==
X-Gm-Message-State: APjAAAULs5XZYtAlkIoZz4YHAhj8bAxh2V3oO9pOp9EkMAN3qIwrIxSo
        k8DxEeimkylQmEKCz8iupaciiQ==
X-Google-Smtp-Source: APXvYqzT4vQGzbOYM+VPVYFS9y0mWpLBiCrhqHfvp4Ojsbmf7gbi2hjgAre2Oc19p5/gbaLnYt9Zqg==
X-Received: by 2002:a92:4a05:: with SMTP id m5mr3698564ilf.91.1571388212846;
        Fri, 18 Oct 2019 01:43:32 -0700 (PDT)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id o14sm1521681iob.49.2019.10.18.01.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 01:43:32 -0700 (PDT)
Date:   Fri, 18 Oct 2019 01:43:29 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Atish Patra <atish.patra@wdc.com>
cc:     linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Allison Randal <allison@lohutok.net>,
        Anup Patel <anup@brainfault.org>,
        Enrico Weigelt <info@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Richard Fontana <rfontana@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2  2/2] RISC-V: Consolidate isa correctness check
In-Reply-To: <20191009220058.24964-3-atish.patra@wdc.com>
Message-ID: <alpine.DEB.2.21.9999.1910180142460.21875@viisi.sifive.com>
References: <20191009220058.24964-1-atish.patra@wdc.com> <20191009220058.24964-3-atish.patra@wdc.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Oct 2019, Atish Patra wrote:

> Currently, isa string is read and checked for correctness at multiple
> places.
> 
> Consolidate them into one function and use it only during early bootup.
> In case of a incorrect isa string, the cpu shouldn't boot at all.
> 
> Signed-off-by: Atish Patra <atish.patra@wdc.com>

Looks like riscv_read_check_isa() is called twice for each hart.  Is there 
any way to call it only once per hart?


- Paul

> ---
>  arch/riscv/include/asm/processor.h |  1 +
>  arch/riscv/kernel/cpu.c            | 41 ++++++++++++++++++++++--------
>  arch/riscv/kernel/cpufeature.c     |  4 +--
>  arch/riscv/kernel/smpboot.c        |  4 +++
>  4 files changed, 37 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
> index f539149d04c2..189bf98f9a3f 100644
> --- a/arch/riscv/include/asm/processor.h
> +++ b/arch/riscv/include/asm/processor.h
> @@ -74,6 +74,7 @@ static inline void wait_for_interrupt(void)
>  }
>  
>  struct device_node;
> +int riscv_read_check_isa(struct device_node *node, const char **isa);
>  int riscv_of_processor_hartid(struct device_node *node);
>  
>  extern void riscv_fill_hwcap(void);
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index 40a3c442ac5f..6bd4c7176bf6 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -8,13 +8,43 @@
>  #include <linux/of.h>
>  #include <asm/smp.h>
>  
> +int riscv_read_check_isa(struct device_node *node, const char **isa)
> +{
> +	u32 hart;
> +
> +	if (of_property_read_u32(node, "reg", &hart)) {
> +		pr_warn("Found CPU without hart ID\n");
> +		return -ENODEV;
> +	}
> +
> +	if (of_property_read_string(node, "riscv,isa", isa)) {
> +		pr_warn("CPU with hartid=%d has no \"riscv,isa\" property\n",
> +			hart);
> +		return -ENODEV;
> +	}
> +	/*
> +	 * Linux doesn't support rv32e or rv128i, and we only support booting
> +	 * kernels on harts with the same ISA that the kernel is compiled for.
> +	 */
> +	if (IS_ENABLED(CONFIG_32BIT) && (strncmp(*isa, "rv32i", 5) != 0)) {
> +		pr_warn("hartid=%d has an invalid ISA \"%s\" for 32bit config\n",
> +			hart, *isa);
> +		return -ENODEV;
> +	} else if (IS_ENABLED(CONFIG_64BIT) &&
> +		  (strncmp(*isa, "rv64i", 5) != 0)) {
> +		pr_warn("hartid=%d has an invalid ISA \"%s\" for 64bit config\n",
> +			hart, *isa);
> +		return -ENODEV;
> +	}
> +	return 0;
> +}
> +
>  /*
>   * Returns the hart ID of the given device tree node, or -ENODEV if the node
>   * isn't an enabled and valid RISC-V hart node.
>   */
>  int riscv_of_processor_hartid(struct device_node *node)
>  {
> -	const char *isa;
>  	u32 hart;
>  
>  	if (!of_device_is_compatible(node, "riscv")) {
> @@ -32,15 +62,6 @@ int riscv_of_processor_hartid(struct device_node *node)
>  		return -ENODEV;
>  	}
>  
> -	if (of_property_read_string(node, "riscv,isa", &isa)) {
> -		pr_warn("CPU with hartid=%d has no \"riscv,isa\" property\n", hart);
> -		return -ENODEV;
> -	}
> -	if (isa[0] != 'r' || isa[1] != 'v') {
> -		pr_warn("CPU with hartid=%d has an invalid ISA of \"%s\"\n", hart, isa);
> -		return -ENODEV;
> -	}
> -
>  	return hart;
>  }
>  
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index b1ade9a49347..eaad5aa07403 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -38,10 +38,8 @@ void riscv_fill_hwcap(void)
>  		if (riscv_of_processor_hartid(node) < 0)
>  			continue;
>  
> -		if (of_property_read_string(node, "riscv,isa", &isa)) {
> -			pr_warn("Unable to find \"riscv,isa\" devicetree entry\n");
> +		if (riscv_read_check_isa(node, &isa) < 0)
>  			continue;
> -		}
>  
>  		for (i = 0; i < strlen(isa); ++i)
>  			this_hwcap |= isa2hwcap[(unsigned char)(isa[i])];
> diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> index 18ae6da5115e..15ee71297abf 100644
> --- a/arch/riscv/kernel/smpboot.c
> +++ b/arch/riscv/kernel/smpboot.c
> @@ -60,12 +60,16 @@ void __init setup_smp(void)
>  	int hart;
>  	bool found_boot_cpu = false;
>  	int cpuid = 1;
> +	const char *isa;
>  
>  	for_each_of_cpu_node(dn) {
>  		hart = riscv_of_processor_hartid(dn);
>  		if (hart < 0)
>  			continue;
>  
> +		if (riscv_read_check_isa(dn, &isa) < 0)
> +			continue;
> +
>  		if (hart == cpuid_to_hartid_map(0)) {
>  			BUG_ON(found_boot_cpu);
>  			found_boot_cpu = 1;
> -- 
> 2.21.0
> 
> 


- Paul
