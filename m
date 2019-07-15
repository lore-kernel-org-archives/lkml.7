Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32862C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 13:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E61620868
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 13:03:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730163AbfGOND1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 09:03:27 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36899 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730071AbfGOND1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 09:03:27 -0400
Received: by mail-wr1-f68.google.com with SMTP id n9so17030833wrr.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 06:03:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6/zxL2JVxAjVsCdS/ni80yoc+YyKRY2Rbvs00w2zLU8=;
        b=CJVyUbP+2VNCHpKPLlLwGZJdsonx1WsDZa+Exef9I1IG0rPa1jYa9X7KgzJIuS7j76
         x9FHlv7lTZEkMfbBv4yVNL7P1d0M8LHV31Dac5jvMFuJE1qZluiA2wZNPyMk6vzuc2ik
         Y8ipBdcKtWIXaZtHwqleevTM8CZdzuPgo5gZUmfc8WXkn02Ae7RuyrEGMjpXYqgWtigx
         9qa3gWGak5c7VIFjH8zXieM6LfcpOUuP284ASGJqwxuUOASnof9iv2iquAiGEuqlotvC
         86oFyQXcn7l1t5KfN8532OzjH9V6c/WxMQ2AO/nCQ5qHTOcEcZ+u/jv+mZEnMERdaQYO
         lWqw==
X-Gm-Message-State: APjAAAWFzbAeFYb5CmU1DoPsij9qFns/dwmeyYrkdrvAJlPpWOG47QXA
        /ARFAcQzwnf8h2RQApfng46KVw==
X-Google-Smtp-Source: APXvYqyX8uRzni0jyabWvBfHbK8UHzDAfHoMp+xbmqO5se1VqvVGLi07jnZ6VYND9wNGQMIbGK6erA==
X-Received: by 2002:adf:ec49:: with SMTP id w9mr27311453wrn.303.1563195805147;
        Mon, 15 Jul 2019 06:03:25 -0700 (PDT)
Received: from [192.168.178.40] ([151.20.129.151])
        by smtp.gmail.com with ESMTPSA id q1sm14379542wmq.25.2019.07.15.06.03.23
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 06:03:24 -0700 (PDT)
Subject: Re: [PATCH 03/22] x86/kvm: Fix frame pointer usage in vmx_vmenter()
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <cover.1563150885.git.jpoimboe@redhat.com>
 <299fe4adb78cff0a182f8376c23a445b94d7c782.1563150885.git.jpoimboe@redhat.com>
 <0b37031b-1043-8274-a086-2b5d0b02b5ef@redhat.com>
 <20190715123704.oke4pd4wguj5a7i3@treble>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <2172ac52-899b-a32a-cba7-c2e5f2bb784e@redhat.com>
Date:   Mon, 15 Jul 2019 15:03:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190715123704.oke4pd4wguj5a7i3@treble>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/07/19 14:37, Josh Poimboeuf wrote:
> On Mon, Jul 15, 2019 at 11:04:03AM +0200, Paolo Bonzini wrote:
>> On 15/07/19 02:36, Josh Poimboeuf wrote:
>>> With CONFIG_FRAME_POINTER, vmx_vmenter() needs to do frame pointer setup
>>> before calling kvm_spurious_fault().
>>>
>>> Fixes the following warning:
>>>
>>>   arch/x86/kvm/vmx/vmenter.o: warning: objtool: vmx_vmenter()+0x14: call without frame pointer save/setup
>>>
>>> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
>>
>> This is not enough, because the RSP value must match what is computed at
>> this place:
>>
>>         /* Adjust RSP to account for the CALL to vmx_vmenter(). */
>>         lea -WORD_SIZE(%_ASM_SP), %_ASM_ARG2
>>         call vmx_update_host_rsp
> 
> Ah, that is surprising :-)
> 
> And then there's this, which overwrites the frame pointer anyway:
> 
> 	mov VCPU_RBP(%_ASM_AX), %_ASM_BP
> 
> Would it make sense to remove the call to vmx_vmenter() altogether, and
> just either embed it in __vmx_vcpu_run(), or jmp back and forth to it
> from __vmx_vcpu_run()?

Unfortunately there's another use of it in nested_vmx_check_vmentry_hw.

The problem is that storing RSP (no matter if adjusted or not) needs a
scratch register.  And vmx_vmenter is exactly the part of the vmentry
that doesn't have any scratch registers available.

Therefore, you must arrange for the caller to store RSP.  You cannot for
example remove it from __vmx_vcpu_run and nested_vmx_check_vmentry_hw in
favor of vmx_vmenter. :(

>> Is this important since kvm_spurious_fault is just BUG()?
> 
> It's probably only important if you care about the stack trace for the
> BUG() case.  But BP is clobbered anyway so I guess it doesn't matter.

Yes, BP is the guest RBP at this point of the code.

Paolo

>> There is no macro currently to support CONFIG_DEBUG_BUGVERBOSE in
>> assembly code, but it's also fine if you just change the call to ud2.
> 
> That would be one way to make objtool happy.
> 

