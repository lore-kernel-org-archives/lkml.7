Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36BF7C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 10:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC6BD2178F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 10:38:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388168AbfKGKi2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 05:38:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46102 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727562AbfKGKi2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 05:38:28 -0500
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 98D4437F41
        for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2019 10:38:27 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id b4so744441wrn.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 02:38:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=1cBytUypSmrDIXCTuphD26i91wQdyJsDQ/c6D49Q3/s=;
        b=kE0PO/YLMKqY6vOpNZiC/H7SE9j1v5UbzexDCPWWuEH2b5IPmcDPTA5ehPXR+19IQO
         mBEYM5W2Z/t+PwYPPTCi46LJfhkzEdku6NUHyzNgFcQ5U35SSoRnTFMOg38BydwGnQql
         TDRG03wogMJsZyT+V/JiBFlWYrb7ZjzBiYTvHYVkv4OMICzcFOrKkCgyDF+j4+n4Zj7s
         Zr8T38C8uDuacQDdYOzV+YVooO7EwrFnaEWbA4xdpEk6uqGdM3YMoWocQ5KUpQMlE/p5
         KH6k24xlxIe6/dT29mIwvY4ix8hGNa967BVa49tNnwMAhKDBUqCcA93n0uJmFkhgHaug
         3TfA==
X-Gm-Message-State: APjAAAW+R2e43asdUurxRlNDSQMA7wQA05whfH3vr27N0wJD1QcC18kv
        pCwryrhhnnv2wLwb9IjgKqD5KYEsKNSuRiMBk8a2If6fRuTqpFxXdW6QgjKp/x9bqY7tu0LRslQ
        PEEzRBuZZInNUByyIECo3SAkd
X-Received: by 2002:adf:ea50:: with SMTP id j16mr2050954wrn.295.1573123106316;
        Thu, 07 Nov 2019 02:38:26 -0800 (PST)
X-Google-Smtp-Source: APXvYqy29JLKN+fQKhtAvQsjApYEtkKH0E4xyVUx/oPkr1HuCBG5qXWHjPsVEHaccFuX1Z35xiuEdQ==
X-Received: by 2002:adf:ea50:: with SMTP id j16mr2050934wrn.295.1573123106058;
        Thu, 07 Nov 2019 02:38:26 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id j14sm1756813wrp.16.2019.11.07.02.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 02:38:25 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     kvm@vger.kernel.org, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Jim Mattson <jmattson@google.com>,
        Liran Alon <liran.alon@oracle.com>,
        linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra \(Intel\)" <peterz@infradead.org>
Subject: Re: [PATCH RFC] KVM: x86: tell guests if the exposed SMT topology is trustworthy
In-Reply-To: <20191105232500.GA25887@linux.intel.com>
References: <20191105161737.21395-1-vkuznets@redhat.com> <20191105193749.GA20225@linux.intel.com> <20191105232500.GA25887@linux.intel.com>
Date:   Thu, 07 Nov 2019 11:38:24 +0100
Message-ID: <87ftj0as4f.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> On Tue, Nov 05, 2019 at 11:37:50AM -0800, Sean Christopherson wrote:
>> On Tue, Nov 05, 2019 at 05:17:37PM +0100, Vitaly Kuznetsov wrote:
>> > Virtualized guests may pick a different strategy to mitigate hardware
>> > vulnerabilities when it comes to hyper-threading: disable SMT completely,
>> > use core scheduling, or, for example, opt in for STIBP. Making the
>> > decision, however, requires an extra bit of information which is currently
>> > missing: does the topology the guest see match hardware or if it is 'fake'
>> > and two vCPUs which look like different cores from guest's perspective can
>> > actually be scheduled on the same physical core. Disabling SMT or doing
>> > core scheduling only makes sense when the topology is trustworthy.
>> > 
>> > Add two feature bits to KVM: KVM_FEATURE_TRUSTWORTHY_SMT with the meaning
>> > that KVM_HINTS_TRUSTWORTHY_SMT bit answers the question if the exposed SMT
>> > topology is actually trustworthy. It would, of course, be possible to get
>> > away with a single bit (e.g. 'KVM_FEATURE_FAKE_SMT') and not lose backwards
>> > compatibility but the current approach looks more straightforward.
>> 
>> I'd stay away from "trustworthy", especially if this is controlled by
>> userspace.  Whether or not the hint is trustworthy is purely up to the
>> guest.  Right now it doesn't really matter, but that will change as we
>> start moving pieces of the host out of the guest's TCB.
>> 
>> It may make sense to split the two (or even three?) cases, e.g.
>> KVM_FEATURE_NO_SMT and KVM_FEATURE_ACCURATE_TOPOLOGY.  KVM can easily
>> enforce NO_SMT _today_, i.e. allow it to be set if and only if SMT is
>> truly disabled.  Verifying that the topology exposed to the guest is legit
>> is a completely different beast.
>
> Scratch the ACCURATE_TOPOLOGY idea, I doubt there's a real use case for
> setting ACCURATE_TOPOLOGY and not KVM_HINTS_REALTIME.  A feature flag to
> state that SMT is disabled seems simple and useful.

You seem to have the most conservative ideas around)

I wasn't actually thinking about KVM enforcing anything here, my goal
was to provide guest with enough information so it can adjust its SMT
related settings accordingly. These could be:
- 'nosmt'
- STIBP
- Core scheduling (not yet upstream afaik)
- Manual vCPU pinning for certain tasks (including running nested
guests). [E.g. nested Hyper-V hides 'md_clear' from its guests when it
doesn't see 'NoNonarchitecturalCoreSharing' from the underlying
hypervisor as it's pointless]
- (Liran's idea): Using SMT information for better scheduling

KVM_FEATURE_NO_SMT would cover one case, however, it's basically the
same as not exposing hyperthreads by KVM userspace, just enforced. Do
you think that such enforcement makes sense? What the guest is supposed
to do when it sees the flag (compared to what's doing now)?

('KVM_HINTS_REALTIME' may actually imply what we want, however, judging
by its name it may gain additional meaning in the future like 'always do
busy polling everywhere')

-- 
Vitaly
