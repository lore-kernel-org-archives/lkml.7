Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C3E5C282E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 21:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFB02217FA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 21:26:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbfDSV04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 17:26:56 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:42520 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfDSV04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 17:26:56 -0400
Received: from pd9ef12d2.dip0.t-ipconnect.de ([217.239.18.210] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hHb23-0001JB-Ca; Fri, 19 Apr 2019 23:26:51 +0200
Date:   Fri, 19 Apr 2019 23:26:50 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andi Kleen <andi@firstfloor.org>
cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v2 3/9] x86/paravirt: Replace paravirt patches with
 data
In-Reply-To: <20190330004743.29541-3-andi@firstfloor.org>
Message-ID: <alpine.DEB.2.21.1904192306120.3174@nanos.tec.linutronix.de>
References: <20190330004743.29541-1-andi@firstfloor.org> <20190330004743.29541-3-andi@firstfloor.org>
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

On Fri, 29 Mar 2019, Andi Kleen wrote:
> For LTO all top level assembler statements need to be global because
> LTO might put it into a different assembler file than the referencing
> C code.
> 
> To avoid making all the paravirt patch snippets global replace them
> with data containing the patch instructions. Since these are unlikely
> to change this shouldn't be a significant maintenance burden.

s/with data containing/with unparseable, inconsistent and broken mess/

Unparseable:
------------

> +static const unsigned char patch_irq_save_fl[] = { 0x9c, 0x58 };  	/* pushf; pop %eax */
> +static const unsigned char patch_cpu_iret[] = { 0xcf };		  	/* iret */
> +static const unsigned char patch_mmu_read_cr2[] = { 0x0f, 0x20, 0xd0 }; /* mov %cr2, %eax */
> +static const unsigned char patch_mmu_write_cr3[] = { 0x0f, 0x22, 0xd8 };/* mov %eax, %cr3 */
> +static const unsigned char patch_mmu_read_cr3[] = { 0x0f, 0x20, 0xd8 }; /* mov %cr3, %eax */

  Overlong lines, spaces and tabs mixed, no formatting which allows easy
  reading and review.

Inconsistent and unparseable:
-----------------------------

>  #define PATCH_SITE(ops, x)					\
>  	case PARAVIRT_PATCH(ops.x):				\
> -		return paravirt_patch_insns(ibuf, len, start_##ops##_##x, end_##ops##_##x)
> +		return paravirt_patch_insns(ibuf, len, 		\
> +				patch_##ops##_##x, patch_##ops##_##x+sizeof(patch_##ops##_x));

vs.

> +		return paravirt_patch_insns(ibuf, len, start_##ops##_##x, \
> +				patch_##ops##_##x + sizeof(patch_##ops##_##x));

Broken:
-------

> +static const unsigned char patch_irq_restore_fl[] =  { 0x50, 0x9d};		/* pushq %rdi; popfq */

Can you spot the fail?

That probably works because Intel CPUs are so good at executing crappy
code, right? That's at least what you told me recently. If that's the proof
then I should really stop reviewing patches.

Thanks,

	tglx




