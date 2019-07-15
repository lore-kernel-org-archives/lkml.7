Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05517C76190
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 09:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCA3120838
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 09:07:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbfGOJHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 05:07:32 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36051 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729394AbfGOJHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 05:07:32 -0400
Received: by mail-wr1-f68.google.com with SMTP id n4so16233455wrs.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 02:07:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iIpNhGzg6P5/kknOVL3At51YBOM3pwLE0ZzAOv+ZuqM=;
        b=hUEG2sYiNOdw0k+VVRJS1sxtxUzdYY4b+GXaSgmVyWgFUGiaNxtSWxUj8ASkPdITq+
         NeAPh7v61A5sQBhUTWbC/v7RcNBHtth/Qyh7rVvzOkubbxpZQYLD9YosYwh5qn14vuZR
         HOWgPEnXsW/v+PYUAllYN64Xic9K6rCrnh98KTHyodGArIxxHV2nAIgCAuDj3IFsGLZa
         tl0DKvx+WO2BXTOGPX6AsBeK/my8peliv8DGKRc+Jqt7ZFpPA1vgycqxJyBWL+6Oe2Ya
         E3eAT1rJ3zKm76WQKsnCRFtbSnxDqmNQh+ap6vrhUFZnHFr8TELo7UHTpShDdxwM0rbU
         IPZg==
X-Gm-Message-State: APjAAAXSci9lgBRoZKIVnSmFEgYyqb4nd5TPmOuSpj4pqgtk7awYsX3D
        niHc5XOs2kBY3e4zDzYYY1wiAg==
X-Google-Smtp-Source: APXvYqyaZd+NyYvWPkdjEU1+MpmkHgjx4zJEDQ81Tovwqc2sbwpA8fHg9HbrB24JFIfbbprCMrzmQg==
X-Received: by 2002:adf:ea88:: with SMTP id s8mr23565961wrm.68.1563181650201;
        Mon, 15 Jul 2019 02:07:30 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e983:8394:d6:a612? ([2001:b07:6468:f312:e983:8394:d6:a612])
        by smtp.gmail.com with ESMTPSA id x185sm8422412wmg.46.2019.07.15.02.07.29
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 02:07:29 -0700 (PDT)
Subject: Re: [PATCH 04/22] x86/kvm: Don't call kvm_spurious_fault() from
 .fixup
To:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <cover.1563150885.git.jpoimboe@redhat.com>
 <1f37a9e42732c224bc5299dbc827b4101c9deb22.1563150885.git.jpoimboe@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <07b8513a-d8f7-f8cf-daf6-83a80ade987a@redhat.com>
Date:   Mon, 15 Jul 2019 11:07:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1f37a9e42732c224bc5299dbc827b4101c9deb22.1563150885.git.jpoimboe@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/07/19 02:36, Josh Poimboeuf wrote:
> After making a change to improve objtool's sibling call detection, it
> started showing the following warning:
> 
>   arch/x86/kvm/vmx/nested.o: warning: objtool: .fixup+0x15: sibling call from callable instruction with modified stack frame
> 
> The problem is the ____kvm_handle_fault_on_reboot() macro.  It does a
> fake call by pushing a fake RIP and doing a jump.  That tricks the
> unwinder into printing the function which triggered the exception,
> rather than the .fixup code.
> 
> Instead of the hack to make it look like the original function made the
> call, just change the macro so that the original function actually does
> make the call.  This allows removal of the hack, and also makes objtool
> happy.
> 
> I triggered a vmx instruction exception and verified that the stack
> trace is still sane:
> 
>   kernel BUG at arch/x86/kvm/x86.c:358!
>   invalid opcode: 0000 [#1] SMP PTI
>   CPU: 28 PID: 4096 Comm: qemu-kvm Not tainted 5.2.0+ #16
>   Hardware name: Lenovo THINKSYSTEM SD530 -[7X2106Z000]-/-[7X2106Z000]-, BIOS -[TEE113Z-1.00]- 07/17/2017
>   RIP: 0010:kvm_spurious_fault+0x5/0x10
>   Code: 00 00 00 00 00 8b 44 24 10 89 d2 45 89 c9 48 89 44 24 10 8b 44 24 08 48 89 44 24 08 e9 d4 40 22 00 0f 1f 40 00 0f 1f 44 00 00 <0f> 0b 66 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 41 55 49 89 fd 41
>   RSP: 0018:ffffbf91c683bd00 EFLAGS: 00010246
>   RAX: 000061f040000000 RBX: ffff9e159c77bba0 RCX: ffff9e15a5c87000
>   RDX: 0000000665c87000 RSI: ffff9e15a5c87000 RDI: ffff9e159c77bba0
>   RBP: 0000000000000000 R08: 0000000000000000 R09: ffff9e15a5c87000
>   R10: 0000000000000000 R11: fffff8f2d99721c0 R12: ffff9e159c77bba0
>   R13: ffffbf91c671d960 R14: ffff9e159c778000 R15: 0000000000000000
>   FS:  00007fa341cbe700(0000) GS:ffff9e15b7400000(0000) knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 00007fdd38356804 CR3: 00000006759de003 CR4: 00000000007606e0
>   DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>   DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>   PKRU: 55555554
>   Call Trace:
>    loaded_vmcs_init+0x4f/0xe0
>    alloc_loaded_vmcs+0x38/0xd0
>    vmx_create_vcpu+0xf7/0x600
>    kvm_vm_ioctl+0x5e9/0x980
>    ? __switch_to_asm+0x40/0x70
>    ? __switch_to_asm+0x34/0x70
>    ? __switch_to_asm+0x40/0x70
>    ? __switch_to_asm+0x34/0x70
>    ? free_one_page+0x13f/0x4e0
>    do_vfs_ioctl+0xa4/0x630
>    ksys_ioctl+0x60/0x90
>    __x64_sys_ioctl+0x16/0x20
>    do_syscall_64+0x55/0x1c0
>    entry_SYSCALL_64_after_hwframe+0x44/0xa9
>   RIP: 0033:0x7fa349b1ee5b
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> ---
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> ---
>  arch/x86/include/asm/kvm_host.h | 33 ++++++++++++++++++---------------
>  1 file changed, 18 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 0cc5b611a113..af7e18c05f98 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1499,22 +1499,25 @@ enum {
>  /*
>   * Hardware virtualization extension instructions may fault if a
>   * reboot turns off virtualization while processes are running.
> - * Trap the fault and ignore the instruction if that happens.
> + * If that happens, trap the fault and panic (unless we're rebooting).

Not sure the comment is better than before, but apar from that

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Thanks for the cleanups!

Paolo

>   */
> -asmlinkage void kvm_spurious_fault(void);
> -
> -#define ____kvm_handle_fault_on_reboot(insn, cleanup_insn)	\
> -	"666: " insn "\n\t" \
> -	"668: \n\t"                           \
> -	".pushsection .fixup, \"ax\" \n" \
> -	"667: \n\t" \
> -	cleanup_insn "\n\t"		      \
> -	"cmpb $0, kvm_rebooting \n\t"	      \
> -	"jne 668b \n\t"      		      \
> -	__ASM_SIZE(push) " $666b \n\t"	      \
> -	"jmp kvm_spurious_fault \n\t"	      \
> -	".popsection \n\t" \
> -	_ASM_EXTABLE(666b, 667b)
> +asmlinkage void __noreturn kvm_spurious_fault(void);
> +
> +#define ____kvm_handle_fault_on_reboot(insn, cleanup_insn)		\
> +	"666: \n\t"							\
> +	insn "\n\t"							\
> +	"jmp	668f \n\t"						\
> +	"667: \n\t"							\
> +	"call	kvm_spurious_fault \n\t"				\
> +	"668: \n\t"							\
> +	".pushsection .fixup, \"ax\" \n\t"				\
> +	"700: \n\t"							\
> +	cleanup_insn "\n\t"						\
> +	"cmpb	$0, kvm_rebooting\n\t"					\
> +	"je	667b \n\t"						\
> +	"jmp	668b \n\t"						\
> +	".popsection \n\t"						\
> +	_ASM_EXTABLE(666b, 700b)
>  
>  #define __kvm_handle_fault_on_reboot(insn)		\
>  	____kvm_handle_fault_on_reboot(insn, "")
> 

