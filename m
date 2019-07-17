Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE3D2C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 09:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BED620880
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 09:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=etsukata-com.20150623.gappssmtp.com header.i=@etsukata-com.20150623.gappssmtp.com header.b="I7aJrzEm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbfGQJhH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 05:37:07 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41495 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbfGQJhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 05:37:06 -0400
Received: by mail-pf1-f193.google.com with SMTP id m30so10566661pff.8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 02:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsukata-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9DC+VLDk8GbdaxKaGFWdz4oQuvhft+ehWftwCduju/g=;
        b=I7aJrzEmMEGOVj1xm1Qs/kMdFx6xWPoQ+AzId8zK8CBDt9JF9nwa4w+jmH+tWRBoHG
         T7yau1eQvMQhUzWu/rXc3kG14ai2zUMCBiKwzL9DqfhOsX4pdXpCWWYU9VtP0x9D4LbA
         Jv9NzEUKVahGSfGVZsRiDgSIp+tKj2F5RvIJBp9mXvkxbE//BQLi1G0jEeMco9oQnyx3
         okZmofExkCXxdzEcksc4VFbhZv4+2HaD9TddJXxZY4LdtI4HVeotsbilHPKa5k4w0y98
         iSAWcJnyngBRoUplJsOVQtybcdiYs6gHnowq0/Hofd+S3XoSQsMUNZxttElBUR+jOf79
         ixwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=9DC+VLDk8GbdaxKaGFWdz4oQuvhft+ehWftwCduju/g=;
        b=CQoL/53V6FkfVo68t57Dx+jOaTByESmfrGDd6CxvuA04kgJNssaDSKqejZmuwexftJ
         V6ih/LNqqRRaJhYmPB3zhnswUD8SbOgi7uwZpoVx3GseeH50WLJNQqiIqkeuED/xi3hk
         nRKJYV07ilyo3aArFqdoedsQ9JY2ura0EQbOCabFh1DfQQr9bvyyaz0lxI+hUFwG83m3
         QDYSfWGy23ZHr//MEUhBc4Mzl+cAU4zdczO0muaJyV7Qh1vlLEoM3L5U/K1xtu0TP7Cm
         +YQhOob8ZXoTPfyLgWscj1jPvYoNCnFmumZNM8QOS+/qttnmkIG2Ht+naAXv+Ec09bkC
         Ikdw==
X-Gm-Message-State: APjAAAV8j0d2e7gHOPg7urfrSjz5P75iE8lgGyDQ4mBaO2gwRQHawc89
        pTMlXZiGfF5UsDyDIKE6RXTixVoC
X-Google-Smtp-Source: APXvYqyO3chLnlhHLfoLfALf0f+Z5a97984TFHJOrjTKk4+L9H9cBhTjsIUgDI68Bc8K8wbU8CtH6g==
X-Received: by 2002:a63:ed06:: with SMTP id d6mr39960453pgi.267.1563356225597;
        Wed, 17 Jul 2019 02:37:05 -0700 (PDT)
Received: from etsukata.local (fs76eecbcd.tkyc008.ap.nuro.jp. [118.238.203.205])
        by smtp.gmail.com with ESMTPSA id 34sm23310281pgl.15.2019.07.17.02.37.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jul 2019 02:37:04 -0700 (PDT)
Subject: Re: [PATCH v3 0/6] Tracing vs CR2
To:     Vegard Nossum <vegard.nossum@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        bp@alien8.de, mingo@kernel.org, rostedt@goodmis.org,
        luto@kernel.org, torvalds@linux-foundation.org,
        linux_lkml_grp@oracle.com
Cc:     hpa@zytor.com, dave.hansen@linux.intel.com, jgross@suse.com,
        linux-kernel@vger.kernel.org, zhe.he@windriver.com,
        joel@joelfernandes.org
References: <20190711114054.406765395@infradead.org>
 <4c71e14d-3a32-c3bb-8e3b-6e5100853192@oracle.com>
 <97cdd0af-95cc-2583-dc19-129b20809110@oracle.com>
From:   Eiichi Tsukata <devel@etsukata.com>
Openpgp: preference=signencrypt
Autocrypt: addr=devel@etsukata.com; keydata=
 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
Message-ID: <d82854b2-d2a4-5b83-b4a4-796db0fd401b@etsukata.com>
Date:   Wed, 17 Jul 2019 18:37:00 +0900
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <97cdd0af-95cc-2583-dc19-129b20809110@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/07/17 6:51, Vegard Nossum wrote:
> 
...
> 
> Got a different one:
> 
> WARNING: CPU: 0 PID: 2150 at arch/x86/kernel/traps.c:791 do_debug+0xfe/0x240
> CPU: 0 PID: 2150 Comm: init Not tainted 5.2.0+ #124
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Ubuntu-1.8.2-1ubuntu1 04/01/2014
> RIP: 0010:do_debug+0xfe/0x240
...


Hello Vegard

I found a way to reproduce #DB WARNING by setting hardware watchpoint to
the address arch_stack_walk_user() will touch.


[Steps to Reproduce #DB WARNING]

poc.s:

```
        .global _start

        .text
_start:
        # exit(0)
        mov $60, %rax
        xor %rdi, %rdi
        syscall
```

build:

  # gcc -g -c poc.s; ld -o poc poc.o

setup ftrace:

  # echo 1 > options/userstacktrace
  # echo 1 > events/preemptirq/irq_disable/enable

exec gdb:(set hardware watch point to $rbp)

  [18:28:48 root@vm loops]# gdb ./poc
  GNU gdb (GDB) Fedora 8.3-6.fc30
  Copyright (C) 2019 Free Software Foundation, Inc.
  License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
  This is free software: you are free to change and redistribute it.
  There is NO WARRANTY, to the extent permitted by law.
  Type "show copying" and "show warranty" for details.
  This GDB was configured as "x86_64-redhat-linux-gnu".
  Type "show configuration" for configuration details.
  For bug reporting instructions, please see:
  <http://www.gnu.org/software/gdb/bugs/>.
  Find the GDB manual and other documentation resources online at:
      <http://www.gnu.org/software/gdb/documentation/>.

  For help, type "help".
  Type "apropos word" to search for commands related to "word"...
  Reading symbols from ./poc...
  (gdb) l
  1               .global _start
  2
  3               .text
  4       _start:
  5               # exit(0)
  6               mov $60, %rax
  7               xor %rdi, %rdi
  8               syscall
  (gdb) b 6
  Breakpoint 1 at 0x401000: file poc.s, line 6.
  (gdb) start
  Function "main" not defined.
  Make breakpoint pending on future shared library load? (y or [n]) n
  Starting program: /root/tmp/loops/poc

  Breakpoint 1, _start () at poc.s:6
  6               mov $60, %rax
  (gdb) set $rbp = $rsp
  (gdb) p $rbp
  $1 = (void *) 0x7fffffffe4b0
  (gdb) rwatch *0x7fffffffe4b0
  Hardware read watchpoint 2: *0x7fffffffe4b0
  (gdb) c
  Continuing.
  [Inferior 1 (process 2744) exited normally]

dmesg:

[  564.646159][ T2744] WARNING: CPU: 0 PID: 2744 at arch/x86/kernel/traps.c:791 do_debug+0x220/0x490
[  564.648581][ T2744] Modules linked in:
[  564.649530][ T2744] CPU: 0 PID: 2744 Comm: poc Tainted: G        W         5.2.0+ #77
[  564.651121][ T2744] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-2.fc30 04/01/2014
[  564.653569][ T2744] RIP: 0010:do_debug+0x220/0x490
[  564.654847][ T2744] Code: 00 48 8b 95 60 ff ff ff 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 03 02 00 00 41 f6 87 88 00 00 00 03 75 60 <0f> 0b 4c 89 f2 49 81 e5 ff bf ff ff 48 b8 00 00 00 00 00 fc ff df
[  564.659905][ T2744] RSP: 0000:fffffe0000014e98 EFLAGS: 00010046
[  564.661500][ T2744] RAX: dffffc0000000000 RBX: 1fffffc0000029d8 RCX: 1ffff1100f81c2d3
[  564.663531][ T2744] RDX: 1fffffc0000029fc RSI: 0000000000000000 RDI: ffffffff85c19f00
[  564.665553][ T2744] RBP: fffffe0000014f48 R08: fffffe0000014fe8 R09: ffff88807c0e08a0
[  564.667637][ T2744] R10: 0000000000000001 R11: 1ffff1100d1042ba R12: ffff88807c0e0000
[  564.669700][ T2744] R13: 0000000000004001 R14: ffff88807c0e1698 R15: fffffe0000014f58
[  564.671768][ T2744] FS:  0000000000000000(0000) GS:ffff888068800000(0000) knlGS:0000000000000000
[  564.674032][ T2744] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  564.675752][ T2744] CR2: 0000000000000001 CR3: 000000005fe08002 CR4: 0000000000160ef0
[  564.677570][ T2744] DR0: 00007fffffffe4b0 DR1: 0000000000000000 DR2: 0000000000000000
[  564.679686][ T2744] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 00000000000f0602
[  564.681788][ T2744] Call Trace:
[  564.682700][ T2744]  <#DB>
[  564.683492][ T2744]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[  564.684954][ T2744]  ? do_int3+0x1f0/0x1f0
[  564.686074][ T2744]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[  564.687512][ T2744]  debug+0x2d/0x70
[  564.688456][ T2744] RIP: 0010:arch_stack_walk_user+0x7d/0xf2
[  564.689899][ T2744] Code: 00 0f 85 8d 00 00 00 49 8b 87 d8 16 00 00 48 83 e8 10 49 39 c6 77 32 41 83 87 e8 15 00 00 01 0f 1f 00 0f ae e8 31 c0 49 8b 0e <85> c0 75 6d 49 8b 76 08 0f 1f 00 85 c0 74 1f 65 48 8b 04 25 00 ef
[  564.694763][ T2744] RSP: 0000:ffff888061fb7c48 EFLAGS: 00000046
[  564.696316][ T2744] RAX: 0000000000000000 RBX: ffff88807c0e0000 RCX: 0000000000000001
[  564.698342][ T2744] RDX: 1ffff1100ba08e93 RSI: 0000000000401009 RDI: ffff888061fb7cbc
[  564.700323][ T2744] RBP: ffff888061fb7c80 R08: 1ffff1100ba08e93 R09: ffff88805d04749c
[  564.702337][ T2744] R10: ffffed100ba08e9b R11: ffff88805d0474db R12: ffff888061fb7cb0
[  564.704359][ T2744] R13: ffff888061fb7f58 R14: 00007fffffffe4b0 R15: ffff88807c0e0000
[  564.706413][ T2744]  </#DB>
[  564.707182][ T2744]  ? stack_trace_save+0xc0/0xc0
[  564.708447][ T2744]  stack_trace_save_user+0x138/0x160
[  564.709752][ T2744]  ? stack_trace_save_tsk_reliable+0x210/0x210
[  564.711235][ T2744]  ? kasan_check_read+0x11/0x20
[  564.712358][ T2744]  trace_buffer_unlock_commit_regs+0x208/0x360
[  564.713871][ T2744]  trace_event_buffer_commit+0x1a0/0x790
[  564.715278][ T2744]  ? trace_event_buffer_reserve+0x163/0x240
[  564.716742][ T2744]  trace_event_raw_event_preemptirq_template+0x156/0x200
[  564.718431][ T2744]  ? perf_trace_preemptirq_template+0x490/0x490
[  564.719761][ T2744]  ? rcu_irq_enter_irqson+0x23/0x30
[  564.721064][ T2744]  ? trace_hardirqs_off+0x28/0x180
[  564.722337][ T2744]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[  564.723729][ T2744]  ? debug+0x49/0x70
[  564.724703][ T2744]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[  564.726113][ T2744]  ? perf_trace_preemptirq_template+0x490/0x490
[  564.727721][ T2744]  trace_hardirqs_off_caller+0x106/0x170
[  564.729154][ T2744]  ? debug+0x44/0x70
[  564.730108][ T2744]  trace_hardirqs_off_thunk+0x1a/0x1c
[  564.731456][ T2744]  debug+0x49/0x70
[  564.732278][ T2744] RIP: 0033:0x401009
[  564.733155][ T2744] Code: Bad RIP value.
[  564.734019][ T2744] RSP: 002b:00007fffffffe4b0 EFLAGS: 00000302
[  564.735366][ T2744] RAX: 000000000000003c RBX: 0000000000000000 RCX: 0000000000000000
[  564.737290][ T2744] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[  564.739314][ T2744] RBP: 00007fffffffe4b0 R08: 0000000000000000 R09: 0000000000000000
[  564.741338][ T2744] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[  564.743311][ T2744] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[  564.745463][ T2744] irq event stamp: 3340
[  564.746554][ T2744] hardirqs last  enabled at (3339): [<ffffffff82a04c12>] trace_hardirqs_on_thunk+0x1a/0x1c
[  564.748558][ T2744] hardirqs last disabled at (3340): [<ffffffff82d28b32>] rcu_irq_enter_irqson+0x12/0x30
[  564.750479][ T2744] softirqs last  enabled at (3330): [<ffffffff85a00634>] __do_softirq+0x634/0x9f1
[  564.752737][ T2744] softirqs last disabled at (3319): [<ffffffff82b77920>] irq_exit+0x150/0x180
[  564.754933][ T2744] ---[ end trace 67c6e66ff6ba5cd0 ]---


