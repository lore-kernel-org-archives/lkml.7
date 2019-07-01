Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C29C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 13:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34B8520665
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 13:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IeRPdVJB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbfGAN22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 09:28:28 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44103 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727415AbfGAN22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 09:28:28 -0400
Received: by mail-pf1-f195.google.com with SMTP id t16so6580638pfe.11
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 06:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7fFS7CBBJ6K/lBDuZXPcMufUo/6BGNy9crfvHh0NbbM=;
        b=IeRPdVJBoWbnSyS26xvoi5mbhQ7m5XCpw0Q7WKg3b0NtlZCQPO7EcvichFBDU4fNOX
         83QEd46hoFA3KOSEvxJ1TUya9ayUBj+1T9Pzfbylhcyv6fHqBX/DIDQbUWnQHaUO1ZvE
         9g1qGwvpEcTBf3ClFKgyX7+DeLTNWMDNW3yKJu/BvCjteoCorTkx9GrhsAuTj/3VKre0
         4vEmz2ZVQgvPXKlSAG2QobsE3BLO+/MDe9SS0AH9m0EasioQYUih+URImQV9KILL5uyE
         ETN8PYxgsf1TTLU8RewFhH0/3eQxNksI+ebuSIV9MZNE9J94BAbLQzGD+MhHofMpJngw
         qBBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7fFS7CBBJ6K/lBDuZXPcMufUo/6BGNy9crfvHh0NbbM=;
        b=fl3cD/KkOZeTp7xHE2H0oKE55/388kQH4FgmpEuxjReop/XUp/4zZeyCYSGmjUX507
         papdqzq8etIIM4KKkTLI3uuUC2o58ujkj+j8hsXwjHfvO1s907RS6SPKwq7LwIPgYboj
         x4K08r7b/iG35VjCuv4tnNutXuAmPao8Q+2FwUszQzTvDPwur9v0JIF3n+aCUs58U1Uo
         tp2V+ZnTVNxvJ3euwTzc6py6Wx4z1Cu3XzFsayV5gNjRztuDmxDCqxOg7FWA9YZL8tF2
         ydeyWQkXSFgzayRQtFN/eDqmLryHMqKc4uzXgOoMw0hNdZqjob8/F2V/zht0pb43tfJ2
         u48A==
X-Gm-Message-State: APjAAAX1OoHmgEPlEiA5OrXWE8zqsPIe8+FXkBT8UCDALL0VmGl2uQ7R
        Y3U1wxyMVHO5jh0wQ6gAa4c=
X-Google-Smtp-Source: APXvYqygZLR4ZfbUnJui6h2p8nQ4787Mguc4o/YCnowgcOVlKYiKalv5OIVvsRUYdfWwtkFxRkw9qw==
X-Received: by 2002:a63:58c:: with SMTP id 134mr22959255pgf.106.1561987707260;
        Mon, 01 Jul 2019 06:28:27 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o12sm9507030pjr.22.2019.07.01.06.28.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 06:28:26 -0700 (PDT)
Subject: Re: [DRAFT] mm/kprobes: Add generic kprobe_fault_handler() fallback
 definition
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org
References: <78863cd0-8cb5-c4fd-ed06-b1136bdbb6ef@arm.com>
 <1561973757-5445-1-git-send-email-anshuman.khandual@arm.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <8c6b9525-5dc5-7d17-cee1-b75d5a5121d6@roeck-us.net>
Date:   Mon, 1 Jul 2019 06:28:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <1561973757-5445-1-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/1/19 2:35 AM, Anshuman Khandual wrote:
> Architectures like parisc enable CONFIG_KROBES without having a definition
> for kprobe_fault_handler() which results in a build failure. Arch needs to
> provide kprobe_fault_handler() as it is platform specific and cannot have
> a generic working alternative. But in the event when platform lacks such a
> definition there needs to be a fallback.
> 
> This adds a stub kprobe_fault_handler() definition which not only prevents
> a build failure but also makes sure that kprobe_page_fault() if called will
> always return negative in absence of a sane platform specific alternative.
> 
> While here wrap kprobe_page_fault() in CONFIG_KPROBES. This enables stud
> definitions for generic kporbe_fault_handler() and kprobes_built_in() can
> just be dropped. Only on x86 it needs to be added back locally as it gets
> used in a !CONFIG_KPROBES function do_general_protection().
> 
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> I am planning to go with approach unless we just want to implement a stub
> definition for parisc to get around the build problem for now.
> 
> Hello Guenter,
> 
> Could you please test this in your parisc setup. Thank you.
> 

With this patch applied on top of next-20190628, parisc:allmodconfig builds
correctly. I scheduled a full build for tonight for all architectures.

Guenter

> - Anshuman
> 
>   arch/arc/include/asm/kprobes.h     |  1 +
>   arch/arm/include/asm/kprobes.h     |  1 +
>   arch/arm64/include/asm/kprobes.h   |  1 +
>   arch/ia64/include/asm/kprobes.h    |  1 +
>   arch/mips/include/asm/kprobes.h    |  1 +
>   arch/powerpc/include/asm/kprobes.h |  1 +
>   arch/s390/include/asm/kprobes.h    |  1 +
>   arch/sh/include/asm/kprobes.h      |  1 +
>   arch/sparc/include/asm/kprobes.h   |  1 +
>   arch/x86/include/asm/kprobes.h     |  6 ++++++
>   include/linux/kprobes.h            | 32 ++++++++++++++++++------------
>   11 files changed, 34 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arc/include/asm/kprobes.h b/arch/arc/include/asm/kprobes.h
> index 2134721dce44..ee8efe256675 100644
> --- a/arch/arc/include/asm/kprobes.h
> +++ b/arch/arc/include/asm/kprobes.h
> @@ -45,6 +45,7 @@ struct kprobe_ctlblk {
>   	struct prev_kprobe prev_kprobe;
>   };
>   
> +#define kprobe_fault_handler kprobe_fault_handler
>   int kprobe_fault_handler(struct pt_regs *regs, unsigned long cause);
>   void kretprobe_trampoline(void);
>   void trap_is_kprobe(unsigned long address, struct pt_regs *regs);
> diff --git a/arch/arm/include/asm/kprobes.h b/arch/arm/include/asm/kprobes.h
> index 213607a1f45c..660f877b989f 100644
> --- a/arch/arm/include/asm/kprobes.h
> +++ b/arch/arm/include/asm/kprobes.h
> @@ -38,6 +38,7 @@ struct kprobe_ctlblk {
>   	struct prev_kprobe prev_kprobe;
>   };
>   
> +#define kprobe_fault_handler kprobe_fault_handler
>   void arch_remove_kprobe(struct kprobe *);
>   int kprobe_fault_handler(struct pt_regs *regs, unsigned int fsr);
>   int kprobe_exceptions_notify(struct notifier_block *self,
> diff --git a/arch/arm64/include/asm/kprobes.h b/arch/arm64/include/asm/kprobes.h
> index 97e511d645a2..667773f75616 100644
> --- a/arch/arm64/include/asm/kprobes.h
> +++ b/arch/arm64/include/asm/kprobes.h
> @@ -42,6 +42,7 @@ struct kprobe_ctlblk {
>   	struct kprobe_step_ctx ss_ctx;
>   };
>   
> +#define kprobe_fault_handler kprobe_fault_handler
>   void arch_remove_kprobe(struct kprobe *);
>   int kprobe_fault_handler(struct pt_regs *regs, unsigned int fsr);
>   int kprobe_exceptions_notify(struct notifier_block *self,
> diff --git a/arch/ia64/include/asm/kprobes.h b/arch/ia64/include/asm/kprobes.h
> index c5cf5e4fb338..c321e8585089 100644
> --- a/arch/ia64/include/asm/kprobes.h
> +++ b/arch/ia64/include/asm/kprobes.h
> @@ -106,6 +106,7 @@ struct arch_specific_insn {
>   	unsigned short slot;
>   };
>   
> +#define kprobe_fault_handler kprobe_fault_handler
>   extern int kprobe_fault_handler(struct pt_regs *regs, int trapnr);
>   extern int kprobe_exceptions_notify(struct notifier_block *self,
>   				    unsigned long val, void *data);
> diff --git a/arch/mips/include/asm/kprobes.h b/arch/mips/include/asm/kprobes.h
> index 68b1e5d458cf..d1efe991ea22 100644
> --- a/arch/mips/include/asm/kprobes.h
> +++ b/arch/mips/include/asm/kprobes.h
> @@ -40,6 +40,7 @@ do {									\
>   
>   #define kretprobe_blacklist_size 0
>   
> +#define kprobe_fault_handler kprobe_fault_handler
>   void arch_remove_kprobe(struct kprobe *p);
>   int kprobe_fault_handler(struct pt_regs *regs, int trapnr);
>   
> diff --git a/arch/powerpc/include/asm/kprobes.h b/arch/powerpc/include/asm/kprobes.h
> index 66b3f2983b22..c94f375ec957 100644
> --- a/arch/powerpc/include/asm/kprobes.h
> +++ b/arch/powerpc/include/asm/kprobes.h
> @@ -84,6 +84,7 @@ struct arch_optimized_insn {
>   	kprobe_opcode_t *insn;
>   };
>   
> +#define kprobe_fault_handler kprobe_fault_handler
>   extern int kprobe_exceptions_notify(struct notifier_block *self,
>   					unsigned long val, void *data);
>   extern int kprobe_fault_handler(struct pt_regs *regs, int trapnr);
> diff --git a/arch/s390/include/asm/kprobes.h b/arch/s390/include/asm/kprobes.h
> index b106aa29bf55..0ecaebb78092 100644
> --- a/arch/s390/include/asm/kprobes.h
> +++ b/arch/s390/include/asm/kprobes.h
> @@ -73,6 +73,7 @@ struct kprobe_ctlblk {
>   void arch_remove_kprobe(struct kprobe *p);
>   void kretprobe_trampoline(void);
>   
> +#define kprobe_fault_handler kprobe_fault_handler
>   int kprobe_fault_handler(struct pt_regs *regs, int trapnr);
>   int kprobe_exceptions_notify(struct notifier_block *self,
>   	unsigned long val, void *data);
> diff --git a/arch/sh/include/asm/kprobes.h b/arch/sh/include/asm/kprobes.h
> index 6171682f7798..637a698393c0 100644
> --- a/arch/sh/include/asm/kprobes.h
> +++ b/arch/sh/include/asm/kprobes.h
> @@ -45,6 +45,7 @@ struct kprobe_ctlblk {
>   	struct prev_kprobe prev_kprobe;
>   };
>   
> +#define kprobe_fault_handler kprobe_fault_handler
>   extern int kprobe_fault_handler(struct pt_regs *regs, int trapnr);
>   extern int kprobe_exceptions_notify(struct notifier_block *self,
>   				    unsigned long val, void *data);
> diff --git a/arch/sparc/include/asm/kprobes.h b/arch/sparc/include/asm/kprobes.h
> index bfcaa6326c20..9aa4d25a45a8 100644
> --- a/arch/sparc/include/asm/kprobes.h
> +++ b/arch/sparc/include/asm/kprobes.h
> @@ -47,6 +47,7 @@ struct kprobe_ctlblk {
>   	struct prev_kprobe prev_kprobe;
>   };
>   
> +#define kprobe_fault_handler kprobe_fault_handler
>   int kprobe_exceptions_notify(struct notifier_block *self,
>   			     unsigned long val, void *data);
>   int kprobe_fault_handler(struct pt_regs *regs, int trapnr);
> diff --git a/arch/x86/include/asm/kprobes.h b/arch/x86/include/asm/kprobes.h
> index 5dc909d9ad81..1af2b6db13bd 100644
> --- a/arch/x86/include/asm/kprobes.h
> +++ b/arch/x86/include/asm/kprobes.h
> @@ -101,11 +101,17 @@ struct kprobe_ctlblk {
>   	struct prev_kprobe prev_kprobe;
>   };
>   
> +#define kprobe_fault_handler kprobe_fault_handler
>   extern int kprobe_fault_handler(struct pt_regs *regs, int trapnr);
>   extern int kprobe_exceptions_notify(struct notifier_block *self,
>   				    unsigned long val, void *data);
>   extern int kprobe_int3_handler(struct pt_regs *regs);
>   extern int kprobe_debug_handler(struct pt_regs *regs);
> +#else
> +static inline int kprobe_fault_handler(struct pt_regs *regs, int trapnr)
> +{
> +	return 0;
> +}
>   
>   #endif /* CONFIG_KPROBES */
>   #endif /* _ASM_X86_KPROBES_H */
> diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
> index 04bdaf01112c..e106f3018804 100644
> --- a/include/linux/kprobes.h
> +++ b/include/linux/kprobes.h
> @@ -182,11 +182,19 @@ DECLARE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
>   /*
>    * For #ifdef avoidance:
>    */
> -static inline int kprobes_built_in(void)
> +
> +/*
> + * Architectures need to override this with their own implementation
> + * if they care to call kprobe_page_fault(). This will just ensure
> + * that kprobe_page_fault() returns false when called without having
> + * a proper platform specific definition for kprobe_fault_handler().
> + */
> +#ifndef kprobe_fault_handler
> +static inline int kprobe_fault_handler(struct pt_regs *regs, int trapnr)
>   {
> -	return 1;
> +	return 0;
>   }
> -
> +#endif
>   #ifdef CONFIG_KRETPROBES
>   extern void arch_prepare_kretprobe(struct kretprobe_instance *ri,
>   				   struct pt_regs *regs);
> @@ -375,14 +383,6 @@ void free_insn_page(void *page);
>   
>   #else /* !CONFIG_KPROBES: */
>   
> -static inline int kprobes_built_in(void)
> -{
> -	return 0;
> -}
> -static inline int kprobe_fault_handler(struct pt_regs *regs, int trapnr)
> -{
> -	return 0;
> -}
>   static inline struct kprobe *get_kprobe(void *addr)
>   {
>   	return NULL;
> @@ -458,12 +458,11 @@ static inline bool is_kprobe_optinsn_slot(unsigned long addr)
>   }
>   #endif
>   
> +#ifdef CONFIG_KPROBES
>   /* Returns true if kprobes handled the fault */
>   static nokprobe_inline bool kprobe_page_fault(struct pt_regs *regs,
>   					      unsigned int trap)
>   {
> -	if (!kprobes_built_in())
> -		return false;
>   	if (user_mode(regs))
>   		return false;
>   	/*
> @@ -476,5 +475,12 @@ static nokprobe_inline bool kprobe_page_fault(struct pt_regs *regs,
>   		return false;
>   	return kprobe_fault_handler(regs, trap);
>   }
> +#else
> +static nokprobe_inline bool kprobe_page_fault(struct pt_regs *regs,
> +					      unsigned int trap)
> +{
> +	return false;
> +}
> +#endif
>   
>   #endif /* _LINUX_KPROBES_H */
> 

