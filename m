Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 897C2C7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 16:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5562920880
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 16:04:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731129AbfGPQEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 12:04:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:11647 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728121AbfGPQEB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 12:04:01 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A00283082A9C;
        Tue, 16 Jul 2019 16:04:00 +0000 (UTC)
Received: from localhost (ovpn-116-109.gru2.redhat.com [10.97.116.109])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0EC3119D7D;
        Tue, 16 Jul 2019 16:03:59 +0000 (UTC)
Date:   Tue, 16 Jul 2019 13:03:58 -0300
From:   Eduardo Habkost <ehabkost@redhat.com>
To:     Tao Xu <tao3.xu@intel.com>
Cc:     pbonzini@redhat.com, rkrcmar@redhat.com, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        sean.j.christopherson@intel.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, fenghua.yu@intel.com,
        xiaoyao.li@linux.intel.com, jingqi.liu@intel.com
Subject: Re: [PATCH v7 2/3] KVM: vmx: Emulate MSR IA32_UMWAIT_CONTROL
Message-ID: <20190716160358.GE26800@habkost.net>
References: <20190712082907.29137-1-tao3.xu@intel.com>
 <20190712082907.29137-3-tao3.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190712082907.29137-3-tao3.xu@intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Tue, 16 Jul 2019 16:04:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 04:29:06PM +0800, Tao Xu wrote:
> UMWAIT and TPAUSE instructions use IA32_UMWAIT_CONTROL at MSR index E1H
> to determines the maximum time in TSC-quanta that the processor can reside
> in either C0.1 or C0.2.
> 
> This patch emulates MSR IA32_UMWAIT_CONTROL in guest and differentiate
> IA32_UMWAIT_CONTROL between host and guest. The variable
> mwait_control_cached in arch/x86/power/umwait.c caches the MSR value, so
> this patch uses it to avoid frequently rdmsr of IA32_UMWAIT_CONTROL.
> 
> Co-developed-by: Jingqi Liu <jingqi.liu@intel.com>
> Signed-off-by: Jingqi Liu <jingqi.liu@intel.com>
> Signed-off-by: Tao Xu <tao3.xu@intel.com>
> ---
[...]
> +static void atomic_switch_umwait_control_msr(struct vcpu_vmx *vmx)
> +{
> +	if (!vmx_has_waitpkg(vmx))
> +		return;
> +
> +	if (vmx->msr_ia32_umwait_control != umwait_control_cached)
> +		add_atomic_switch_msr(vmx, MSR_IA32_UMWAIT_CONTROL,
> +			vmx->msr_ia32_umwait_control,
> +			umwait_control_cached, false);

How exactly do we ensure NR_AUTOLOAD_MSRS (8) is still large enough?

I see 3 existing add_atomic_switch_msr() calls, but the one at
atomic_switch_perf_msrs() is in a loop.  Are we absolutely sure
that perf_guest_get_msrs() will never return more than 5 MSRs?


> +	else
> +		clear_atomic_switch_msr(vmx, MSR_IA32_UMWAIT_CONTROL);
> +}
> +
>  static void vmx_arm_hv_timer(struct vcpu_vmx *vmx, u32 val)
>  {
>  	vmcs_write32(VMX_PREEMPTION_TIMER_VALUE, val);
[...]


-- 
Eduardo
