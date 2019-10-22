Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F9ACA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 13:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E36B620684
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 13:11:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732015AbfJVNLY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 09:11:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60696 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727831AbfJVNLY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 09:11:24 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7A45183F51
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 13:11:23 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id q22so5888491wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 06:11:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=AWIpPvm7UprL2uTNf2oKMNhafTTRgSL5RG8YF9O+sQ0=;
        b=SnBMoz5LrfmyTrFOPlyDJ5HkhfV81rmPNuz/LKNK1yxnBsTEwZUEJvfeiwl3BItSam
         ho5mT08uu9oeyIyfVU4CQueqnW2664X62TDRLAvKz9QSP7KfLWFWJ1+ckr7lDJQYY2aQ
         KJRpTVvogIZgurvi1iQYP5z68s0FVtamhDhh7AQBVECRC1+F2SDPnMRwhn5aRCmZi1UZ
         EDsCfH00YA18oIVmY8rZrEGPEAzBu8bnTheWoQY6u1cxWo6y+rgYveGrOwxRx48h1iIW
         wALlZd4RL97HLLiFoJxgEVUNPIyzE/hQsgZGylJRdJA8wIwDmGE3eZgOyHSIATyV9CGd
         AGcQ==
X-Gm-Message-State: APjAAAXFPqFMmsRDodeJwiih/bH7QShl5X0YsIkWpgqZsXfWxro919cC
        tgEqJ/Vum+U3GflFZ0dKoImgiEkYHB7+dGBUgiSCnf9mUEGK7VlFXS55V2eC1NP47B/PeCgdOJ+
        /eZlOFKjj+x32HlA1nEJmF3co
X-Received: by 2002:a05:6000:118f:: with SMTP id g15mr245426wrx.242.1571749882082;
        Tue, 22 Oct 2019 06:11:22 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzAEy/wjVyqz3gSBY2lKtBGQuAlLyTMHI7PFn5YaAc9NTp8p4NIJGat0PwLnzZzfUSMKXzEJw==
X-Received: by 2002:a05:6000:118f:: with SMTP id g15mr245385wrx.242.1571749881755;
        Tue, 22 Oct 2019 06:11:21 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id c14sm11510623wru.24.2019.10.22.06.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 06:11:21 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com,
        sean.j.christopherson@intel.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, boris.ostrovsky@oracle.com,
        jgross@suse.com, peterz@infradead.org, will@kernel.org,
        linux-hyperv@vger.kernel.org, kvm@vger.kernel.org,
        mikelley@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, sashal@kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v7 3/5] x86/kvm: Add "nopvspin" parameter to disable PV spinlocks
In-Reply-To: <dbc50272-a4f5-ce7c-ba71-75031521f420@oracle.com>
References: <1571649076-2421-1-git-send-email-zhenzhong.duan@oracle.com> <1571649076-2421-4-git-send-email-zhenzhong.duan@oracle.com> <8736fl1071.fsf@vitty.brq.redhat.com> <dbc50272-a4f5-ce7c-ba71-75031521f420@oracle.com>
Date:   Tue, 22 Oct 2019 15:11:19 +0200
Message-ID: <87tv81ylfs.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zhenzhong Duan <zhenzhong.duan@oracle.com> writes:

> Hi Vitaly,
>
> On 2019/10/22 19:36, Vitaly Kuznetsov wrote:
>
>> Zhenzhong Duan<zhenzhong.duan@oracle.com>  writes:
>>
> ...snip
>
>>> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
>>> index 249f14a..3945aa5 100644
>>> --- a/arch/x86/kernel/kvm.c
>>> +++ b/arch/x86/kernel/kvm.c
>>> @@ -825,18 +825,36 @@ __visible bool __kvm_vcpu_is_preempted(long cpu)
>>>    */
>>>   void __init kvm_spinlock_init(void)
>>>   {
>>> -	/* Does host kernel support KVM_FEATURE_PV_UNHALT? */
>>> -	if (!kvm_para_has_feature(KVM_FEATURE_PV_UNHALT))
>>> +	/*
>>> +	 * In case host doesn't support KVM_FEATURE_PV_UNHALT there is still an
>>> +	 * advantage of keeping virt_spin_lock_key enabled: virt_spin_lock() is
>>> +	 * preferred over native qspinlock when vCPU is preempted.
>>> +	 */
>>> +	if (!kvm_para_has_feature(KVM_FEATURE_PV_UNHALT)) {
>>> +		pr_info("PV spinlocks disabled, no host support.\n");
>>>   		return;
>>> +	}
>>>   
>>> +	/*
>>> +	 * Disable PV qspinlock and use native qspinlock when dedicated pCPUs
>>> +	 * are available.
>>> +	 */
>>>   	if (kvm_para_has_hint(KVM_HINTS_REALTIME)) {
>>> -		static_branch_disable(&virt_spin_lock_key);
>>> -		return;
>>> +		pr_info("PV spinlocks disabled with KVM_HINTS_REALTIME hints.\n");
>>> +		goto out;
>>>   	}
>>>   
>>> -	/* Don't use the pvqspinlock code if there is only 1 vCPU. */
>>> -	if (num_possible_cpus() == 1)
>>> -		return;
>>> +	if (num_possible_cpus() == 1) {
>>> +		pr_info("PV spinlocks disabled, single CPU.\n");
>>> +		goto out;
>>> +	}
>>> +
>>> +	if (nopvspin) {
>>> +		pr_info("PV spinlocks disabled, forced by \"nopvspin\" parameter.\n");
>>> +		goto out;
>>> +	}
>>> +
>>> +	pr_info("PV spinlocks enabled\n");
>>>   
>>>   	__pv_init_lock_hash();
>>>   	pv_ops.lock.queued_spin_lock_slowpath = __pv_queued_spin_lock_slowpath;
>>> @@ -849,6 +867,8 @@ void __init kvm_spinlock_init(void)
>>>   		pv_ops.lock.vcpu_is_preempted =
>>>   			PV_CALLEE_SAVE(__kvm_vcpu_is_preempted);
>>>   	}
>>> +out:
>>> +	static_branch_disable(&virt_spin_lock_key);
>> You probably need to add 'return' before 'out:' as it seems you're
>> disabling virt_spin_lock_key in all cases now).
>
> virt_spin_lock_key is kept enabled in !kvm_para_has_feature(KVM_FEATURE_PV_UNHALT)
> case which is the only case virt_spin_lock() optimization is used.
>
> When PV qspinlock is enabled, virt_spin_lock() isn't called in
> __pv_queued_spin_lock_slowpath() in which case we don't care
> virt_spin_lock_key's value.
>

True, my bad: I though we still need it enabled for something.

> So adding 'return' or not are both ok, I chosed to save a line,
> let me know if you prefer to add a 'return' and I'll change it.

No, please ignore.

>
> btw: __pv_queued_spin_lock_slowpath() is alias of queued_spin_lock_slowpath()
>
> Thanks
> Zhenzhong
>

-- 
Vitaly
