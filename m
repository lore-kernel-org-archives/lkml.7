Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CCDDC742A2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 00:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EC0F208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 00:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbfGLAmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 20:42:50 -0400
Received: from mga03.intel.com ([134.134.136.65]:7091 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbfGLAmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 20:42:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jul 2019 17:42:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,480,1557212400"; 
   d="scan'208";a="174309127"
Received: from txu2-mobl.ccr.corp.intel.com (HELO [10.239.196.126]) ([10.239.196.126])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Jul 2019 17:42:45 -0700
Subject: Re: [PATCH v6 2/3] KVM: vmx: Emulate MSR IA32_UMWAIT_CONTROL
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     rkrcmar@redhat.com, corbet@lwn.net, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        sean.j.christopherson@intel.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, fenghua.yu@intel.com,
        xiaoyao.li@linux.intel.com, jingqi.liu@intel.com
References: <20190621055747.17060-1-tao3.xu@intel.com>
 <20190621055747.17060-3-tao3.xu@intel.com>
 <43814a5e-12bf-ceb5-e4fb-12bbb32cd4cb@redhat.com>
From:   Tao Xu <tao3.xu@intel.com>
Message-ID: <fcae19b2-e37e-1a39-1569-f514631913b1@intel.com>
Date:   Fri, 12 Jul 2019 08:42:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <43814a5e-12bf-ceb5-e4fb-12bbb32cd4cb@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/11/2019 9:25 PM, Paolo Bonzini wrote:
> On 21/06/19 07:57, Tao Xu wrote:
>> +	if (guest_cpuid_has(vcpu, X86_FEATURE_WAITPKG))
>> +		atomic_switch_umwait_control_msr(vmx);
>> +
> 
> guest_cpuid_has is slow.  Please replace it with a test on
> secondary_exec_controls_get(vmx).

Thank you paolo, I will improve it.

> 
> Are you going to look into nested virtualization support?  This should
> include only 1) allowing setting the enable bit in secondary execution
> controls, and passing it through in prepare_vmcs02_early; 2) reflecting
> the vmexit in nested_vmx_exit_reflected.
> 

I will add nested support in next version.

> Thanks,
> 
> Paolo
> 

