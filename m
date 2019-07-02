Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36163C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 16:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1361821479
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 16:37:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfGBQh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 12:37:56 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41375 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfGBQhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 12:37:55 -0400
Received: by mail-wr1-f68.google.com with SMTP id c2so18606838wrm.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 09:37:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cORuISKlF1zQhJ8JGiqwg5jMPZztaSacWdmpxJhXPOM=;
        b=oQhjVLO+kkCKaAQ8hR2Y1H8gmzpI/e8foQM4re2ayrof7ikRepO1KmmA9CDV0W26u6
         8iGiExZhuPAkucWLwfwz9Rrivt3sf7kcUmXYIXMi9nQgzDMGsrCditOHksr707wL3CB8
         4ahzg/dNRx12Km/e5WiL+d8opNqbNYHvMu8v6Eqaj0/3IOOo5no4xUtJAhzyK1ilMGTm
         mnarflWBxWQSGL3rALLFyMwXA8xqCynTjMaN6ylBrvh8BZcSBJQ9Xe/LHI7ckb8JTVWW
         HyOva27iPOtbmwkKV3NNX6NTApOySfuCJJ2RAwy/3xN49DFcG7lht+SoQbSctDyGLkJg
         pvzw==
X-Gm-Message-State: APjAAAX0RJnLBUdtdLbMhugXKLHU6rOaTYVe0yADd+yYzdoWLNcrFtV7
        c1OIO3hfvLatOLvJ7gI1hgo7Sg==
X-Google-Smtp-Source: APXvYqwEsF1sxV23mbMbJoUyCSlNSxgo8hrA7zmVK0nJSXXIRzeIu9FxMTqD9S/aOoxK2t6+RLvGaA==
X-Received: by 2002:adf:c541:: with SMTP id s1mr23841350wrf.44.1562085473999;
        Tue, 02 Jul 2019 09:37:53 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b8:794:183e:9e2a? ([2001:b07:6468:f312:b8:794:183e:9e2a])
        by smtp.gmail.com with ESMTPSA id g5sm15256894wrp.29.2019.07.02.09.37.52
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 09:37:53 -0700 (PDT)
Subject: Re: [PATCH v5 2/3] KVM: vmx: Emulate MSR IA32_UMWAIT_CONTROL
To:     Xiaoyao Li <xiaoyao.li@linux.intel.com>,
        Tao Xu <tao3.xu@intel.com>, rkrcmar@redhat.com, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        sean.j.christopherson@intel.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        fenghua.yu@intel.com, jingqi.liu@intel.com
References: <20190620084620.17974-1-tao3.xu@intel.com>
 <20190620084620.17974-3-tao3.xu@intel.com>
 <b2cfa1d015315c74af6cee1c00185e5c68cfa397.camel@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <22533924-f7e8-4b50-d5fe-7cbcc9295b53@redhat.com>
Date:   Tue, 2 Jul 2019 18:37:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <b2cfa1d015315c74af6cee1c00185e5c68cfa397.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/06/19 11:46, Xiaoyao Li wrote:
> You cannot put the atomic switch here. What if umwait_control_cached is changed
> at runtime? Host kernel patch exposed a sysfs interface to let it happen.

Thanks for the review, Xiaoyao.  I agree with both of your remarks.

Paolo

>> +		break;
>>  	case MSR_IA32_SPEC_CTRL:
>>  		if (!msr_info->host_initiated &&
>>  		    !guest_cpuid_has(vcpu, X86_FEATURE_SPEC_CTRL))
>> @@ -4126,6 +4148,8 @@ static void vmx_vcpu_reset(struct kvm_vcpu *vcpu, bool
>> init_event)
>>  	vmx->rmode.vm86_active = 0;
>>  	vmx->spec_ctrl = 0;
>>  
>> +	vmx->msr_ia32_umwait_control = 0;
>> +
>>  	vcpu->arch.microcode_version = 0x100000000ULL;
>>  	vmx->vcpu.arch.regs[VCPU_REGS_RDX] = get_rdx_init_val();
>>  	kvm_set_cr8(vcpu, 0);
>> diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
>> index 61128b48c503..8485bec7c38a 100644
>> --- a/arch/x86/kvm/vmx/vmx.h
>> +++ b/arch/x86/kvm/vmx/vmx.h
>> @@ -14,6 +14,8 @@
>>  extern const u32 vmx_msr_index[];
>>  extern u64 host_efer;
>>  
>> +extern u32 umwait_control_cached;
>> +
>>  #define MSR_TYPE_R	1
>>  #define MSR_TYPE_W	2
>>  #define MSR_TYPE_RW	3
>> @@ -194,6 +196,7 @@ struct vcpu_vmx {
>>  #endif
>>  
>>  	u64		      spec_ctrl;
>> +	u64		      msr_ia32_umwait_control;
>>  
>>  	u32 vm_entry_controls_shadow;
>>  	u32 vm_exit_controls_shadow;
>> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>> index 83aefd759846..4480de459bf4 100644
>> --- a/arch/x86/kvm/x86.c
>> +++ b/arch/x86/kvm/x86.c
>> @@ -1138,6 +1138,7 @@ static u32 msrs_to_save[] = {
>>  	MSR_IA32_RTIT_ADDR1_A, MSR_IA32_RTIT_ADDR1_B,
>>  	MSR_IA32_RTIT_ADDR2_A, MSR_IA32_RTIT_ADDR2_B,
>>  	MSR_IA32_RTIT_ADDR3_A, MSR_IA32_RTIT_ADDR3_B,
>> +	MSR_IA32_UMWAIT_CONTROL,
>>  };
>>  
>>  static unsigned num_msrs_to_save;
> 

