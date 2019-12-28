Return-Path: <SRS0=tgXE=2S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40BE0C2D0C3
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 00:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 112E0208C4
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 00:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbfL1AKM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 19:10:12 -0500
Received: from mga11.intel.com ([192.55.52.93]:57911 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725306AbfL1AKL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 19:10:11 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Dec 2019 16:10:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,364,1571727600"; 
   d="scan'208";a="418459089"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 27 Dec 2019 16:10:08 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1ikzgG-0006Nm-CP; Sat, 28 Dec 2019 08:10:08 +0800
Date:   Sat, 28 Dec 2019 08:10:07 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     kbuild-all@lists.01.org, Andrew Morton <akpm@linux-foundation.org>,
        "Willhalm, Thomas" <thomas.willhalm@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Bruggeman, Otto G" <otto.g.bruggeman@intel.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        linux-mm@kvack.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH 2/2] thp, shmem: Fix conflict of above-47bit hint address
 and PMD alignment
Message-ID: <201912280704.DFqECoHe%lkp@intel.com>
References: <20191220142548.7118-3-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191220142548.7118-3-kirill.shutemov@linux.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "Kirill,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v5.5-rc3 next-20191220]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Kirill-A-Shutemov/Fix-two-above-47bit-hint-address-vs-THP-bugs/20191223-221713
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 46cf053efec6a3a5f343fead837777efe8252a46
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-129-g341daf20-dirty
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> mm/shmem.c:2147:34: sparse: sparse: incorrect type in argument 1 (different base types)
>> mm/shmem.c:2147:34: sparse:    expected struct file *
>> mm/shmem.c:2147:34: sparse:    got unsigned long uaddr

vim +2147 mm/shmem.c

  2073	
  2074	unsigned long shmem_get_unmapped_area(struct file *file,
  2075					      unsigned long uaddr, unsigned long len,
  2076					      unsigned long pgoff, unsigned long flags)
  2077	{
  2078		unsigned long (*get_area)(struct file *,
  2079			unsigned long, unsigned long, unsigned long, unsigned long);
  2080		unsigned long addr;
  2081		unsigned long offset;
  2082		unsigned long inflated_len;
  2083		unsigned long inflated_addr;
  2084		unsigned long inflated_offset;
  2085	
  2086		if (len > TASK_SIZE)
  2087			return -ENOMEM;
  2088	
  2089		get_area = current->mm->get_unmapped_area;
  2090		addr = get_area(file, uaddr, len, pgoff, flags);
  2091	
  2092		if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGE_PAGECACHE))
  2093			return addr;
  2094		if (IS_ERR_VALUE(addr))
  2095			return addr;
  2096		if (addr & ~PAGE_MASK)
  2097			return addr;
  2098		if (addr > TASK_SIZE - len)
  2099			return addr;
  2100	
  2101		if (shmem_huge == SHMEM_HUGE_DENY)
  2102			return addr;
  2103		if (len < HPAGE_PMD_SIZE)
  2104			return addr;
  2105		if (flags & MAP_FIXED)
  2106			return addr;
  2107		/*
  2108		 * Our priority is to support MAP_SHARED mapped hugely;
  2109		 * and support MAP_PRIVATE mapped hugely too, until it is COWed.
  2110		 * But if caller specified an address hint and we allocated area there
  2111		 * successfully, respect that as before.
  2112		 */
  2113		if (uaddr == addr)
  2114			return addr;
  2115	
  2116		if (shmem_huge != SHMEM_HUGE_FORCE) {
  2117			struct super_block *sb;
  2118	
  2119			if (file) {
  2120				VM_BUG_ON(file->f_op != &shmem_file_operations);
  2121				sb = file_inode(file)->i_sb;
  2122			} else {
  2123				/*
  2124				 * Called directly from mm/mmap.c, or drivers/char/mem.c
  2125				 * for "/dev/zero", to create a shared anonymous object.
  2126				 */
  2127				if (IS_ERR(shm_mnt))
  2128					return addr;
  2129				sb = shm_mnt->mnt_sb;
  2130			}
  2131			if (SHMEM_SB(sb)->huge == SHMEM_HUGE_NEVER)
  2132				return addr;
  2133		}
  2134	
  2135		offset = (pgoff << PAGE_SHIFT) & (HPAGE_PMD_SIZE-1);
  2136		if (offset && offset + len < 2 * HPAGE_PMD_SIZE)
  2137			return addr;
  2138		if ((addr & (HPAGE_PMD_SIZE-1)) == offset)
  2139			return addr;
  2140	
  2141		inflated_len = len + HPAGE_PMD_SIZE - PAGE_SIZE;
  2142		if (inflated_len > TASK_SIZE)
  2143			return addr;
  2144		if (inflated_len < len)
  2145			return addr;
  2146	
> 2147		inflated_addr = get_area(uaddr, 0, inflated_len, 0, flags);
  2148		if (IS_ERR_VALUE(inflated_addr))
  2149			return addr;
  2150		if (inflated_addr & ~PAGE_MASK)
  2151			return addr;
  2152	
  2153		inflated_offset = inflated_addr & (HPAGE_PMD_SIZE-1);
  2154		inflated_addr += offset - inflated_offset;
  2155		if (inflated_offset > offset)
  2156			inflated_addr += HPAGE_PMD_SIZE;
  2157	
  2158		if (inflated_addr > TASK_SIZE - len)
  2159			return addr;
  2160		return inflated_addr;
  2161	}
  2162	

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
