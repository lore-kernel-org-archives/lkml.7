Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6FC8C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 15:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99A21208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 15:39:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732448AbfFYPjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 11:39:25 -0400
Received: from foss.arm.com ([217.140.110.172]:44256 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730803AbfFYPjZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 11:39:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A2D62B;
        Tue, 25 Jun 2019 08:39:24 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 971F53F718;
        Tue, 25 Jun 2019 08:39:21 -0700 (PDT)
Date:   Tue, 25 Jun 2019 16:39:19 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Will Deacon <will@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Will Deacon <will.deacon@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Olof Johansson <olof@lixom.net>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] arm64: defconfig: update and enable CONFIG_RANDOMIZE_BASE
Message-ID: <20190625153918.GA53763@arrakis.emea.arm.com>
References: <20190620003244.261595-1-ndesaulniers@google.com>
 <20190620074640.GA27228@brain-police>
 <CAKv+Gu_KCFCVxw_zAfzUf8DjD4DmhvaJEoqBsX_SigOse_NwYw@mail.gmail.com>
 <CAKwvOdmQ+WdD8nvLz_VB_5atDi56fv485Xsn+mHJZKnyj6L-JA@mail.gmail.com>
 <20190624095749.wasjfrgcda7ygdr5@willie-the-truck>
 <CAKv+Gu8G2GQGxmcAAy1XQ5gkN-2fJSWAKCQQm9T4skYdh5cT3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu8G2GQGxmcAAy1XQ5gkN-2fJSWAKCQQm9T4skYdh5cT3Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 12:06:18PM +0200, Ard Biesheuvel wrote:
> On Mon, 24 Jun 2019 at 11:57, Will Deacon <will@kernel.org> wrote:
> > Thanks for having a look. It could be that we've fixed the issue Catalin was
> > running into in the past -- he was going to see if the problem persists with
> > mainline, since it was frequent enough that it was causing us to ignore the
> > results from our testing infrastructure when RANDOMIZE_BASE=y.
> 
> I had no idea this was the case. I can look into it if we are still
> seeing failures.

I've seen the panic below with 5.2-rc1, defconfig + RANDOMIZE_BASE=y in
a guest on TX2. It takes a few tries to trigger just with kaslr,
enabling lots of other DEBUG_* options makes the failures more
deterministic. I can't really say it's kaslr's fault here, only that I
used to consistently get it in this configuration. For some reason, I
can no longer reproduce it on arm64 for-next/core (or maybe it just
takes more tries and my script doesn't catch this).

The fault is in the ip_tables module, the __this_cpu_read in
xt_write_recseq_begin() inlined in ipt_do_table(). The disassembled
sequence in my build:

0000000000000188 <ipt_do_table>:
...
     258:       d538d080        mrs     x0, tpidr_el1
     25c:       aa1303f9        mov     x25, x19
     260:       b8606b34        ldr     w20, [x25, x0]

# modprobe iptable_filter
[   45.618896] Unable to handle kernel paging request at virtual address ffffeda0ffbe1388
[   45.620545] Mem abort info:
[   45.621035]   ESR = 0x96000005
[   45.621559]   Exception class = DABT (current EL), IL = 32 bits
[   45.622527]   SET = 0, FnV = 0
[   45.623032]   EA = 0, S1PTW = 0
[   45.623684] Data abort info:
[   45.624192]   ISV = 0, ISS = 0x00000005
[   45.624849]   CM = 0, WnR = 0
[   45.625361] swapper pgtable: 4k pages, 48-bit VAs, pgdp = 0000000026cb760e
[   45.626537] [ffffeda0ffbe1388] pgd=00000000bfffa003, pud=0000000000000000
[   45.627864] Internal error: Oops: 96000005 [#1] PREEMPT SMP
[   45.628844] Modules linked in: iptable_filter cfg80211 rfkill 8021q garp crct10dif_ce stp mrp llc ip_tables x_tables ipv6
[   45.630700] Process kworker/u8:5 (pid: 173, stack limit = 0x0000000047fc7e17)
[   45.632056] CPU: 3 PID: 173 Comm: kworker/u8:5 Not tainted 5.2.0-rc1 #1
[   45.633377] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
[   45.634752] Workqueue: rpciod rpc_async_schedule
[   45.635684] pstate: 80400005 (Nzcv daif +PAN -UAO)
[   45.636674] pc : ipt_do_table+0xd8/0x4b8 [ip_tables]
[   45.637686] lr : ipt_do_table+0xc4/0x4b8 [ip_tables]
[   45.638685] sp : ffff000010aa35a0
[   45.639358] x29: ffff000010aa35a0 x28: ffffeda1f7eb0ce8
[   45.640424] x27: ffffeda1e69f1380 x26: ffff5d2c2314a288
[   45.641493] x25: ffff5d2c0cfbf388 x24: ffffeda1fb5a9000
[   45.642556] x23: ffff5d2c2314a220 x22: 0000000000000003
[   45.643636] x21: ffffeda1f79c15d8 x20: ffffeda1e69f1780
[   45.644727] x19: ffff5d2c0cfbf388 x18: 0000000000000000
[   45.645814] x17: 0000000000000000 x16: ffff5d2d0bc16d78
[   45.646908] x15: 0000000000000000 x14: 0900000017ea6502
[   45.647994] x13: 014a023b4751727f x12: 0000000000002238
[   45.649060] x11: ffff5d2d0e0de000 x10: 0000000000004000
[   45.650117] x9 : 000000000000000e x8 : ffffeda1fb5a9000
[   45.651178] x7 : ffffeda1f7eb0c00 x6 : 00000000000000e8
[   45.652263] x5 : 0000000000000080 x4 : 00009074f2c22000
[   45.653286] x3 : 0000000000000200 x2 : ffffeda1fc41c440
[   45.654314] x1 : ffff5d2c2314a000 x0 : 00009074f2c22000
[   45.655382] Call trace:
[   45.655896]  ipt_do_table+0xd8/0x4b8 [ip_tables]
[   45.656825]  iptable_filter_hook+0x1c/0x28 [iptable_filter]
[   45.657938]  nf_hook_slow+0x44/0xe8
[   45.658647]  __ip_local_out+0x150/0x250
[   45.659421]  ip_local_out+0x20/0x80
[   45.660142]  __ip_queue_xmit+0x1b0/0x540
[   45.660937]  ip_queue_xmit+0x10/0x18
[   45.661661]  __tcp_transmit_skb+0x50c/0xad8
[   45.662494]  tcp_write_xmit+0x6cc/0x1010
[   45.663294]  __tcp_push_pending_frames+0x38/0xc0
[   45.664236]  tcp_push+0x150/0x170
[   45.664912]  tcp_sendmsg_locked+0xaa0/0xc40
[   45.665754]  tcp_sendmsg+0x34/0x58
[   45.666442]  inet_sendmsg+0x48/0x210
[   45.667175]  sock_sendmsg+0x18/0x30
[   45.667889]  xs_sendpages+0xfc/0x2d8
[   45.668610]  xs_tcp_send_request+0x9c/0x1b0
[   45.669454]  xprt_transmit+0x100/0x5b8
[   45.670210]  call_transmit+0x8c/0xa0
[   45.670938]  __rpc_execute+0xbc/0x580
[   45.671687]  rpc_async_schedule+0x28/0x48
[   45.672493]  process_one_work+0x244/0x680
[   45.673306]  worker_thread+0x40/0x3f0
[   45.674053]  kthread+0x128/0x130
[   45.674710]  ret_from_fork+0x10/0x18
[   45.675436] Code: b0f4f3d3 910e2273 d538d080 aa1303f9 (b8606b34)
[   45.676665] ---[ end trace 9d1f75fe6e41c0d7 ]---
[   45.677590] Kernel panic - not syncing: Fatal exception in interrupt
[   45.678851] SMP: stopping secondary CPUs
[   45.679670] Kernel Offset: 0x5d2cfb600000 from 0xffff000010000000
[   45.680882] PHYS_OFFSET: 0xffff925ec0000000
[   45.681727] CPU features: 0x002,23800438
[   45.682518] Memory Limit: none
[   45.683143] ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---

-- 
Catalin
