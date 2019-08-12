Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D893C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 17:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E0052067D
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 17:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQ5RmEeK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbfHLRYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 13:24:39 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33785 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbfHLRYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 13:24:38 -0400
Received: by mail-lj1-f194.google.com with SMTP id z17so10590759ljz.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 10:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wRm3to4Dq8v0Hg8U3IDeztd4CZqoW9/u9rjH8thk/0s=;
        b=LQ5RmEeKXqgPPlIkE/GrRdIHzByoeotcRGYjo/CzKA++MZfFX0LP9vApu4cAHb86Gn
         sGn9B70fpIbOnyVEe9U+weWf2Y1gv5OpsCXnw4PvA8wLrJ9kTNq6Kp8yNqqLdVE9VTyh
         HhM3zU/5hRzJGJxs93f4Y97eqxd/choYyZ3J8MVVBFLrH/epi7LCw2i2ape+Qa5fruD+
         k4cTclK0V7XdD2K3byDb782QZS6TEPilxrYpkaaTIX/melq/eOeainVTgXwQMtb6PbT4
         hgOoI/2CjVnXzILlrObj3xKSASX74bFKaOeFC6mxyRaZjd6tqKdOiqRztEldzvKcdX/O
         KOhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wRm3to4Dq8v0Hg8U3IDeztd4CZqoW9/u9rjH8thk/0s=;
        b=dId9CqlnE6jahiv88t/DSg+aYOR3osVeXeMcl1X6Z5pN1jQ/JrCTizPip+yYY5axdU
         86yMB+P+5BBjyNCzURna4VYGflixgXllkMtwzZA9w2Xk/NTXTtAwjCBk8kCSe5OgWtGo
         36B1t15XVXHGW1cRvGSkNUP/lpBYL6e8VEKdcefY7w3hb9kuBVYFIRBW3QsD9BSocoDj
         3dD1MwrXAXVz1yGgvNFM+UxYEoEshyYyquCQaIpU7Ai58lxODtc5I3W67CmwHWQLnY2i
         PwTbKGdxrWfdD31Gn9WY8k4jpN/hT3YMA65Hb2OXV6Y7lqCHbi/TEpqG43QlPr+lOLC/
         8Img==
X-Gm-Message-State: APjAAAVRwa8PHPdLUZICSRFUGtOgLYbQyfPK8GY2YCuOpGnMEiJ0k95G
        6kDgqAKho5HUgloIirgIOsM6CjDfnzbwMm4Lx9g=
X-Google-Smtp-Source: APXvYqxzlcEB4Zm5MNVorjD4kACPeQ2L92JOWEXiRmvx+GdxnwrRUDdYpmqH+O/elkCfFEY27eS7loy7tULA1M8OQGA=
X-Received: by 2002:a2e:9cc6:: with SMTP id g6mr4915175ljj.22.1565630675826;
 Mon, 12 Aug 2019 10:24:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAM_iQpXvuYKn94WjJ9nSjzhk8DzYAvDmdgxsi6cc9CdBfkdTnw@mail.gmail.com>
 <20180223121456.GZ25201@hirez.programming.kicks-ass.net> <20180226203937.GA21543@tassilo.jf.intel.com>
In-Reply-To: <20180226203937.GA21543@tassilo.jf.intel.com>
From:   Josh Hunt <joshhunt00@gmail.com>
Date:   Mon, 12 Aug 2019 10:24:24 -0700
Message-ID: <CAKA=qzYOU-VtEC5p6djRNmVS0xGe=jpTd3ZgUr++1G3Jj1=PTg@mail.gmail.com>
Subject: Re: Long standing kernel warning: perfevents: irq loop stuck!
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "Liang, Kan" <kan.liang@intel.com>, jolsa@redhat.com,
        bigeasy@linutronix.de, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 12:40 PM Andi Kleen <ak@linux.intel.com> wrote:
>
> > Given the HSD143 errata and its possible relevance, have you tried
> > changing the magic number to 32, does it then still fix things?
> >
> > No real objection to the patch as such, it just needs a coherent comment
> > and a tested-by tag I think.
>
> 128 min period will affect a lot of valid use cases with slower ticking
> events.  I often use smaller periods there.
>
> It would be better to debug this properly.
>
> Or at a minimum only do the limitation for the events that tick really
> fast (like cycles, uops retired etc.)
>
> -Andi

Was there any progress made on debugging this issue? We are still
seeing it on 4.19.44:

[ 2660.685392] ------------[ cut here ]------------
[ 2660.685392] perfevents: irq loop stuck!
[ 2660.685392] WARNING: CPU: 1 PID: 4436 at
arch/x86/events/intel/core.c:2278 intel_pmu_handle_irq+0x37b/0x530
[ 2660.685393] Modules linked in: sch_fq ip6table_raw ip6table_filter
ip6_tables iptable_raw xt_TARPIT ts_bm xt_u32 xt_recent xt_string
xt_set ip_set_hash_ip ip_set_hash_ipportip ip_set_hash_net dev_cstack
tcp_bbr tcp_qdk netconsole aep ip6_udp_tunnel udp_tunnel dm_mod
i2c_dev tcp_fast w83627ehf hwmon_vid jc42 i2c_core softdog autofs4
raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor
async_tx xor raid6_pq libcrc32c raid1 raid0 linear md_mod ext4
crc32c_generic crc16 mbcache jbd2 xt_tcpudp ipv6 iptable_filter
ip_tables ip_set nfnetlink x_tables zfs(O) zunicode(O) zavl(O) icp(O)
sr_mod zcommon(O) znvpair(O) spl(O) coretemp hwmon kvm_intel
ipmi_devintf kvm ata_piix irqbypass crc32c_intel ipmi_msghandler
i7core_edac libata lpc_ich mfd_core e1000e pcc_cpufreq
[ 2660.685405] CPU: 1 PID: 4436 Comm: xx_yyyy01 Tainted: G           O
     4.19.44 #1
[ 2660.685405] Hardware name: Ciara Technologies
[ 2660.685405] RIP: 0010:intel_pmu_handle_irq+0x37b/0x530
[ 2660.685406] Code: 00 00 bf 40 03 00 00 48 8b 40 10 e8 bf 82 9f 00
e9 f3 fc ff ff 80 3d f3 54 61 01 00 75 1a 48 c7 c7 02 00 e1 93 e8 45
8d 06 00 <0f> 0b e8 2e a9 ff ff c6 05 d7 54 61 01 01 65 4c 8b 35 5f 4f
00 6d
[ 2660.685406] RSP: 0018:fffffe0000034c40 EFLAGS: 00010086
[ 2660.685407] RAX: 000000000000001c RBX: 0000000000000064 RCX: 0000000000000002
[ 2660.685407] RDX: 0000000000000003 RSI: ffffffff93e1001e RDI: ffff926bafa555a8
[ 2660.685407] RBP: fffffe0000034e30 R08: fffffff8919fe17a R09: 0000000000000000
[ 2660.685407] R10: fffffe0000034c40 R11: 0000000000000000 R12: ffff926bafa4f3a0
[ 2660.685408] R13: ffff926b93739000 R14: 0000000000000040 R15: ffff926bafa4f5a0
[ 2660.685408] FS:  00007f0b9ccd7940(0000) GS:ffff926bafa40000(0000)
knlGS:0000000000000000
[ 2660.685408] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2660.685409] CR2: 00007f45c3497750 CR3: 000000042388e000 CR4: 00000000000007e0
[ 2660.685409] Call Trace:
[ 2660.685409]  <NMI>
[ 2660.685409]  ? perf_event_nmi_handler+0x2e/0x50
[ 2660.685409]  ? intel_pmu_save_and_restart+0x50/0x50
[ 2660.685410]  perf_event_nmi_handler+0x2e/0x50
[ 2660.685410]  nmi_handle+0x6e/0x120
[ 2660.685410]  default_do_nmi+0x3e/0x100
[ 2660.685410]  do_nmi+0x102/0x160
[ 2660.685410]  end_repeat_nmi+0x16/0x50
[ 2660.685411] RIP: 0010:native_write_msr+0x6/0x20
[ 2660.685411] Code: c3 48 c1 e2 20 48 89 d3 8b 16 48 09 c3 48 89 de
e8 bf 53 3b 00 48 89 d8 5b c3 66 2e 0f 1f 84 00 00 00 00 00 89 f9 89
f0 0f 30 <66> 66 66 66 90 c3 48 c1 e2 20 89 f6 48 09 d6 31 d2 e9 24 53
3b 00
[ 2660.685411] RSP: 0018:ffffb04661fb7c60 EFLAGS: 00000046
[ 2660.685412] RAX: 0000000000000bb0 RBX: ffff926b93739000 RCX: 000000000000038d
[ 2660.685412] RDX: 0000000000000000 RSI: 0000000000000bb0 RDI: 000000000000038d
[ 2660.685412] RBP: 000000000000000b R08: fffffff8919fe17a R09: ffffffff941602d0
[ 2660.685413] R10: ffffb04661fb7bd0 R11: 0000000000000362 R12: 0000000000000008
[ 2660.685413] R13: 0000000000000001 R14: ffff926bafa4f5c4 R15: 0000000000000001
[ 2660.685413]  ? native_write_msr+0x6/0x20
[ 2660.685413]  ? native_write_msr+0x6/0x20
[ 2660.685414]  </NMI>
[ 2660.685414]  intel_pmu_enable_event+0x1ce/0x1f0
[ 2660.685414]  x86_pmu_start+0x78/0xa0
[ 2660.685414]  x86_pmu_enable+0x252/0x310
[ 2660.685414]  __perf_event_task_sched_in+0x181/0x190
[ 2660.685415]  ? __switch_to_asm+0x34/0x70
[ 2660.685415]  ? __switch_to_asm+0x40/0x70
[ 2660.685415]  ? __switch_to_asm+0x34/0x70
[ 2660.685415]  ? __switch_to_asm+0x40/0x70
[ 2660.685416]  finish_task_switch+0x158/0x260
[ 2660.685416]  __schedule+0x2f6/0x840
[ 2660.685416]  ? hrtimer_start_range_ns+0x153/0x210
[ 2660.685416]  schedule+0x32/0x80
[ 2660.685417]  schedule_hrtimeout_range_clock+0x8a/0x100
[ 2660.685417]  ? hrtimer_init+0x120/0x120
[ 2660.685417]  ep_poll+0x2f7/0x3a0
[ 2660.685417]  ? wake_up_q+0x60/0x60
[ 2660.685417]  do_epoll_wait+0xa9/0xc0
[ 2660.685418]  __x64_sys_epoll_wait+0x1a/0x20
[ 2660.685418]  do_syscall_64+0x4e/0x110
[ 2660.685418]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 2660.685418] RIP: 0033:0x7f4d35107c03
[ 2660.685419] Code: 49 89 ca b8 e8 00 00 00 0f 05 48 3d 01 f0 ff ff
73 34 c3 48 83 ec 08 e8 cb d6 00 00 48 89 04 24 49 89 ca b8 e8 00 00
00 0f 05 <48> 8b 3c 24 48 89 c2 e8 11 d7 00 00 48 89 d0 48 83 c4 08 48
3d 01
[ 2660.685419] RSP: 002b:00007f0f6d11dd60 EFLAGS: 00000293 ORIG_RAX:
00000000000000e8
[ 2660.685420] RAX: ffffffffffffffda RBX: 000000001a3a3410 RCX: 00007f4d35107c03
[ 2660.685420] RDX: 00000000000003e8 RSI: 000000001a3a37b8 RDI: 0000000000000124
[ 2660.685420] RBP: 000000001a3a37b8 R08: 00007f4d36a86000 R09: 0000000000000000
[ 2660.685421] R10: 0000000000000004 R11: 0000000000000293 R12: 0000000000000004
[ 2660.685421] R13: 0000000000000000 R14: 000000001a3a3410 R15: 0000000000000004
[ 2660.685421] ---[ end trace 0e6128739ea4836a ]---

[ 2660.685421] CPU#1: ctrl:       0000000000000000
[ 2660.685422] CPU#1: status:     0000000400000000
[ 2660.685422] CPU#1: overflow:   0000000000000000
[ 2660.685422] CPU#1: fixed:      0000000000000bb0
[ 2660.685422] CPU#1: pebs:       0000000000000000
[ 2660.685422] CPU#1: debugctl:   0000000000000000
[ 2660.685423] CPU#1: active:     0000000600000000
[ 2660.685423] CPU#1:   gen-PMC0 ctrl:  0000000000000000
[ 2660.685423] CPU#1:   gen-PMC0 count: 0000000000000000
[ 2660.685423] CPU#1:   gen-PMC0 left:  0000000000000000
[ 2660.685424] CPU#1:   gen-PMC1 ctrl:  0000000000000000
[ 2660.685424] CPU#1:   gen-PMC1 count: 0000000000000000
[ 2660.685424] CPU#1:   gen-PMC1 left:  0000000000000000
[ 2660.685424] CPU#1:   gen-PMC2 ctrl:  0000000000000000
[ 2660.685425] CPU#1:   gen-PMC2 count: 0000000000000000
[ 2660.685425] CPU#1:   gen-PMC2 left:  0000000000000000
[ 2660.685425] CPU#1:   gen-PMC3 ctrl:  0000000000000000
[ 2660.685425] CPU#1:   gen-PMC3 count: 0000000000000000
[ 2660.685425] CPU#1:   gen-PMC3 left:  0000000000000000
[ 2660.685426] CPU#1: fixed-PMC0 count: 0000000000000000
[ 2660.685426] CPU#1: fixed-PMC1 count: 0000ffffeef5464e
[ 2660.685426] CPU#1: fixed-PMC2 count: 0000fffffffffff8
[ 2660.685426] core: clearing PMU state on CPU#1
[ 4700.443984] core: clearing PMU state on CPU#6

It does not reliably reproduce, but we have seen it in our lab. I'd be
happy to help debug, but need some guidance.
-- 
Josh
