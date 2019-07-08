Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2792C606A7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 09:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9346420844
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 09:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=etsukata-com.20150623.gappssmtp.com header.i=@etsukata-com.20150623.gappssmtp.com header.b="CISax33a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729942AbfGHJmW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 05:42:22 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40066 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729108AbfGHJmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 05:42:21 -0400
Received: by mail-pg1-f195.google.com with SMTP id w10so7372246pgj.7
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 02:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsukata-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=M/4OrivpT6+lXaU8memgsxuzGhSKdcr+fhQ4zWWlSDI=;
        b=CISax33ahqtT1Cvdt550qk1ojeaBh79r3plhsEt7rFT9YWV+ZUMicp3Kwioloci9zT
         yU2hIgRYRyDiG2aa1iB60s/crpVVYRShXFX3+f4ThsFpyoxaTg7M39jEiDw5qrhT6JhU
         E2yaVveqzIsoO0YerxGikUVMl+OiqfndkGcTsM9xpMMZpaykplhnTXJuXeNmByyH2LH+
         ASWXK+rePVGpqK93LqnBN6uKNKBoORRys+VyvDjBDNe0Jqx8sWDyOL5QqEPzT+i8EnVq
         rgcp+RkH7WmztJHxtlazLmn1lwd8Anv/CevTfMHQXrUrDShpCj4J5BFLjvMcyRdb3+qx
         HrMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=M/4OrivpT6+lXaU8memgsxuzGhSKdcr+fhQ4zWWlSDI=;
        b=bAuaZHWfP6XGW5s5CUR1yKdNOVcfiDWwnM1Lkf+eob04FnGy4V1xLMAd6VFjxdE1GX
         hCz+bnELGjWwy2YwzGZe1RUMEk6pPnXhgxe0HHofd8gSSyz4K+w55doUon27mQ3RJurB
         i0LdOGzkS0rCKR5K4VmPHIwyEkPMa6FS7/qxE9m7R9ekqRaRbDWlerFV0RrGV+RHyvoR
         Lo8r0tGRDdxpFjRl1X32eZFwv/eCblh0k2ay+RBIKFXkM+i8aOT2WoHfFKg6sRBm6F4b
         DLtDQlUP36KTolFXObEoK9AKYHCHr9u+HEmpdIyimWZdIT/3UdARU5KTZ3qSN7XEsNtx
         NUFg==
X-Gm-Message-State: APjAAAWiRw6gi6giKb/wofJNq67Y8ASUkc3EAwbMn6T4MNL4STjHi98a
        XdDTWp6tyMYc63IeijlDt07/qBMOgnU=
X-Google-Smtp-Source: APXvYqwULBSzBMAtHokX7PqUSuXM1IDUa7J/rAfwkxzrLgdQKwaRTTFQRZ/e7c8Y5C8f0XXStBxSIw==
X-Received: by 2002:a17:90a:2627:: with SMTP id l36mr24606720pje.71.1562578940830;
        Mon, 08 Jul 2019 02:42:20 -0700 (PDT)
Received: from etsukata.local (fs76eecbcd.tkyc008.ap.nuro.jp. [118.238.203.205])
        by smtp.gmail.com with ESMTPSA id o12sm13846102pjr.22.2019.07.08.02.42.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 02:42:20 -0700 (PDT)
Subject: Re: [PATCH v2 5/7] x86/mm, tracing: Fix CR2 corruption
From:   Eiichi Tsukata <devel@etsukata.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
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
 <a4a50e28-d972-3cef-b668-1e49d5b5496f@etsukata.com>
 <20190708074823.GV3402@hirez.programming.kicks-ass.net>
 <48e29640-fedc-3e72-535c-27ef07b73938@etsukata.com>
Openpgp: preference=signencrypt
Autocrypt: addr=devel@etsukata.com; keydata=
 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
Message-ID: <c6dce7ee-3e11-c110-fd64-035e049cde37@etsukata.com>
Date:   Mon, 8 Jul 2019 18:42:15 +0900
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <48e29640-fedc-3e72-535c-27ef07b73938@etsukata.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/07/08 17:58, Eiichi Tsukata wrote:

> 
> By the way, is there possibility that the WARNING(#GP in execve(2)) which Steven
> previously hit? : https://lore.kernel.org/lkml/20190321095502.47b51356@gandalf.local.home/
> 
> Even if there were, it will *Not* be the bug introduced by this patch series,
> but the bug revealed by this series.
> 

I reproduced with the kernel:
  - https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?h=x86/core&id=057b48d544b384c47ed921f616128b802ab1fdc3

Reproducer:

  # echo 1 > events/preemptirq/irq_disable/enable
  # echo userstacktrace > trace_options
  # service sshd restart

[   20.338200] ------------[ cut here ]------------
[   20.339471] General protection fault in user access. Non-canonical address?
[   20.339488] WARNING: CPU: 1 PID: 1957 at arch/x86/mm/extable.c:126 ex_handler_uaccess+0x52/0x60
[   20.342550] Modules linked in:
[   20.343209] CPU: 1 PID: 1957 Comm: systemctl Tainted: G        W         5.2.0-rc7+ #48
[   20.344935] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-2.fc30 04/01/2014
[   20.346688] RIP: 0010:ex_handler_uaccess+0x52/0x60
[   20.347667] Code: c4 08 b8 01 00 00 00 5b 5d c3 80 3d b6 8c 94 01 00 75 db 48 c7 c7 b8 e4 6f aa 48 89 75 f0 c6 05 ad
[   20.351508] RSP: 0018:ffffb28940453688 EFLAGS: 00010082
[   20.352707] RAX: 0000000000000000 RBX: ffffffffaa2023c0 RCX: 0000000000000001
[   20.354478] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffffaa7dab8d
[   20.355706] RBP: ffffb28940453698 R08: 0000000000000000 R09: 0000000000000001
[   20.356665] R10: 0000000000000000 R11: 0000000000000000 R12: ffffb28940453728
[   20.357594] R13: 0000000000000000 R14: 000000000000000d R15: 0000000000000000
[   20.358876] FS:  00007fec9fa248c0(0000) GS:ffff921d3d800000(0000) knlGS:0000000000000000
[   20.360573] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   20.361792] CR2: 0000000000000004 CR3: 0000000074d4e000 CR4: 00000000000006e0
[   20.363300] Call Trace:
[   20.363830]  fixup_exception+0x4a/0x61
[   20.364637]  __idt_do_general_protection+0x65/0x1d0
[   20.365684]  do_general_protection+0x1e/0x30
[   20.366654]  general_protection+0x1e/0x30
[   20.367513] RIP: 0010:arch_stack_walk_user+0x7a/0x100
[   20.368583] Code: 00 01 1f 00 0f 85 8d 00 00 00 49 8b 87 98 16 00 00 48 83 e8 10 49 39 c6 77 32 41 83 87 d0 15 00 04
[   20.372797] RSP: 0018:ffffb289404537d0 EFLAGS: 00010046
[   20.374027] RAX: 0000000000000000 RBX: ffff921d383bcb00 RCX: 0074726174736572
[   20.375674] RDX: ffff921d38393b84 RSI: 7265732e64687373 RDI: ffffb28940453818
[   20.377179] RBP: ffffb28940453808 R08: 0000000000000001 R09: ffff921d3d169c00
[   20.378681] R10: 0000000000000b60 R11: ffff921d38393b70 R12: ffffb28940453818
[   20.380195] R13: ffffb28940453f58 R14: 0074726174736572 R15: ffff921d383bcb00
[   20.381703]  ? profile_setup.cold+0x9b/0x9b
[   20.382604]  stack_trace_save_user+0x60/0x7d
[   20.383520]  trace_buffer_unlock_commit_regs+0x17b/0x220
[   20.384686]  trace_event_buffer_commit+0x6b/0x200
[   20.385741]  trace_event_raw_event_preemptirq_template+0x7b/0xc0
[   20.387067]  ? get_page_from_freelist+0x10a/0x13b0
[   20.388129]  ? __alloc_pages_nodemask+0x178/0x380
[   20.389132]  trace_hardirqs_off+0xc6/0x100
[   20.390006]  get_page_from_freelist+0x10a/0x13b0
[   20.390997]  ? kvm_clock_read+0x18/0x30
[   20.391813]  ? sched_clock+0x9/0x10
[   20.392647]  __alloc_pages_nodemask+0x178/0x380
[   20.393706]  alloc_pages_current+0x87/0xe0
[   20.394609]  __page_cache_alloc+0xcd/0x110
[   20.395491]  __do_page_cache_readahead+0xa1/0x1a0
[   20.396547]  ondemand_readahead+0x220/0x540
[   20.397486]  page_cache_sync_readahead+0x35/0x50
[   20.398511]  generic_file_read_iter+0x8d8/0xbd0
[   20.399335]  ? __might_sleep+0x4b/0x80
[   20.400110]  ext4_file_read_iter+0x35/0x40
[   20.400937]  new_sync_read+0x10f/0x1a0
[   20.401833]  __vfs_read+0x29/0x40
[   20.402608]  vfs_read+0xc0/0x170
[   20.403319]  kernel_read+0x31/0x50
[   20.404128]  prepare_binprm+0x150/0x190
[   20.404766]  __do_execve_file.isra.0+0x4c0/0xaa0
[   20.405559]  __x64_sys_execve+0x39/0x50
[   20.406173]  do_syscall_64+0x55/0x1b0
[   20.406762]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[   20.407703] RIP: 0033:0x7fec9f0ee647
[   20.408441] Code: ff 76 e0 f7 d8 64 41 89 01 eb d8 0f 1f 84 00 00 00 00 00 f7 d8 64 41 89 01 eb d7 0f 1f 84 00 00 08
[   20.411636] RSP: 002b:00007ffe7f316228 EFLAGS: 00000202 ORIG_RAX: 000000000000003b
[   20.412686] RAX: ffffffffffffffda RBX: 00007fec9f8105a4 RCX: 00007fec9f0ee647
[   20.414047] RDX: 00007ffe7f3167d8 RSI: 00007ffe7f316230 RDI: 00007fec9f73cea0
[   20.415048] RBP: 00007ffe7f316480 R08: 0000000000000030 R09: 0000000000000001
[   20.416076] R10: 00007ffe7f316498 R11: 0000000000000202 R12: 00007fec9f73cea0
[   20.417556] R13: 0000000000000001 R14: 0000000000000001 R15: 0000000000000000
[   20.419032] irq event stamp: 832
[   20.419493] hardirqs last  enabled at (831): [<ffffffffa94b9f2e>] __find_get_block+0xde/0x360
[   20.420649] hardirqs last disabled at (832): [<ffffffffa9305ad2>] rcu_irq_enter_irqson+0x12/0x30
[   20.422179] softirqs last  enabled at (436): [<ffffffffaa20037f>] __do_softirq+0x37f/0x472
[   20.423286] softirqs last disabled at (291): [<ffffffffa927bce3>] irq_exit+0xb3/0xd0
[   20.424296] ---[ end trace cdb84a67edcdc420 ]---
