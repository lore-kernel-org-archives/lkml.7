Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B87C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 02:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E19B721744
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 02:15:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbfLECPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 21:15:41 -0500
Received: from mga17.intel.com ([192.55.52.151]:28117 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728121AbfLECPl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 21:15:41 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Dec 2019 18:15:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,279,1571727600"; 
   d="scan'208";a="219080343"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga001.fm.intel.com with ESMTP; 04 Dec 2019 18:15:37 -0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     richard.weiyang@gmail.com, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.or, tglx@linutronix.de,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [Patch v2 0/6] Refactor split_mem_range with proper helper and loop
Date:   Thu,  5 Dec 2019 10:13:57 +0800
Message-Id: <20191205021403.25606-1-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

split_mem_range is used to prepare range before mapping kernel page table.

After first version, Thomas suggested some brilliant idea to re-write the
logic.

Wei split the big patch into pieces and did some tests.  To verify the
functionality, Wei abstract the code into userland and did following test
cases:
    
        * ranges fits only 4K
        * ranges fits only 2M
        * ranges fits only 1G
        * ranges fits 4K and 2M
        * ranges fits 2M and 1G
        * ranges fits 4K, 2M and 1G
        * ranges fits 4K, 2M and 1G but w/o 1G size
        * ranges fits 4K, 2M and 1G with only 4K size
    
    Below is the test result:
    
        ### Split [4K, 16K][0x00001000-0x00004000]:
        [mem 0x00001000-0x00003fff] page size 4K
        ### Split [4M, 64M][0x00400000-0x04000000]:
        [mem 0x00400000-0x03ffffff] page size 2M
        ### Split [0G, 2G][0000000000-0x80000000]:
        [mem 0000000000-0x7fffffff] page size 1G
        ### Split [16K, 4M + 16K][0x00004000-0x00404000]:
        [mem 0x00004000-0x001fffff] page size 4K
        [mem 0x00200000-0x003fffff] page size 2M
        [mem 0x00400000-0x00403fff] page size 4K
        ### Split [4M, 2G + 2M][0x00400000-0x80200000]:
        [mem 0x00400000-0x3fffffff] page size 2M
        [mem 0x40000000-0x7fffffff] page size 1G
        [mem 0x80000000-0x801fffff] page size 2M
        ### Split [4M - 16K, 2G + 2M + 16K][0x003fc000-0x80204000]:
        [mem 0x003fc000-0x003fffff] page size 4K
        [mem 0x00400000-0x3fffffff] page size 2M
        [mem 0x40000000-0x7fffffff] page size 1G
        [mem 0x80000000-0x801fffff] page size 2M
        [mem 0x80200000-0x80203fff] page size 4K
        ### Split w/o 1G size [4M - 16K, 2G + 2M + 16K][0x003fc000-0x80204000]:
        [mem 0x003fc000-0x003fffff] page size 4K
        [mem 0x00400000-0x801fffff] page size 2M
        [mem 0x80200000-0x80203fff] page size 4K
        ### Split w/ only 4K [4M - 16K, 2G + 2M + 16K][0x003fc000-0x80204000]:
        [mem 0x003fc000-0x80203fff] page size 4K

Thomas Gleixner (1):
  x86/mm: Refactor split_mem_range with proper helper and loop

Wei Yang (5):
  x86/mm: Remove second argument of split_mem_range()
  x86/mm: Add attribute __ro_after_init to after_bootmem
  x86/mm: Make page_size_mask unsigned int clearly
  x86/mm: Refine debug print string retrieval function
  x86/mm: Use address directly in split_mem_range()

 arch/x86/mm/init.c | 259 ++++++++++++++++++---------------------------
 1 file changed, 103 insertions(+), 156 deletions(-)

-- 
2.17.1

