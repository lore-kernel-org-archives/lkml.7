Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58511C282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 19:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3181A2171F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 19:07:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731697AbfDETHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 15:07:31 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49504 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731183AbfDETHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 15:07:31 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hCUBV-0002xD-C9; Fri, 05 Apr 2019 21:07:29 +0200
Date:   Fri, 5 Apr 2019 21:07:28 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Zhao Yakui <yakui.zhao@intel.com>
cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Jason Chen CJ <jason.cj.chen@intel.com>
Subject: Re: [RFC PATCH v2 2/3] arch/x86/acrn: Use HYPERVISOR_CALLBACK_VECTOR
 for Acrn upcall vector
In-Reply-To: <1553576023-6434-3-git-send-email-yakui.zhao@intel.com>
Message-ID: <alpine.DEB.2.21.1904052101270.1802@nanos.tec.linutronix.de>
References: <1553576023-6434-1-git-send-email-yakui.zhao@intel.com> <1553576023-6434-3-git-send-email-yakui.zhao@intel.com>
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
> diff --git a/arch/x86/include/asm/hardirq.h b/arch/x86/include/asm/hardirq.h
> index d9069bb..a8f4d08 100644
> --- a/arch/x86/include/asm/hardirq.h
> +++ b/arch/x86/include/asm/hardirq.h
> @@ -37,7 +37,8 @@ typedef struct {
>  #ifdef CONFIG_X86_MCE_AMD
>  	unsigned int irq_deferred_error_count;
>  #endif
> -#if IS_ENABLED(CONFIG_HYPERV) || defined(CONFIG_XEN)
> +#if IS_ENABLED(CONFIG_HYPERV) || defined(CONFIG_XEN) ||\
> +		defined(CONFIG_ACRN_GUEST)

..

> @@ -134,7 +134,8 @@ int arch_show_interrupts(struct seq_file *p, int prec)
>  		seq_printf(p, "%10u ", per_cpu(mce_poll_count, j));
>  	seq_puts(p, "  Machine check polls\n");
>  #endif
> -#if IS_ENABLED(CONFIG_HYPERV) || defined(CONFIG_XEN)
> +#if IS_ENABLED(CONFIG_HYPERV) || defined(CONFIG_XEN) ||\
> +		defined(CONFIG_ACRN_GUEST)
>  	if (test_bit(HYPERVISOR_CALLBACK_VECTOR, system_vectors)) {
>  		seq_printf(p, "%*s: ", prec, "HYP");
>  		for_each_online_cpu(j)

This starts to become unreadable. Please create a new config symbol:

     config X86_HV_CALLBACK_VECTOR
     	def_bool

and select if from HYPERV, XEN and your new thing. That wants to be a
separate preparatory patch at the beginning of the series please.

Thanks,

	tglx
