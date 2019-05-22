Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA33C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 16:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9A1920868
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 16:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b="Mawa/qrB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729884AbfEVQIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 12:08:39 -0400
Received: from mail-qt1-f174.google.com ([209.85.160.174]:35151 "EHLO
        mail-qt1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728638AbfEVQIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 12:08:39 -0400
Received: by mail-qt1-f174.google.com with SMTP id a39so3043632qtk.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 09:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google;
        h=from:date:to:subject:message-id:user-agent:mime-version;
        bh=0W5+YdyQTta665vGFYLsY3r1b4A0P0ouPgGLxR8CZ/Y=;
        b=Mawa/qrBnDwcE39kFrkUNNIp0UL1yME4LODXV0Ioleq5Ggv3nodRhWUbxwrxHD6h7q
         ZN4/muelgnxwX+TZALejEAztKSZjKjra3f7XKppWwbdlJV70+8qx5VbcA2StzUOMZV+U
         bME9r1MSESqTa4xztMDQfQFvmKRJWOgvEqcYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:subject:message-id:user-agent
         :mime-version;
        bh=0W5+YdyQTta665vGFYLsY3r1b4A0P0ouPgGLxR8CZ/Y=;
        b=Zr1bTngIJDrgOiyvkLlzGogFeUo1U68gVOxHjYGfakOMtbLmALeX27yG2JurE64cR9
         qil0KRoaZkE463uXzS+L5yQy+Db1f9tNjF+lSnBthqF0plJcH3ZB+JN7pc9BCtf67+Pp
         lREZoP6OKZ05LRh2/h+JCWm2/1ygGl+8BjQEkbXFFCRi5K8cEprueThOVegTHRG7mEtt
         rvOmjGPZ2860yCGHF46nb8+uvJrrJ94N99NNiKE5sbpPduOYfebBfHH1Bpg4UlwxwGZp
         5zilS7bQiQp3LwrBpU8quKwnU711ahGyaqg1q6fiZ42wk4qkvCXsBWXVb4w0iGYE0pj4
         2vSw==
X-Gm-Message-State: APjAAAVMXncmetEAa7fYSUXdfff0OOyV/Zjv/rW3g8EYwkpDaEQdrM4G
        WK9ggk4yduMtgNyocxr1gA+wlA==
X-Google-Smtp-Source: APXvYqyp4pPk5sl9rt+Cz7ip/kyAvyP/5GSwcGEHzrLO2xFheW0+IsSM+LkWtmFE8F24TNTd/jfF/g==
X-Received: by 2002:ac8:16c9:: with SMTP id y9mr74719118qtk.50.1558541317789;
        Wed, 22 May 2019 09:08:37 -0700 (PDT)
Received: from macbook-air (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id o63sm11808779qkf.41.2019.05.22.09.08.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 22 May 2019 09:08:36 -0700 (PDT)
From:   Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date:   Wed, 22 May 2019 12:08:31 -0400 (EDT)
X-X-Sender: vince@macbook-air
To:     Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Subject: perf: fuzzer causes crash in new XMM code
Message-ID: <alpine.DEB.2.21.1905221154300.22830@macbook-air>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The perf fuzzer caused my skylake machine to crash hard with the trace at 
the end here.  (this is with current git)

It appears to be happening in new code introduced by:

commit 878068ea270ea82767ff1d26c91583263c81fba0
Author: Kan Liang <kan.liang@linux.intel.com>
Date:   Tue Apr 2 12:44:59 2019 -0700

    perf/x86: Support outputting XMM registers


u64 perf_reg_value(struct pt_regs *regs, int idx)
{
        struct x86_perf_regs *perf_regs;

        if (idx >= PERF_REG_X86_XMM0 && idx < PERF_REG_X86_XMM_MAX) {
                perf_regs = container_of(regs, struct x86_perf_regs, regs);
===>            if (!perf_regs->xmm_regs)
                        return 0;
                return perf_regs->xmm_regs[idx - PERF_REG_X86_XMM0];
        }


[ 9679.952236] BUG: stack guard page was hit at 00000000a58f0e2f (stack is 000000007d0772c9..00000000938c7501)
[ 9679.962289] kernel stack overflow (page fault): 0000 [#1] SMP PTI
[ 9679.968575] CPU: 1 PID: 18831 Comm: perf_fuzzer Tainted: G        W         5.2.0-rc1 #37
[ 9679.976966] Hardware name: LENOVO 10FY0017US/SKYBAY, BIOS FWKT53A   06/06/2016
[ 9679.984325] RIP: 0010:perf_reg_value+0xd/0x50
[ 9679.988799] Code: 45 14 48 83 c3 20 4c 39 e3 75 c3 5b 5d 41 5c 41 5d 41 5e c3 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 8d 46 e0 83 f8 1f 77 1d <48> 8b 97 a8 00 00 00 31 c0 48 85 d2 74 0e 48 63 f6 48 8b 84 f2 00
[ 9680.008003] RSP: 0000:ffffba6000dd0bc0 EFLAGS: 00010097
[ 9680.013339] RAX: 0000000000000001 RBX: 0000000000000021 RCX: 0000000000000021
[ 9680.020658] RDX: 0000000000000021 RSI: 0000000000000021 RDI: ffffba6008d2ff58
[ 9680.027952] RBP: ffffba6000dd0c78 R08: 0000000000000000 R09: 0000000000000000
[ 9680.035262] R10: 00000000bffffff0 R11: 0000000000000005 R12: ffffba6008d2ff58
[ 9680.042564] R13: ffff94a5ebde48b0 R14: 0000000000000030 R15: 0000000000000000
[ 9680.049830] FS:  00007fccbb62e540(0000) GS:ffff94a5f5a40000(0000) knlGS:0000000000000000
[ 9680.058069] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 9680.063934] CR2: ffffba6008d30000 CR3: 000000022b7a8006 CR4: 00000000003606e0
[ 9680.071227] DR0: 0000000000000000 DR1: 0000000081007f80 DR2: 0000000000000000
[ 9680.078521] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
[ 9680.085831] Call Trace:
[ 9680.088301]  <IRQ>
[ 9680.090363]  perf_output_sample_regs+0x43/0xa0
[ 9680.094928]  perf_output_sample+0x3aa/0x7a0
[ 9680.099181]  perf_event_output_forward+0x53/0x80
[ 9680.103917]  __perf_event_overflow+0x52/0xf0
[ 9680.108266]  ? perf_trace_run_bpf_submit+0xc0/0xc0
[ 9680.113108]  perf_swevent_hrtimer+0xe2/0x150
[ 9680.117475]  ? check_preempt_wakeup+0x181/0x230
[ 9680.122091]  ? check_preempt_curr+0x62/0x90
[ 9680.126361]  ? ttwu_do_wakeup+0x19/0x140
[ 9680.130355]  ? try_to_wake_up+0x54/0x460
[ 9680.134366]  ? reweight_entity+0x15b/0x1a0
[ 9680.138559]  ? __queue_work+0x103/0x3f0
[ 9680.142472]  ? update_dl_rq_load_avg+0x1cd/0x270
[ 9680.147194]  ? timerqueue_del+0x1e/0x40
[ 9680.151092]  ? __remove_hrtimer+0x35/0x70
[ 9680.155191]  __hrtimer_run_queues+0x100/0x280
[ 9680.159658]  hrtimer_interrupt+0x100/0x220
[ 9680.163835]  smp_apic_timer_interrupt+0x6a/0x140
[ 9680.168555]  apic_timer_interrupt+0xf/0x20
[ 9680.172756]  </IRQ>
[ 9680.174905] RIP: 0033:0x55dad77a9927
[ 9680.178575] Code: 00 00 00 48 89 d1 31 c0 48 89 f2 89 fe bf 41 01 00 00 e9 4c 09 ff ff 66 2e 0f 1f 84 00 00 00 00 00 66 90 31 c9 b9 1f a1 07 00 <ff> c9 75 fc 31 c0 c3 66 90 48 8b 05 c9 96 00 00 48 89 44 24 f8 b9
[ 9680.197779] RSP: 002b:00007fff595603a8 EFLAGS: 00000206 ORIG_RAX: ffffffffffffff13
[ 9680.205489] RAX: 0000000000004985 RBX: 000000000000000c RCX: 00000000000365ca
[ 9680.212748] RDX: 00001e15d36cec84 RSI: 0000000000000000 RDI: 0000000000000001
[ 9680.220059] RBP: 00007fff595603c0 R08: 0000000000000000 R09: 00007fccbb62e540
[ 9680.227362] R10: fffffffffffffd4e R11: 0000000000000246 R12: 000055dad779a4c0
[ 9680.234630] R13: 00007fff595627b0 R14: 0000000000000000 R15: 0000000000000000
[ 9680.310017] ---[ end trace 511b9368cf14c65a ]---

