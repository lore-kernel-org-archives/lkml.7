Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A77EC3A59D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 19:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11E1E2133F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 19:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JjBRgQ+Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbfHPTcM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 15:32:12 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33503 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727548AbfHPTcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 15:32:12 -0400
Received: by mail-pf1-f194.google.com with SMTP id g2so3626559pfq.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 12:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hVVzRElrXHOC96cwRJJQM8LBjRS5xbrnoxFKlNmKNBY=;
        b=JjBRgQ+Y0gU7vwmv+vhEnOSjUTR/ikLVyLy/Bcg+54cEiAsCtSIrRQSDiSze1010DM
         7hB62ODfTpSWsxthzNIRNuuX6qaixBOE11NLxhxTVq0S2w3khUGIcLiSbmxi2hwrGFS6
         FN0lR+gLzDnT5ljrY6Y5eo0pM/h8ZMa6KtF7uAnYjAyr3u7pUOSkQaE5M6DyS4WhcQjq
         JATeYIs754662iH8cL8RUsxsny+p1blIl0qrykbtj6AX/JYXN7ieKDMZS4mv8jcQn5Jm
         jgoJyg1f+GambkrpzGz0wC0jJAxexmTSKG6PE9ygPyfHivU9YGxWIFW4La7hFErzila+
         SH6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=hVVzRElrXHOC96cwRJJQM8LBjRS5xbrnoxFKlNmKNBY=;
        b=GfapMPkQnyyFuJJMYcnx3EYYXRpAgZObNPnJ283O4Sn/Ry19LF3fDpAdbBxhnk6ZCX
         hQ2HO4NFUz+iUy/HTcOUkjpzlwR7eUrOJsEEuhieaeJAMkPCg00TI9BzrZanfwoiX8we
         HO7bUtXI4Aomc8kLrzSMZer+Y8ZbECVORBcVo5IftpMtBy0dPz4dr9RYH/meagokdpJu
         QrPcmugb3QQ97F7xBNvxJEiWNMv+bjt0aHQgWiKRyeNzjMAqScVg7jDTJMAYVAF4fqko
         /I0NGDcRtm6CwjRtABUm4uNZpd/bMKy80I70I/0MztgBr/tC29cmNua6TzsykcAkgd/i
         o6Ww==
X-Gm-Message-State: APjAAAVhhBcdqjJF1YsyKVIJ9Imne8tU48pkI32L98tFMKV0pwaxR0Ev
        uZlUA755EdHhPy5L1M46+k8=
X-Google-Smtp-Source: APXvYqyGpfS81/q+uJdWEFOSSMxdp1ZaYcfNuqTtNsbo9zx5M43OrqjvfWOTV3nV2Jm8RoFmq/VHpw==
X-Received: by 2002:aa7:9ab6:: with SMTP id x22mr12507848pfi.80.1565983931675;
        Fri, 16 Aug 2019 12:32:11 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k5sm5705723pgo.45.2019.08.16.12.32.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Aug 2019 12:32:10 -0700 (PDT)
Date:   Fri, 16 Aug 2019 12:32:08 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>
Subject: Re: sched: Unexpected reschedule of offline CPU#2!
Message-ID: <20190816193208.GA29478@roeck-us.net>
References: <20190727164450.GA11726@roeck-us.net>
 <20190729093545.GV31381@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1907291156170.1791@nanos.tec.linutronix.de>
 <20190729101349.GX31381@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1907291235580.1791@nanos.tec.linutronix.de>
 <20190729104745.GA31398@hirez.programming.kicks-ass.net>
 <20190729205059.GA1127@roeck-us.net>
 <alpine.DEB.2.21.1908161217380.1873@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1908161217380.1873@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 12:22:22PM +0200, Thomas Gleixner wrote:
> On Mon, 29 Jul 2019, Guenter Roeck wrote:
> > On Mon, Jul 29, 2019 at 12:47:45PM +0200, Peter Zijlstra wrote:
> > > On Mon, Jul 29, 2019 at 12:38:30PM +0200, Thomas Gleixner wrote:
> > > > Reboot has two modes:
> > > > 
> > > >  - Regular reboot initiated from user space
> > > > 
> > > >  - Panic reboot
> > > > 
> > > > For the regular reboot we can make it go through proper hotplug, 
> > > 
> > > That seems sensible.
> > > 
> > > > for the panic case not so much.
> > > 
> > > It's panic, shit has already hit fan, one or two more pieces shouldn't
> > > something anybody cares about.
> > > 
> > 
> > Some more digging shows that this happens a lot with Google GCE intances,
> > typically after a panic. The problem with that, if I understand correctly,
> > is that it may prevent coredumps from being written. So, while of course
> > the panic is what needs to be fixed, it is still quite annoying, and it
> > would help if this can be fixed for panic handling as well.
> > 
> > How about the patch suggested by Hillf Danton ? Would that help for the
> > panic case ?
> 
> I have no idea how that patch looks like, but the quick hack is below.
> 
> Thanks,
> 
> 	tglx
> 
> 8<---------------
> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index 75fea0d48c0e..625627b1457c 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -601,6 +601,7 @@ void stop_this_cpu(void *dummy)
>  	/*
>  	 * Remove this CPU:
>  	 */
> +	set_cpu_active(smp_processor_id(), false);
>  	set_cpu_online(smp_processor_id(), false);
>  	disable_local_APIC();
>  	mcheck_cpu_clear(this_cpu_ptr(&cpu_info));
> 
No luck. The problem is still seen with this patch applied on top of
the mainline kernel (commit a69e90512d9def6).

Guenter

---
[   22.315834] e1000e: EEE TX LPI TIMER: 00000000
[   22.323624] reboot: Restarting system
[   22.324260] reboot: machine restart
[   22.325885] ------------[ cut here ]------------
[   22.330425] sched: Unexpected reschedule of offline CPU#3!
ILLOPC: ffffffffb524403f: 0f 0b
[   22.330926] WARNING: CPU: 1 PID: 0 at arch/x86/kernel/smp.c:126 native_smp_send_reschedule+0x2f/0x40
[   22.331238] Modules linked in:
[   22.331427] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.3.0-rc4+ #1
[   22.331626] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
[   22.331971] RIP: 0010:native_smp_send_reschedule+0x2f/0x40
[   22.332164] Code: 05 de 81 95 01 73 15 48 8b 05 bd fa 61 01 be fd 00 00 00 48 8b 40 30 e9 6f d0 fb 00 89 fe 48 c7 c7 88 da 74 b6 e8 7f 6c 02 00 <0f> 0b c3 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 55 53 48 83 ec
[   22.332705] RSP: 0018:ffffa457800d0d68 EFLAGS: 00000086
[   22.332884] RAX: 0000000000000000 RBX: ffff9a8cbb9ba000 RCX: 0000000000000103
[   22.333109] RDX: 0000000080000103 RSI: 0000000000000000 RDI: 00000000ffffffff
[   22.333327] RBP: ffffa457800d0e90 R08: 0000000000000000 R09: 0000000000000000
[   22.333546] R10: 0000000000000000 R11: ffffa457800d0c10 R12: 000000000000a1b9
[   22.333767] R13: ffff9a8cbae26030 R14: ffff9a8cbae25f80 R15: ffff9a8cbb83a000
[   22.334045] FS:  0000000000000000(0000) GS:ffff9a8cbb880000(0000) knlGS:0000000000000000
[   22.334321] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   22.334520] CR2: 00007fba66a35010 CR3: 0000000176cd6000 CR4: 00000000007406e0
[   22.334794] PKRU: 55555554
[   22.334915] Call Trace:
[   22.335062]  <IRQ>
[   22.335148]  check_preempt_curr+0x7f/0xc0
[   22.335295]  load_balance+0x589/0xc50
[   22.335513]  rebalance_domains+0x30d/0x410
[   22.335684]  _nohz_idle_balance+0x1bd/0x200
[   22.335854]  __do_softirq+0xe5/0x478
[   22.336023]  irq_exit+0xa9/0xc0
[   22.336163]  reschedule_interrupt+0xf/0x20
[   22.336317]  </IRQ>
[   22.336409] RIP: 0010:default_idle+0x23/0x180
[   22.336561] Code: ff 90 90 90 90 90 90 41 55 41 54 55 53 e8 45 75 7c ff 0f 1f 44 00 00 e8 0b aa 40 ff e9 07 00 00 00 0f 00 2d 31 94 4a 00 fb f4 <e8> 28 75 7c ff 89 c5 0f 1f 44 00 00 5b 5d 41 5c 41 5d c3 65 8b 05
[   22.337102] RSP: 0018:ffffa4578006bec0 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff02
[   22.337342] RAX: ffff9a8cbae23fc0 RBX: 0000000000000001 RCX: 0000000000000001
[   22.337561] RDX: 0000000000000046 RSI: 0000000000000006 RDI: ffffffffb6852dd6
[   22.337780] RBP: ffffffffb6b9c1f8 R08: 0000000000000001 R09: 0000000000000000
[   22.337996] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[   22.338229] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   22.338501]  do_idle+0x1df/0x260
[   22.338588]  ? _raw_spin_unlock_irqrestore+0x4c/0x60
[   22.338706]  cpu_startup_entry+0x14/0x20
[   22.338793]  start_secondary+0x151/0x180
[   22.338885]  secondary_startup_64+0xa4/0xb0
[   22.339060] irq event stamp: 61631
[   22.339176] hardirqs last  enabled at (61630): [<ffffffffb5f5c6dc>] _raw_spin_unlock_irqrestore+0x4c/0x60
[   22.339373] hardirqs last disabled at (61631): [<ffffffffb5f5c46d>] _raw_spin_lock_irqsave+0xd/0x50
[   22.339568] softirqs last  enabled at (61626): [<ffffffffb5272bc8>] irq_enter+0x58/0x60
[   22.339726] softirqs last disabled at (61627): [<ffffffffb5272c79>] irq_exit+0xa9/0xc0
[   22.339897] ---[ end trace 8ad53445879058cc ]---
[   22.340384] ACPI MEMORY or I/O RESET_REG.
