Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A9FC43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9798A2088F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfDYPkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 11:40:17 -0400
Received: from mga01.intel.com ([192.55.52.88]:47058 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbfDYPkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 11:40:17 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Apr 2019 08:40:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,394,1549958400"; 
   d="scan'208";a="165032277"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 25 Apr 2019 08:40:15 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hJgTv-0007a5-M7; Thu, 25 Apr 2019 23:40:15 +0800
Date:   Thu, 25 Apr 2019 23:40:13 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org, tipbuild@zytor.com
Subject: [tip:WIP.x86/paravirt 7/8] arch/x86/events/intel/ds.c:359:17:
 sparse: sparse: incorrect type in initializer (different address spaces)
Message-ID: <201904252311.Tbs4mccA%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git WIP.x86/paravirt
head:   269b8685f55e335b82b64f9858a751ba3d5ea8d8
commit: 124d6af5a5f559e516ed2c6ea857e889ed293b43 [7/8] x86/paravirt: Standardize 'insn_buff' variable names
reproduce:
        # apt-get install sparse
        git checkout 124d6af5a5f559e516ed2c6ea857e889ed293b43
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> arch/x86/events/intel/ds.c:359:17: sparse: sparse: incorrect type in initializer (different address spaces) @@    expected void const [noderef] <asn:3> *__vpp_verify @@    got sn:3> *__vpp_verify @@
>> arch/x86/events/intel/ds.c:359:17: sparse:    expected void const [noderef] <asn:3> *__vpp_verify
>> arch/x86/events/intel/ds.c:359:17: sparse:    got void **

vim +359 arch/x86/events/intel/ds.c

   333	
   334	static int alloc_pebs_buffer(int cpu)
   335	{
   336		struct cpu_hw_events *hwev = per_cpu_ptr(&cpu_hw_events, cpu);
   337		struct debug_store *ds = hwev->ds;
   338		size_t bsiz = x86_pmu.pebs_buffer_size;
   339		int max, node = cpu_to_node(cpu);
   340		void *buffer, *insn_buff, *cea;
   341	
   342		if (!x86_pmu.pebs)
   343			return 0;
   344	
   345		buffer = dsalloc_pages(bsiz, GFP_KERNEL, cpu);
   346		if (unlikely(!buffer))
   347			return -ENOMEM;
   348	
   349		/*
   350		 * HSW+ already provides us the eventing ip; no need to allocate this
   351		 * buffer then.
   352		 */
   353		if (x86_pmu.intel_cap.pebs_format < 2) {
   354			insn_buff = kzalloc_node(PEBS_FIXUP_SIZE, GFP_KERNEL, node);
   355			if (!insn_buff) {
   356				dsfree_pages(buffer, bsiz);
   357				return -ENOMEM;
   358			}
 > 359			per_cpu(insn_buff, cpu) = insn_buff;
   360		}
   361		hwev->ds_pebs_vaddr = buffer;
   362		/* Update the cpu entry area mapping */
   363		cea = &get_cpu_entry_area(cpu)->cpu_debug_buffers.pebs_buffer;
   364		ds->pebs_buffer_base = (unsigned long) cea;
   365		ds_update_cea(cea, buffer, bsiz, PAGE_KERNEL);
   366		ds->pebs_index = ds->pebs_buffer_base;
   367		max = x86_pmu.pebs_record_size * (bsiz / x86_pmu.pebs_record_size);
   368		ds->pebs_absolute_maximum = ds->pebs_buffer_base + max;
   369		return 0;
   370	}
   371	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
