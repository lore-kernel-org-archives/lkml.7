Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 639A8C48BD3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 02:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DCCB2186A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 02:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfF0Cxo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 22:53:44 -0400
Received: from mga01.intel.com ([192.55.52.88]:15307 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbfF0Cxo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 22:53:44 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2019 19:53:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,422,1557212400"; 
   d="scan'208";a="156085021"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 26 Jun 2019 19:53:42 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hgKXd-000AoM-TD; Thu, 27 Jun 2019 10:53:41 +0800
Date:   Thu, 27 Jun 2019 10:52:53 +0800
From:   kbuild test robot <lkp@intel.com>
To:     KarimAllah Ahmed <karahmed@amazon.de>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: arch/x86/kernel/e820.c:88:9-10: WARNING: return of 0/1 in function
 '_e820__mapped_any' with return type bool
Message-ID: <201906271045.dTM7ZVZU%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   249155c20f9b0754bc1b932a33344cfb4e0c2101
commit: 0c55671f84fffe591e8435c93a8c83286fd6b8eb kvm, x86: Properly check whether a pfn is an MMIO or not
date:   8 weeks ago

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


coccinelle warnings: (new ones prefixed by >>)

>> arch/x86/kernel/e820.c:88:9-10: WARNING: return of 0/1 in function '_e820__mapped_any' with return type bool

vim +/_e820__mapped_any +88 arch/x86/kernel/e820.c

b79cd8f1 Yinghai Lu       2008-05-11  71  
b79cd8f1 Yinghai Lu       2008-05-11  72  /*
b79cd8f1 Yinghai Lu       2008-05-11  73   * This function checks if any part of the range <start,end> is mapped
b79cd8f1 Yinghai Lu       2008-05-11  74   * with type.
b79cd8f1 Yinghai Lu       2008-05-11  75   */
0c55671f KarimAllah Ahmed 2019-01-31  76  static bool _e820__mapped_any(struct e820_table *table,
0c55671f KarimAllah Ahmed 2019-01-31  77  			      u64 start, u64 end, enum e820_type type)
b79cd8f1 Yinghai Lu       2008-05-11  78  {
b79cd8f1 Yinghai Lu       2008-05-11  79  	int i;
b79cd8f1 Yinghai Lu       2008-05-11  80  
0c55671f KarimAllah Ahmed 2019-01-31  81  	for (i = 0; i < table->nr_entries; i++) {
0c55671f KarimAllah Ahmed 2019-01-31  82  		struct e820_entry *entry = &table->entries[i];
b79cd8f1 Yinghai Lu       2008-05-11  83  
e5540f87 Ingo Molnar      2017-01-28  84  		if (type && entry->type != type)
b79cd8f1 Yinghai Lu       2008-05-11  85  			continue;
e5540f87 Ingo Molnar      2017-01-28  86  		if (entry->addr >= end || entry->addr + entry->size <= start)
b79cd8f1 Yinghai Lu       2008-05-11  87  			continue;
b79cd8f1 Yinghai Lu       2008-05-11 @88  		return 1;
b79cd8f1 Yinghai Lu       2008-05-11  89  	}
b79cd8f1 Yinghai Lu       2008-05-11  90  	return 0;
b79cd8f1 Yinghai Lu       2008-05-11  91  }
0c55671f KarimAllah Ahmed 2019-01-31  92  

:::::: The code at line 88 was first introduced by commit
:::::: b79cd8f1268bab57ff85b19d131f7f23deab2dee x86: make e820.c to have common functions

:::::: TO: Yinghai Lu <yhlu.kernel@gmail.com>
:::::: CC: Thomas Gleixner <tglx@linutronix.de>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
