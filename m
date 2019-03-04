Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795A6C4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 09:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5071120823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 09:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbfCDJkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 04:40:06 -0500
Received: from a.mx.secunet.com ([62.96.220.36]:52890 "EHLO a.mx.secunet.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726034AbfCDJkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 04:40:06 -0500
Received: from localhost (localhost [127.0.0.1])
        by a.mx.secunet.com (Postfix) with ESMTP id D87D7201E5;
        Mon,  4 Mar 2019 10:40:02 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
        by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id NF9nzjRMfW0y; Mon,  4 Mar 2019 10:40:02 +0100 (CET)
Received: from mail-essen-01.secunet.de (mail-essen-01.secunet.de [10.53.40.204])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by a.mx.secunet.com (Postfix) with ESMTPS id 07DBA2006F;
        Mon,  4 Mar 2019 10:40:02 +0100 (CET)
Received: from gauss2.secunet.de (10.182.7.193) by mail-essen-01.secunet.de
 (10.53.40.204) with Microsoft SMTP Server id 14.3.439.0; Mon, 4 Mar 2019
 10:40:01 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)      id 752D031825E2;
 Mon,  4 Mar 2019 10:40:01 +0100 (CET)
Date:   Mon, 4 Mar 2019 10:40:01 +0100
From:   Steffen Klassert <steffen.klassert@secunet.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
CC:     Yue Haibing <yuehaibing@huawei.com>, <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: Re: [PATCH] xfrm: policy: Fix out-of-bound array accesses in
 __xfrm_policy_unlink
Message-ID: <20190304094001.GA14737@gauss3.secunet.de>
References: <20190228071859.17768-1-yuehaibing@huawei.com>
 <20190228075226.hza3hydllddj65nd@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190228075226.hza3hydllddj65nd@gondor.apana.org.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-G-Data-MailSecurity-for-Exchange-State: 0
X-G-Data-MailSecurity-for-Exchange-Error: 0
X-G-Data-MailSecurity-for-Exchange-Sender: 23
X-G-Data-MailSecurity-for-Exchange-Server: d65e63f7-5c15-413f-8f63-c0d707471c93
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-G-Data-MailSecurity-for-Exchange-Guid: 024DDA43-8B3B-4C2D-92DD-61A8688EB4BB
X-G-Data-MailSecurity-for-Exchange-ProcessedOnRouted: True
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 03:52:27PM +0800, Herbert Xu wrote:
> On Thu, Feb 28, 2019 at 03:18:59PM +0800, Yue Haibing wrote:
> > From: YueHaibing <yuehaibing@huawei.com>
> > 
> > UBSAN report this:
> > 
> > UBSAN: Undefined behaviour in net/xfrm/xfrm_policy.c:1289:24
> > index 6 is out of range for type 'unsigned int [6]'
> > CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.4.162-514.55.6.9.x86_64+ #13
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
> >  0000000000000000 1466cf39b41b23c9 ffff8801f6b07a58 ffffffff81cb35f4
> >  0000000041b58ab3 ffffffff83230f9c ffffffff81cb34e0 ffff8801f6b07a80
> >  ffff8801f6b07a20 1466cf39b41b23c9 ffffffff851706e0 ffff8801f6b07ae8
> > Call Trace:
> >  <IRQ>  [<ffffffff81cb35f4>] __dump_stack lib/dump_stack.c:15 [inline]
> >  <IRQ>  [<ffffffff81cb35f4>] dump_stack+0x114/0x1a0 lib/dump_stack.c:51
> >  [<ffffffff81d94225>] ubsan_epilogue+0x12/0x8f lib/ubsan.c:164
> >  [<ffffffff81d954db>] __ubsan_handle_out_of_bounds+0x16e/0x1b2 lib/ubsan.c:382
> >  [<ffffffff82a25acd>] __xfrm_policy_unlink+0x3dd/0x5b0 net/xfrm/xfrm_policy.c:1289
> >  [<ffffffff82a2e572>] xfrm_policy_delete+0x52/0xb0 net/xfrm/xfrm_policy.c:1309
> >  [<ffffffff82a3319b>] xfrm_policy_timer+0x30b/0x590 net/xfrm/xfrm_policy.c:243
> >  [<ffffffff813d3927>] call_timer_fn+0x237/0x990 kernel/time/timer.c:1144
> >  [<ffffffff813d8e7e>] __run_timers kernel/time/timer.c:1218 [inline]
> >  [<ffffffff813d8e7e>] run_timer_softirq+0x6ce/0xb80 kernel/time/timer.c:1401
> >  [<ffffffff8120d6f9>] __do_softirq+0x299/0xe10 kernel/softirq.c:273
> >  [<ffffffff8120e676>] invoke_softirq kernel/softirq.c:350 [inline]
> >  [<ffffffff8120e676>] irq_exit+0x216/0x2c0 kernel/softirq.c:391
> >  [<ffffffff82c5edab>] exiting_irq arch/x86/include/asm/apic.h:652 [inline]
> >  [<ffffffff82c5edab>] smp_apic_timer_interrupt+0x8b/0xc0 arch/x86/kernel/apic/apic.c:926
> >  [<ffffffff82c5c985>] apic_timer_interrupt+0xa5/0xb0 arch/x86/entry/entry_64.S:735
> >  <EOI>  [<ffffffff81188096>] ? native_safe_halt+0x6/0x10 arch/x86/include/asm/irqflags.h:52
> >  [<ffffffff810834d7>] arch_safe_halt arch/x86/include/asm/paravirt.h:111 [inline]
> >  [<ffffffff810834d7>] default_idle+0x27/0x430 arch/x86/kernel/process.c:446
> >  [<ffffffff81085f05>] arch_cpu_idle+0x15/0x20 arch/x86/kernel/process.c:437
> >  [<ffffffff8132abc3>] default_idle_call+0x53/0x90 kernel/sched/idle.c:92
> >  [<ffffffff8132b32d>] cpuidle_idle_call kernel/sched/idle.c:156 [inline]
> >  [<ffffffff8132b32d>] cpu_idle_loop kernel/sched/idle.c:251 [inline]
> >  [<ffffffff8132b32d>] cpu_startup_entry+0x60d/0x9a0 kernel/sched/idle.c:299
> >  [<ffffffff8113e119>] start_secondary+0x3c9/0x560 arch/x86/kernel/smpboot.c:245
> > 
> > The issue is triggered as this:
> > 
> > xfrm_add_policy
> >     -->verify_newpolicy_info  //check the index provided by user with XFRM_POLICY_MAX
> > 			      //In my case, the index is 0x6E6BB6, so it pass the check.
> >     -->xfrm_policy_construct  //copy the user's policy and set xfrm_policy_timer
> >     -->xfrm_policy_insert
> > 	--> __xfrm_policy_link //use the orgin dir, in my case is 2
> > 	--> xfrm_gen_index   //generate policy index, there is 0x6E6BB6
> > 
> > then xfrm_policy_timer be fired
> > 
> > xfrm_policy_timer
> >    --> xfrm_policy_id2dir  //get dir from (policy index & 7), in my case is 6
> >    --> xfrm_policy_delete
> >       --> __xfrm_policy_unlink //access policy_count[dir], trigger out of range access
> > 
> > Add xfrm_policy_id2dir check in verify_newpolicy_info, make sure the computed dir is
> > valid, to fix the issue.
> > 
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Fixes: e682adf021be ("xfrm: Try to honor policy index if it's supplied by user")
> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> > ---
> >  net/xfrm/xfrm_user.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Acked-by: Herbert Xu <herbert@gondor.apana.org.au>

Applied, thanks everyone!
