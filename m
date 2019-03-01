Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F767C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 22:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 432B920848
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 22:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YI20aabl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbfCAWD1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 17:03:27 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33340 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfCAWD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 17:03:27 -0500
Received: by mail-pl1-f195.google.com with SMTP id y10so12130686plp.0;
        Fri, 01 Mar 2019 14:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=y947FJGfU9mB3J3mmZUEkpmJCbN6ZHl8etoK8obmHEg=;
        b=YI20aablCoYVoSrRrIvLtSW/Ads9/FHmqppuD8aPvNDf8vtD1EI3bfY2YInA8IfsVp
         qC6jqauZTPZMYH0zZLZ1fIIjp1Q2ZTL/ltcAFjLAROIewuLVLHdFJxSNsExplqbXnLvW
         3wGY2RCLFrBtC5TtJzESCsqdBxJmniD1tT0FXWF3Gj0swWswPSNYqwDvCno6dvY8JwBo
         JpzK450Js1NrKMpuHDK8kV7AUhP2vARZFw51qIjDRT2YO+P14VY+Arl02lY6oM1A1N1E
         kqYuoZ/EjbrHDQq4Y7mJrTT1g/eO9xq/JsWKtHoVxLyZ9u9g5t7w3VNkLSLEE17CJY7w
         1FaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=y947FJGfU9mB3J3mmZUEkpmJCbN6ZHl8etoK8obmHEg=;
        b=mKW8vWZ7NxTFUp3h63rk+JAKQbEtDS9JCNWfJLhAaZO9n3gD1ygF5QcfbXha0GAEAs
         gw3q1XkI6zIS99sA9lafQfmdirObbB+tMylbeTPF8n4Yuy3YG8KvPpaFIgqmcZbUgUQQ
         VIJ3biIHYQmIoJZS3gX6fuLVMOBYjXCBFUgTSPIfxihKqm1+JdELrSTdqsDjQzDofdgP
         U3i4dhAup3IcRHjptOJUDdYRYfItUhuof8yJ2565sikXMvTOWpK7D0yJkqBhg3/1OQrV
         YuUrC5RPmxbvgdg94PzozvOa75Zn21qEjEESaTY6MuZSwnh6xDgU+IVcovbcCwiHc2ir
         u0/A==
X-Gm-Message-State: APjAAAV1C//gyBMiyDkr/tvVdk5FD1P/XB9Ubr2NsDlW4ZdH1LIR28hO
        en8xDUKdh5fNbz70E5vGYHo=
X-Google-Smtp-Source: APXvYqx+Q+fX7f4Kmhn1GetX6wVK2bNMG/fOkBg/4fmeQa32T1rNkRHg4tQm2DwhHUKi5eK8vBuNSg==
X-Received: by 2002:a17:902:e3:: with SMTP id a90mr7603545pla.45.1551477806240;
        Fri, 01 Mar 2019 14:03:26 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j9sm35993161pfc.67.2019.03.01.14.03.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Mar 2019 14:03:25 -0800 (PST)
Date:   Fri, 1 Mar 2019 14:03:23 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bpf: enable program stats
Message-ID: <20190301220323.GA13770@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Feb 25, 2019 at 02:28:39PM -0800, Alexei Starovoitov wrote:
> JITed BPF programs are indistinguishable from kernel functions, but unlike
> kernel code BPF code can be changed often.
> Typical approach of "perf record" + "perf report" profiling and tuning of
> kernel code works just as well for BPF programs, but kernel code doesn't
> need to be monitored whereas BPF programs do.
> Users load and run large amount of BPF programs.
> These BPF stats allow tools monitor the usage of BPF on the server.
> The monitoring tools will turn sysctl kernel.bpf_stats_enabled
> on and off for few seconds to sample average cost of the programs.
> Aggregated data over hours and days will provide an insight into cost of BPF
> and alarms can trigger in case given program suddenly gets more expensive.
> 
> The cost of two sched_clock() per program invocation adds ~20 nsec.
> Fast BPF progs (like selftests/bpf/progs/test_pkt_access.c) will slow down
> from ~10 nsec to ~30 nsec.
> static_key minimizes the cost of the stats collection.
> There is no measurable difference before/after this patch
> with kernel.bpf_stats_enabled=0
> 

This patch causes my qemu tests for 'parisc' to crash. Reverting this patch
as well as "bpf: expose program stats via bpf_prog_info" fixes the problem.

Crash log and bisect results are attached. Bisect ends with the merge;
I identified the two patches manually.

I suspect that
	prog->aux->stats = alloc_percpu_gfp(struct bpf_prog_stats, gfp_flags);
	...
	u64_stats_init(&prog->aux->stats->syncp);
may be wrong. At the very least it looks odd, and I don't find a similar use
of u64_stats_init() anywhere else in the kernel.

Guenter

---
Crash logs:

..
PDC_CHASSIS: Fault (1), CHASSIS  0
Backtrace:
 [<109c6dac>] bpf_prog_create+0x58/0xc4
 [<10131fd0>] 0x10131fd0
 [<101314ac>] 0x101314ac
 [<1018e1c4>] do_one_initcall+0x54/0x1a8
 [<101011e8>] 0x101011e8
 [<10b218d0>] kernel_init+0x1c/0x150
 [<1019601c>] ret_from_kernel_thread+0x1c/0x24
Kernel Fault: Code=18 (Data memory protection/unaligned access trap) at addr 10193fd0
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.0.0-rc8-next-20190301 #1
Hardware name: 9000/778/B160L
     YZrvWESTHLNXBCVMcbcbcbcbOGFRQPDI
PSW: 00000000000001000011111100001111 Not tainted
r00-03  00043f0f 1017ec10 10260078 2f83c380
r04-07  00000dc0 00810000 2f834620 10dbbb44
r08-11  10dcf000 00000002 10179528 10e4cc10
r12-15  10e4cc10 1013c010 00000008 f0018f04
r16-19  f001672e 00000001 00000028 1131d000
r20-23  00000000 11370fd8 00000018 00000006
r24-27  00000018 00000000 2f834620 10db9c10
r28-31  10193fc0 00000400 2f83c400 11370fc0
sr00-03  00000000 00000000 00000000 00000000
sr04-07  00000000 00000000 00000000 00000000
IASQ: 00000000 00000000 IAOQ: 10260088 1026008c
 IIR: 6b800020    ISR: 00000000  IOR: 10193fd0
 CPU:        0   CR30: 2f83c000 CR31: 00000000
 ORIG_R28: 00000000
 IAOQ[0]: bpf_prog_alloc+0x50/0x8c
 IAOQ[1]: bpf_prog_alloc+0x54/0x8c
 RP(r2): bpf_prog_alloc+0x40/0x8c
Backtrace:
 [<109c6dac>] bpf_prog_create+0x58/0xc4
 [<10131fd0>] 0x10131fd0
 [<101314ac>] 0x101314ac
 [<1018e1c4>] do_one_initcall+0x54/0x1a8
 [<101011e8>] 0x101011e8
 [<10b218d0>] kernel_init+0x1c/0x150
 [<1019601c>] ret_from_kernel_thread+0x1c/0x24
SeaBIOS wants SYSTEM HALT.

Note: The missing call is from ptp_classifier_init(), called from
sock_init(). The actual crash occurs in u64_stats_init().

---
Another crash log:

...
random: get_random_u32 called from bucket_table_alloc+0xa0/0x1e4 with crng_init=0
clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
futex hash table entries: 1024 (order: 3, 49152 bytes)
xor: measuring software checksum speed
   8regs     :  1326.000 MB/sec
   8regs_prefetch:   719.000 MB/sec
   32regs    :   722.000 MB/sec
   32regs_prefetch:   690.000 MB/sec
xor: using function: 8regs (1326.000 MB/sec)
PDC_CHASSIS: Fault (1), CHASSIS  0
Backtrace:
 [<109c6dac>] bpf_prog_create+0x58/0xc4
 [<10131fd0>] 0x10131fd0
 [<101314ac>] 0x101314ac
 [<1018e1c4>] do_one_initcall+0x54/0x1a8
 [<101011e8>] 0x101011e8
 [<10b218d0>] kernel_init+0x1c/0x150
 [<1019601c>] ret_from_kernel_thread+0x1c/0x24
Kernel Fault: Code=18 (Data memory protection/unaligned access trap) at addr 10193fd0
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.0.0-rc8-next-20190301 #1
Hardware name: 9000/778/B160L
     YZrvWESTHLNXBCVMcbcbcbcbOGFRQPDI
PSW: 00000000000001100011111100001111 Not tainted
r00-03  00063f0f 1017ec10 10260078 2fc3c380
r04-07  00000dc0 00810000 2fc356e0 10dbbb44
r08-11  10dcf000 00000002 10179528 10e4cc10
r12-15  10e4cc10 1013c010 00000008 f0018f04
r16-19  f001672e 00000001 00000028 1131d000
r20-23  00000000 11370fd8 00000018 00000006
r24-27  00000018 00000000 2fc356e0 10db9c10
r28-31  10193fc0 00000400 2fc3c400 11370fc0
sr00-03  00000000 00000000 00000000 00000000
sr04-07  00000000 00000000 00000000 00000000
IASQ: 00000000 00000000 IAOQ: 10260088 1026008c
 IIR: 6b800020    ISR: 00000000  IOR: 10193fd0
 CPU:        0   CR30: 2fc3c000 CR31: 00000000
 ORIG_R28: 00000000
 IAOQ[0]: bpf_prog_alloc+0x50/0x8c
 IAOQ[1]: bpf_prog_alloc+0x54/0x8c
 RP(r2): bpf_prog_alloc+0x40/0x8c
Backtrace:
 [<109c6dac>] bpf_prog_create+0x58/0xc4
 [<10131fd0>] 0x10131fd0
 [<101314ac>] 0x101314ac
 [<1018e1c4>] do_one_initcall+0x54/0x1a8
 [<101011e8>] 0x101011e8
 [<10b218d0>] kernel_init+0x1c/0x150
 [<1019601c>] ret_from_kernel_thread+0x1c/0x24
SeaBIOS wants SYSTEM HALT.

---
# bad: [42fd8df9d1d9c83046226e771a4f5f3d05a706ff] Add linux-next specific files for 20190228
# good: [5908e6b738e3357af42c10e1183753c70a0117a9] Linux 5.0-rc8
git bisect start 'HEAD' 'v5.0-rc8'
# good: [7c3eb312dbd9653e6a932eec87ae55d0a0cc43b6] Merge remote-tracking branch 'net-next/master'
git bisect good 7c3eb312dbd9653e6a932eec87ae55d0a0cc43b6
# bad: [f7ae930a8cb9ca6429ac096c7fdac52560732524] Merge remote-tracking branch 'spi/for-next'
git bisect bad f7ae930a8cb9ca6429ac096c7fdac52560732524
# bad: [45821a15aebf0d27a37dfa9e8fc0ed4e6bfa9307] Merge remote-tracking branch 'drm/drm-next'
git bisect bad 45821a15aebf0d27a37dfa9e8fc0ed4e6bfa9307
# good: [148fb2e2e38769d99e3dfafdc03d06eeedcf7ad3] Merge branch 'drm-next-5.1' of git://people.freedesktop.org/~agd5f/linux into drm-next
git bisect good 148fb2e2e38769d99e3dfafdc03d06eeedcf7ad3
# good: [a5f2fafece141ef3509e686cea576366d55cabb6] Merge https://gitlab.freedesktop.org/drm/msm into drm-next
git bisect good a5f2fafece141ef3509e686cea576366d55cabb6
# bad: [07b71f8ab1b2714eef4f00eed8086fbeb30f85bf] Merge remote-tracking branch 'mtd/mtd/next'
git bisect bad 07b71f8ab1b2714eef4f00eed8086fbeb30f85bf
# bad: [3e23a64449722b73f941341f3a4b91a4963d3b0e] Merge remote-tracking branch 'wireless-drivers-next/master'
git bisect bad 3e23a64449722b73f941341f3a4b91a4963d3b0e
# bad: [236de6acd6dd91716cdc468e6ba3b413324d4064] Merge remote-tracking branch 'netfilter-next/master'
git bisect bad 236de6acd6dd91716cdc468e6ba3b413324d4064
# good: [d2e614cb0795d935aee879e47aab231247274f13] samples: bpf: fix: broken sample regarding removed function
git bisect good d2e614cb0795d935aee879e47aab231247274f13
# good: [03fe5efc4c9c8c7157092d0cbb5d1bbea629ce48] netfilter: nat: remove csum_update hook
git bisect good 03fe5efc4c9c8c7157092d0cbb5d1bbea629ce48
# good: [35acfbab6e5b229ea3c4807d1949c3ab8fda9818] netfilter: remove unneeded switch fall-through
git bisect good 35acfbab6e5b229ea3c4807d1949c3ab8fda9818
# good: [a01cbae57ec29b161d42ee1caa4ffffda5d519c2] netfilter: nft_set_hash: bogus element self comparison from deactivation path
git bisect good a01cbae57ec29b161d42ee1caa4ffffda5d519c2
# good: [123f89c8aab782854d8b27b1c01f3f2cff33c20d] netfilter: nft_set_hash: remove nft_hash_key()
git bisect good 123f89c8aab782854d8b27b1c01f3f2cff33c20d
# bad: [688a5cf30666a8145c3ef8da6d089e6a9cdc414d] Merge remote-tracking branch 'bpf-next/master'
git bisect bad 688a5cf30666a8145c3ef8da6d089e6a9cdc414d
# first bad commit: [688a5cf30666a8145c3ef8da6d089e6a9cdc414d] Merge remote-tracking branch 'bpf-next/master'

