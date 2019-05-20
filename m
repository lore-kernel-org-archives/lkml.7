Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBEBEC04E87
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 910A62081C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:08:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731211AbfETIIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 04:08:21 -0400
Received: from ivanoab6.miniserver.com ([5.153.251.140]:58424 "EHLO
        www.kot-begemot.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727720AbfETIIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 04:08:20 -0400
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1hSdL2-0002PP-9N; Mon, 20 May 2019 08:08:04 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
        by jain.kot-begemot.co.uk with esmtp (Exim 4.89)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1hSdKz-0007w1-OP; Mon, 20 May 2019 09:08:03 +0100
Subject: Re: [PATCH] x86: Hide the int3_emulate_call/jmp functions from UML
To:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        linux-um@lists.infradead.org
References: <20190511083954.23a60052@gandalf.local.home>
From:   Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <41bc0b7b-9f51-6a10-6182-811163aa0890@cambridgegreys.com>
Date:   Mon, 20 May 2019 09:08:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190511083954.23a60052@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Clacks-Overhead: GNU Terry Pratchett
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/05/2019 13:39, Steven Rostedt wrote:
> 
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> User Mode Linux does not have access to the ip or sp fields of the
> pt_regs, and accessing them causes UML to fail to build. Hide the
> int3_emulate_jmp() and int3_emulate_call() instructions from UML, as it
> doesn't need them anyway.
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
> 
> [ I added this to my queue to test too ]
> 
>   arch/x86/include/asm/text-patching.h | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/text-patching.h
> b/arch/x86/include/asm/text-patching.h index 05861cc08787..0bbb07eaed6b
> 100644 --- a/arch/x86/include/asm/text-patching.h
> +++ b/arch/x86/include/asm/text-patching.h
> @@ -39,6 +39,7 @@ extern int poke_int3_handler(struct pt_regs *regs);
>   extern void *text_poke_bp(void *addr, const void *opcode, size_t len,
> void *handler); extern int after_bootmem;
>   
> +#ifndef CONFIG_UML_X86
>   static inline void int3_emulate_jmp(struct pt_regs *regs, unsigned
> long ip) {
>   	regs->ip = ip;
> @@ -65,6 +66,7 @@ static inline void int3_emulate_call(struct pt_regs
> *regs, unsigned long func) int3_emulate_push(regs, regs->ip -
> INT3_INSN_SIZE + CALL_INSN_SIZE); int3_emulate_jmp(regs, func);
>   }
> -#endif
> +#endif /* CONFIG_X86_64 */
> +#endif /* !CONFIG_UML_X86 */
>   
>   #endif /* _ASM_X86_TEXT_PATCHING_H */
> 
The patch has been garbled by an auto-wrap. Can you resend it please.

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/
