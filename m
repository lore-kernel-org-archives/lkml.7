Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59EC3C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 06:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37E8D2071E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 06:37:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbfKYGh3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 01:37:29 -0500
Received: from mga06.intel.com ([134.134.136.31]:27907 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbfKYGh2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 01:37:28 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Nov 2019 22:37:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,240,1571727600"; 
   d="scan'208";a="233304453"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 24 Nov 2019 22:37:26 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iZ7zx-0002qo-Ob; Mon, 25 Nov 2019 14:37:25 +0800
Date:   Mon, 25 Nov 2019 14:36:40 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Scott Cheloha <cheloha@linux.vnet.ibm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Hildenbrand <david@redhat.com>, nathanl@linux.ibm.com,
        ricklind@linux.vnet.ibm.com,
        Scott Cheloha <cheloha@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] drivers/base/memory.c: cache blocks in radix tree to
 accelerate lookup
Message-ID: <201911251315.iroYiVrK%lkp@intel.com>
References: <20191121195952.3728-1-cheloha@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121195952.3728-1-cheloha@linux.vnet.ibm.com>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Scott,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on driver-core/driver-core-testing]
[also build test WARNING on v5.4]
[cannot apply to next-20191122]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Scott-Cheloha/drivers-base-memory-c-cache-blocks-in-radix-tree-to-accelerate-lookup/20191124-104557
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git 0e4a459f56c32d3e52ae69a4b447db2f48a65f44
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-36-g9305d48-dirty
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/base/memory.c:874:9: sparse: sparse: incorrect type in assignment (different address spaces) @@    expected void **slot @@    got void [noderef] <asvoid **slot @@
>> drivers/base/memory.c:874:9: sparse:    expected void **slot
>> drivers/base/memory.c:874:9: sparse:    got void [noderef] <asn:4> **
>> drivers/base/memory.c:874:9: sparse: sparse: incorrect type in assignment (different address spaces) @@    expected void **slot @@    got void [noderef] <asvoid **slot @@
>> drivers/base/memory.c:874:9: sparse:    expected void **slot
>> drivers/base/memory.c:874:9: sparse:    got void [noderef] <asn:4> **
>> drivers/base/memory.c:877:45: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void [noderef] <asn:4> **slot @@    got n:4> **slot @@
>> drivers/base/memory.c:877:45: sparse:    expected void [noderef] <asn:4> **slot
>> drivers/base/memory.c:877:45: sparse:    got void **slot
   drivers/base/memory.c:874:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void [noderef] <asn:4> **slot @@    got n:4> **slot @@
   drivers/base/memory.c:874:9: sparse:    expected void [noderef] <asn:4> **slot
   drivers/base/memory.c:874:9: sparse:    got void **slot
>> drivers/base/memory.c:874:9: sparse: sparse: incorrect type in assignment (different address spaces) @@    expected void **slot @@    got void [noderef] <asvoid **slot @@
>> drivers/base/memory.c:874:9: sparse:    expected void **slot
>> drivers/base/memory.c:874:9: sparse:    got void [noderef] <asn:4> **

vim +874 drivers/base/memory.c

   845	
   846	/**
   847	 * walk_memory_blocks - walk through all present memory blocks overlapped
   848	 *			by the range [start, start + size)
   849	 *
   850	 * @start: start address of the memory range
   851	 * @size: size of the memory range
   852	 * @arg: argument passed to func
   853	 * @func: callback for each memory section walked
   854	 *
   855	 * This function walks through all present memory blocks overlapped by the
   856	 * range [start, start + size), calling func on each memory block.
   857	 *
   858	 * In case func() returns an error, walking is aborted and the error is
   859	 * returned.
   860	 */
   861	int walk_memory_blocks(unsigned long start, unsigned long size,
   862			       void *arg, walk_memory_blocks_func_t func)
   863	{
   864		struct radix_tree_iter iter;
   865		const unsigned long start_block_id = phys_to_block_id(start);
   866		const unsigned long end_block_id = phys_to_block_id(start + size - 1);
   867		struct memory_block *mem;
   868		void **slot;
   869		int ret = 0;
   870	
   871		if (!size)
   872			return 0;
   873	
 > 874		radix_tree_for_each_slot(slot, &memory_blocks, &iter, start_block_id) {
   875			if (iter.index > end_block_id)
   876				break;
 > 877			mem = radix_tree_deref_slot(slot);

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
