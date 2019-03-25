Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9FEC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 08:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 580222085A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 08:27:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730006AbfCYI1s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 04:27:48 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:44967 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729920AbfCYI1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 04:27:47 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h8KxJ-000582-Md; Mon, 25 Mar 2019 09:27:41 +0100
Date:   Mon, 25 Mar 2019 09:27:41 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Zhao, Yakui" <yakui.zhao@intel.com>
cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Chen, Jason CJ" <jason.cj.chen@intel.com>
Subject: RE: [RFC PATCH 2/3] arch/x86/acrn: Use HYPERVISOR_CALLBACK_VECTOR
 for Acrn upcall vector
In-Reply-To: <01363028D91B0B448414F51B4258CAA574CD3920@SHSMSX101.ccr.corp.intel.com>
Message-ID: <alpine.DEB.2.21.1903250925130.1798@nanos.tec.linutronix.de>
References: <1551924251-19466-1-git-send-email-yakui.zhao@intel.com> <1551924251-19466-3-git-send-email-yakui.zhao@intel.com> <alpine.DEB.2.21.1903221620150.1729@nanos.tec.linutronix.de>
 <01363028D91B0B448414F51B4258CAA574CD3920@SHSMSX101.ccr.corp.intel.com>
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

On Mon, 25 Mar 2019, Zhao, Yakui wrote:
> >> +/* SPDX-License-Identifier: GPL-2.0 */ #ifndef _ASM_X86_ACRNHYPER_H
> >> +#define _ASM_X86_ACRNHYPER_H
> >> +
> >> +#include <linux/types.h>
> >> +#include <asm/io.h>
> >> +
> >> +#ifdef CONFIG_ACRN
> >> +/* ACRN Hypervisor callback */
> >> +void acrn_hv_callback_vector(void);
> >
> >What declares acrn_hv_vector_handler() ?
> 
> Acrn_hv_callback_vector is defined in arch/x86/entry/entry_64.S, which will be used as
> the parameter of alloc_intr_gate
> 
> Acrn_hv_vector_handler is the real ISR handler, which is defined in acrn.c.

I know how that works and I was not asking where stuff is defined. I was
asking where it is declared. Global functions need a declaration in a
header file.

> >> +void acrn_remove_intr_irq(void)
> >> +{
> >> +	acrn_intr_handler = NULL;
> >> +}
> >> +EXPORT_SYMBOL(acrn_remove_intr_irq);
> >
> >Where is the code which uses these exports? We are not adding exports just
> >because or for consumption by out of tree modules.
> 
> Understand it.
> Is it reasonable that the above two functions are added in the driver patch set?

Yes, because then we see the context.

Thanks,

	tglx
