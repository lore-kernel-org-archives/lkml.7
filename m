Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B915FC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90D86218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730185AbfDYHWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 03:22:52 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:56586 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727435AbfDYHWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 03:22:52 -0400
Received: from p5de0b374.dip0.t-ipconnect.de ([93.224.179.116] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hJYiW-0006jn-N6; Thu, 25 Apr 2019 09:22:48 +0200
Date:   Thu, 25 Apr 2019 09:22:48 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ingo Molnar <mingo@kernel.org>
cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Juergen Gross <jgross@suse.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [patch 3/3] x86/paravirt: Replace paravirt patch asm magic
In-Reply-To: <20190425065209.GA89582@gmail.com>
Message-ID: <alpine.DEB.2.21.1904250921010.1762@nanos.tec.linutronix.de>
References: <20190424134115.091452807@linutronix.de> <20190424134223.690835713@linutronix.de> <20190425065209.GA89582@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Apr 2019, Ingo Molnar wrote:
> > +# else
> > +	.irq_restore_fl		= { 0x50, 0x9d },	// push %eax; popf
> > +	.mmu_write_cr3		= { 0x0f, 0x22, 0xd8 },	// mov %eax, %cr3
> > +	.cpu_iret		= { 0xcf },		// iret
> > +# endif
> 
> I think these open-coded hexa versions are somewhat fragile as well, how 
> about putting these into a .S file and controlling the sections in an LTO 
> safe manner there?
> 
> That will also allow us to write proper asm, and global labels can be 
> used to extract the patchlets and their length?

We are not changing these any other day and I really don't see a reason to
have these things global just because.

Thanks,

	tglx
