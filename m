Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9176C4CEC5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 09:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC07320717
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 09:51:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387628AbfIMJvl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 05:51:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51416 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728767AbfIMJvk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 05:51:40 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1694F88304
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 09:51:40 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id h6so1046241wmb.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 02:51:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YHn+lgx3KH3nZ7vvGzR2tsrfN+sBUuJK+hZ3hDebNeE=;
        b=EtcdCe+DZoCn4m3HocyZan3eTgXLxlKK4bLgUl7N5M40kSTB6YEjMLvfflCG4nIcNG
         2BzMa5iJntcS7Ei1h8zCmnKZR10Xifr2CqIlhiSIiLEUZa+pCP3g0s8fXFdmQ5umpePh
         HKsQ+XNI4DTCizGD2udSHH8qwy/ZnThRJa5+SEHPyEOwRlATgOM/2dNzVfMniKc1xMh/
         PMoTVs9W++b7rQjdaxokNjEloLx6wNJDRBrf2w2Sa1T39xReZs4BtCOLxQpLZsZGwfWp
         e4w2DpV+bdpfG+HaNBArXvja3+j7I+Dh4mCsPuOENFbqw/GhvuZgpBFPRHPuWhC6nlby
         yAMg==
X-Gm-Message-State: APjAAAU9p1J+88rcvS3B+K4XHXd2eNpPRoefHmSphL1QVcZRHjfHVxbb
        O/G05zwir+dMthdV3CgiSlUR+jb9IFc3MOaRSO509DQ5GaA6np1jWW7gQwkPHj+d/ZEmEoKVfXR
        oyPCNLlalsPR1X/UQl+p5fGvZ
X-Received: by 2002:adf:e485:: with SMTP id i5mr37460755wrm.175.1568368298368;
        Fri, 13 Sep 2019 02:51:38 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzxoEtYyiIrtD+sRoaOShW6tq+/DZp2oqi7KnZb2EInrwcUyNPzLvE174ZhgAJUiU4wK5xV6w==
X-Received: by 2002:adf:e485:: with SMTP id i5mr37460724wrm.175.1568368298099;
        Fri, 13 Sep 2019 02:51:38 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c5d2:4bb2:a923:3a9a? ([2001:b07:6468:f312:c5d2:4bb2:a923:3a9a])
        by smtp.gmail.com with ESMTPSA id a15sm1590919wmj.25.2019.09.13.02.51.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2019 02:51:37 -0700 (PDT)
Subject: Re: [PATCH 0/3] fix emulation error on Windows bootup
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Jan Dakinevich <jan.dakinevich@virtuozzo.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Denis Lunev <den@virtuozzo.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
References: <1566911210-30059-1-git-send-email-jan.dakinevich@virtuozzo.com>
 <b35c8b24-7531-5a5d-1518-eaf9567359ae@redhat.com>
 <20190911195359.GK1045@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <4a4c71d8-c29a-d04c-e7d3-4ea9ec916a29@redhat.com>
Date:   Fri, 13 Sep 2019 11:51:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190911195359.GK1045@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/09/19 21:53, Sean Christopherson wrote:
> On Wed, Sep 11, 2019 at 05:51:05PM +0200, Paolo Bonzini wrote:
>> On 27/08/19 15:07, Jan Dakinevich wrote:
>>> This series intended to fix (again) a bug that was a subject of the 
>>> following change:
>>>
>>>   6ea6e84 ("KVM: x86: inject exceptions produced by x86_decode_insn")
>>>
>>> Suddenly, that fix had a couple mistakes. First, ctxt->have_exception was 
>>> not set if fault happened during instruction decoding. Second, returning 
>>> value of inject_emulated_instruction was used to make the decision to 
>>> reenter guest, but this could happen iff on nested page fault, that is not 
>>> the scope where this bug could occur.
>>>
>>> However, I have still deep doubts about 3rd commit in the series. Could
>>> you please, make me an advise if it is the correct handling of guest page 
>>> fault?
>>>
>>> Jan Dakinevich (3):
>>>   KVM: x86: fix wrong return code
>>>   KVM: x86: set ctxt->have_exception in x86_decode_insn()
>>>   KVM: x86: always stop emulation on page fault
>>>
>>>  arch/x86/kvm/emulate.c | 4 +++-
>>>  arch/x86/kvm/x86.c     | 4 +++-
>>>  2 files changed, 6 insertions(+), 2 deletions(-)
>>>
>>
>> Queued, thanks.  I added the WARN_ON_ONCE that Sean suggested.
> 
> Which version did you queue?  It sounds like you queued v1, which breaks
> VMware backdoor emulation due to incorrect patch ordering.  v3[*] fixes
> the ordering issue and adds the WARN_ON_ONCE.

I applied v1 with all the fixes, then found out v3 existed and replaced
with it (but still added a comment).

Paolo

