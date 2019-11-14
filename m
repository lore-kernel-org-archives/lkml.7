Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39939C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 22:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6EB5206F0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 22:36:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=multiplay-co-uk.20150623.gappssmtp.com header.i=@multiplay-co-uk.20150623.gappssmtp.com header.b="J4uERKCe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfKNWgH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 17:36:07 -0500
Received: from mail-wr1-f53.google.com ([209.85.221.53]:34459 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbfKNWgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 17:36:07 -0500
Received: by mail-wr1-f53.google.com with SMTP id e6so8735069wrw.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 14:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=multiplay-co-uk.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=+3QdBRPt5T43gkcV9US6wGcZpwXlrJaX/2SMoRiI9Fg=;
        b=J4uERKCeThrj34mprbpQxzRwxbKNXbmmLvPw/1DWZpXZR/CIG4CG30blrtxrxsB77z
         MxWPcw6QNLHbpokV8nOSEJV8I3eaZL738Sa0XIuQQZyAAGkjFkuT7jzHNoY9xATwb1ZX
         uxhu0+T4u12FmGfmIeftn+zfDErEpOGn8Cl7gl5e5QLzVgKy+ncHFI0VHYlWY59CTiar
         ibkEW4X7w+5JFVEIrtnbzOffdCT02bWFJAzJvFsglVzzZNWj0VBE0rJ6MOXPQ8gB8nFi
         DwGDrwLGHMK0gXmauD8KRZ+N16FBWWor3/DmnR/7fn5LWLpq2EJ8LWyf6Vet6/UI1ao5
         f+zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=+3QdBRPt5T43gkcV9US6wGcZpwXlrJaX/2SMoRiI9Fg=;
        b=uTYQBVo62AYuvZgnNFaUe9WXTtz5EONB/GE8DZ6VPATMaO0RIhIXv7eNIEmoRMsizh
         hTLkUQJP4vbxRVleoRMn6oMPI1ZsQs3rSpM4KFRKOKexMFuJzYBaVCxcB8zo7z3yNI2d
         3h5UHPRmExjL37EWzJvfjqxGPPpXsvifS1EjwiXWr/Hebeb4TPuRB8nz4BWArfpXhSgh
         R9EvjoLk7vBG61doqL7U2AFNcdenrTRUo8CS8+lQ1xUYrePynYirw1BL9ChOb4SP/EHk
         c0mfc62R2OIUl2CvUL2leiuY6pE9O763QioebQrNR/MxJa2hnfE6UNqmVKTl5KLXtK8X
         oQ2A==
X-Gm-Message-State: APjAAAUvVDEMAtby/6j4zIC5TLNubFyNgxk6cOq2u+6whgbV4+3terNM
        gx4mmV/2+dK1nPZh/LtI2PF54gAfMHIk7w==
X-Google-Smtp-Source: APXvYqz+sFmRTzRB32O3wukrK3hyahwff42A4IJRPJv1xkfY56Vo9QDeLbKPvD8fH0ROz4rBLXiX3A==
X-Received: by 2002:adf:9d88:: with SMTP id p8mr11877880wre.286.1573770963067;
        Thu, 14 Nov 2019 14:36:03 -0800 (PST)
Received: from [10.44.128.75] ([193.117.175.106])
        by smtp.gmail.com with ESMTPSA id x9sm8634775wru.32.2019.11.14.14.36.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Nov 2019 14:36:02 -0800 (PST)
To:     linux-kernel@vger.kernel.org
From:   Steven Hartland <steven.hartland@multiplay.co.uk>
Subject: panic handling futex syscall
Message-ID: <298d1398-e37e-1bb1-a608-cd3eb08913ea@multiplay.co.uk>
Date:   Thu, 14 Nov 2019 22:36:01 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We're seeing Oops panics running a binary, which all seem to point to 
sys_futex as the cause.

We're have quite a few versions of this most haven't resulted in a full 
trace due to double faults and most won't even decode with 7.2.3 version 
of crash included in ubuntu LTS 16.04 only with 7.2.7 built from source; 
however we have one which has so here are the details:

[54978.681991] unable to execute userspace code (SMEP?) (uid: 2000)
[54978.688191] BUG: unable to handle kernel paging request at 
ffffffff93eb1990
[54978.697039] IP: _copy_from_user+0x0/0x70
[54978.701689] PGD 51b20e067 P4D 51b20e067 PUD 51b20f063 PMD 51a4000e1
[54978.708788] Oops: 0010 [#1] SMP PTI
[54978.712484] Modules linked in: binfmt_misc ipmi_devintf 
ipmi_msghandler ip6table_filter ip6_tables iptable_filter ip_tables 
x_tables input_leds pvpanic serio_raw ib_iser rdma_cm iw_cm ib_cm 
ib_core iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi autofs4 
btrfs zstd_compress raid10 raid456 async_raid6_recov async_memcpy 
async_pq async_xor async_tx xor raid6_pq raid1 raid0 multipath linear 
crct10dif_pclmul crc32_pclmul ghash_clmulni_intel pcbc aesni_intel 
aes_x86_64 crypto_simd glue_helper cryptd psmouse virtio_net
[54978.783832] CPU: 6 PID: 25729 Comm: PoolThread 6 Not tainted 
4.15.0-1041-gcp #43-Ubuntu
[54978.800464] Hardware name: Google Google Compute Engine/Google 
Compute Engine, BIOS Google 01/01/2011
[54978.809908] RIP: 0010:_copy_from_user+0x0/0x70
[54978.814470] RSP: 0018:ffffad564a203eb0 EFLAGS: 00010246
[54978.819837] RAX: 0000000000000009 RBX: 0000000000000009 RCX: 
00007f1c0672fcf8
[54978.827090] RDX: 0000000000000010 RSI: 00007f1c0672fcf8 RDI: 
ffffad564a203ee0
[54978.834344] RBP: ffffad564a203f20 R08: 00007f1c03979d20 R09: 
00000000ffffffff
[54978.841616] R10: 0000000000000000 R11: 0000000000000000 R12: 
0000000000000189
[54978.848960] R13: 00007f1c0672fcf8 R14: 00007f1c03979d4c R15: 
00000000000022a1
[54978.856219] FS:  00007f1c06730700(0000) GS:ffff9126bfd80000(0000) 
knlGS:0000000000000000
[54978.864432] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[54978.870304] CR2: ffffffff93eb1990 CR3: 0000000799a1c004 CR4: 
00000000003606e0
[54978.877563] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[54978.885368] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[54978.892636] Call Trace:
[54978.895211]  ? SyS_futex+0xbb/0x180
[54978.898825]  do_syscall_64+0x7b/0x150
[54978.903310]  entry_SYSCALL_64_after_hwframe+0x42/0xb7
[54978.908478] RIP: 0033:0x7f1c13fa6709
[54978.912170] RSP: 002b:00007f1c0672fc70 EFLAGS: 00000202 ORIG_RAX: 
00000000000000ca
[54978.919886] RAX: ffffffffffffffda RBX: 00007f1c03979d48 RCX: 
00007f1c13fa6709
[54978.927139] RDX: 00000000000022a1 RSI: 0000000000000189 RDI: 
00007f1c03979d4c
[54978.934407] RBP: 0000000000000001 R08: 00007f1c03979d20 R09: 
00000000ffffffff
[54978.941674] R10: 00007f1c0672fcf8 R11: 0000000000000202 R12: 
00000000000022a1
[54978.948930] R13: 00007f1c0672fcf8 R14: ffffffffffffff92 R15: 
000000005dc96200
[54978.956185] Code: d2 60 4f 00 74 15 4c 89 e7 e8 cd 1b 50 00 0f b6 45 
ef 48 83 c4 08 5b 41 5c 5d c3 48 83 c4 08 b8 01 00 00 00 5b 41 5c 5d c3 
90 90 <55> 65 48 8b 04 25 00 5c 01 00 48 89 e5 41 55 41 54 53 48 89 d3
[54978.975188] RIP: _copy_from_user+0x0/0x70 RSP: ffffad564a203eb0
[54978.981214] CR2: ffffffff93eb1990

       KERNEL: /usr/lib/debug/boot/vmlinux-4.15.0-1041-gcp
     DUMPFILE: /var/crash/201911111331/dump.201911111331  [PARTIAL DUMP]
         CPUS: 8
         DATE: Mon Nov 11 13:30:54 2019
       UPTIME: 03:52:51
LOAD AVERAGE: 1.52, 0.57, 0.37
        TASKS: 402
     NODENAME: p-gce-XXX
      RELEASE: 4.15.0-1041-gcp
      VERSION: #43-Ubuntu SMP Wed Aug 21 09:04:51 UTC 2019
      MACHINE: x86_64  (2000 Mhz)
       MEMORY: 30 GB
        PANIC: "BUG: unable to handle kernel paging request at 
ffffffff93eb1990"
          PID: 25729
      COMMAND: "PoolThread 6"
         TASK: ffff912678c98000  [THREAD_INFO: ffff912678c98000]
          CPU: 6
        STATE: TASK_RUNNING (PANIC)

crash> dis -l ffffffff93eb1990
/build/linux-gcp-lp4Fx0/linux-gcp-4.15.0/lib/usercopy.c: 8
0xffffffff93eb1990 <_copy_from_user>:   push   %rbp
/build/linux-gcp-lp4Fx0/linux-gcp-4.15.0/arch/x86/include/asm/current.h: 15
0xffffffff93eb1991 <_copy_from_user+1>: mov %gs:0x15c00,%rax
/build/linux-gcp-lp4Fx0/linux-gcp-4.15.0/lib/usercopy.c: 8
0xffffffff93eb199a <_copy_from_user+10>:        mov %rsp,%rbp
0xffffffff93eb199d <_copy_from_user+13>:        push   %r13
0xffffffff93eb199f <_copy_from_user+15>:        push   %r12
0xffffffff93eb19a1 <_copy_from_user+17>:        push   %rbx
0xffffffff93eb19a2 <_copy_from_user+18>:        mov %rdx,%rbx
/build/linux-gcp-lp4Fx0/linux-gcp-4.15.0/lib/usercopy.c: 11
0xffffffff93eb19a5 <_copy_from_user+21>:        mov 0x1358(%rax),%rdx
/build/linux-gcp-lp4Fx0/linux-gcp-4.15.0/arch/x86/include/asm/uaccess.h: 61
0xffffffff93eb19ac <_copy_from_user+28>:        mov %rsi,%rax
/build/linux-gcp-lp4Fx0/linux-gcp-4.15.0/lib/usercopy.c: 8
0xffffffff93eb19af <_copy_from_user+31>:        mov %rdi,%r12
/build/linux-gcp-lp4Fx0/linux-gcp-4.15.0/arch/x86/include/asm/uaccess.h: 61
0xffffffff93eb19b2 <_copy_from_user+34>:        mov %rbx,%r13
0xffffffff93eb19b5 <_copy_from_user+37>:        add %rbx,%rax
0xffffffff93eb19b8 <_copy_from_user+40>:        jb 0xffffffff93eb19d8 
<_copy_from_user+72>
/build/linux-gcp-lp4Fx0/linux-gcp-4.15.0/lib/usercopy.c: 11
0xffffffff93eb19ba <_copy_from_user+42>:        cmp %rax,%rdx
0xffffffff93eb19bd <_copy_from_user+45>:        jb 0xffffffff93eb19c9 
<_copy_from_user+57>
/build/linux-gcp-lp4Fx0/linux-gcp-4.15.0/arch/x86/include/asm/uaccess_64.h: 
37
0xffffffff93eb19bf <_copy_from_user+47>:        mov %ebx,%edx
0xffffffff93eb19c1 <_copy_from_user+49>:        callq 0xffffffff943a38e0 
<copy_user_enhanced_fast_string>
/build/linux-gcp-lp4Fx0/linux-gcp-4.15.0/arch/x86/include/asm/uaccess_64.h: 
46
0xffffffff93eb19c6 <_copy_from_user+54>:        mov %eax,%r13d
/build/linux-gcp-lp4Fx0/linux-gcp-4.15.0/lib/usercopy.c: 15
0xffffffff93eb19c9 <_copy_from_user+57>:        test %r13,%r13
0xffffffff93eb19cc <_copy_from_user+60>:        jne 0xffffffff93eb19d8 
<_copy_from_user+72>
/build/linux-gcp-lp4Fx0/linux-gcp-4.15.0/lib/usercopy.c: 18
0xffffffff93eb19ce <_copy_from_user+62>:        pop    %rbx
0xffffffff93eb19cf <_copy_from_user+63>:        mov %r13,%rax
0xffffffff93eb19d2 <_copy_from_user+66>:        pop    %r12
0xffffffff93eb19d4 <_copy_from_user+68>:        pop    %r13
0xffffffff93eb19d6 <_copy_from_user+70>:        pop    %rbp
0xffffffff93eb19d7 <_copy_from_user+71>:        retq
/build/linux-gcp-lp4Fx0/linux-gcp-4.15.0/include/linux/string.h: 332
0xffffffff93eb19d8 <_copy_from_user+72>:        sub %r13,%rbx
0xffffffff93eb19db <_copy_from_user+75>:        mov %r13,%rdx
0xffffffff93eb19de <_copy_from_user+78>:        xor %esi,%esi
0xffffffff93eb19e0 <_copy_from_user+80>:        lea (%r12,%rbx,1),%rdi
0xffffffff93eb19e4 <_copy_from_user+84>:        callq 0xffffffff943a60e0 
<__memset>
/build/linux-gcp-lp4Fx0/linux-gcp-4.15.0/lib/usercopy.c: 18
0xffffffff93eb19e9 <_copy_from_user+89>:        mov %r13,%rax
0xffffffff93eb19ec <_copy_from_user+92>:        pop    %rbx
0xffffffff93eb19ed <_copy_from_user+93>:        pop    %r12
0xffffffff93eb19ef <_copy_from_user+95>:        pop    %r13
0xffffffff93eb19f1 <_copy_from_user+97>:        pop    %rbp
0xffffffff93eb19f2 <_copy_from_user+98>:        retq
0xffffffff93eb19f3 <_copy_from_user+99>:        nopl   (%rax)
0xffffffff93eb19f6 <_copy_from_user+102>:       nopw %cs:0x0(%rax,%rax,1)

Other relevant info:
Linux version 4.15.0-1041-gcp (buildd@lgw01-amd64-018) (gcc version 
5.4.0 20160609 (Ubuntu 5.4.0-6ubuntu1~16.04.10)) #43-Ubuntu SMP Wed Aug 
21 09:04:51 UTC 2019

Linux p-gce-XXX 4.15.0-1041-gcp #43-Ubuntu SMP Wed Aug 21 09:04:51 UTC 
2019 x86_64 x86_64 x86_64 GNU/Linux

GNU C                   5.4.0
GNU Make                4.1
Binutils                2.26.1
Util-linux              2.27.1
Mount                   2.27.1
Module-init-tools       22
E2fsprogs               1.42.13
Xfsprogs                4.3.0
Linux C Library         2.23
Dynamic linker (ldd)    2.23
Linux C++ Library       6.0.21
Procps                  3.3.10
Net-tools               1.60
Kbd                     1.15.5
Console-tools           1.15.5
Sh-utils                8.25
Udev                    229
Modules Loaded          aesni_intel aes_x86_64 async_memcpy async_pq 
async_raid6_recov async_tx async_xor autofs4 binfmt_misc btrfs 
crc32_pclmul crct10dif_pclmul cryptd crypto_simd ghash_clmulni_intel 
glue_helper ib_cm ib_core ib_iser input_leds ip6table_filter ip6_tables 
ipmi_devintf ipmi_msghandler iptable_filter ip_tables iscsi_tcp iw_cm 
libiscsi libiscsi_tcp linear multipath pcbc psmouse pvpanic raid0 raid10 
raid1 raid456 raid6_pq rdma_cm scsi_transport_iscsi serio_raw virtio_net 
xor x_tables zstd_compress

     Regards
     Steve
