Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795BDC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 10:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E126214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 10:33:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbfDWKdh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 06:33:37 -0400
Received: from mga01.intel.com ([192.55.52.88]:49595 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725990AbfDWKdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 06:33:36 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Apr 2019 03:33:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,385,1549958400"; 
   d="scan'208";a="164230692"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 23 Apr 2019 03:33:35 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hIsk3-0001Po-5q; Tue, 23 Apr 2019 18:33:35 +0800
Date:   Tue, 23 Apr 2019 18:33:33 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [rcu:dev.2019.04.16a 38/72] kernel/rcu/tree.c:2408:36: sparse:
 sparse: incorrect type in initializer (different address spaces)
Message-ID: <201904231828.a3jAyl28%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2019.04.16a
head:   ca8714f549be5a186d086a223184095759eb7094
commit: 9a1a31194644dfc6b8f19755ea44ecf84f37cf40 [38/72] rcu: Enable elimination of Tree-RCU softirq processing
reproduce:
        # apt-get install sparse
        git checkout 9a1a31194644dfc6b8f19755ea44ecf84f37cf40
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>



sparse warnings: (new ones prefixed by >>)

>> kernel/rcu/tree.c:2408:36: sparse: sparse: incorrect type in initializer (different address spaces) @@    expected struct task_struct [noderef] <asn:3> **store @@    got struct task_struct [noderef] <asn:3> **store @@
>> kernel/rcu/tree.c:2408:36: sparse:    expected struct task_struct [noderef] <asn:3> **store
>> kernel/rcu/tree.c:2408:36: sparse:    got struct task_struct *[noderef] <asn:3> *
   kernel/rcu/tree.c:3234:13: sparse: sparse: incorrect type in argument 1 (different modifiers) @@    expected int ( *threadfn )( ... ) @@    got int ( [noreint ( *threadfn )( ... ) @@
   kernel/rcu/tree.c:3234:13: sparse:    expected int ( *threadfn )( ... )
   kernel/rcu/tree.c:3234:13: sparse:    got int ( [noreturn] * )( ... )
   kernel/rcu/tree.c:1110:13: sparse: sparse: context imbalance in 'rcu_start_this_gp' - different lock contexts for basic block
   kernel/rcu/tree.c:1502:9: sparse: sparse: context imbalance in 'rcu_gp_init' - different lock contexts for basic block
   kernel/rcu/tree.c:2190:9: sparse: sparse: context imbalance in 'force_qs_rnp' - different lock contexts for basic block
   kernel/rcu/tree.c:2243:25: sparse: sparse: context imbalance in 'rcu_force_quiescent_state' - unexpected unlock
   kernel/rcu/tree_stall.h:640:9: sparse: sparse: context imbalance in 'rcu_check_gp_start_stall' - different lock contexts for basic block
   kernel/rcu/tree_exp.h:193:9: sparse: sparse: context imbalance in '__rcu_report_exp_rnp' - different lock contexts for basic block

vim +2408 kernel/rcu/tree.c

  2406	
  2407	static struct smp_hotplug_thread rcu_cpu_thread_spec = {
> 2408		.store			= &rcu_data.rcu_cpu_kthread_task,
  2409		.thread_should_run	= rcu_cpu_kthread_should_run,
  2410		.thread_fn		= rcu_cpu_kthread,
  2411		.thread_comm		= "rcuc/%u",
  2412		.setup			= rcu_cpu_kthread_setup,
  2413		.park			= rcu_cpu_kthread_park,
  2414	};
  2415	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
