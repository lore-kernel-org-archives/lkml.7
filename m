Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1493AC0650E
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 11:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFF7220863
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 11:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=etsukata-com.20150623.gappssmtp.com header.i=@etsukata-com.20150623.gappssmtp.com header.b="TO6mEpaM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfGFLH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 07:07:28 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45020 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbfGFLH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 07:07:28 -0400
Received: by mail-pl1-f195.google.com with SMTP id t14so2700963plr.11
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jul 2019 04:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsukata-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:references:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Pk4PrgLLVdx4xtTOSI/M+KUxYjAwOS3icMsQzvS73t0=;
        b=TO6mEpaMCuU20l+ev7t1crfF9OivHkvDUPOtOeyVdRLJ2/DBVkoVASmweLawKc4+jH
         PZjAzETIHN/VqL0eRsCKrNwgGhfN6SZDBIzZwX0S687wkOckRsGeTJK/kPkw5Bz/x3Gh
         tCsVQFXkoyj+DPzqhP+jgaH5kr9e1eKNX25wqD5uIl5ZZJundgXev5Hd+/kJQX1CESqw
         yrHR/Xdl4Lq2gSbkF8SaMQ4d8pJAs5+GUvL9y9ChJXXXA4sqwcCr3BAT/LvtKV1RWeFj
         0VRF4c4QFmizqjbYIvdlH4EyjKuOVQ5BclMS1Zmz+SPHYez+2U1gritC33yB5HgrW4iF
         zW+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Pk4PrgLLVdx4xtTOSI/M+KUxYjAwOS3icMsQzvS73t0=;
        b=flL66TJDkFd5GLnc6OLoovTcArZkyxigaDu3ccvU9CoeB0c1Gtirh8eshMcxfLQQRE
         Gr+YK/GDvA3Nf0rgOyNdiCDnubZIY+dJ63SP5Njf7mJNbTRHLEuaRmrSZPZ17lBHGpLM
         MkG//e2rQD00S4Td0bFOluIXMr6jDcrr2fZokp7fY6ClpU+MoBF4RpQs7rQsMUEPhv5D
         sgr/7XR3GL3JdEmw3DiQdZIZoFz8skoSIhbs+m7xt7RzXPCh0FZCNLc94bL9WAmDZedf
         wnTCoo4Eor9C95ITdmVDz7X8FOx5xxgRvL4FYL7aneRWR1HAHzvLZIkJGInAgRkcJ7g8
         PKmA==
X-Gm-Message-State: APjAAAW+t8vjZccmh8oJQCic7U/tYJuiHmnkIF05Zw2pNRGL6BpJZot3
        xzXbwXVgtKXT+gJTqi4+s5RSeg==
X-Google-Smtp-Source: APXvYqw14Z0JIw92fRxK1PVVwEmwSOmiMoAQ1TefLIP16eBfi3Feiu59d9V0y97PAj5cEcS5rgr4rQ==
X-Received: by 2002:a17:902:4283:: with SMTP id h3mr10633025pld.15.1562411247154;
        Sat, 06 Jul 2019 04:07:27 -0700 (PDT)
Received: from Etsukata.local (p2517222-ipngn21701marunouchi.tokyo.ocn.ne.jp. [118.7.246.222])
        by smtp.gmail.com with ESMTPSA id x128sm30503111pfd.17.2019.07.06.04.07.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Jul 2019 04:07:26 -0700 (PDT)
From:   Eiichi Tsukata <devel@etsukata.com>
Subject: Re: [PATCH v2 5/7] x86/mm, tracing: Fix CR2 corruption
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Peter Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        He Zhe <zhe.he@windriver.com>,
        Joel Fernandes <joel@joelfernandes.org>
References: <20190704195555.580363209@infradead.org>
 <20190704200050.534802824@infradead.org>
 <CAHk-=wiJ4no+TW-8KTfpO-Q5+aaTGVoBJzrnFTvj_zGpVbrGfA@mail.gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=devel@etsukata.com; keydata=
 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
Message-ID: <a4a50e28-d972-3cef-b668-1e49d5b5496f@etsukata.com>
Date:   Sat, 6 Jul 2019 20:07:22 +0900
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAHk-=wiJ4no+TW-8KTfpO-Q5+aaTGVoBJzrnFTvj_zGpVbrGfA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/07/05 11:18, Linus Torvalds wrote:
> On Fri, Jul 5, 2019 at 5:03 AM Peter Zijlstra <peterz@infradead.org> wrote:
>>
>> Despire the current efforts to read CR2 before tracing happens there
>> still exist a number of possible holes:
> 
> So this whole series disturbs me for the simple reason that I thought
> tracing was supposed to save/restore cr2 and make it unnecessary to
> worry about this in non-tracing code.
> 
> That is very much what the NMI code explicitly does. Why shouldn't all
> the other tracing code do the same thing in case they can take page
> faults?
> 
> So I don't think the patches are wrong per se, but this seems to solve
> it at the wrong level.
> 
>                  Linus
> 

Steven previously tried to fix it by saving CR2 in TRACE_IRQS_OFF:
https://lore.kernel.org/lkml/20190320221534.165ab87b@oasis.local.home/

But hit the following WARNING:
https://lore.kernel.org/lkml/20190321095502.47b51356@gandalf.local.home/

I tried to find out the root cause of the WARNING, and found that it is
caused by touching trace point(TRACE_IRQS_OFF) before search_binary_handler()
at exeve.

To prevent userstack trace code from reading user stack before it becomes ready,
checking current->in_execve in stack_trace_save_user() can help Steven's approach,
though trace_sched_process_exec() is called before current->in_execve = 0 so it changes
current behavior.

The PoC code is as follows:

diff --git a/arch/x86/kernel/stacktrace.c b/arch/x86/kernel/stacktrace.c
index 2abf27d7df6b..30fa6e1b7a87 100644
--- a/arch/x86/kernel/stacktrace.c
+++ b/arch/x86/kernel/stacktrace.c
@@ -116,10 +116,12 @@ void arch_stack_walk_user(stack_trace_consume_fn consume_entry, void *cookie,
                          const struct pt_regs *regs)
 {
        const void __user *fp = (const void __user *)regs->bp;
+       unsigned long address;
 
        if (!consume_entry(cookie, regs->ip, false))
                return;
 
+       address = read_cr2();
        while (1) {
                struct stack_frame_user frame;
 
@@ -131,11 +133,14 @@ void arch_stack_walk_user(stack_trace_consume_fn consume_entry, void *cookie,
                        break;
                if (frame.ret_addr) {
                        if (!consume_entry(cookie, frame.ret_addr, false))
-                               return;
+                               break;
                }
                if (fp == frame.next_fp)
                        break;
                fp = frame.next_fp;
        }
+
+       if (address != read_cr2())
+               write_cr2(address);
 }
 
diff --git a/kernel/stacktrace.c b/kernel/stacktrace.c
index 36139de0a3c4..489d33bb5d28 100644
--- a/kernel/stacktrace.c
+++ b/kernel/stacktrace.c
@@ -230,6 +230,9 @@ unsigned int stack_trace_save_user(unsigned long *store, unsigned int size)
        /* Trace user stack if not a kernel thread */
        if (!current->mm)
                return 0;
+       /* current can reach some trace points before its stack is ready */
+       if (current->in_execve)
+               return 0;
 
        arch_stack_walk_user(consume_entry, &c, task_pt_regs(current));
        return c.len;
  



