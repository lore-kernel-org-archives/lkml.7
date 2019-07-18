Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF15C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 09:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B731E2173E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 09:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389704AbfGRJHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 05:07:07 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45802 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389453AbfGRJHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 05:07:07 -0400
Received: by mail-wr1-f67.google.com with SMTP id f9so27766580wre.12
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 02:07:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o9/78Nh53njXX6v0c2aPrfA34ngPUQ0RdFKx5mOyEAk=;
        b=N81zupP+HqVgSu0MHuGlLIYQ+w+fw1v0p0/+LCQi2iibrGfZ5d5Dg9s1m5M0kcC96s
         E72TbhrHvBkzYKhxD4HTEa2q3o3bGiPXUeOjsCFBtK3VLyKQU/2F956ZNuwdZ/FXllaw
         p3ofULqlvnrkKiCeEQ0+8N/BPXdy8Or7hKgKejN0Uo9boAml4oNs/z3QZ+EGM5YgocO9
         SP5KD3ZAWoVFjOrkfTVn+YS4SOFcfQLhUJvk3BVn3emX+pUI2FpiNGWCkJrvXUNShaUk
         w/B1Bmc1KBzejI96T06aquFEs3f6cOeUoJtGx+afMArgxBTEL+kCpz8zUj54b19VAwfP
         RcZQ==
X-Gm-Message-State: APjAAAV9x84Q2Ip19mpvN6JA+iT9jtU9+qePJgqjdoLvNHoEVYHtCSjk
        pHDVd00UIK5wsAj62o10imSZwQ==
X-Google-Smtp-Source: APXvYqyJe5LzHOHqey7c/rVfA7/ANs0/AhmbYSsFPjYjrtprmy7Pr4a1Jbp/0GZaf1H8zloLknoqKw==
X-Received: by 2002:adf:db50:: with SMTP id f16mr35132159wrj.214.1563440825128;
        Thu, 18 Jul 2019 02:07:05 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e427:3beb:1110:dda2? ([2001:b07:6468:f312:e427:3beb:1110:dda2])
        by smtp.gmail.com with ESMTPSA id y6sm20665974wrp.12.2019.07.18.02.07.04
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 02:07:04 -0700 (PDT)
Subject: Re: [PATCH RESEND] KVM: Boosting vCPUs that are delivering interrupts
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <1562915730-9490-1-git-send-email-wanpengli@tencent.com>
 <f95fbf72-090f-fb34-3c20-64508979f251@redhat.com>
 <db74a3a8-290e-edff-10ad-f861c60fbf8e@de.ibm.com>
 <e31024e4-f437-becd-a9e3-e1ea8cd2e0c7@redhat.com>
 <CANRm+Cw43DKqD17U+7-OPX3BmeNBThSe9-uWP2Atob+A0ApzLA@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <bc210153-fbae-25d4-bf6b-e31ceef36aa5@redhat.com>
Date:   Thu, 18 Jul 2019 11:07:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CANRm+Cw43DKqD17U+7-OPX3BmeNBThSe9-uWP2Atob+A0ApzLA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/07/19 10:43, Wanpeng Li wrote:
>>> Isnt that done by the sched_in handler?
>>
>> I am a bit confused because, if it is done by the sched_in later, I
>> don't understand why the sched_out handler hasn't set vcpu->preempted
>> already.
>>
>> The s390 commit message is not very clear, but it talks about "a former
>> sleeping cpu" that "gave up the cpu voluntarily".  Does "voluntarily"
>> that mean it is in kvm_vcpu_block?  But then at least for x86 it would
> 
> see the prepare_to_swait_exlusive() in kvm_vcpu_block(), the task will
> be set in TASK_INTERRUPTIBLE state, kvm_sched_out will set
> vcpu->preempted to true iff current->state == TASK_RUNNING.

Ok, I was totally blind to that "if" around vcpu->preempted = true, it's
obvious now.

I think we need two flags then, for example vcpu->preempted and vcpu->ready:

- kvm_sched_out sets both of them to true iff current->state == TASK_RUNNING

- kvm_vcpu_kick sets vcpu->ready to true

- kvm_sched_in clears both of them

This way, vmx_vcpu_pi_load can keep looking at preempted only (it
handles voluntary preemption in pi_pre_block/pi_post_block).

Also, kvm_s390_vcpu_wakeup can be changed to use kvm_vcpu_wake_up, which
is nice.

Paolo
