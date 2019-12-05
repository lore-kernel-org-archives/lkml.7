Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F12CAC43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 12:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD5DA2464D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 12:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729314AbfLEMac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 07:30:32 -0500
Received: from foss.arm.com ([217.140.110.172]:60952 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729117AbfLEMac (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 07:30:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C0E231B;
        Thu,  5 Dec 2019 04:30:31 -0800 (PST)
Received: from arm.com (e112269-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ABE333F68E;
        Thu,  5 Dec 2019 04:30:30 -0800 (PST)
Date:   Thu, 5 Dec 2019 12:30:26 +0000
From:   Steven Price <steven.price@arm.com>
To:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: linux-next 20191204: crash in mm/pagewalk.c
Message-ID: <20191205123025.GA46328@arm.com>
References: <4587.1575548582@turing-police>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4587.1575548582@turing-police>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2019 at 12:23:02PM +0000, Valdis Klētnieks wrote:
> linux-next 20191204 dies a horrid death on my laptop while booting:

This is due to an unfortunate conflict between my series reworking of
the page walk infrastructure to reuse it for kernel walks and a commit
by Thomas Hellstrom to allow safe modification of entries in the
callback. See [1] for more detail.

I believe Andrew has dropped my series for now while I rework it to fix
this conflict.

Steve

[1] https://lore.kernel.org/linux-arm-kernel/20191204163235.GA1597@arm.com/

> [   12.344975] Write protecting the kernel read-only data: 26624k
> [   12.348497] Freeing unused kernel image (text/rodata gap) memory: 2036K
> [   12.349701] Freeing unused kernel image (rodata/data gap) memory: 1056K
> [   12.349756] BUG: kernel NULL pointer dereference, address: 0000000000000018
> [   12.349810] #PF: supervisor read access in kernel mode
> [   12.349904] #PF: error_code(0x0000) - not-present page
> [   12.349920] PGD 0 P4D 0
> [   12.349996] Oops: 0000 [#1] SMP
> [   12.350012] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G                T 5.4.0-next-20191204-dirty #703
> [   12.350031] Hardware name: TOSHIBA Satellite C55-B/ZBWAA, BIOS 5.00 07/23/2015
> [   12.350055] RIP: 0010:__lock_acquire+0x465/0x810
> [   12.350132] Code: 00 85 c0 74 10 44 8b 25 79 17 ba 01 45 85 e4 0f 84 c4 30 00 00 45 31 e4 48 83 c4 30 44 89 e0 5b 41 5c 41 5d 41 5e 41 5f 5d c3 <49> 81 3e 60 32 0c 9d 41 ba 00 00 00 00 45 0f 45 d7 41 83 fc 01 0f
> [   12.350163] RSP: 0018:ffffb2f940053b70 EFLAGS: 00010002
> [   12.350179] RAX: ffff8896c7d74040 RBX: 0000000000000000 RCX: 0000000000000000
> [   12.350195] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000018
> [   12.350211] RBP: ffffb2f940053bc8 R08: 0000000000000001 R09: 0000000000000000
> [   12.350227] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
> [   12.350305] R13: 0000000000000000 R14: 0000000000000018 R15: 0000000000000001
> [   12.350323] FS:  0000000000000000(0000) GS:ffff8897f7a00000(0000) knlGS:0000000000000000
> [   12.350340] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   12.350355] CR2: 0000000000000018 CR3: 0000000028a24000 CR4: 00000000001006f0
> [   12.350370] Call Trace:
> [   12.350385]  ? __bfs+0x2c/0x300
> [   12.350404]  lock_acquire+0x90/0x170
> [   12.350421]  ? walk_pgd_range+0x556/0x7b0
> [   12.350441]  _raw_spin_lock+0x31/0x70
> [   12.350463]  ? walk_pgd_range+0x556/0x7b0
> [   12.350479]  walk_pgd_range+0x556/0x7b0
> [   12.350500]  __walk_page_range+0x1a5/0x1c0
> [   12.350517]  ? __lock_acquired+0x1f8/0x310
> [   12.350534]  walk_page_range_novma+0x72/0xc0
> [   12.350553]  ptdump_walk_pgd+0x47/0x80
> [   12.350570]  ptdump_walk_pgd_level_core+0xc3/0xf0
> [   12.350588]  ? ptdump_walk_pgd_level_debugfs+0x30/0x30
> [   12.350683]  ? 0xffffffff9b000000
> [   12.350699]  ptdump_walk_pgd_level_checkwx+0x19/0x1b
> [   12.350717]  mark_rodata_ro+0xc2/0xc9
> [   12.350732]  ? rest_init+0x2c1/0x2eb
> [   12.350747]  kernel_init+0x3d/0x105
> [   12.350761]  ? rest_init+0x2eb/0x2eb
> [   12.350783]  ret_from_fork+0x3a/0x50
> [   12.350797] Modules linked in:
> [   12.350810] CR2: 0000000000000018
> [   12.350822] ---[ end trace 5060898a61f6b985 ]---
> [   12.424261] probe of 1-1 returned 1 after 1829 usecs
> [   12.453678] calling  sdhci_drv_init+0x0/0x4a @ 1
> [   12.527751] RIP: 0010:__lock_acquire+0x465/0x810
> [   12.527771] Code: 00 85 c0 74 10 44 8b 25 79 17 ba 01 45 85 e4 0f 84 c4 30 00 00 45 31 e4 48 83 c4 30 44 89 e0 5b 41 5c 41 5d 41 5e 41 5f 5d c3 <49> 81 3e 60 32 0c 9d 41 ba 00 00 00 00 45 0f 45 d7 41 83 fc 01 0f
> [   12.527792] RSP: 0018:ffffb2f940053b70 EFLAGS: 00010002
> [   12.527803] RAX: ffff8896c7d74040 RBX: 0000000000000000 RCX: 0000000000000000
> [   12.527814] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000018
> [   12.527825] RBP: ffffb2f940053bc8 R08: 0000000000000001 R09: 0000000000000000
> [   12.527836] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
> [   12.527846] R13: 0000000000000000 R14: 0000000000000018 R15: 0000000000000001
> [   12.527858] FS:  0000000000000000(0000) GS:ffff8897f7a00000(0000) knlGS:0000000000000000
> [   12.527879] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   12.527894] CR2: 0000000000000018 CR3: 000000023060a000 CR4: 00000000001006f0
> [   12.527911] Kernel panic - not syncing: Fatal exception
> 


