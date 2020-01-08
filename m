Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B9C7C33C9E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 12:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D52BA206DB
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 12:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgAHMXK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 07:23:10 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:46145 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbgAHMXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 07:23:10 -0500
Received: from mail-lf1-f45.google.com ([209.85.167.45]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MUXlG-1jFWw90LXE-00QSh7 for <linux-kernel@vger.kernel.org>; Wed, 08 Jan
 2020 13:23:09 +0100
Received: by mail-lf1-f45.google.com with SMTP id 9so2278020lfq.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 04:23:08 -0800 (PST)
X-Gm-Message-State: APjAAAUTWUgAuSFWsGKV2F63gz61Xfmc2lNcxLGV70+GqE9Lh4biQl+j
        oOWW472FpWCjfJ7E9SSZL4niPd5zBmTTPJY5JiU=
X-Google-Smtp-Source: APXvYqxZVKL40UtTBnxwakO4BEP7Fg10DBHbrKV7AbfPjYEuAmDBjsakudNCB5AuWCx9OLiNKfD9haJZpMsPM/Lza9E=
X-Received: by 2002:a19:22cc:: with SMTP id i195mr2827292lfi.148.1578486188600;
 Wed, 08 Jan 2020 04:23:08 -0800 (PST)
MIME-Version: 1.0
References: <20191111131252.921588318@infradead.org> <20191111132458.220458362@infradead.org>
 <20191111164703.GA11521@willie-the-truck> <20191111171955.GO4114@hirez.programming.kicks-ass.net>
 <20191111172541.GT5671@hirez.programming.kicks-ass.net> <20191112112950.GB17835@willie-the-truck>
 <20191113092636.GG4131@hirez.programming.kicks-ass.net>
In-Reply-To: <20191113092636.GG4131@hirez.programming.kicks-ass.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 8 Jan 2020 13:22:52 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0MJGpg6AkmwRL6o7TCPOQXSMDShutigvBjeOMDn0BHaA@mail.gmail.com>
Message-ID: <CAK8P3a0MJGpg6AkmwRL6o7TCPOQXSMDShutigvBjeOMDn0BHaA@mail.gmail.com>
Subject: Re: [PATCH -v5mkII 13/17] arm/ftrace: Use __patch_text()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, bristot@redhat.com,
        Jason Baron <jbaron@akamai.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, namit@vmware.com,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jessica Yu <jeyu@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Rabin Vincent <rabin@rab.in>, Nicolas Pitre <nico@fluxnic.net>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:sSmR0fZx9K8ZOKVdELxlCTXbpKjNcSyt9EK5Sc76vueqKBjwAbx
 Q+qdThfTB0xkby4isKhgGjmxkw+Bf8auNRr+3PZ1hk8eMq9XeuAQm6+KAGbXuqou1LJGZw/
 TY4IBMuuoXmP2zQYPUSuKjgWQf1L05n06F3DmMD4YTlDtxMcp0FFIrvFN+lLFAQs275nMWr
 +lVFqMKrvK6KmTBS7YZ5g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+j8e/PRnFgU=:aCc4YJVxDVByYMxUx2ltpk
 AD7grOXeZrCDRqA+3zOcVAaoObC7m6VrczoDw0OVro2Wp3WNXDWg62vLYkQfLSifjVa0xPesi
 PPa5F53cGsgFejsqdJuc/mKIzyHRBHmjqVZAAHoxgOcUg6C9ff9wMfoCFds5di5D9K/LLWVBf
 zpUBXT6Af6xQqahblNL/xtNYjmA6ZBZ7+i9kMkO4bHf9GniWdoY/ja62BDDgMVVwyJ6lTgzHt
 RhZbye/uHoszNSfwg0TU9Zn5x4lnnj7naUj+dtxaeNfh0lETXzaeLQO3a66xZpji3E1Do76gd
 z0iK2Ew2ZuIs8mVAKy67lzrpKgwaSOqlgVOpFO27pOBr8/wLASxOruWzBrbzSlL70TSi/7XyN
 RArfBkm7ruPOVcmfo74JdE8HeV5i1nvnBuUdYsHtqnIJcYenH8HCMYfyVWaYi+EejXvGL+0Kr
 veKX/SaE2nd2NkPcOfVBlmm1gZBwWwNmibMtsC/uVourO087khEMWGUtZIiZKcrWHK8pffss4
 +c5NT5L2Xp9FqEQh8vuAaLz4WVC2uuI9Nc1Dvosrg6Fr/LZy6mKrXc0jidz3OicQCxf4Xkyks
 2mEMlokreJy480U7PAIxCasY+9h+/tyClOfAHSCUj7KYlAea5cb6SJ0qdS9A3cGutf4Qe6ZAq
 Ljhr80O2ww7I/K5Nngf1HkS8hxRbAzUcux3iYi5jMOWVP5smHaZDzhQ+TWViQQGxcBmZv/p5Z
 X/10c0VuFni1w+hp4D6AeazO9MaWnApRUlppQnCNycaUwQ5289wsX+ai00KGTIxBsbDdqpzut
 xgDWxb7twGmzpxJD5SJSCC/63UMUyT+IhKGSwPhLGjIWRrBFFnDkcLx7R6c2D8ZB4mq0znOZn
 TYhOCZBgq99kNWIM5r5w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 10:29 AM Peter Zijlstra <peterz@infradead.org> wrote:
> @@ -49,8 +49,8 @@ obj-$(CONFIG_HAVE_ARM_SCU)    += smp_scu.o
>  obj-$(CONFIG_HAVE_ARM_TWD)     += smp_twd.o
>  obj-$(CONFIG_ARM_ARCH_TIMER)   += arch_timer.o
>  obj-$(CONFIG_FUNCTION_TRACER)  += entry-ftrace.o
> -obj-$(CONFIG_DYNAMIC_FTRACE)   += ftrace.o insn.o
> -obj-$(CONFIG_FUNCTION_GRAPH_TRACER)    += ftrace.o insn.o
> +obj-$(CONFIG_DYNAMIC_FTRACE)   += ftrace.o insn.o patch.o
> +obj-$(CONFIG_FUNCTION_GRAPH_TRACER)    += ftrace.o insn.o patch.o
>  obj-$(CONFIG_JUMP_LABEL)       += jump_label.o insn.o patch.o
>  obj-$(CONFIG_KEXEC)            += machine_kexec.o relocate_kernel.o

This broke randconfig builds with big-endian ARMv5:

../arch/arm/kernel/patch.c: In function '__patch_text_real':
../arch/arm/kernel/patch.c:94:11: error: implicit declaration of
function '__opcode_to_mem_thumb32'
[-Werror=implicit-function-declaration]
    insn = __opcode_to_mem_thumb32(insn);
           ^~~~~~~~~~~~~~~~~~~~~~~

The problem is that we don't have a BE32 definition of
__opcode_to_mem_thumb32, mostly because no hardware
supports that.

One possible workaround is a big ugly:

diff --git a/arch/arm/kernel/patch.c b/arch/arm/kernel/patch.c
index d0a05a3bdb96..1067fd122897 100644
--- a/arch/arm/kernel/patch.c
+++ b/arch/arm/kernel/patch.c
@@ -90,9 +90,11 @@ void __kprobes __patch_text_real(void *addr,
unsigned int insn, bool remap)

                size = sizeof(u32);
        } else {
+#ifdef CONFIG_THUMB2_KERNEL
                if (thumb2)
                        insn = __opcode_to_mem_thumb32(insn);
                else
+#endif
                        insn = __opcode_to_mem_arm(insn);

                *(u32 *)waddr = insn;


Any other suggestions?

       Arnd
