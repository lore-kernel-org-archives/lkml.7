Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A2BC74A22
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 13:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D1562084B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 13:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562765295;
	bh=q8GjbjSImP7tzaAMbCpFOr1U3p0VFW84U6lPth4uWLU=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=H96/cr2NBBbG2Q2HSi/6zQnNTbt1Zhs0cqAd5hOuGADn59zfiiNd0HMqeAq8V7fyY
	 ClqslOCruXSwbofX1CHEsb6XzfgABrr121OMMSqR9+ZIUd/Umt3H7DjwHEFYJP7Pu1
	 P6IubqeHlHFfxlMPf8lDqmEOizMKNDC15IYSjU2A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbfGJN2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 09:28:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:48260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725994AbfGJN2N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 09:28:13 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65AAA2064B;
        Wed, 10 Jul 2019 13:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562765293;
        bh=q8GjbjSImP7tzaAMbCpFOr1U3p0VFW84U6lPth4uWLU=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=BO/GDZr7U/7GyYq6P32WmgyeBwVrY68wmrKvwkY7q8NxVGZLoXl+3sFAFnDMG0OTG
         JxGSSvdlhpMJkTXu1zpGmkAiXge4pojZCWvcVoWHOCvS0RHU0FBoXipssAXWtTaQ1U
         d6oxT8concyGAp4y66n0tqi9E9Pqj8Rw655CteQo=
Date:   Wed, 10 Jul 2019 15:28:04 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Thomas Gleixner <tglx@linutronix.de>,
        Xi Ruoyao <xry111@mengyan1223.wang>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>, Len Brown <lenb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Bob Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Nadav Amit <namit@vmware.com>
Subject: Re: [GIT PULL] x86/topology changes for v5.3
In-Reply-To: <nycvar.YFH.7.76.1907101523550.5899@cbobk.fhfr.pm>
Message-ID: <nycvar.YFH.7.76.1907101527380.5899@cbobk.fhfr.pm>
References: <CAHk-=whJtbQFHNtNG7t7y6+oEKLpjj3eSQOrr3OPCVGbMaRz-A@mail.gmail.com> <CAHk-=wh7NChJP+WkaDd3qCz847Fq4NdQ6z6m-VFpbr3py_EknQ@mail.gmail.com> <alpine.DEB.2.21.1907100023020.1758@nanos.tec.linutronix.de> <alpine.DEB.2.21.1907100039540.1758@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1907100115220.1758@nanos.tec.linutronix.de> <201907091727.91CC6C72D8@keescook> <1ad2de95e694a29909801d022fe2d556df9a4bd5.camel@mengyan1223.wang> <cb6d381ed7cd0bf732ae9d8f30c806b849b0f94b.camel@mengyan1223.wang>
 <alpine.DEB.2.21.1907101404570.1758@nanos.tec.linutronix.de> <nycvar.YFH.7.76.1907101425290.5899@cbobk.fhfr.pm> <20190710132144.GM3402@hirez.programming.kicks-ass.net> <nycvar.YFH.7.76.1907101523550.5899@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Jul 2019, Jiri Kosina wrote:

> On Wed, 10 Jul 2019, Peter Zijlstra wrote:
> 
> > > > BUG: unable to handle page fault for address: ffffffff9edc1598
> > > > #PF: supervisor write access in kernel mode
> > > > #PF: error_code(0x0003) - permissions violation
> > > > PGD 1a20c067 P4D 1a20c067 PUD 1a20d063 PMD 8000000019e000e1 
> > > > Oops: 0003 [#1] SMP PTI
> > > > 2 PID: 151 Comm: systemd-udevd Not tainted 5.2.0+ #54
> > > > Hardware name: LENOVO 20175/INVALID, BIOS 66CN54WW 01/21/2013
> > > > RIP: 0010:static_key_set_mod.isra.0+0x10/0x30
> > > > Code: 48 8b 37 83 e6 03 48 09 c6 48 89 37 c3 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f0 a8 03 75 0d 48 8b 37 83 e6 03 48 09 c6 <48> 89 37 c3 0f 0b 48 8b 37 83 e6 03 48 09 c6 48 89 37 c3 66 66 2e
> > > > RSP: 0000:ffffa606c032bc98 EFLAGS: 00010286
> > > > RAX: ffff9981ddce30a0 RBX: ffffffff9edc1590 RCX: 0000000000000000
> > > > RDX: 0000000000000020 RSI: ffff9981ddce30a0 RDI: ffffffff9edc1598
> > > > RBP: ffffffffc06f4000 R08: ffff9981e6003980 R09: ffff9981ddce30a0
> > > > R10: 0000000000000000 R11: 0000000000028b56 R12: ffffffffc06f8880
> > > > R13: ffff9981ddce3080 R14: ffffffffc06f4008 R15: ffffffffc06f6dc0
> > > > FS:  00007f992dd9a680(0000) GS:ffff9981e7080000(0000) knlGS:0000000000000000
> > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > CR2: ffffffff9edc1598 CR3: 00000002233aa001 CR4: 00000000001606e0
> > > > Call Trace:
> > > >   jump_label_module_notify+0x1e7/0x2b0
> > > >   notifier_call_chain+0x44/0x70
> > > >   blocking_notifier_call_chain+0x43/0x60
> > > >   load_module+0x1bcb/0x2490
> > > >   ? vfs_read+0x11f/0x150
> > > >   ? __do_sys_finit_module+0xbf/0xe0
> > > >   __do_sys_finit_module+0xbf/0xe0
> > > >   do_syscall_64+0x43/0x110
> > > >   entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > > > 
> > > > Josh, didn't you mention that yesterday or so?
> > > 
> > > That's what Tony yesterday indicated on IRC that his system is suffering 
> > > from as well.
> > > 
> > > Adding Daniel to check whether this couldn't be some fallout of jumplabel 
> > > batching.
> > 
> > AFAICT this is _before_ we get to patching. The function that explodes
> > is static_key_set_mod(), as called from jump_label_add_module().
> > 
> > What that function does is for all patch sites in the module, find the
> > corresponding key; if that key is not also in that module, allocate a
> > static_key_mod structure and link the module entries to the key. Such
> > that we can find all instances from a given key.
> > 
> > I don't think anything here has changed in a while.
> 
> Hm, and it seems to explode on dereferencing the static_key* in %rsi

								  ^^^ %rdi of course

>   21:   48 8b 37                mov    (%rdi),%rsi
>   24:   83 e6 03                and    $0x3,%esi
>   27:   48 09 c6                or     %rax,%rsi
>   2a:*  48 89 37                mov    %rsi,(%rdi)              <-- trapping instruction
> 
> which looks odd, as it derefenced it successfully just 3 instructions ago.
> 
> -- 
> Jiri Kosina
> SUSE Labs
> 
> 

-- 
Jiri Kosina
SUSE Labs

