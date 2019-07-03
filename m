Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32684C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 20:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15F6E218B6
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 20:34:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbfGCUej (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 16:34:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56122 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbfGCUeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 16:34:36 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hilxa-0008FU-Gu; Wed, 03 Jul 2019 22:34:34 +0200
Date:   Wed, 3 Jul 2019 22:34:33 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Nadav Amit <namit@vmware.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Feng Tang <feng.tang@intel.com>
Subject: Re: [patch 16/18] x86/apic: Convert 32bit to IPI shorthand static
 key
In-Reply-To: <1DC35A28-DEBC-4A46-AC35-3AADD23AA40D@vmware.com>
Message-ID: <alpine.DEB.2.21.1907032213250.1802@nanos.tec.linutronix.de>
References: <20190703105431.096822793@linutronix.de> <20190703105917.044463061@linutronix.de> <1DC35A28-DEBC-4A46-AC35-3AADD23AA40D@vmware.com>
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

Nadav,

On Wed, 3 Jul 2019, Nadav Amit wrote:
> > On Jul 3, 2019, at 3:54 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > void default_send_IPI_all(int vector)
> > {
> > -	if (apic_ipi_shorthand_off || vector == NMI_VECTOR) {
> > +	if (static_branch_likely(&apic_use_ipi_shorthand)) {
> > 		apic->send_IPI_mask(cpu_online_mask, vector);
> > 	} else {
> > 		__default_send_IPI_shortcut(APIC_DEST_ALLINC, vector);
> 
> It may be better to check the static-key in native_send_call_func_ipi() (and
> other callers if there are any), and remove all the other checks in
> default_send_IPI_all(), x2apic_send_IPI_mask_allbutself(), etc.

That makes sense. Should have thought about that myself, but hunting that
APIC emulation issue was affecting my brain obviously :)
 
>  void native_send_call_func_ipi(const struct cpumask *mask)
>  {
> -	cpumask_var_t allbutself;
> -
> -	if (!alloc_cpumask_var(&allbutself, GFP_ATOMIC)) {
> -		apic->send_IPI_mask(mask, CALL_FUNCTION_VECTOR);
> -		return;
> +	int cpu, this_cpu = smp_processor_id();
> +	bool allbutself = true;
> +	bool self = false;
> +
> +	for_each_cpu_and_not(cpu, cpu_online_mask, mask) {
> +
> +		if (cpu != this_cpu) {
> +			allbutself = false;
> +			break;
> +		}
> +		self = true;

That accumulates to a large iteration in the worst case. 

>  	}
>  
> -	cpumask_copy(allbutself, cpu_online_mask);
> -	__cpumask_clear_cpu(smp_processor_id(), allbutself);
> -
> -	if (cpumask_equal(mask, allbutself) &&
> +	if (allbutself && !self &&
>  	    cpumask_equal(cpu_online_mask, cpu_callout_mask))

Hmm. I overlooked that one. Need to take a deeper look.

>  		apic->send_IPI_allbutself(CALL_FUNCTION_VECTOR);
>  	else
>  		apic->send_IPI_mask(mask, CALL_FUNCTION_VECTOR);

Let me think about it for a while.

Thanks,

	tglx
