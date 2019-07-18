Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A5C8C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 09:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F01A217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 09:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389577AbfGRJjs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 05:39:48 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39934 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbfGRJjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 05:39:47 -0400
Received: by mail-wm1-f68.google.com with SMTP id u25so14578044wmc.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 02:39:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8haVWoDpVR5WxCmFLokklmzinBm2VLPR7zTTlvNe1xo=;
        b=BZ+6jGpqILM2f4QehlFxDZf6usQ8r5lI2Jc7EVOYi9wSo5seXiVkw1akQy9+TWTIaO
         DgK9wuFOxoXBTwekMSOYXhriWOP7RYkM/xBaukhqKdmDaAdvgb2hemikorqms/1jYFHB
         n+eSZhf+IDONTRBfFnIXMHjt2L9QhWx7xYexzZkl9iud9mwUHq95kBBfqOvaWkJnbDEa
         YTj+kOnZADksc6ma6qSPXvjylD6FCPjwvfTgYBnD4QFko9CHS5MzFtnAE0ApLPfDO0ZK
         5CB69h5bojHLDLPtdx5Rtku0iU8Yr64gPXoqrosxKjeZRPQg1OBxhY+22bXFbD7R8J0B
         kqlg==
X-Gm-Message-State: APjAAAU5wAXD15A8JCMkCtiyHx8WFCliH6Au/Zo3++GwrQ5v0o+OWdIJ
        WJlyWIfpIS5a8LIaLzXTucRSTw==
X-Google-Smtp-Source: APXvYqx23CP7qsEyw52dzAYhntF3bkpxTa1Ol4aIfCYcJ9vKxpbFYwnXz61NjcCrebAKq/6WqokZGQ==
X-Received: by 2002:a7b:cc09:: with SMTP id f9mr42911311wmh.68.1563442785542;
        Thu, 18 Jul 2019 02:39:45 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e427:3beb:1110:dda2? ([2001:b07:6468:f312:e427:3beb:1110:dda2])
        by smtp.gmail.com with ESMTPSA id p3sm24437124wmg.15.2019.07.18.02.39.44
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 02:39:45 -0700 (PDT)
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
 <bc210153-fbae-25d4-bf6b-e31ceef36aa5@redhat.com>
 <CANRm+CxV0c3RSidV_GQtVuQ5fUUCT8vM=5LpodgDg+dFWhkH3w@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <f6f9c2ca-6fea-d7b5-9797-d180e42f50d5@redhat.com>
Date:   Thu, 18 Jul 2019 11:39:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CANRm+CxV0c3RSidV_GQtVuQ5fUUCT8vM=5LpodgDg+dFWhkH3w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/07/19 11:29, Wanpeng Li wrote:
> On Thu, 18 Jul 2019 at 17:07, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> On 18/07/19 10:43, Wanpeng Li wrote:
>>>>> Isnt that done by the sched_in handler?
>>>>
>>>> I am a bit confused because, if it is done by the sched_in later, I
>>>> don't understand why the sched_out handler hasn't set vcpu->preempted
>>>> already.
>>>>
>>>> The s390 commit message is not very clear, but it talks about "a former
>>>> sleeping cpu" that "gave up the cpu voluntarily".  Does "voluntarily"
>>>> that mean it is in kvm_vcpu_block?  But then at least for x86 it would
>>>
>>> see the prepare_to_swait_exlusive() in kvm_vcpu_block(), the task will
>>> be set in TASK_INTERRUPTIBLE state, kvm_sched_out will set
>>> vcpu->preempted to true iff current->state == TASK_RUNNING.
>>
>> Ok, I was totally blind to that "if" around vcpu->preempted = true, it's
>> obvious now.
>>
>> I think we need two flags then, for example vcpu->preempted and vcpu->ready:
>>
>> - kvm_sched_out sets both of them to true iff current->state == TASK_RUNNING
>>
>> - kvm_vcpu_kick sets vcpu->ready to true
>>
>> - kvm_sched_in clears both of them

... and also kvm_vcpu_on_spin should check vcpu->ready.  vcpu->preempted
remains only for use by vmx_vcpu_pi_put.

Later we could think of removing vcpu->preempted.  For example,
kvm_arch_sched_out and kvm_x86_ops->sched_out could get the code
currently in vmx_vcpu_pi_put (testing curent->state == TASK_RUNNING
instead of vcpu->preempted).  But for now there's no need and I'm not
sure it's an improvement at all.

Paolo

>> This way, vmx_vcpu_pi_load can keep looking at preempted only (it
>> handles voluntary preemption in pi_pre_block/pi_post_block).

