Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0FE2C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 13:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73CBA2196E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 13:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573479493;
	bh=WF38uwOVhJ4pj2v1Suqztk7S5cMNZgsZ4rON1mDbc9o=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=zuzs/H0fEEN3TPnOB3d++w+GKP1xz61SDw5H+EzMHj15evVz13jIMr8psfag+f7h3
	 kndEG+vlh2vOWmsYeOQOrDoGQjD0xhhgsJmcZyRF6dfn06UixYZfl+du62Lwkj3m7R
	 VswZo5yeXjBS/V1ksDuSeKmDnPym9VjAWfX/uVo0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbfKKNiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 08:38:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:44478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727036AbfKKNiL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 08:38:11 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAB6D21872;
        Mon, 11 Nov 2019 13:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573479490;
        bh=WF38uwOVhJ4pj2v1Suqztk7S5cMNZgsZ4rON1mDbc9o=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=0cagCvnxZg1QMbhoXsbAYxWbAOMLKN1PKBDrh81BpkXQ1+MUQC9Xj7fDtVoBD0Htt
         PNl4+N1FAfKdHUTZ9Q7v/arwcgzHj+HEphjUcFc1/ap+zoPNMd8RSHgL4X2kC2+0Ko
         uGSbfQgwoy2T4JwxsTz7ygihILFG4EonsUxBkyLM=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 3E3E635227B6; Mon, 11 Nov 2019 05:38:10 -0800 (PST)
Date:   Mon, 11 Nov 2019 05:38:10 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Christopher Lameter <cl@linux.com>,
        Dennis Zhou <dennis@kernel.org>, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2] percpu-refcount: Use normal instead of RCU-sched"
Message-ID: <20191111133810.GL2865@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191002112252.ro7wpdylqlrsbamc@linutronix.de>
 <20191107091319.6zf5tmdi54amtann@linutronix.de>
 <20191107161749.GA93945@dennisz-mbp>
 <20191107162842.2qgd3db2cjmmsxeh@linutronix.de>
 <20191107165519.GA99408@dennisz-mbp>
 <20191107172434.ylz4hyxw4rbmhre2@linutronix.de>
 <20191107173653.GA1242@dennisz-mbp>
 <20191108173553.lxsdic6wa4y3ifsr@linutronix.de>
 <alpine.DEB.2.21.1911081813330.1687@www.lameter.com>
 <20191111104403.5gna4pyg25v4mdin@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191111104403.5gna4pyg25v4mdin@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 11:44:03AM +0100, Sebastian Andrzej Siewior wrote:
> On 2019-11-08 18:17:47 [+0000], Christopher Lameter wrote:
> > On Fri, 8 Nov 2019, Sebastian Andrzej Siewior wrote:
> > 
> > > diff --git a/include/linux/percpu-refcount.h b/include/linux/percpu-refcount.h
> > > index 7aef0abc194a2..390031e816dcd 100644
> > > --- a/include/linux/percpu-refcount.h
> > > +++ b/include/linux/percpu-refcount.h
> > > @@ -186,14 +186,14 @@ static inline void percpu_ref_get_many(struct percpu_ref *ref, unsigned long nr)
> > >  {
> > >  	unsigned long __percpu *percpu_count;
> > >
> > > -	rcu_read_lock_sched();
> > > +	rcu_read_lock();
> > >
> > >  	if (__ref_is_percpu(ref, &percpu_count))
> > >  		this_cpu_add(*percpu_count, nr);
> > 
> > You can use
> > 
> > 	__this_cpu_add()
> > 
> > instead since rcu_read_lock implies preempt disable.
> 
> Paul may correct me but rcu_read_lock() does not imply
> preempt_disable().  rcu_read_lock() does preempt_disable() on preemption
> models other than "Low-Latency Desktop". You can be preempted in a
> RCU-read section.

Sebastian is quite correct, rcu_read_lock() definitely does not imply
preempt_disable() when CONFIG_PREEMPT=y.  So the splat below is expected
behavior, and not just on x86.

							Thanx, Paul

> > This will not change the code for x86 but other platforms that do not use
> > atomic operation here will be able to avoid including to code to disable
> > preempt for the per cpu operations.
> 
> x86 triggers this warning with the suggested change:
> 
> | BUG: using __this_cpu_add() in preemptible [00000000] code: login/2370
> | caller is blk_mq_get_request+0x74/0x4c0
> | CPU: 0 PID: 2370 Comm: login Not tainted 5.4.0-rc7+ #82
> | Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.12.0-1 04/01/2014
> | Call Trace:
> |  dump_stack+0x7a/0xaa
> |  __this_cpu_preempt_check.cold+0x49/0x4e
> |  blk_mq_get_request+0x74/0x4c0
> |  blk_mq_make_request+0x111/0x890
> |  generic_make_request+0xd3/0x3f0
> |  submit_bio+0x42/0x140
> |  submit_bh_wbc.isra.0+0x13f/0x170
> |  ll_rw_block+0xa0/0xb0
> |  __breadahead+0x3f/0x70
> |  __ext4_get_inode_loc+0x40a/0x520
> |  __ext4_iget+0x10a/0xcf0
> |  ext4_lookup+0x106/0x1f0
> |  lookup_open+0x267/0x8e0
> |  path_openat+0x7c8/0xcb0
> |  do_filp_open+0x8c/0x100
> |  do_sys_open+0x17a/0x230
> |  __x64_sys_openat+0x1b/0x20
> |  do_syscall_64+0x5a/0x230
> |  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> > Same is valid for all other per cpu operations in the patch.
> 
> Sebastian
