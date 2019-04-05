Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 034CEC282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 19:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3B8F21773
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 19:19:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731714AbfDETTe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 15:19:34 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49512 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731183AbfDETTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 15:19:34 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hCUN7-00036a-Ta; Fri, 05 Apr 2019 21:19:30 +0200
Date:   Fri, 5 Apr 2019 21:19:29 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Zhao Yakui <yakui.zhao@intel.com>
cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Jason Chen CJ <jason.cj.chen@intel.com>
Subject: Re: [RFC PATCH v2 3/3] arch/x86/acrn: add hypercall for acrn_guest
In-Reply-To: <1553576023-6434-4-git-send-email-yakui.zhao@intel.com>
Message-ID: <alpine.DEB.2.21.1904052110370.1802@nanos.tec.linutronix.de>
References: <1553576023-6434-1-git-send-email-yakui.zhao@intel.com> <1553576023-6434-4-git-send-email-yakui.zhao@intel.com>
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

On Tue, 26 Mar 2019, Zhao Yakui wrote:

> When acrn_hypervisor is detected, the hypercall is needed so that the
> acrn guest can query/config some settings. For example: it can be used
> to query the resources in hypervisor and manage the CPU/memory/device/
> interrupt for Guest system.
> 
> So the hypercall is added so that the kernel can communicate with the
> low-level acrn-hypervisor. On x86 it is implemented by using vmacll when

is implemented with the VMCALL instruction

> the acrn hypervisor is enabled.
> 
> +++ b/arch/x86/include/asm/acrn_hypercall.h
> @@ -0,0 +1,84 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * acrn_hypercall.h : acrn hypervisor call API

No file names in headers please. They are pointless and get out of sync
when files are renamed.

> + */
> +
> +#ifndef __ACRN_HYPERCALL_H__
> +#define __ACRN_HYPERCALL_H__

asm headers start with

    __ASM_X86_....

> +
> +#include <linux/errno.h>
> +
> +#ifdef CONFIG_ACRN_GUEST
> +
> +/*
> + * Hypercalls for ACRN Guest
> + *
> + * Hypercall number is passed in r8 register.
> + * Return value will be placed in rax.
> + * Up to 2 arguments are passed in rdi, rsi.
> + */
> +
> +static inline long acrn_hypercall0(unsigned long hcall_id)
> +{
> +

Remove the empty new line please.

> +	register long result asm("rax");
> +	register unsigned long r8 asm("r8") = hcall_id;

Please order them the other way around, like a reverse christmas tree:

	register unsigned long r8 asm("r8") = hcall_id;
	register long result asm("rax");

That's way simpler to read.

> +	asm volatile(".byte 0x0F,0x01,0xC1\n"
> +			: "=r"(result)
> +			:  "r"(r8));

Please mention in the changelog why this is implemented with bytes and not
with the proper mnemonic. I assume it depends on binutils, so please
document which version of binutils supports the mnemonic.

And in the first function, i.e. hypercall0, add a comment above the asm
volatile() to that effect as well. 

Thanks,

	tglx
