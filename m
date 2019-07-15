Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07148C73C66
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 01:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D055120820
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 01:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbfGOBLg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 21:11:36 -0400
Received: from mga04.intel.com ([192.55.52.120]:47392 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726916AbfGOBLg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 21:11:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jul 2019 18:11:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,492,1557212400"; 
   d="scan'208";a="160944974"
Received: from txu2-mobl.ccr.corp.intel.com (HELO [10.239.196.203]) ([10.239.196.203])
  by orsmga008.jf.intel.com with ESMTP; 14 Jul 2019 18:11:32 -0700
Subject: Re: [PATCH v7 1/3] KVM: x86: add support for user wait instructions
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     pbonzini@redhat.com, rkrcmar@redhat.com, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        fenghua.yu@intel.com, xiaoyao.li@linux.intel.com,
        jingqi.liu@intel.com
References: <20190712082907.29137-1-tao3.xu@intel.com>
 <20190712082907.29137-2-tao3.xu@intel.com>
 <20190712151300.GB29659@linux.intel.com>
From:   Tao Xu <tao3.xu@intel.com>
Message-ID: <72e39861-7af4-057c-f879-4cc5a363e3e4@intel.com>
Date:   Mon, 15 Jul 2019 09:11:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190712151300.GB29659@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/12/2019 11:13 PM, Sean Christopherson wrote:
> On Fri, Jul 12, 2019 at 04:29:05PM +0800, Tao Xu wrote:
>> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
>> index 46af3a5e9209..a4d5da34b306 100644
>> --- a/arch/x86/kvm/vmx/nested.c
>> +++ b/arch/x86/kvm/vmx/nested.c
>> @@ -2048,6 +2048,7 @@ static void prepare_vmcs02_early(struct vcpu_vmx *vmx, struct vmcs12 *vmcs12)
>>   				  SECONDARY_EXEC_ENABLE_INVPCID |
>>   				  SECONDARY_EXEC_RDTSCP |
>>   				  SECONDARY_EXEC_XSAVES |
>> +				  SECONDARY_EXEC_ENABLE_USR_WAIT_PAUSE |
>>   				  SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY |
>>   				  SECONDARY_EXEC_APIC_REGISTER_VIRT |
>>   				  SECONDARY_EXEC_ENABLE_VMFUNC);
>> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
>> index d98eac371c0a..f411c9ae5589 100644
>> --- a/arch/x86/kvm/vmx/vmx.c
>> +++ b/arch/x86/kvm/vmx/vmx.c
>> @@ -2247,6 +2247,7 @@ static __init int setup_vmcs_config(struct vmcs_config *vmcs_conf,
>>   			SECONDARY_EXEC_RDRAND_EXITING |
>>   			SECONDARY_EXEC_ENABLE_PML |
>>   			SECONDARY_EXEC_TSC_SCALING |
>> +			SECONDARY_EXEC_ENABLE_USR_WAIT_PAUSE |
>>   			SECONDARY_EXEC_PT_USE_GPA |
>>   			SECONDARY_EXEC_PT_CONCEAL_VMX |
>>   			SECONDARY_EXEC_ENABLE_VMFUNC |
>> @@ -3984,6 +3985,25 @@ static void vmx_compute_secondary_exec_control(struct vcpu_vmx *vmx)
>>   		}
>>   	}
>>   
>> +	if (vmcs_config.cpu_based_2nd_exec_ctrl &
>> +		SECONDARY_EXEC_ENABLE_USR_WAIT_PAUSE) {
> 
> This should be aligned with the beginning of the conditional.
> Alternatively, add a vmx_waitpkg_supported() helper, which is fairly
> ubiquitous even when there is only a single call site.
> 

OK, Thank you for your suggestion.
>> +		/* Exposing WAITPKG only when WAITPKG is exposed */
> No need for this comment.  It's also oddly worded, e.g. the second
> "exposed" should probably be "enabled"?
> 
>> +		bool waitpkg_enabled =
>> +			guest_cpuid_has(vcpu, X86_FEATURE_WAITPKG);
>> +
>> +		if (!waitpkg_enabled)
>> +			exec_control &= ~SECONDARY_EXEC_ENABLE_USR_WAIT_PAUSE;
>> +
>> +		if (nested) {
>> +			if (waitpkg_enabled)
>> +				vmx->nested.msrs.secondary_ctls_high |=
>> +					SECONDARY_EXEC_ENABLE_USR_WAIT_PAUSE;
>> +			else
>> +				vmx->nested.msrs.secondary_ctls_high &=
>> +					~SECONDARY_EXEC_ENABLE_USR_WAIT_PAUSE;
>> +		}
>> +	}
>> +
>>   	vmx->secondary_exec_control = exec_control;
>>   }
>>   
>> -- 
>> 2.20.1
>>

