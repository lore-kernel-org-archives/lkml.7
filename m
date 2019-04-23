Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4136C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 15:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63E26206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 15:08:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbfDWPIY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 11:08:24 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49455 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727761AbfDWPIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 11:08:24 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hIx1q-0001Te-Pk; Tue, 23 Apr 2019 17:08:14 +0200
Date:   Tue, 23 Apr 2019 17:08:14 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [rcu:dev.2019.04.16a 38/72] kernel/rcu/tree.c:2408:36: sparse:
 sparse: incorrect type in initializer (different address spaces)
Message-ID: <20190423150814.4lhcavywthyiwipd@linutronix.de>
References: <201904231828.a3jAyl28%lkp@intel.com>
 <20190423124619.GH3923@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20190423124619.GH3923@linux.ibm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-04-23 05:46:19 [-0700], Paul E. McKenney wrote:
> On Tue, Apr 23, 2019 at 06:33:33PM +0800, kbuild test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2019.04.16a
> > head:   ca8714f549be5a186d086a223184095759eb7094
> > commit: 9a1a31194644dfc6b8f19755ea44ecf84f37cf40 [38/72] rcu: Enable elimination of Tree-RCU softirq processing
> > reproduce:
> >         # apt-get install sparse
> >         git checkout 9a1a31194644dfc6b8f19755ea44ecf84f37cf40
> >         make ARCH=x86_64 allmodconfig
> >         make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'
> > 
> > If you fix the issue, kindly add following tag
> > Reported-by: kbuild test robot <lkp@intel.com>
> > 
> > 
> > 
> > sparse warnings: (new ones prefixed by >>)
> > 
> > >> kernel/rcu/tree.c:2408:36: sparse: sparse: incorrect type in initializer (different address spaces) @@    expected struct task_struct [noderef] <asn:3> **store @@    got struct task_struct [noderef] <asn:3> **store @@
> 
> Line 2408 of kernel/rcu/tree.c for commit 9a1a31194644 ("rcu: Enable
> elimination of Tree-RCU softirq processing") is this:
> 
> 	.store			= &rcu_data.rcu_cpu_kthread_task,
> 
> So I am having some difficulty understanding this sparse diagnostic.
> 
> Help?

this helps

diff --git a/include/linux/smpboot.h b/include/linux/smpboot.h
index d0884b5250010..c2678e29807c1 100644
--- a/include/linux/smpboot.h
+++ b/include/linux/smpboot.h
@@ -29,7 +29,7 @@ struct smpboot_thread_data;
  * @thread_comm:	The base name of the thread
  */
 struct smp_hotplug_thread {
-	struct task_struct __percpu	**store;
+	struct task_struct		*__percpu *store;
 	struct list_head		list;
 	int				(*thread_should_run)(unsigned int cpu);
 	void				(*thread_fn)(unsigned int cpu);


I just need to find the correct words for it.
And yes, it is not RCU related…

> 							Thanx, Paul

Sebastian
