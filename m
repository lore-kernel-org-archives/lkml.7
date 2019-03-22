Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB47C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0545521900
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:01:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729064AbfCVQBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 12:01:54 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:41382 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728176AbfCVQBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 12:01:54 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h7McB-0005P9-J1; Fri, 22 Mar 2019 17:01:51 +0100
Date:   Fri, 22 Mar 2019 17:01:51 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Zhao Yakui <yakui.zhao@intel.com>
cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Jason Chen CJ <jason.cj.chen@intel.com>
Subject: Re: [RFC PATCH 3/3] arch/x86/acrn: add hypercall for
 acrn_hypervisor
In-Reply-To: <1551924251-19466-4-git-send-email-yakui.zhao@intel.com>
Message-ID: <alpine.DEB.2.21.1903221644530.1729@nanos.tec.linutronix.de>
References: <1551924251-19466-1-git-send-email-yakui.zhao@intel.com> <1551924251-19466-4-git-send-email-yakui.zhao@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Mar 2019, Zhao Yakui wrote:

> When acrn_hypervisor is detected, the other module may communicate with

Which other module?

> the hypervisor to query/config some settings. For example: it can be used
> to query the resources in hypervisor and manage the CPU/memory/device/
> interrupt for Guest system.
 
> +++ b/arch/x86/include/asm/acrn_hypercall.h
> @@ -0,0 +1,85 @@
> +/* SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause */

So the hypercall header is GPL-2.0+ and the acrn.c file is GPL-2.0. Not
that I personally care, but is this intended?

> +/*
> + * acrn_hypercall.h : acrn hypervisor call API
> + */
> +
> +#ifndef __ACRN_HYPERCALL_H__
> +#define __ACRN_HYPERCALL_H__
> +
> +#include <linux/errno.h>
> +
> +#ifdef CONFIG_ACRN
> +
> +static inline long acrn_hypercall0(unsigned long hcall_id)
> +{
> +
> +	/* x86-64 System V ABI register usage */

Well, yes. But can you please provide a link to the hypercall specification
in the changelog?

Also instead of repeating the same comment over and over, explain the
calling convention in a top level comment.

> +	register signed long    result asm("rax");
> +	register unsigned long  r8 asm("r8")  = hcall_id;

I appreciate the attempt of making this tabular, but it's unreadable and
has random white space in it. Also please use 'long' and not 'signed long'.

	register unsigned long	r8	asm("r8") = hcall_id;
	register long		result	asm("rax");
	
> +
> +	/* Execute vmcall */
> +	asm volatile(".byte 0x0F,0x01,0xC1\n"
> +			: "=r"(result)
> +			:  "r"(r8));
> +
> +	/* Return result to caller */

Please do not comment the obvious. It's entirely clear that this returns
'result' to the caller. Comments are there to explain what's not obvious.

> +	return result;
> +}

Thanks,

	tglx
