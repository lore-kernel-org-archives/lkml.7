Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A9FC282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 17:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9461D20705
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 17:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KXshFjai"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729684AbgAHRPB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 12:15:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38175 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729583AbgAHRPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 12:15:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578503699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vnM+x6Ssb1mcduODxbe5+uNany1GBwa/Hz6WtXlr7O4=;
        b=KXshFjaiK+BY8WVt7xLYXKQN7/HZeV/wxWpsgHAFAh6tMF2fvSDbr2zFX8qJ5p4HD/SxcT
        cdOZ0fIiVKwWaf4y4vLaGoC/Kx+9wlHnYn9R6qtsDLHRklKFTmjsTzCgVY6v3vEfUZi4dm
        A9NxLl9Ztc75t7HFuhcQw13hEzjRvHc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-zgY4dCtzPgeivscO2AQDPA-1; Wed, 08 Jan 2020 12:14:58 -0500
X-MC-Unique: zgY4dCtzPgeivscO2AQDPA-1
Received: by mail-wm1-f71.google.com with SMTP id b9so1076087wmj.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 09:14:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vnM+x6Ssb1mcduODxbe5+uNany1GBwa/Hz6WtXlr7O4=;
        b=MFHnIiVx3kJu6bQDCR5KIHV13Kep4VZVlbDnAXEr3aEihoE3jM4cFupMv1xw1FZKeI
         r2hqxNBRWg5uV1/LvLvkL9nNO1CUeclq2FWCTB9Pju6Qzlb/o/J9Z50zEx294mBxktRR
         1pD+FYp9j6VDFnaY1CBCKXiKPFVpCepFsszsMoZEqg6k+o6OvrPGHLN/Gul+TaO2Z7BW
         KGkYCXIVTWCDv4UDTPBeCBnn5Am6zARauUIeF34eq7rc3CmLQdu4SNsDUUK9VDr5zREl
         6uM7BWRPKDTbeaXMRxT3CKGaSmB3VPgoIG/rBXHGNiCACMCJ7b9xuOBor0hgQRV685uI
         YPng==
X-Gm-Message-State: APjAAAWUcC4Urbe3pyqxs4Dr7ETLTzVO6VtTU1Fp5D4yajeIF1jKApLj
        +fyO3GyV5E6Wj2RzXPxSvFKrTijF/1cJ2m6z3DftjntZRp82w52cTDt4iuBh9lTvgphi7wuDsrY
        JaImosaOzXC0cxgkay4NKNLb8
X-Received: by 2002:a1c:a9c6:: with SMTP id s189mr5225232wme.151.1578503696577;
        Wed, 08 Jan 2020 09:14:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqz6QfyCjkkc/cn5N9B3HuvF1UbjB6DCyXC1I49m1Q5gG7DdVR/OqIU5VsKS3NDGqXBnTP1SDQ==
X-Received: by 2002:a1c:a9c6:: with SMTP id s189mr5225208wme.151.1578503696324;
        Wed, 08 Jan 2020 09:14:56 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c6d:4079:b74c:e329? ([2001:b07:6468:f312:c6d:4079:b74c:e329])
        by smtp.gmail.com with ESMTPSA id b21sm4680093wmd.37.2020.01.08.09.14.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2020 09:14:55 -0800 (PST)
Subject: Re: [PATCH RFC] sched/fair: Penalty the cfs task which executes
 mwait/hlt
To:     Peter Zijlstra <peterz@infradead.org>,
        Wanpeng Li <kernellwp@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        KarimAllah <karahmed@amazon.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Ankur Arora <ankur.a.arora@oracle.com>
References: <1578448201-28218-1-git-send-email-wanpengli@tencent.com>
 <20200108155040.GB2827@hirez.programming.kicks-ass.net>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <00d884a7-d463-74b4-82cf-9deb0aa70971@redhat.com>
Date:   Wed, 8 Jan 2020 18:14:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200108155040.GB2827@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/01/20 16:50, Peter Zijlstra wrote:
> On Wed, Jan 08, 2020 at 09:50:01AM +0800, Wanpeng Li wrote:
>> From: Wanpeng Li <wanpengli@tencent.com>
>>
>> To deliver all of the resources of a server to instances in cloud, there are no 
>> housekeeping cpus reserved. libvirtd, qemu main loop, kthreads, and other agent/tools 
>> etc which can't be offloaded to other hardware like smart nic, these stuff will 
>> contend with vCPUs even if MWAIT/HLT instructions executed in the guest.

^^ this is the problem statement:

He has VCPU threads which are being pinned 1:1 to physical CPUs.  He
needs to have various housekeeping threads preempting those vCPU
threads, but he'd rather preempt vCPU threads that are doing HLT/MWAIT
than those that are keeping the CPU busy.

>> The is no trap and yield the pCPU after we expose mwait/hlt to the guest [1][2],
>> the top command on host still observe 100% cpu utilization since qemu process is 
>> running even though guest who has the power management capability executes mwait. 
>> Actually we can observe the physical cpu has already enter deeper cstate by 
>> powertop on host.
>>
>> For virtualization, there is a HLT activity state in CPU VMCS field which indicates 
>> the logical processor is inactive because it executed the HLT instruction, but 
>> SDM 24.4.2 mentioned that execution of the MWAIT instruction may put a logical 
>> processor into an inactive state, however, this VMCS field never reflects this 
>> state.
> 
> So far I think I can follow, however it does not explain who consumes
> this VMCS state if it is set and how that helps. Also, this:

I think what Wanpeng was saying is: "KVM could gather this information
using the activity state field in the VMCS.  However, when the guest
does MWAIT the processor can go into an inactive state without updating
the VMCS."  Hence looking at the APERFMPERF ratio.

>> This patch avoids fine granularity intercept and reschedule vCPU if MWAIT/HLT
>> instructions executed, because it can worse the message-passing workloads which 
>> will switch between idle and running frequently in the guest. Lets penalty the 
>> vCPU which is long idle through tick-based sampling and preemption.
> 
> is just complete gibberish. And I have no idea what problem you're
> trying to solve how.

This is just explaining why MWAIT and HLT is not being trapped in his
setup.  (Because vmexit on HLT or MWAIT is awfully expensive).

> Also, I don't think the TSC/MPERF ratio is architected, we can't assume
> this is true for everything that has APERFMPERF.

Right, you have to look at APERF/MPERF, not TSC/MPERF.  My scheduler-fu
is zero so I can't really help with a nicer solution.

Paolo

