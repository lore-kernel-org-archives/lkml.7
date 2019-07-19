Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44937C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 21:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 207812184E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 21:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388630AbfGSVlY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 17:41:24 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34100 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728658AbfGSVlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 17:41:24 -0400
Received: by mail-wm1-f66.google.com with SMTP id w9so24536889wmd.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 14:41:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JPnD2on9MPes546wI5hB8iJA16OLHGs/RSJMTP+xE/g=;
        b=nOg1DwOTFWIywA7i0YU19tPX1t6ScyvTomB5LfFAu6MWCPR/9D5d82XAqMEZKa76Uv
         Ok0+wry/fw6uMYh1bQ6tWTqBf75EEpYOfCXbWvTK7ptv3n6mGuyllz8xg28bg4pvjqaw
         ShOgPylIQMsMTm7Oz4DDQo0jln78kZeQY8Pv0YRTeEoIno/8E/mjPOx51bwhCBMRAIuQ
         UTpP+B3NQ3r7HQtQE7ABYaQoniyDR/saYS/e3OwLG46qexG5myrD/Fiu+uBMHjNi/r8L
         UawV6agTFNkb9oSg0wgFhLjCqW9AS/wuTZmZ1OHJty/9i7smjrvYnycklGFACsXBPpPr
         y3Gg==
X-Gm-Message-State: APjAAAUz7gzOx82yr4SKGweUZihHan0LisBntbuTrunoV2lXuIXeDrSb
        rWNaS0P+n1bpO2ZwGEpPu/EBE7HSqZs=
X-Google-Smtp-Source: APXvYqzWFOG1apvfJTpaD1HUhIGFOxEDFz5ZgU6gLi4SlZV7MzTBwfbH9+P+iHt7d6Pk/Val0bHt2g==
X-Received: by 2002:a7b:c251:: with SMTP id b17mr51176977wmj.143.1563572481866;
        Fri, 19 Jul 2019 14:41:21 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:8501:6b03:f18c:74f8? ([2001:b07:6468:f312:8501:6b03:f18c:74f8])
        by smtp.gmail.com with ESMTPSA id j10sm50967571wrd.26.2019.07.19.14.41.20
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jul 2019 14:41:21 -0700 (PDT)
Subject: Re: [PATCH v2 5/5] KVM: x86: Don't check kvm_rebooting in
 __kvm_handle_fault_on_reboot()
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190719204110.18306-1-sean.j.christopherson@intel.com>
 <20190719204110.18306-6-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <2fe374ae-9611-1f29-32f0-e8fce126cd41@redhat.com>
Date:   Fri, 19 Jul 2019 23:41:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190719204110.18306-6-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/19 22:41, Sean Christopherson wrote:
> Remove the kvm_rebooting check from VMX/SVM instruction exception fixup
> now that kvm_spurious_fault() conditions its BUG() on !kvm_rebooting.
> Because the 'cleanup_insn' functionally is also gone, deferring to
> kvm_spurious_fault() means __kvm_handle_fault_on_reboot() can eliminate
> its .fixup code entirely and have its exception table entry branch
> directly to the call to kvm_spurious_fault().
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/include/asm/kvm_host.h | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 92c59cd923b6..a5ae5562ce0a 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1511,13 +1511,7 @@ asmlinkage void kvm_spurious_fault(void);
>  	"667: \n\t"							\
>  	"call	kvm_spurious_fault \n\t"				\
>  	"668: \n\t"							\
> -	".pushsection .fixup, \"ax\" \n\t"				\
> -	"700: \n\t"							\
> -	"cmpb	$0, kvm_rebooting\n\t"					\
> -	"je	667b \n\t"						\
> -	"jmp	668b \n\t"						\
> -	".popsection \n\t"						\
> -	_ASM_EXTABLE(666b, 700b)
> +	_ASM_EXTABLE(666b, 667b)
>  
>  #define KVM_ARCH_WANT_MMU_NOTIFIER
>  int kvm_unmap_hva_range(struct kvm *kvm, unsigned long start, unsigned long end);
> 

Acked-by: Paolo Bonzini <pbonzini@redhat.com>
