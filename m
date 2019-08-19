Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A524C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 21:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A093214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 21:13:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbfHSVN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 17:13:29 -0400
Received: from mga03.intel.com ([134.134.136.65]:62965 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728018AbfHSVN3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 17:13:29 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Aug 2019 14:13:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,406,1559545200"; 
   d="scan'208";a="261959137"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 19 Aug 2019 14:13:25 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hzoxw-000IkP-Ks; Tue, 20 Aug 2019 05:13:24 +0800
Date:   Tue, 20 Aug 2019 05:12:50 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org, tipbuild@zytor.com
Subject: [tip:WIP.timers/core 27/68] include/linux/rcupdate.h:644:9: sparse:
 sparse: context imbalance in 'timer_wait_running' - unexpected unlock
Message-ID: <201908200519.rhw6pxwJ%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://kernel.googlesource.com/pub/scm/linux/kernel/git/tip/tip.git WIP.timers/core
head:   b16101077c4444bc7e0dde91e7ffb258ce1f979b
commit: e51f39feec02940feeb0914ef9ff8fe5e05965c1 [27/68] posix-timer: Use a callback for cancel synchronization
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-rc1-7-g2b96cd8-dirty
        git checkout e51f39feec02940feeb0914ef9ff8fe5e05965c1
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   kernel/time/posix-timers.c:588:24: sparse: sparse: context imbalance in '__lock_timer' - different lock contexts for basic block
>> include/linux/rcupdate.h:644:9: sparse: sparse: context imbalance in 'timer_wait_running' - unexpected unlock
   kernel/time/posix-timers.c:870:12: sparse: sparse: context imbalance in 'do_timer_settime' - different lock contexts for basic block
   kernel/time/posix-timers.c:976:1: sparse: sparse: context imbalance in '__se_sys_timer_delete' - different lock contexts for basic block

vim +/timer_wait_running +644 include/linux/rcupdate.h

^1da177e4c3f41 Linus Torvalds      2005-04-16  596  
^1da177e4c3f41 Linus Torvalds      2005-04-16  597  /*
^1da177e4c3f41 Linus Torvalds      2005-04-16  598   * So where is rcu_write_lock()?  It does not exist, as there is no
^1da177e4c3f41 Linus Torvalds      2005-04-16  599   * way for writers to lock out RCU readers.  This is a feature, not
^1da177e4c3f41 Linus Torvalds      2005-04-16  600   * a bug -- this property is what provides RCU's performance benefits.
^1da177e4c3f41 Linus Torvalds      2005-04-16  601   * Of course, writers must coordinate with each other.  The normal
^1da177e4c3f41 Linus Torvalds      2005-04-16  602   * spinlock primitives work well for this, but any other technique may be
^1da177e4c3f41 Linus Torvalds      2005-04-16  603   * used as well.  RCU does not care how the writers keep out of each
^1da177e4c3f41 Linus Torvalds      2005-04-16  604   * others' way, as long as they do so.
^1da177e4c3f41 Linus Torvalds      2005-04-16  605   */
3d76c082907e8f Paul E. McKenney    2009-09-28  606  
3d76c082907e8f Paul E. McKenney    2009-09-28  607  /**
ca5ecddfa8fcbd Paul E. McKenney    2010-04-28  608   * rcu_read_unlock() - marks the end of an RCU read-side critical section.
3d76c082907e8f Paul E. McKenney    2009-09-28  609   *
f27bc4873fa8b7 Paul E. McKenney    2014-05-04  610   * In most situations, rcu_read_unlock() is immune from deadlock.
f27bc4873fa8b7 Paul E. McKenney    2014-05-04  611   * However, in kernels built with CONFIG_RCU_BOOST, rcu_read_unlock()
f27bc4873fa8b7 Paul E. McKenney    2014-05-04  612   * is responsible for deboosting, which it does via rt_mutex_unlock().
f27bc4873fa8b7 Paul E. McKenney    2014-05-04  613   * Unfortunately, this function acquires the scheduler's runqueue and
f27bc4873fa8b7 Paul E. McKenney    2014-05-04  614   * priority-inheritance spinlocks.  This means that deadlock could result
f27bc4873fa8b7 Paul E. McKenney    2014-05-04  615   * if the caller of rcu_read_unlock() already holds one of these locks or
ec84b27f9b3b56 Anna-Maria Gleixner 2018-05-25  616   * any lock that is ever acquired while holding them.
f27bc4873fa8b7 Paul E. McKenney    2014-05-04  617   *
f27bc4873fa8b7 Paul E. McKenney    2014-05-04  618   * That said, RCU readers are never priority boosted unless they were
f27bc4873fa8b7 Paul E. McKenney    2014-05-04  619   * preempted.  Therefore, one way to avoid deadlock is to make sure
f27bc4873fa8b7 Paul E. McKenney    2014-05-04  620   * that preemption never happens within any RCU read-side critical
f27bc4873fa8b7 Paul E. McKenney    2014-05-04  621   * section whose outermost rcu_read_unlock() is called with one of
f27bc4873fa8b7 Paul E. McKenney    2014-05-04  622   * rt_mutex_unlock()'s locks held.  Such preemption can be avoided in
f27bc4873fa8b7 Paul E. McKenney    2014-05-04  623   * a number of ways, for example, by invoking preempt_disable() before
f27bc4873fa8b7 Paul E. McKenney    2014-05-04  624   * critical section's outermost rcu_read_lock().
f27bc4873fa8b7 Paul E. McKenney    2014-05-04  625   *
f27bc4873fa8b7 Paul E. McKenney    2014-05-04  626   * Given that the set of locks acquired by rt_mutex_unlock() might change
f27bc4873fa8b7 Paul E. McKenney    2014-05-04  627   * at any time, a somewhat more future-proofed approach is to make sure
f27bc4873fa8b7 Paul E. McKenney    2014-05-04  628   * that that preemption never happens within any RCU read-side critical
f27bc4873fa8b7 Paul E. McKenney    2014-05-04  629   * section whose outermost rcu_read_unlock() is called with irqs disabled.
f27bc4873fa8b7 Paul E. McKenney    2014-05-04  630   * This approach relies on the fact that rt_mutex_unlock() currently only
f27bc4873fa8b7 Paul E. McKenney    2014-05-04  631   * acquires irq-disabled locks.
f27bc4873fa8b7 Paul E. McKenney    2014-05-04  632   *
f27bc4873fa8b7 Paul E. McKenney    2014-05-04  633   * The second of these two approaches is best in most situations,
f27bc4873fa8b7 Paul E. McKenney    2014-05-04  634   * however, the first approach can also be useful, at least to those
f27bc4873fa8b7 Paul E. McKenney    2014-05-04  635   * developers willing to keep abreast of the set of locks acquired by
f27bc4873fa8b7 Paul E. McKenney    2014-05-04  636   * rt_mutex_unlock().
f27bc4873fa8b7 Paul E. McKenney    2014-05-04  637   *
3d76c082907e8f Paul E. McKenney    2009-09-28  638   * See rcu_read_lock() for more information.
3d76c082907e8f Paul E. McKenney    2009-09-28  639   */
bc33f24bdca8b6 Paul E. McKenney    2009-08-22  640  static inline void rcu_read_unlock(void)
bc33f24bdca8b6 Paul E. McKenney    2009-08-22  641  {
f78f5b90c4ffa5 Paul E. McKenney    2015-06-18  642  	RCU_LOCKDEP_WARN(!rcu_is_watching(),
bde23c6892878e Heiko Carstens      2012-02-01  643  			 "rcu_read_unlock() used illegally while idle");
bc33f24bdca8b6 Paul E. McKenney    2009-08-22 @644  	__release(RCU);
bc33f24bdca8b6 Paul E. McKenney    2009-08-22  645  	__rcu_read_unlock();
d24209bb689e2c Paul E. McKenney    2015-01-21  646  	rcu_lock_release(&rcu_lock_map); /* Keep acq info for rls diags. */
bc33f24bdca8b6 Paul E. McKenney    2009-08-22  647  }
^1da177e4c3f41 Linus Torvalds      2005-04-16  648  

:::::: The code at line 644 was first introduced by commit
:::::: bc33f24bdca8b6e97376e3a182ab69e6cdefa989 rcu: Consolidate sparse and lockdep declarations in include/linux/rcupdate.h

:::::: TO: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
:::::: CC: Ingo Molnar <mingo@elte.hu>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
