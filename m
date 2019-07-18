Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C8E5C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 08:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ACD92173B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 08:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389350AbfGRIgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 04:36:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:44520 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726386AbfGRIgb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 04:36:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1A70CAE12;
        Thu, 18 Jul 2019 08:36:30 +0000 (UTC)
Date:   Thu, 18 Jul 2019 10:36:29 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Konstantin Khlebnikov <koct9i@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        John Ogness <john.ogness@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Tesarik <ptesarik@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] printk/panic: Access the main printk log in panic()
 only when safe
Message-ID: <20190718083629.nso3vwbvmankqgks@pathway.suse.cz>
References: <20190716072805.22445-1-pmladek@suse.com>
 <20190716072805.22445-2-pmladek@suse.com>
 <20190717095615.GD3664@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190717095615.GD3664@jagdpanzerIV>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2019-07-17 18:56:15, Sergey Senozhatsky wrote:
> On (07/16/19 09:28), Petr Mladek wrote:
> > Kernel tries hard to store and show printk messages when panicking. Even
> > logbuf_lock gets re-initialized when only one CPU is running after
> > smp_send_stop().
> > 
> > Unfortunately, smp_send_stop() might fail on architectures that do not
> > use NMI as a fallback. Then printk log buffer might stay locked and
> > a deadlock is almost inevitable.
> 
> I'd say that deadlock is still almost inevitable.
> 
> panic-CPU syncs with the printing-CPU before it attempts to SMP_STOP.
> If there is an active printing-CPU, which is looping in console_unlock(),
> taking logbuf_lock in order to msg_print_text() and stuff, then panic-CPU
> will spin on console_owner waiting for that printing-CPU to handover
> printing duties.
> 
> 	pr_emerg("Kernel panic - not syncing");
> 	smp_send_stop();

Good point. I forgot the handover logic. Well, it is enabled only
around call_console_drivers(). Therefore it is not under
lockbuf_lock.

I had in mind some infinite loop or deadlock in vprintk_store().
There was at least one long time ago (warning triggered
by leap second).


> If printing-CPU goes nuts under logbuf_lock, has corrupted IDT or anything
> else, then we will not progress with panic(). panic-CPU will deadlock. If
> not on
> 	pr_emerg("Kernel panic - not syncing")
> 
> then on another pr_emerg(), right before the NMI-fallback.

Nested printk() should not be problem thanks to printk_safe.

Also printk_safe_flush_on_panic() is safe because it checks whether
the lock is available.

The problem is kmsg_dump() and console_unlock() called from
console_unblank() and console_flush_on_panic(). They do not
check whether the lock is available.


This patch does not help in all possible scenarios. But I still
believe that it will help in some.

Well, I am primary interested into the 2nd patch. It fixes
a real life bug report.

Best Regards,
Petr
