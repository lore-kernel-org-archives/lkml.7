Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D758C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 10:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAB8A20856
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 10:44:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbfKKKoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 05:44:06 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56151 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbfKKKoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 05:44:06 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iU7Ax-0004ZX-JU; Mon, 11 Nov 2019 11:44:03 +0100
Date:   Mon, 11 Nov 2019 11:44:03 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Christopher Lameter <cl@linux.com>
Cc:     Dennis Zhou <dennis@kernel.org>, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v2] percpu-refcount: Use normal instead of RCU-sched"
Message-ID: <20191111104403.5gna4pyg25v4mdin@linutronix.de>
References: <20191002112252.ro7wpdylqlrsbamc@linutronix.de>
 <20191107091319.6zf5tmdi54amtann@linutronix.de>
 <20191107161749.GA93945@dennisz-mbp>
 <20191107162842.2qgd3db2cjmmsxeh@linutronix.de>
 <20191107165519.GA99408@dennisz-mbp>
 <20191107172434.ylz4hyxw4rbmhre2@linutronix.de>
 <20191107173653.GA1242@dennisz-mbp>
 <20191108173553.lxsdic6wa4y3ifsr@linutronix.de>
 <alpine.DEB.2.21.1911081813330.1687@www.lameter.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1911081813330.1687@www.lameter.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-11-08 18:17:47 [+0000], Christopher Lameter wrote:
> On Fri, 8 Nov 2019, Sebastian Andrzej Siewior wrote:
> 
> > diff --git a/include/linux/percpu-refcount.h b/include/linux/percpu-refcount.h
> > index 7aef0abc194a2..390031e816dcd 100644
> > --- a/include/linux/percpu-refcount.h
> > +++ b/include/linux/percpu-refcount.h
> > @@ -186,14 +186,14 @@ static inline void percpu_ref_get_many(struct percpu_ref *ref, unsigned long nr)
> >  {
> >  	unsigned long __percpu *percpu_count;
> >
> > -	rcu_read_lock_sched();
> > +	rcu_read_lock();
> >
> >  	if (__ref_is_percpu(ref, &percpu_count))
> >  		this_cpu_add(*percpu_count, nr);
> 
> You can use
> 
> 	__this_cpu_add()
> 
> instead since rcu_read_lock implies preempt disable.

Paul may correct me but rcu_read_lock() does not imply
preempt_disable().  rcu_read_lock() does preempt_disable() on preemption
models other than "Low-Latency Desktop". You can be preempted in a
RCU-read section.

> This will not change the code for x86 but other platforms that do not use
> atomic operation here will be able to avoid including to code to disable
> preempt for the per cpu operations.

x86 triggers this warning with the suggested change:

| BUG: using __this_cpu_add() in preemptible [00000000] code: login/2370
| caller is blk_mq_get_request+0x74/0x4c0
| CPU: 0 PID: 2370 Comm: login Not tainted 5.4.0-rc7+ #82
| Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.12.0-1 04/01/2014
| Call Trace:
|  dump_stack+0x7a/0xaa
|  __this_cpu_preempt_check.cold+0x49/0x4e
|  blk_mq_get_request+0x74/0x4c0
|  blk_mq_make_request+0x111/0x890
|  generic_make_request+0xd3/0x3f0
|  submit_bio+0x42/0x140
|  submit_bh_wbc.isra.0+0x13f/0x170
|  ll_rw_block+0xa0/0xb0
|  __breadahead+0x3f/0x70
|  __ext4_get_inode_loc+0x40a/0x520
|  __ext4_iget+0x10a/0xcf0
|  ext4_lookup+0x106/0x1f0
|  lookup_open+0x267/0x8e0
|  path_openat+0x7c8/0xcb0
|  do_filp_open+0x8c/0x100
|  do_sys_open+0x17a/0x230
|  __x64_sys_openat+0x1b/0x20
|  do_syscall_64+0x5a/0x230
|  entry_SYSCALL_64_after_hwframe+0x49/0xbe

> Same is valid for all other per cpu operations in the patch.

Sebastian
