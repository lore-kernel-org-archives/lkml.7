Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E37F6FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 11:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C58E8218DE
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 11:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387476AbfJPL7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 07:59:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37752 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726372AbfJPL7B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 07:59:01 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5A8B17FDE9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 11:59:00 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id k184so1107306wmk.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 04:59:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iQqLr0072EPsnTxt9Tx21FXVuFvWLQZSEt/0llfkeOA=;
        b=WjwqEqgS61VtAectjHI/os0huTSyJy3vHD7JOhXAy1P7I2pzIQVkXjxmvgnzsz+Jlf
         7odHrXIf6o5Jmb9/YOF5bovsVEjCpSiebYSDR9oj4CZFwpY3ocwoqCskuXZW4EuNOba/
         fvQika3v61ZjRC7PTyVdBazsicCWVy8zANwkBjUcYDcey2c1Dh5XCRYzi+XB8qCEl9AP
         rsLvodw8YImRnBQv6IfaVgOVzZZx2FaLXZyoQna1PPOpe8vaNuAjMmHAt4/p+NAEDxgf
         tXA3tSEZhJzoNu+JesuGeCJMK2pnvMBpews8v3sBkyTzvu53Wo85XBK7S9Aklg9loMCi
         5blQ==
X-Gm-Message-State: APjAAAXexUzV17POpCQ0yDhpug9do76uvRa1JqO5Q6sbtV2tkXU6JBYt
        qWYyk9XJg/D3hphOy6ljn1t5YnbNME8nUaUHHSIPdhqbv8UaYS5KQ0P0ZQWdYAItSO3ErMSbZXa
        FteBFhJef6Maz71pNhDaCp9ss
X-Received: by 2002:adf:ecc7:: with SMTP id s7mr2398976wro.305.1571227138943;
        Wed, 16 Oct 2019 04:58:58 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyPn2WqMqrALmzAf7rRPCploJic5/A4+kCdmkuSxok12U/qcGXOFuOtsmSdfRterPobr4w6Pg==
X-Received: by 2002:adf:ecc7:: with SMTP id s7mr2398937wro.305.1571227138615;
        Wed, 16 Oct 2019 04:58:58 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d001:591b:c73b:6c41? ([2001:b07:6468:f312:d001:591b:c73b:6c41])
        by smtp.gmail.com with ESMTPSA id u11sm2148223wmd.32.2019.10.16.04.58.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2019 04:58:58 -0700 (PDT)
Subject: Re: [PATCH v9 09/17] x86/split_lock: Handle #AC exception for split
 lock
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, kvm@vger.kernel.org
References: <1560897679-228028-1-git-send-email-fenghua.yu@intel.com>
 <1560897679-228028-10-git-send-email-fenghua.yu@intel.com>
 <alpine.DEB.2.21.1906262209590.32342@nanos.tec.linutronix.de>
 <20190626203637.GC245468@romley-ivt3.sc.intel.com>
 <alpine.DEB.2.21.1906262338220.32342@nanos.tec.linutronix.de>
 <20190925180931.GG31852@linux.intel.com>
 <3ec328dc-2763-9da5-28d6-e28970262c58@redhat.com>
 <alpine.DEB.2.21.1910161142560.2046@nanos.tec.linutronix.de>
 <57f40083-9063-5d41-f06d-fa1ae4c78ec6@redhat.com>
 <alpine.DEB.2.21.1910161244060.2046@nanos.tec.linutronix.de>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <3a12810b-1196-b70a-aa2e-9fe17dc7341a@redhat.com>
Date:   Wed, 16 Oct 2019 13:58:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1910161244060.2046@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/10/19 13:49, Thomas Gleixner wrote:
> On Wed, 16 Oct 2019, Paolo Bonzini wrote:
>> Yes it does.  But Sean's proposal, as I understand it, leads to the
>> guest receiving #AC when it wasn't expecting one.  So for an old guest,
>> as soon as the guest kernel happens to do a split lock, it gets an
>> unexpected #AC and crashes and burns.  And then, after much googling and
>> gnashing of teeth, people proceed to disable split lock detection.
> 
> I don't think that this was what he suggested/intended.

Xiaoyao's reply suggests that he also understood it like that.

>> In all of these cases, the common final result is that split-lock
>> detection is disabled on the host.  So might as well go with the
>> simplest one and not pretend to virtualize something that (without core
>> scheduling) is obviously not virtualizable.
> 
> You are completely ignoring any argument here and just leave it behind your
> signature (instead of trimming your reply).

I am not ignoring them, I think there is no doubt that this is the
intended behavior.  I disagree that Sean's patches achieve it, however.

>>> 1) Sane guest
>>>
>>> Guest kernel has #AC handler and you basically prevent it from
>>> detecting malicious user space and killing it. You also prevent #AC
>>> detection in the guest kernel which limits debugability.
> 
> That's a perfectly fine situation. Host has #AC enabled and exposes the
> availability of #AC to the guest. Guest kernel has a proper handler and
> does the right thing. So the host _CAN_ forward #AC to the guest and let it
> deal with it. For that to work you need to expose the MSR so you know the
> guest state in the host.
> 
> Your lazy 'solution' just renders #AC completely useless even for
> debugging.
> 
>>> 2) Malicious guest
>>>
>>> Trigger #AC to disable the host detection and then carry out the DoS 
>>> attack.
> 
> With your proposal you render #AC useless even on hosts which have SMT
> disabled, which is just wrong. There are enough good reasons to disable
> SMT.

My lazy "solution" only applies to SMT enabled.  When SMT is either not
supported, or disabled as in "nosmt=force", we can virtualize it like
the posted patches have done so far.

> I agree that with SMT enabled the situation is truly bad, but we surely can
> be smarter than just disabling it globally unconditionally and forever.
> 
> Plus we want a knob which treats guests triggering #AC in the same way as
> we treat user space, i.e. kill them with SIGBUS.

Yes, that's a valid alternative.  But if SMT is possible, I think the
only sane possibilities are global disable and SIGBUS.  SIGBUS (or
better, a new KVM_RUN exit code) can be acceptable for debugging guests too.

Paolo
