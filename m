Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248F2C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE1D2217FA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:19:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sLoZSC3r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbfDYITg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 04:19:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44402 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbfDYITg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 04:19:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RhfoKhb76TIyHeM5VaQWRBakrv5QI74DngONPZZhv+8=; b=sLoZSC3rt5frxj7EZl681VLmJ
        cZ2mP0CA97Sez5G4e3jlQEu2QOzH4LNPC2L4UTy2dPeSHFUwrRCnLhhS0T9nk5dS1TynJc0ak/zEw
        HYi0kev4GyLJDTtcA1gYZdTwOjiE+X7y2CwkrGm9jS5E1XjW202phfEktFp5NTo24fSuK0KxnRQFC
        cYdyt5onqHf/EWMvh/PT4fXLymesOWG6JII9XoOSE4R/Y+MXek26JunpaC7nSPugv/Wsdp2aG0UvM
        BYJD+FDFV495WVMBSMpOd/fR4kVsbEpwyPXzYyoxZ+Mozdq/vQdwPxGxDyUIIRwjLgdSEsIW1VdQh
        esf/OABVw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJZbR-0007uh-3u; Thu, 25 Apr 2019 08:19:33 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 939D629BA467B; Thu, 25 Apr 2019 10:19:31 +0200 (CEST)
Date:   Thu, 25 Apr 2019 10:19:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Juergen Gross <jgross@suse.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [patch 3/3] x86/paravirt: Replace paravirt patch asm magic
Message-ID: <20190425081931.GA14281@hirez.programming.kicks-ass.net>
References: <20190424134115.091452807@linutronix.de>
 <20190424134223.690835713@linutronix.de>
 <20190425065209.GA89582@gmail.com>
 <20190425080810.GY11158@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190425080810.GY11158@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 10:08:10AM +0200, Peter Zijlstra wrote:
> On Thu, Apr 25, 2019 at 08:52:09AM +0200, Ingo Molnar wrote:
> 
> > > -# ifdef CONFIG_PARAVIRT_XXL
> > > -DEF_NATIVE(irq, irq_disable, "cli");
> > > -DEF_NATIVE(irq, irq_enable, "sti");
> > > -DEF_NATIVE(irq, restore_fl, "push %eax; popf");
> > > -DEF_NATIVE(irq, save_fl, "pushf; pop %eax");
> > > -DEF_NATIVE(cpu, iret, "iret");
> > > -DEF_NATIVE(mmu, read_cr2, "mov %cr2, %eax");
> > > -DEF_NATIVE(mmu, write_cr3, "mov %eax, %cr3");
> > > -DEF_NATIVE(mmu, read_cr3, "mov %cr3, %eax");
> > 
> > > +static const struct patch_xxl patch_data_xxl = {
> > > +	.irq_irq_disable	= { 0xfa },		// cli
> > > +	.irq_irq_enable		= { 0xfb },		// sti
> > > +	.irq_save_fl		= { 0x9c, 0x58 },	// pushf; pop %[re]ax
> > > +	.mmu_read_cr2		= { 0x0f, 0x20, 0xd0 },	// mov %cr2, %[re]ax
> > > +	.mmu_read_cr3		= { 0x0f, 0x20, 0xd8 },	// mov %cr3, %[re]ax
> > > +# ifdef CONFIG_X86_64
> > > +	.irq_restore_fl		= { 0x57, 0x9d },	// push %rdi; popfq
> > > +	.mmu_write_cr3		= { 0x0f, 0x22, 0xdf },	// mov %rdi, %cr3
> > > +	.cpu_wbinvd		= { 0x0f, 0x09 },	// wbinvd
> > > +	.cpu_usergs_sysret64	= { 0x0f, 0x01, 0xf8,
> > > +				    0x48, 0x0f, 0x07 },	// swapgs; sysretq
> > > +	.cpu_swapgs		= { 0x0f, 0x01, 0xf8 },	// swapgs
> > > +	.mov64			= { 0x48, 0x89, 0xf8 },	// mov %rdi, %rax
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
> While I'm not fan either; I think that will be worse still, because it
> splits the information over multiple files.
> 
> The advantage of this form is that it is clear how long the instructions
> are, which is important for the patching. These immediates have to be
> shorter than 5 bytes because they overwrite the CALL/JMP to the paravirt
> function.
> 
> /me eyes .cpu_usergs_sysret64 and goes wtf..

OK, my bad, the indirect CALL/JMP is 6 bytes.. phew.
