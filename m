Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B772C43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 22:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9ADA20842
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 22:07:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725998AbfCCWHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 17:07:25 -0500
Received: from mga03.intel.com ([134.134.136.65]:51307 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725923AbfCCWHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 17:07:25 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Mar 2019 14:07:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,437,1544515200"; 
   d="scan'208";a="122332855"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 03 Mar 2019 14:07:23 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1h0ZGU-0009JX-G5; Mon, 04 Mar 2019 06:07:22 +0800
Date:   Mon, 4 Mar 2019 06:07:18 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: mm/kasan/init.c:44:8-9: WARNING: return of 0/1 in function
 'kasan_p4d_table' with return type bool
Message-ID: <201903040615.AFuPIoDo%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c027c7cf1577bc2333449447c6e48c93126a56b0
commit: b938fcf42739de8270e6ea41593722929c8a7dd0 kasan: rename source files to reflect the new naming scheme
date:   9 weeks ago


coccinelle warnings: (new ones prefixed by >>)

>> mm/kasan/init.c:44:8-9: WARNING: return of 0/1 in function 'kasan_p4d_table' with return type bool
>> mm/kasan/init.c:68:8-9: WARNING: return of 0/1 in function 'kasan_pmd_table' with return type bool
>> mm/kasan/init.c:56:8-9: WARNING: return of 0/1 in function 'kasan_pud_table' with return type bool

vim +/kasan_p4d_table +44 mm/kasan/init.c

69786cdb3 mm/kasan/kasan_init.c Andrey Ryabinin    2015-08-13  34  
c2febafc6 mm/kasan/kasan_init.c Kirill A. Shutemov 2017-03-09  35  #if CONFIG_PGTABLE_LEVELS > 4
c65e774fb mm/kasan/kasan_init.c Kirill A. Shutemov 2018-02-14  36  p4d_t kasan_zero_p4d[MAX_PTRS_PER_P4D] __page_aligned_bss;
0207df4fa mm/kasan/kasan_init.c Andrey Ryabinin    2018-08-17  37  static inline bool kasan_p4d_table(pgd_t pgd)
0207df4fa mm/kasan/kasan_init.c Andrey Ryabinin    2018-08-17  38  {
0207df4fa mm/kasan/kasan_init.c Andrey Ryabinin    2018-08-17  39  	return pgd_page(pgd) == virt_to_page(lm_alias(kasan_zero_p4d));
0207df4fa mm/kasan/kasan_init.c Andrey Ryabinin    2018-08-17  40  }
0207df4fa mm/kasan/kasan_init.c Andrey Ryabinin    2018-08-17  41  #else
0207df4fa mm/kasan/kasan_init.c Andrey Ryabinin    2018-08-17  42  static inline bool kasan_p4d_table(pgd_t pgd)
0207df4fa mm/kasan/kasan_init.c Andrey Ryabinin    2018-08-17  43  {
0207df4fa mm/kasan/kasan_init.c Andrey Ryabinin    2018-08-17 @44  	return 0;
0207df4fa mm/kasan/kasan_init.c Andrey Ryabinin    2018-08-17  45  }
c2febafc6 mm/kasan/kasan_init.c Kirill A. Shutemov 2017-03-09  46  #endif
69786cdb3 mm/kasan/kasan_init.c Andrey Ryabinin    2015-08-13  47  #if CONFIG_PGTABLE_LEVELS > 3
69786cdb3 mm/kasan/kasan_init.c Andrey Ryabinin    2015-08-13  48  pud_t kasan_zero_pud[PTRS_PER_PUD] __page_aligned_bss;
0207df4fa mm/kasan/kasan_init.c Andrey Ryabinin    2018-08-17  49  static inline bool kasan_pud_table(p4d_t p4d)
0207df4fa mm/kasan/kasan_init.c Andrey Ryabinin    2018-08-17  50  {
0207df4fa mm/kasan/kasan_init.c Andrey Ryabinin    2018-08-17  51  	return p4d_page(p4d) == virt_to_page(lm_alias(kasan_zero_pud));
0207df4fa mm/kasan/kasan_init.c Andrey Ryabinin    2018-08-17  52  }
0207df4fa mm/kasan/kasan_init.c Andrey Ryabinin    2018-08-17  53  #else
0207df4fa mm/kasan/kasan_init.c Andrey Ryabinin    2018-08-17  54  static inline bool kasan_pud_table(p4d_t p4d)
0207df4fa mm/kasan/kasan_init.c Andrey Ryabinin    2018-08-17  55  {
0207df4fa mm/kasan/kasan_init.c Andrey Ryabinin    2018-08-17 @56  	return 0;
0207df4fa mm/kasan/kasan_init.c Andrey Ryabinin    2018-08-17  57  }
69786cdb3 mm/kasan/kasan_init.c Andrey Ryabinin    2015-08-13  58  #endif
69786cdb3 mm/kasan/kasan_init.c Andrey Ryabinin    2015-08-13  59  #if CONFIG_PGTABLE_LEVELS > 2
69786cdb3 mm/kasan/kasan_init.c Andrey Ryabinin    2015-08-13  60  pmd_t kasan_zero_pmd[PTRS_PER_PMD] __page_aligned_bss;
0207df4fa mm/kasan/kasan_init.c Andrey Ryabinin    2018-08-17  61  static inline bool kasan_pmd_table(pud_t pud)
0207df4fa mm/kasan/kasan_init.c Andrey Ryabinin    2018-08-17  62  {
0207df4fa mm/kasan/kasan_init.c Andrey Ryabinin    2018-08-17  63  	return pud_page(pud) == virt_to_page(lm_alias(kasan_zero_pmd));
0207df4fa mm/kasan/kasan_init.c Andrey Ryabinin    2018-08-17  64  }
0207df4fa mm/kasan/kasan_init.c Andrey Ryabinin    2018-08-17  65  #else
0207df4fa mm/kasan/kasan_init.c Andrey Ryabinin    2018-08-17  66  static inline bool kasan_pmd_table(pud_t pud)
0207df4fa mm/kasan/kasan_init.c Andrey Ryabinin    2018-08-17  67  {
0207df4fa mm/kasan/kasan_init.c Andrey Ryabinin    2018-08-17 @68  	return 0;
0207df4fa mm/kasan/kasan_init.c Andrey Ryabinin    2018-08-17  69  }
69786cdb3 mm/kasan/kasan_init.c Andrey Ryabinin    2015-08-13  70  #endif
69786cdb3 mm/kasan/kasan_init.c Andrey Ryabinin    2015-08-13  71  pte_t kasan_zero_pte[PTRS_PER_PTE] __page_aligned_bss;
69786cdb3 mm/kasan/kasan_init.c Andrey Ryabinin    2015-08-13  72  

:::::: The code at line 44 was first introduced by commit
:::::: 0207df4fa1a869281ddbf72db6203dbf036b3e1a kernel/memremap, kasan: make ZONE_DEVICE with work with KASAN

:::::: TO: Andrey Ryabinin <aryabinin@virtuozzo.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
