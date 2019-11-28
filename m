Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0507C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 16:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7930D217BC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 16:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574957906;
	bh=xcp2/xjwI3w39cOL/3dd7MxykaRtfXbScWWoLRzvBN4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=QXrpeKZt+XT2PrDkFREMrEmbTEwhcQ4ES5vZw+meuFyyoYQMTEBmPz/zRNRhcDmGn
	 0Pywbhw+hQlViVbjLZhzs+EgFFe8NdrY6gm/s2iYtJSuRZp7zlfH2OFHbe9uxGKsuw
	 IxRD7qZZqg+kv7TxdEcv6HssPnm5IX/vbJuYFWBw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbfK1QSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 11:18:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:36114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726446AbfK1QSZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 11:18:25 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 266D6217BC;
        Thu, 28 Nov 2019 16:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574957904;
        bh=xcp2/xjwI3w39cOL/3dd7MxykaRtfXbScWWoLRzvBN4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ouJbZhGcmmSpB5wji5MGZZpDdwAcv85b6dsd6M18Xt2FvTTfFF8aKdB9OuWQFUVzj
         r92VKH18UM5kQxmyecbqRYZuyg8Xi7bTzdRLhcBGGoNG7/OxT+VbqATH8/H1TT7rgW
         ueP0pMia01y1Xg8H/EPAHUGfNBWjDLiGqImHM/Yw=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id EA0A73520836; Thu, 28 Nov 2019 08:18:23 -0800 (PST)
Date:   Thu, 28 Nov 2019 08:18:23 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: Workqueues splat due to ending up on wrong CPU
Message-ID: <20191128161823.GA24667@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191125230312.GP2889@paulmck-ThinkPad-P72>
 <20191126183334.GE2867037@devbig004.ftw2.facebook.com>
 <20191126220533.GU2889@paulmck-ThinkPad-P72>
 <20191127155027.GA15170@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191127155027.GA15170@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 07:50:27AM -0800, Paul E. McKenney wrote:
> On Tue, Nov 26, 2019 at 02:05:33PM -0800, Paul E. McKenney wrote:
> > On Tue, Nov 26, 2019 at 10:33:34AM -0800, Tejun Heo wrote:
> > > Hello, Paul.
> > > 
> > > On Mon, Nov 25, 2019 at 03:03:12PM -0800, Paul E. McKenney wrote:
> > > > I am seeing this occasionally during rcutorture runs in the presence
> > > > of CPU hotplug.  This is on v5.4-rc1 in process_one_work() at the first
> > > > WARN_ON():
> > > > 
> > > > 	WARN_ON_ONCE(!(pool->flags & POOL_DISASSOCIATED) &&
> > > > 		     raw_smp_processor_id() != pool->cpu);
> > > 
> > > Hmm... so it's saying that this worker's pool is supposed to be bound
> > > to a cpu but it's currently running on the wrong cpu.
> > 
> > Probably because the bound-to CPU recently went offline.  And maybe
> > back online and back offline recently as well.
> > 
> > > > What should I do to help further debug this?
> > > 
> > > Do you always see rescuer_thread in the backtrace?  Can you please
> > > apply the following patch and reproduce the problem?
> > 
> > The short answer is "yes", they all have rescuer_thread() in the
> > backtrace.
> 
> And 420 hours of test overnight failed to reproduce the problem.  I kicked
> off an additional 672 hours that should complete tomorrow (Thursday PST)
> morning.  If it is still -ENOREPRODUCE, I will be making some rcutorture
> changes to avoid unrelated false-positive rcutorture splats due to fun
> with hyperthreading on large systems and rerun.  Just in case timing due
> to hyperthreading is required to make this splat happen or some such...

And still -ENOREPRODUCE.  It did happen on this system with
hyperthreading, so the next step is to make rcutorture better tolerate
very large hyperthreaded systems and try again.

(What happens now is that rcutorture cranks itself up full bore while the
system is still running through its initcalls, which causes rcutorture
to be gravely disappointed in the resulting (lack of) forward progress.
With hyperthreading enabled, we have different guest OSes attempting
to boot on the two hyperthreads of a given core, increasing the time
spend running initcalls from about 20 seconds to about 50 seconds, which
doesn't play well with rcutorture turning the stress up to 11 at about
30 seconds.  The fix is straightforward, just keep the stress levels
down until initcalls are complete.  And running hyperthreaded should
inject more performance variations, which should be expected to find
more timing bugs.)

							Thanx, Paul

> > Here is the one from October:
> > 
> > ------------------------------------------------------------------------
> > 
> > [  951.674908] WARNING: CPU: 2 PID: 4 at kernel/workqueue.c:2185 process_one_work+0x48/0x3b0
> > [  951.676859] Modules linked in:
> > [  951.677284] CPU: 2 PID: 4 Comm: rcu_par_gp Not tainted 5.3.0-rc2+ #4
> > [  951.678144] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.12.0-1 04/01/2014
> > [  951.679330] RIP: 0010:process_one_work+0x48/0x3b0
> > [  951.680010] Code: 00 00 00 00 4c 0f 44 e0 49 8b 44 24 08 44 8b a8 00 01 00 00 41 83 e5 20 f6 45 10 04 75 0e 65 8b 05 cd e0 98 5f 39 45 04 74 02 <0f> 0b 48 ba eb 83 b5 80 46 86 c8 61 48 0f af d6 48 c1 ea 3a 48 8b
> > [  951.682598] RSP: 0000:ffffa3624002fe80 EFLAGS: 00010093
> > [  951.683315] RAX: 0000000000000002 RBX: ffffa242dec107a8 RCX: ffffa242df228898
> > [  951.684307] RDX: ffffa242df228898 RSI: ffffffffa1a4e2b8 RDI: ffffa242dec10780
> > [  951.685356] RBP: ffffa242df228880 R08: 0000000000000000 R09: 0000000000000000
> > [  951.686394] R10: 0000000000000000 R11: 0000000000000000 R12: ffffa242df22cf00
> > [  951.687422] R13: 0000000000000000 R14: ffffa242df2288a0 R15: ffffa242dec10780
> > [  951.688397] FS:  0000000000000000(0000) GS:ffffa242df280000(0000) knlGS:0000000000000000
> > [  951.689497] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  951.690284] CR2: 00000000000000b0 CR3: 000000001e20a000 CR4: 00000000000006e0
> > [  951.691248] Call Trace:
> > [  951.691602]  rescuer_thread+0x244/0x320
> > [  951.692130]  ? worker_thread+0x3c0/0x3c0
> > [  951.692676]  kthread+0x10d/0x130
> > [  951.693126]  ? kthread_create_on_node+0x60/0x60
> > [  951.693771]  ret_from_fork+0x35/0x40
> > [  951.694297] ---[ end trace e04817902e40095b ]---
> > 
> > ------------------------------------------------------------------------
> > 
> > And the other one from August:
> > 
> > ------------------------------------------------------------------------
> > 
> > [ 1668.624302] WARNING: CPU: 1 PID: 4 at kernel/workqueue.c:2185 process_one_work+0x84/0x5b0
> > [ 1668.625806] Modules linked in:
> > [ 1668.626133] CPU: 1 PID: 4 Comm: rcu_par_gp Not tainted 5.3.0-rc2+ #420
> > [ 1668.626806] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.10.2-1ubuntu1 04/01/2014
> > [ 1668.627673] RIP: 0010:process_one_work+0x84/0x5b0
> > [ 1668.628146] Code: 48 8b 46 20 41 83 e6 20 41 f6 44 24 44 04 48 89 45 b0 48 8b 46 38 48 89 45 c8 75 10 65 8b 05 13 80 58 54 41 39 44 24 38 74 02 <0f> 0b 48 ba eb 83 b5 80 46 86 c8 61 48 0f af d3 48 c1 ea 3a 49 8b
> > [ 1668.630099] RSP: 0000:ffffa2668002be50 EFLAGS: 00010006
> > [ 1668.630650] RAX: 0000000000000001 RBX: fffffffface678e8 RCX: 0000000000000000
> > [ 1668.631399] RDX: ffff8e00df329508 RSI: fffffffface678e8 RDI: ffff8e00dec94600
> > [ 1668.632149] RBP: ffffa2668002beb0 R08: 0000000000000000 R09: 0000000000000000
> > [ 1668.632902] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8e00df3294c0
> > [ 1668.633651] R13: ffff8e00df32de00 R14: 0000000000000000 R15: ffff8e00dec94600
> > [ 1668.634377] FS:  0000000000000000(0000) GS:ffff8e00df240000(0000) knlGS:0000000000000000
> > [ 1668.635226] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [ 1668.635814] CR2: 0000000000000148 CR3: 000000001581e000 CR4: 00000000000006e0
> > [ 1668.636536] Call Trace:
> > [ 1668.636803]  rescuer_thread+0x20b/0x340
> > [ 1668.637194]  ? worker_thread+0x3d0/0x3d0
> > [ 1668.637566]  kthread+0x10e/0x130
> > [ 1668.637886]  ? kthread_park+0xa0/0xa0
> > [ 1668.638278]  ret_from_fork+0x35/0x40
> > [ 1668.638657] ---[ end trace 6290de3b1c80098a ]---
> > 
> > ------------------------------------------------------------------------
> > 
> > I have started running your patch.  Not enough data to be statistically
> > significant, but it looks like rcutorture scenario TREE02 is the
> > best bet, so I will focus on that one.
> > 
> > 							Thanx, Paul
> > 
> > > Thanks.
> > > 
> > > diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> > > index 914b845ad4ff..6f7f185cd146 100644
> > > --- a/kernel/workqueue.c
> > > +++ b/kernel/workqueue.c
> > > @@ -1842,13 +1842,18 @@ static struct worker *alloc_worker(int node)
> > >  static void worker_attach_to_pool(struct worker *worker,
> > >  				   struct worker_pool *pool)
> > >  {
> > > +	int ret;
> > > +
> > >  	mutex_lock(&wq_pool_attach_mutex);
> > >  
> > >  	/*
> > >  	 * set_cpus_allowed_ptr() will fail if the cpumask doesn't have any
> > >  	 * online CPUs.  It'll be re-applied when any of the CPUs come up.
> > >  	 */
> > > -	set_cpus_allowed_ptr(worker->task, pool->attrs->cpumask);
> > > +	ret = set_cpus_allowed_ptr(worker->task, pool->attrs->cpumask);
> > > +	if (ret && !(pool->flags & POOL_DISASSOCIATED))
> > > +		printk("XXX worker pid %d failed to attach to cpus of pool %d, ret=%d\n",
> > > +		       task_pid_nr(worker->task), pool->id, ret);
> > >  
> > >  	/*
> > >  	 * The wq_pool_attach_mutex ensures %POOL_DISASSOCIATED remains
> > > @@ -2183,8 +2188,10 @@ __acquires(&pool->lock)
> > >  	lockdep_copy_map(&lockdep_map, &work->lockdep_map);
> > >  #endif
> > >  	/* ensure we're on the correct CPU */
> > > -	WARN_ON_ONCE(!(pool->flags & POOL_DISASSOCIATED) &&
> > > -		     raw_smp_processor_id() != pool->cpu);
> > > +	WARN_ONCE(!(pool->flags & POOL_DISASSOCIATED) &&
> > > +		  raw_smp_processor_id() != pool->cpu,
> > > +		  "expected on cpu %d but on cpu %d, pool %d, workfn=%pf\n",
> > > +		  pool->cpu, raw_smp_processor_id(), pool->id, work->func);
> > >  
> > >  	/*
> > >  	 * A single work shouldn't be executed concurrently by
> > > 
> > > -- 
> > > tejun
