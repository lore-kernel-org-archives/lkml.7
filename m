Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D5DC32792
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 02:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B40220815
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 02:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730757AbfJACYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 22:24:19 -0400
Received: from mga09.intel.com ([134.134.136.24]:33644 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727810AbfJACYS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 22:24:18 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Sep 2019 19:24:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,569,1559545200"; 
   d="scan'208";a="194382135"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 30 Sep 2019 19:24:15 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iF7pn-0000VI-0Z; Tue, 01 Oct 2019 10:24:15 +0800
Date:   Tue, 1 Oct 2019 10:23:29 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Stefan-gabriel Mirea <stefan-gabriel.mirea@nxp.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stoica Cosmin-Stefan <cosmin.stoica@nxp.com>,
        "Adrian.Nitu" <adrian.nitu@freescale.com>,
        Larisa Grigore <Larisa.Grigore@nxp.com>,
        Ana Nedelcu <B56683@freescale.com>,
        Mihaela Martinas <Mihaela.Martinas@freescale.com>,
        Matthew Nunez <matthew.nunez@nxp.com>
Subject: include/linux/spinlock.h:393:9: sparse: sparse: context imbalance in
 'linflex_console_write' - unexpected unlock
Message-ID: <201910011019.MzeuDvQA%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c
commit: 09864c1cdf5c537bd01bff45181406e422ea988c tty: serial: Add linflexuart driver for S32V234
date:   4 weeks ago
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-rc1-37-gd466a02-dirty
        git checkout 09864c1cdf5c537bd01bff45181406e422ea988c
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> include/linux/spinlock.h:393:9: sparse: sparse: context imbalance in 'linflex_console_write' - unexpected unlock

vim +/linflex_console_write +393 include/linux/spinlock.h

c2f21ce2e31286 Thomas Gleixner 2009-12-02  390  
3490565b633c70 Denys Vlasenko  2015-07-13  391  static __always_inline void spin_unlock_irqrestore(spinlock_t *lock, unsigned long flags)
c2f21ce2e31286 Thomas Gleixner 2009-12-02  392  {
c2f21ce2e31286 Thomas Gleixner 2009-12-02 @393  	raw_spin_unlock_irqrestore(&lock->rlock, flags);
c2f21ce2e31286 Thomas Gleixner 2009-12-02  394  }
c2f21ce2e31286 Thomas Gleixner 2009-12-02  395  

:::::: The code at line 393 was first introduced by commit
:::::: c2f21ce2e31286a0a32f8da0a7856e9ca1122ef3 locking: Implement new raw_spinlock

:::::: TO: Thomas Gleixner <tglx@linutronix.de>
:::::: CC: Thomas Gleixner <tglx@linutronix.de>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
