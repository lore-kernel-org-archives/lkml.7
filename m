Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22011C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 08:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F39AA217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 08:17:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbfGRIRt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 04:17:49 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43616 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfGRIRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 04:17:49 -0400
Received: by mail-wr1-f67.google.com with SMTP id p13so27595182wru.10
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 01:17:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Gxcnav4cxj9NSWzD1Jo7B/97fmLNhoQUXArg3gxl5H8=;
        b=XuTwyj57aTCaU6cyJZhbiuYI5t/6Olkt1dmOmmtKit/YRAN1qhsjHF/igqCYsTcMRH
         QxXf/tFpSiSOejc7RiaA7YtH0YZnT0QV+lbMjReBWBNGuaF9rvgqqq5m+hM1tI935Hs+
         E7de6uZrtdecJG6izXlRfFpf1E8pY/rdPuuOky5b9iSEq2gIFPG4wDUZyNjO5GYY+0Pm
         O3sTdH2uvVmvsSF+EwD/CUKjs33eCMryjPTdUvVj3HeXQsDtfBA174b0feGQKxv+gu+e
         t53C43SQgM2YhbLETnYGcFPIO4H9Ms8PKE5NEUUrHiFEBS3vNv52xqI+lcOdVJUY0TLf
         27jQ==
X-Gm-Message-State: APjAAAW7tUaL/UpiZc+UkwBnKJT/LpAHyr8xV/g/7tudNbP3LAK3EVjy
        FBT4ER1AGT7JHfr7J4T7NYwLWwH3n3rAKQ==
X-Google-Smtp-Source: APXvYqzGFipt/JGSI4UDF+hfMuTUCQUMCUT8bsb/SNwDx6YIzS8VdHrXOL4zKiO14pX+q9h3fbDbpg==
X-Received: by 2002:adf:cd84:: with SMTP id q4mr40390898wrj.232.1563437867685;
        Thu, 18 Jul 2019 01:17:47 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e427:3beb:1110:dda2? ([2001:b07:6468:f312:e427:3beb:1110:dda2])
        by smtp.gmail.com with ESMTPSA id k17sm28255950wrq.83.2019.07.18.01.17.46
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 01:17:47 -0700 (PDT)
Subject: Re: [PATCH v2 03/22] x86/kvm: Replace vmx_vmenter()'s call to
 kvm_spurious_fault() with UD2
To:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <cover.1563413318.git.jpoimboe@redhat.com>
 <9fc2216c9dc972f95bb65ce2966a682c6bda1cb0.1563413318.git.jpoimboe@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <2a0e0d3f-f8a1-afce-810a-bc9697e54ed1@redhat.com>
Date:   Thu, 18 Jul 2019 10:17:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <9fc2216c9dc972f95bb65ce2966a682c6bda1cb0.1563413318.git.jpoimboe@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/07/19 03:36, Josh Poimboeuf wrote:
> Objtool reports the following:
> 
>   arch/x86/kvm/vmx/vmenter.o: warning: objtool: vmx_vmenter()+0x14: call without frame pointer save/setup
> 
> But frame pointers are necessarily broken anyway, because
> __vmx_vcpu_run() clobbers RBP with the guest's value before calling
> vmx_vmenter().  So calling without a frame pointer doesn't make things
> any worse.
> 
> Make objtool happy by changing the call to a UD2.
> 
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
> v2: ud2 instead of kvm_spurious_fault() [Paolo]
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> ---
>  arch/x86/kvm/vmx/vmenter.S | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
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

Acked-by: Paolo Bonzini <pbonzini@redhat.com>
