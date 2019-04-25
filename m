Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3286C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 06:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8725C217FA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 06:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556175135;
	bh=S5f1qcsepvqbumXVX4TS7tPs8tBGK1oMYU4KaDDnbIo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SQwgB+TqwzJAIidJ2r7qSkK2LRz5jC9nSEIf55iM5wwEjmvIJvuo3IpzRegoyDCPE
	 HZFv+0rNn2l9g7tZ3PxvqzvzcmnNOG7D/P4Hpd9EZ5h6yTU86k/VgnZS70K4mJ1LML
	 uamr2KshxAWTZ+0Twg2v35e0FRyl9N0WcLwNy5bM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729873AbfDYGwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 02:52:14 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:38918 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfDYGwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 02:52:14 -0400
Received: by mail-wm1-f48.google.com with SMTP id n25so8817906wmk.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 23:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TXX6+gv7iWhMRNXZMbTkplqE/2KpwHYiSmGi33/7wls=;
        b=PQS++NYW/VuRgmUQ/AlgsuwLmbWSuuFgW2GQqOkp0ReLqN59tG7prr8rhDaKgiIow7
         DfP6RoxxMKcjM0i2HsFfvpKAxfC9vL+6zTfxhAHx2mIyt00blakIUmahyKLHt15yVXV6
         2XWKBnQettmhc0mNrZiuvIgF62/+8tguxfFDWccZCZla8WOMPDJquLvOEsteDojORUCa
         uFbwk/ZwGf0CGXhLLiakZTcVWsTHWYp6yMb/B7fITqZIUqoH860ghpRzmcysQmgm6iJN
         Xs0QN6/ltI/2Q6jZS2eNKUFj4X45bcmkbSe2cDPUUgr1kHiqX7Q1Kr5RnKy7nCu3ux9N
         3dsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=TXX6+gv7iWhMRNXZMbTkplqE/2KpwHYiSmGi33/7wls=;
        b=nOVYb2RbHuuzjIXO3suzjuY9nN7uZTdxbJe8OWi24IRbW9ck7Xh96ZAZRcasah90lU
         +YPDG6wrEekvjZVeuFWA+kJ70msTgLe3kGNsznFWiPWbij6kZGgaDvek41theJ2jq8pw
         sl9RFggFNh8xnVy12DZQYz0F/EQJWbBo1U7nBe+W63Ja0uBPjEABuTOSVFH54cIg1Xu9
         K/RJZpUeyUUDV5FKEuqwr5QYFolC4MhlNwUV3L0bUF4x4fKEuYWmvm3ijPnoZR4svJFJ
         mwzpdKykvUA5QQCX0zFy0g7EKhAZwbIZHMCOiLpQNUXw6zcH/836fPcxQTGOEeMXE7kB
         iguw==
X-Gm-Message-State: APjAAAXPYvl2VObAjxz8FL6EHtk57kYAqnHB9JZyMj0iQQRIqy1T0gkV
        OsT+AC57DmjQeyjpvXYh/ac=
X-Google-Smtp-Source: APXvYqyv2pXGvTJJQXMMRuZqilOlTbp9o65d8ZaXPFJx4WdO/ju/l4eQS917ZCazQW7Jt8AOcd26lA==
X-Received: by 2002:a1c:6c19:: with SMTP id h25mr2092886wmc.119.1556175132431;
        Wed, 24 Apr 2019 23:52:12 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id z17sm21389161wmc.7.2019.04.24.23.52.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 23:52:11 -0700 (PDT)
Date:   Thu, 25 Apr 2019 08:52:09 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Juergen Gross <jgross@suse.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [patch 3/3] x86/paravirt: Replace paravirt patch asm magic
Message-ID: <20190425065209.GA89582@gmail.com>
References: <20190424134115.091452807@linutronix.de>
 <20190424134223.690835713@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424134223.690835713@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> The magic macro DEF_NATIVE() in the paravirt patching code uses inline
> assembly to generate a data table for patching in the native instructions.
> 
> While clever this is falling apart with LTO and even aside of LTO the
> construct is just working by chance according to GCC folks.
> 
> Aside of that the tables are constant data and not some form of magic
> text.
> 
> As these constructs are not subject to frequent changes it is not a
> maintenance issue to convert them to regular data tables which are
> initialized with hex bytes.
> 
> Create a new set of macros and data structures to store the instruction
> sequences and convert the code over.
> 
> Reported-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

> -# ifdef CONFIG_PARAVIRT_XXL
> -DEF_NATIVE(irq, irq_disable, "cli");
> -DEF_NATIVE(irq, irq_enable, "sti");
> -DEF_NATIVE(irq, restore_fl, "push %eax; popf");
> -DEF_NATIVE(irq, save_fl, "pushf; pop %eax");
> -DEF_NATIVE(cpu, iret, "iret");
> -DEF_NATIVE(mmu, read_cr2, "mov %cr2, %eax");
> -DEF_NATIVE(mmu, write_cr3, "mov %eax, %cr3");
> -DEF_NATIVE(mmu, read_cr3, "mov %cr3, %eax");

> +static const struct patch_xxl patch_data_xxl = {
> +	.irq_irq_disable	= { 0xfa },		// cli
> +	.irq_irq_enable		= { 0xfb },		// sti
> +	.irq_save_fl		= { 0x9c, 0x58 },	// pushf; pop %[re]ax
> +	.mmu_read_cr2		= { 0x0f, 0x20, 0xd0 },	// mov %cr2, %[re]ax
> +	.mmu_read_cr3		= { 0x0f, 0x20, 0xd8 },	// mov %cr3, %[re]ax
> +# ifdef CONFIG_X86_64
> +	.irq_restore_fl		= { 0x57, 0x9d },	// push %rdi; popfq
> +	.mmu_write_cr3		= { 0x0f, 0x22, 0xdf },	// mov %rdi, %cr3
> +	.cpu_wbinvd		= { 0x0f, 0x09 },	// wbinvd
> +	.cpu_usergs_sysret64	= { 0x0f, 0x01, 0xf8,
> +				    0x48, 0x0f, 0x07 },	// swapgs; sysretq
> +	.cpu_swapgs		= { 0x0f, 0x01, 0xf8 },	// swapgs
> +	.mov64			= { 0x48, 0x89, 0xf8 },	// mov %rdi, %rax
> +# else
> +	.irq_restore_fl		= { 0x50, 0x9d },	// push %eax; popf
> +	.mmu_write_cr3		= { 0x0f, 0x22, 0xd8 },	// mov %eax, %cr3
> +	.cpu_iret		= { 0xcf },		// iret
> +# endif

I think these open-coded hexa versions are somewhat fragile as well, how 
about putting these into a .S file and controlling the sections in an LTO 
safe manner there?

That will also allow us to write proper asm, and global labels can be 
used to extract the patchlets and their length?

Thanks,

	Ingo
