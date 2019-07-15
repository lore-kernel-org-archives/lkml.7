Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B203C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 18:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B3B020665
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 18:17:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730292AbfGOSRl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 14:17:41 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38759 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729277AbfGOSRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 14:17:40 -0400
Received: by mail-wr1-f67.google.com with SMTP id g17so18136547wrr.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 11:17:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ffNMjzF2N9rsv6oDEllNIn4jfwNv5JXmfhkGppQP1yg=;
        b=O91eXFT25PXdBCwhhWiW4XT6Ld7SM875chYeGEWh3d7UKI+ba51uEdduWIKFRshMcl
         e6/D1LlqWXeQx30xA8X4TOEMmpMpXv9voNyB64YGQosi3kDInKhWM7r/ZjDkD9t4l1Gv
         XQp9JFmnRDTNZse5z7vew4RPL6Ff6l4Je5YnpWKCdDdSMZqBYaC+CACnk1UHErpJS7t7
         ZDw2l4sXBniDzIGXDRF78p68Bzvtmgfil7kXtEI7qDE1rjMqW/EcRzqAveWyvSQPbzm9
         hjxyV6ZvERPJ1Ai5YuYgePt838oqMFlQzwyR2xZxIsKBEqOwjc3V4zJbK2OZU12aSYm3
         jiSg==
X-Gm-Message-State: APjAAAUhV9HV8vdtFsW9dtZzFr7Qiyrml+4venHcuYo5xX5MY1+kbxs0
        ElnL7HbsSu/j76+O+zLA1bNYew==
X-Google-Smtp-Source: APXvYqxyNSL3gMJzkJ6eNIg7eCskXt9Cw0ay4qeS8/0JUUWSzWob6wGPt/fu6XxHcdfYx8zmgiaKAA==
X-Received: by 2002:adf:f888:: with SMTP id u8mr2920645wrp.238.1563214658539;
        Mon, 15 Jul 2019 11:17:38 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b159:8d52:3041:ae0d? ([2001:b07:6468:f312:b159:8d52:3041:ae0d])
        by smtp.gmail.com with ESMTPSA id l17sm5378428wrr.94.2019.07.15.11.17.37
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 11:17:38 -0700 (PDT)
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
 <2172ac52-899b-a32a-cba7-c2e5f2bb784e@redhat.com>
 <20190715133525.gr4wvnd4kxwtv63o@treble>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <48ce6e66-6458-483a-f36b-9ea8e19cbc4e@redhat.com>
Date:   Mon, 15 Jul 2019 20:17:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190715133525.gr4wvnd4kxwtv63o@treble>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/07/19 15:35, Josh Poimboeuf wrote:
> On Mon, Jul 15, 2019 at 03:03:23PM +0200, Paolo Bonzini wrote:
>> On 15/07/19 14:37, Josh Poimboeuf wrote:
>>> Would it make sense to remove the call to vmx_vmenter() altogether, and
>>> just either embed it in __vmx_vcpu_run(), or jmp back and forth to it
>>> from __vmx_vcpu_run()?
>>
>> Unfortunately there's another use of it in nested_vmx_check_vmentry_hw.
> 
> Ah, I missed that too (failed by cscope).  Is this ok?

Yes, it is.  Thanks!

Paolo

> diff --git a/arch/x86/kvm/vmx/vmenter.S b/arch/x86/kvm/vmx/vmenter.S
> index d4cb1945b2e3..4010d519eb8c 100644
> --- a/arch/x86/kvm/vmx/vmenter.S
> +++ b/arch/x86/kvm/vmx/vmenter.S
> @@ -54,9 +54,9 @@ ENTRY(vmx_vmenter)
>  	ret
>  
>  3:	cmpb $0, kvm_rebooting
> -	jne 4f
> -	call kvm_spurious_fault
> -4:	ret
> +	je 4f
> +	ret
> +4:	ud2
>  
>  	.pushsection .fixup, "ax"
>  5:	jmp 3b
> 

