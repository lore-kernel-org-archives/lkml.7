Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54EDAC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AF36217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556179820;
	bh=P3fBnmuCEkkrN38hwYL/mpQsxyGVucm4xdpvcipVdXg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Zzhp7ZsFQcHlEnbkO3vACJZNfbw+S4hHC2bdCdvaNzRyLjs+qWBdb3p9We83pMyuU
	 S8KYmzm8nQdNlJdZu/PETpxizE7x8fAtvQGShvji7UArvjOTNTjpY70QPOhnu18M53
	 VQhDzTZTMrL0cnQRGL58cqpc3eD5R3kha5aO4r3Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730354AbfDYIKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 04:10:18 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35850 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbfDYIKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 04:10:18 -0400
Received: by mail-wm1-f66.google.com with SMTP id h18so9168027wml.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 01:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iDqpNO2TLoefJuf6dnHZrz5daEWkzHmzd4t455X3hWI=;
        b=fLbSclH1Uo84LqxFbxSJ7du1xtksS0ZrdVZr/YXerxd7dJxxiIwOrojiSHltiHV2sE
         pRcbnAOrIK2L2+CsKZhIJkwpjTRxJYeHBB4tuN4nJHCHCCYaTczaqh9KKOSjm0OvBsmS
         S+06Fl6PzNdiQMczDSABsvRlU3jQczbD0ShJ6mmmju0xPtfF4F3422GpI8R/p90/eBGo
         VCItne1msCbEjWensE+tdo+ZPN6kfQ0iZGs7NTPa5XMIFD3MpGHVU4twdzfzz/8ZqxHO
         50lh0HLy9YoAMmlhVVNzyi/xia8BWUs9n6iRaW3LEcaw3v0tEflNkDNCBQ78fAWaR5Um
         aSFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=iDqpNO2TLoefJuf6dnHZrz5daEWkzHmzd4t455X3hWI=;
        b=YLQJIpQ9YsH2NtrH07hEyJ3+q7Y2Rpp4NwE0bPzk5m5pDticCnuAnj+xoJm66xLmmh
         ZE6rRi5GxSDhNYIvoruO6LWPUP+FDHqj13anKxfwJHCmGEUbeNnaPKVt3aQg8zrM1i/3
         EDjZ5zXiqpmFwXK5pT2GcWUCdfxgG+b3/JQMmqbMq6PBLvQ1r3LKLVB70+oPuxhfH7LA
         VL4M3ngBPYzCoe8NInTcyJvvu1oXfPO0woJmUNG6/9EcsBhJdAI4bYV2fRzsB9b0L1Px
         vArBoHG1wW62J5bkbI7OI1moHTgAp06QrUugDhm6VMKEfDHHzO5fDK4o182koRzasTyj
         o1tA==
X-Gm-Message-State: APjAAAVuGiFqf8oifTO01lC7k7vrXJS3NmIUU8k7QhR1yGlituci7Nye
        +KHaAO3m6zG/rypkLL8liAI=
X-Google-Smtp-Source: APXvYqybc/KxCW09TwSUUeKIYag8OxbQUecAutrWX+fQ4gAtYMFh3PGQDQU2tPCraOuYoYGIIlT6Ow==
X-Received: by 2002:a1c:a953:: with SMTP id s80mr2472992wme.50.1556179815657;
        Thu, 25 Apr 2019 01:10:15 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id z14sm28818090wro.81.2019.04.25.01.10.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 01:10:15 -0700 (PDT)
Date:   Thu, 25 Apr 2019 10:10:12 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Juergen Gross <jgross@suse.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH] x86/paravirt: Match paravirt patchlet field definition
 ordering to initialization ordering
Message-ID: <20190425081012.GA115378@gmail.com>
References: <20190424134115.091452807@linutronix.de>
 <20190424134223.690835713@linutronix.de>
 <20190425065209.GA89582@gmail.com>
 <alpine.DEB.2.21.1904250921010.1762@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1904250921010.1762@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> On Thu, 25 Apr 2019, Ingo Molnar wrote:
> > > +# else
> > > +	.irq_restore_fl		= { 0x50, 0x9d },	// push %eax; popf
> > > +	.mmu_write_cr3		= { 0x0f, 0x22, 0xd8 },	// mov %eax, %cr3
> > > +	.cpu_iret		= { 0xcf },		// iret
> > > +# endif
> > 
> > I think these open-coded hexa versions are somewhat fragile as well, how 
> > about putting these into a .S file and controlling the sections in an LTO 
> > safe manner there?
> > 
> > That will also allow us to write proper asm, and global labels can be 
> > used to extract the patchlets and their length?
> 
> We are not changing these any other day and I really don't see a reason to
> have these things global just because.

Firstly, I'm not sure I understand the objection to using symbols: in an 
average distro kernel we have more than 75,000 symbols - as long as the 
namespace is clear they are there to be used, there's nothing wrong with 
them per se.

Secondly, my main point is that putting these code patching sequences 
into the .S it's easy to verify that the instructions and patchlets are 
what we claim them to be.

Right now they are randomly ordered data tables that don't match to the 
source code.

I know, because I tried. :-)

Here's the objdump -D output of the PATCH_XXL data table:

0000000000000010 <patch_data_xxl>:
  10:   fa                      cli    
  11:   fb                      sti    
  12:   57                      push   %rdi
  13:   9d                      popfq  
  14:   9c                      pushfq 
  15:   58                      pop    %rax
  16:   0f 20 d0                mov    %cr2,%rax
  19:   0f 20 d8                mov    %cr3,%rax
  1c:   0f 22 df                mov    %rdi,%cr3
  1f:   0f 09                   wbinvd 
  21:   0f 01 f8                swapgs 
  24:   48 0f 07                sysretq 
  27:   0f 01 f8                swapgs 
  2a:   48 89 f8                mov    %rdi,%rax

Note how this doesn't match up to the source code:

static const struct patch_xxl patch_data_xxl = {
        .irq_irq_disable        = { 0xfa },             // cli
        .irq_irq_enable         = { 0xfb },             // sti
        .irq_save_fl            = { 0x9c, 0x58 },       // pushf; pop %[re]ax
        .mmu_read_cr2           = { 0x0f, 0x20, 0xd0 }, // mov %cr2, %[re]ax
        .mmu_read_cr3           = { 0x0f, 0x20, 0xd8 }, // mov %cr3, %[re]ax
# ifdef CONFIG_X86_64
        .irq_restore_fl         = { 0x57, 0x9d },       // push %rdi; popfq
        .mmu_write_cr3          = { 0x0f, 0x22, 0xdf }, // mov %rdi, %cr3
        .cpu_wbinvd             = { 0x0f, 0x09 },       // wbinvd
        .cpu_usergs_sysret64    = { 0x0f, 0x01, 0xf8,
                                    0x48, 0x0f, 0x07 }, // swapgs; sysretq
        .cpu_swapgs             = { 0x0f, 0x01, 0xf8 }, // swapgs
        .mov64                  = { 0x48, 0x89, 0xf8 }, // mov %rdi, %rax
# else
        .irq_restore_fl         = { 0x50, 0x9d },       // push %eax; popf
        .mmu_write_cr3          = { 0x0f, 0x22, 0xd8 }, // mov %eax, %cr3
        .cpu_iret               = { 0xcf },             // iret
# endif
};

Note how they are reordered: in the generated code .irq_restore_fl comes 
before .irq_save_fl, etc. This is because the field ordering in struct 
patch_xxl does not match the initialization ordering of patch_data_xxl.

Third, beyond readability there's another advantage of my suggested 
approach as well: for example that way we could verify the passed in 
length with the patchlet length. Right now it's completely unverified:

        case PARAVIRT_PATCH(ops.m):                                     \
                return PATCH(data, ops##_##m, ibuf, len)

right now we don't check whether the 'len' passed in by the usage site 
matches the actual structure field length.

Although maybe we could do that with your C space structure as well.

Anyway, no strong feelings and I didn't want to create extra work for you 
- but I think at minimum we should do the patch below, which matches up 
the initialization order with the definition order - this at least makes 
the disassembly reviewable:

0000000000000010 <patch_data_xxl>:
  10:   fa                      cli    
  11:   fb                      sti    
  12:   9c                      pushfq 
  13:   58                      pop    %rax
  14:   0f 20 d0                mov    %cr2,%rax
  17:   0f 20 d8                mov    %cr3,%rax
  1a:   0f 22 df                mov    %rdi,%cr3
  1d:   57                      push   %rdi
  1e:   9d                      popfq  
  1f:   0f 09                   wbinvd 
  21:   0f 01 f8                swapgs 
  24:   48 0f 07                sysretq 
  27:   0f 01 f8                swapgs 
  2a:   48 89 f8                mov    %rdi,%rax

And yes, with that applied it verifies 100%. :-)

Thanks,

	Ingo

Signed-off-by: Ingo Molnar <mingo@kernel.org>

--- tip.orig/arch/x86/kernel/paravirt_patch.c
+++ tip/arch/x86/kernel/paravirt_patch.c
@@ -21,11 +21,11 @@
 struct patch_xxl {
 	const unsigned char	irq_irq_disable[1];
 	const unsigned char	irq_irq_enable[1];
-	const unsigned char	irq_restore_fl[2];
 	const unsigned char	irq_save_fl[2];
 	const unsigned char	mmu_read_cr2[3];
 	const unsigned char	mmu_read_cr3[3];
 	const unsigned char	mmu_write_cr3[3];
+	const unsigned char	irq_restore_fl[2];
 # ifdef CONFIG_X86_64
 	const unsigned char	cpu_wbinvd[2];
 	const unsigned char	cpu_usergs_sysret64[6];
@@ -43,16 +43,16 @@ static const struct patch_xxl patch_data
 	.mmu_read_cr2		= { 0x0f, 0x20, 0xd0 },	// mov %cr2, %[re]ax
 	.mmu_read_cr3		= { 0x0f, 0x20, 0xd8 },	// mov %cr3, %[re]ax
 # ifdef CONFIG_X86_64
-	.irq_restore_fl		= { 0x57, 0x9d },	// push %rdi; popfq
 	.mmu_write_cr3		= { 0x0f, 0x22, 0xdf },	// mov %rdi, %cr3
+	.irq_restore_fl		= { 0x57, 0x9d },	// push %rdi; popfq
 	.cpu_wbinvd		= { 0x0f, 0x09 },	// wbinvd
 	.cpu_usergs_sysret64	= { 0x0f, 0x01, 0xf8,
 				    0x48, 0x0f, 0x07 },	// swapgs; sysretq
 	.cpu_swapgs		= { 0x0f, 0x01, 0xf8 },	// swapgs
 	.mov64			= { 0x48, 0x89, 0xf8 },	// mov %rdi, %rax
 # else
-	.irq_restore_fl		= { 0x50, 0x9d },	// push %eax; popf
 	.mmu_write_cr3		= { 0x0f, 0x22, 0xd8 },	// mov %eax, %cr3
+	.irq_restore_fl		= { 0x50, 0x9d },	// push %eax; popf
 	.cpu_iret		= { 0xcf },		// iret
 # endif
 };
