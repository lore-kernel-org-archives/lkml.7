Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B1CC5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 09:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C07C72087E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 09:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731051AbfKFJlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 04:41:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46612 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726192AbfKFJlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 04:41:21 -0500
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6A1EFC057F88
        for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2019 09:41:20 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id b4so13737740wrn.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 01:41:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V+9RtC2tIR3+aOkoPaatHM7in9ZXxdq+z956RndgbxQ=;
        b=Q/MbW7aqx8AFJ28vpkASTgzmMvtaAUQo7QeT2uF/AkJs469o7DOd50IOn71bpV9Obl
         xf5Pe9MH9BPrH29mFYE4K61YjM15egN4duDRzn7faSbWyCoOH5WUFyxEZ6p8Uacl5In3
         7YzedayC/B+cydgtfvTrvmPFO1ajIXxF/X89BWE0kEJZdfldc3LdpOwLKbUTi2GGfR6W
         SkOT55uNDafhFIQgQLbMl9qtwEM00cHPHpT5kOyjyhJXOUziKZVnXqd414VUrCZ/hTxy
         TATh5rflJ8W28R668Ulu1dUybYrk6WrLCJGD/9ozf7IFY0lhnyMSiW85CwmO1hhTSXqZ
         abAw==
X-Gm-Message-State: APjAAAXWpn34IquId1Kbt6EQtOy4LDJGXOSk7VtEbx1q+ODT6qwuOV/p
        VWECH/iPFHB/5+GvmricBnxq6beZkB4/YxN7SRVyyI/2gEmY3ZUY+yenJCsjdNYALt1+W/JJ1kz
        Z2PRsDow1UUXzwGhmtwfErqly
X-Received: by 2002:a05:6000:34f:: with SMTP id e15mr1878083wre.232.1573033279003;
        Wed, 06 Nov 2019 01:41:19 -0800 (PST)
X-Google-Smtp-Source: APXvYqyiv1qp+lTOADX3rk3JMi3lcumtT2MZM4wlln0Jie+Z5hC8xxQhI2ctnxyiYUwNKfLFC4Zr4Q==
X-Received: by 2002:a05:6000:34f:: with SMTP id e15mr1878057wre.232.1573033278721;
        Wed, 06 Nov 2019 01:41:18 -0800 (PST)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id j22sm32676046wrd.41.2019.11.06.01.41.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2019 01:41:18 -0800 (PST)
Subject: Re: [PATCH RFC] KVM: x86: tell guests if the exposed SMT topology is
 trustworthy
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jim Mattson <jmattson@google.com>,
        Liran Alon <liran.alon@oracle.com>,
        linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>
References: <20191105161737.21395-1-vkuznets@redhat.com>
 <20191105200218.GF3079@worktop.programming.kicks-ass.net>
 <51c9fe0c-0bda-978c-27f7-85fe7e59e91d@redhat.com>
 <20191106083212.GO4131@hirez.programming.kicks-ass.net>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <5833c75e-9f3e-0412-d58c-b6cabdfbdaee@redhat.com>
Date:   Wed, 6 Nov 2019 10:41:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191106083212.GO4131@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/11/19 09:32, Peter Zijlstra wrote:
>>> The only way virt topology can make any sense what so ever is if the
>>> vcpus are pinned to physical CPUs.
>>
>> This is a subset of the requirements for "trustworthy" SMT.  You can have:
>>
>> - vCPUs pinned to two threads in the same core and exposed as multiple
>> cores in the guest
> 
> Why the .... would one do anything like that?

If a vCPUs from a different guest could be pinned to a threads in the
same core as this guest (e.g. guests with an odd number of vCPUs), then
why not.  Side-channel wise, you're screwed anyway.

>> - vCPUs from different guests pinned to two threads in the same core
>>
>> and that would be okay as far as KVM_HINTS_REALTIME is concerned, but
>> would still allow exploitation of side-channels, respectively within the
>> VM and between VMs.
> 
> Hardly, RT really rather would not have SMT. SMT is pretty crap for
> determinism.

True, but not a problem as long as the guest knows that - it can ignore
one sibling for each core for RT tasks, and use hyperthreading for
non-RT and housekeeping tasks.

Paolo
