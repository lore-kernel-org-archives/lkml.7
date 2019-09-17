Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D61BDC4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 14:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6F67206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 14:08:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfIQOIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 10:08:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48656 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726986AbfIQOIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 10:08:36 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4AE75C010927
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 14:08:36 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id o188so1305442wmo.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 07:08:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zo94M/S+0QMhxiiEtdJA09kaXmZqIlmiIBtzBP4Qi5Q=;
        b=qrgWQTQ5soWy2LpQxG5VxRwUPmPCa9cbCXjDSWIMn6ZVd7O0IvBceau/RRl+ydKbvy
         VyHtttQLYMbweXVYnki5BNch+Tni59e33HT384tdyyI9XYN/1WmtCbCbfbbQLN3ZGBGa
         G3AcRi8ZcqYEYJEnvz/gbzoOrx3co4ehz7bIr2PEE8zzcBBWqDPPddn5g58OZAHiecK4
         v+Z4Fm2PotdKlftUwg4/LuTpnLES7FVXoI/mI901PupRCMOV3p8yWm/NSdQnaUbKg0Ce
         a+tpQ52r6GzagrhsV1ZL9PWFK2rknRiOCnMXvHY19i55LHRLsruV4ZMTLW12QyiU4Btn
         iabQ==
X-Gm-Message-State: APjAAAX75bDa6TqFnG91Kv7QA79rAjoTMBjlfx7xKgw25m18gkpmMfiL
        LnAGumM1IqdpgGPLw70Iy0yQg71PieJVOG1vDHmFID7+8JkVSQ9YVogpa9bEORMTHAn++VGTG4y
        og/qDdmnH/u4QBDgxpRzRNxQz
X-Received: by 2002:a5d:5005:: with SMTP id e5mr3115540wrt.79.1568729314707;
        Tue, 17 Sep 2019 07:08:34 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzwJyVSxT1tRPcoJlKjfzhaJKAAxzm8KWOT8E3UWBRupFvvr6hlcptMJiwcFHxzxq1OsrSzVw==
X-Received: by 2002:a5d:5005:: with SMTP id e5mr3115522wrt.79.1568729314447;
        Tue, 17 Sep 2019 07:08:34 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c46c:2acb:d8d2:21d8? ([2001:b07:6468:f312:c46c:2acb:d8d2:21d8])
        by smtp.gmail.com with ESMTPSA id l18sm2701304wrc.18.2019.09.17.07.08.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2019 07:08:34 -0700 (PDT)
Subject: Re: [PATCH 2/3] KVM: x86: hyper-v: set NoNonArchitecturalCoreSharing
 CPUID bit when SMT is impossible
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-hyperv@vger.kernel.org,
        the arch/x86 maintainers <x86@kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Roman Kagan <rkagan@virtuozzo.com>
References: <20190916162258.6528-1-vkuznets@redhat.com>
 <20190916162258.6528-3-vkuznets@redhat.com>
 <CALMp9eRa0-HO+JWGDoAFO1zOtNjrutfT7d4pLxjsxn-XiAJwwQ@mail.gmail.com>
 <87ef0fb72x.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <fae07d28-e7de-1ed1-c6d4-513884a97c2f@redhat.com>
Date:   Tue, 17 Sep 2019 16:08:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87ef0fb72x.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/09/19 11:33, Vitaly Kuznetsov wrote:
> Jim Mattson <jmattson@google.com> writes:
> 
>> On Mon, Sep 16, 2019 at 9:23 AM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>>>
>>> Hyper-V 2019 doesn't expose MD_CLEAR CPUID bit to guests when it cannot
>>> guarantee that two virtual processors won't end up running on sibling SMT
>>> threads without knowing about it. This is done as an optimization as in
>>> this case there is nothing the guest can do to protect itself against MDS
>>> and issuing additional flush requests is just pointless. On bare metal the
>>> topology is known, however, when Hyper-V is running nested (e.g. on top of
>>> KVM) it needs an additional piece of information: a confirmation that the
>>> exposed topology (wrt vCPU placement on different SMT threads) is
>>> trustworthy.
>>>
>>> NoNonArchitecturalCoreSharing (CPUID 0x40000004 EAX bit 18) is described in
>>> TLFS as follows: "Indicates that a virtual processor will never share a
>>> physical core with another virtual processor, except for virtual processors
>>> that are reported as sibling SMT threads." From KVM we can give such
>>> guarantee in two cases:
>>> - SMT is unsupported or forcefully disabled (just 'disabled' doesn't work
>>>  as it can become re-enabled during the lifetime of the guest).
>>> - vCPUs are properly pinned so the scheduler won't put them on sibling
>>> SMT threads (when they're not reported as such).
>>
>> That's a nice bit of information. Have you considered a mechanism for
>> communicating this information to kvm guests in a way that doesn't
>> require Hyper-V enlightenments?
>>
> 
> (I haven't put much thought in this) but can we re-use MD_CLEAR CPUID
> bit for that? Like if the hypervisor can't guarantee usefulness
> (e.g. when two random vCPUs can be put on sibling SMT threads) of
> flushing, is there any reason to still make the guest think the feature
> is there?

Yes, that's a good idea.

Paolo
