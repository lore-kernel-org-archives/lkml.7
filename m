Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E78C47404
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 02:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1B94222C5
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 02:29:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbfJFC0A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 22:26:00 -0400
Received: from mga01.intel.com ([192.55.52.88]:32871 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbfJFCZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 22:25:59 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Oct 2019 19:25:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,261,1566889200"; 
   d="scan'208";a="392686570"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 05 Oct 2019 19:25:55 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iGwF9-000Cry-6s; Sun, 06 Oct 2019 10:25:55 +0800
Date:   Sun, 6 Oct 2019 10:25:48 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     kbuild-all@01.org, mike.kravetz@oracle.com,
        akpm@linux-foundation.org, hughd@google.com, aarcange@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: Re: [PATCH] hugetlb: remove unused hstate in
 hugetlb_fault_mutex_hash()
Message-ID: <201910061041.AvdQQNe9%lkp@intel.com>
References: <20191005003302.785-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191005003302.785-1-richardw.yang@linux.intel.com>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wei,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[cannot apply to v5.4-rc1 next-20191004]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Wei-Yang/hugetlb-remove-unused-hstate-in-hugetlb_fault_mutex_hash/20191005-090034
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-rc1-42-g38eda53-dirty
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   mm/userfaultfd.c:262:17: sparse: sparse: undefined identifier 'h'
   mm/userfaultfd.c:273:75: sparse: sparse: undefined identifier 'h'
   mm/userfaultfd.c:300:69: sparse: sparse: undefined identifier 'h'
>> mm/userfaultfd.c:262:17: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected struct hstate *h @@    got hstate *h @@
>> mm/userfaultfd.c:262:17: sparse:    expected struct hstate *h
>> mm/userfaultfd.c:262:17: sparse:    got bad type
   mm/userfaultfd.c:273:75: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected struct hstate *h @@    got hstate *h @@
   mm/userfaultfd.c:273:75: sparse:    expected struct hstate *h
   mm/userfaultfd.c:273:75: sparse:    got bad type
   mm/userfaultfd.c:300:69: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected struct hstate *h @@    got hstate *h @@
   mm/userfaultfd.c:300:69: sparse:    expected struct hstate *h
   mm/userfaultfd.c:300:69: sparse:    got bad type

vim +262 mm/userfaultfd.c

c1a4de99fada21 Andrea Arcangeli 2015-09-04  167  
60d4d2d2b40e44 Mike Kravetz     2017-02-22  168  #ifdef CONFIG_HUGETLB_PAGE
60d4d2d2b40e44 Mike Kravetz     2017-02-22  169  /*
60d4d2d2b40e44 Mike Kravetz     2017-02-22  170   * __mcopy_atomic processing for HUGETLB vmas.  Note that this routine is
60d4d2d2b40e44 Mike Kravetz     2017-02-22  171   * called with mmap_sem held, it will release mmap_sem before returning.
60d4d2d2b40e44 Mike Kravetz     2017-02-22  172   */
60d4d2d2b40e44 Mike Kravetz     2017-02-22  173  static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
60d4d2d2b40e44 Mike Kravetz     2017-02-22  174  					      struct vm_area_struct *dst_vma,
60d4d2d2b40e44 Mike Kravetz     2017-02-22  175  					      unsigned long dst_start,
60d4d2d2b40e44 Mike Kravetz     2017-02-22  176  					      unsigned long src_start,
60d4d2d2b40e44 Mike Kravetz     2017-02-22  177  					      unsigned long len,
60d4d2d2b40e44 Mike Kravetz     2017-02-22  178  					      bool zeropage)
60d4d2d2b40e44 Mike Kravetz     2017-02-22  179  {
1c9e8def43a345 Mike Kravetz     2017-02-22  180  	int vm_alloc_shared = dst_vma->vm_flags & VM_SHARED;
1c9e8def43a345 Mike Kravetz     2017-02-22  181  	int vm_shared = dst_vma->vm_flags & VM_SHARED;
60d4d2d2b40e44 Mike Kravetz     2017-02-22  182  	ssize_t err;
60d4d2d2b40e44 Mike Kravetz     2017-02-22  183  	pte_t *dst_pte;
60d4d2d2b40e44 Mike Kravetz     2017-02-22  184  	unsigned long src_addr, dst_addr;
60d4d2d2b40e44 Mike Kravetz     2017-02-22  185  	long copied;
60d4d2d2b40e44 Mike Kravetz     2017-02-22  186  	struct page *page;
60d4d2d2b40e44 Mike Kravetz     2017-02-22  187  	unsigned long vma_hpagesize;
60d4d2d2b40e44 Mike Kravetz     2017-02-22  188  	pgoff_t idx;
60d4d2d2b40e44 Mike Kravetz     2017-02-22  189  	u32 hash;
60d4d2d2b40e44 Mike Kravetz     2017-02-22  190  	struct address_space *mapping;
60d4d2d2b40e44 Mike Kravetz     2017-02-22  191  
60d4d2d2b40e44 Mike Kravetz     2017-02-22  192  	/*
60d4d2d2b40e44 Mike Kravetz     2017-02-22  193  	 * There is no default zero huge page for all huge page sizes as
60d4d2d2b40e44 Mike Kravetz     2017-02-22  194  	 * supported by hugetlb.  A PMD_SIZE huge pages may exist as used
60d4d2d2b40e44 Mike Kravetz     2017-02-22  195  	 * by THP.  Since we can not reliably insert a zero page, this
60d4d2d2b40e44 Mike Kravetz     2017-02-22  196  	 * feature is not supported.
60d4d2d2b40e44 Mike Kravetz     2017-02-22  197  	 */
60d4d2d2b40e44 Mike Kravetz     2017-02-22  198  	if (zeropage) {
60d4d2d2b40e44 Mike Kravetz     2017-02-22  199  		up_read(&dst_mm->mmap_sem);
60d4d2d2b40e44 Mike Kravetz     2017-02-22  200  		return -EINVAL;
60d4d2d2b40e44 Mike Kravetz     2017-02-22  201  	}
60d4d2d2b40e44 Mike Kravetz     2017-02-22  202  
60d4d2d2b40e44 Mike Kravetz     2017-02-22  203  	src_addr = src_start;
60d4d2d2b40e44 Mike Kravetz     2017-02-22  204  	dst_addr = dst_start;
60d4d2d2b40e44 Mike Kravetz     2017-02-22  205  	copied = 0;
60d4d2d2b40e44 Mike Kravetz     2017-02-22  206  	page = NULL;
60d4d2d2b40e44 Mike Kravetz     2017-02-22  207  	vma_hpagesize = vma_kernel_pagesize(dst_vma);
60d4d2d2b40e44 Mike Kravetz     2017-02-22  208  
60d4d2d2b40e44 Mike Kravetz     2017-02-22  209  	/*
60d4d2d2b40e44 Mike Kravetz     2017-02-22  210  	 * Validate alignment based on huge page size
60d4d2d2b40e44 Mike Kravetz     2017-02-22  211  	 */
60d4d2d2b40e44 Mike Kravetz     2017-02-22  212  	err = -EINVAL;
60d4d2d2b40e44 Mike Kravetz     2017-02-22  213  	if (dst_start & (vma_hpagesize - 1) || len & (vma_hpagesize - 1))
60d4d2d2b40e44 Mike Kravetz     2017-02-22  214  		goto out_unlock;
60d4d2d2b40e44 Mike Kravetz     2017-02-22  215  
60d4d2d2b40e44 Mike Kravetz     2017-02-22  216  retry:
60d4d2d2b40e44 Mike Kravetz     2017-02-22  217  	/*
60d4d2d2b40e44 Mike Kravetz     2017-02-22  218  	 * On routine entry dst_vma is set.  If we had to drop mmap_sem and
60d4d2d2b40e44 Mike Kravetz     2017-02-22  219  	 * retry, dst_vma will be set to NULL and we must lookup again.
60d4d2d2b40e44 Mike Kravetz     2017-02-22  220  	 */
60d4d2d2b40e44 Mike Kravetz     2017-02-22  221  	if (!dst_vma) {
27d02568f529e9 Mike Rapoport    2017-02-24  222  		err = -ENOENT;
60d4d2d2b40e44 Mike Kravetz     2017-02-22  223  		dst_vma = find_vma(dst_mm, dst_start);
60d4d2d2b40e44 Mike Kravetz     2017-02-22  224  		if (!dst_vma || !is_vm_hugetlb_page(dst_vma))
60d4d2d2b40e44 Mike Kravetz     2017-02-22  225  			goto out_unlock;
60d4d2d2b40e44 Mike Kravetz     2017-02-22  226  		/*
29ec90660d68bb Andrea Arcangeli 2018-11-30  227  		 * Check the vma is registered in uffd, this is
29ec90660d68bb Andrea Arcangeli 2018-11-30  228  		 * required to enforce the VM_MAYWRITE check done at
29ec90660d68bb Andrea Arcangeli 2018-11-30  229  		 * uffd registration time.
60d4d2d2b40e44 Mike Kravetz     2017-02-22  230  		 */
27d02568f529e9 Mike Rapoport    2017-02-24  231  		if (!dst_vma->vm_userfaultfd_ctx.ctx)
27d02568f529e9 Mike Rapoport    2017-02-24  232  			goto out_unlock;
27d02568f529e9 Mike Rapoport    2017-02-24  233  
60d4d2d2b40e44 Mike Kravetz     2017-02-22  234  		if (dst_start < dst_vma->vm_start ||
60d4d2d2b40e44 Mike Kravetz     2017-02-22  235  		    dst_start + len > dst_vma->vm_end)
60d4d2d2b40e44 Mike Kravetz     2017-02-22  236  			goto out_unlock;
1c9e8def43a345 Mike Kravetz     2017-02-22  237  
27d02568f529e9 Mike Rapoport    2017-02-24  238  		err = -EINVAL;
27d02568f529e9 Mike Rapoport    2017-02-24  239  		if (vma_hpagesize != vma_kernel_pagesize(dst_vma))
27d02568f529e9 Mike Rapoport    2017-02-24  240  			goto out_unlock;
27d02568f529e9 Mike Rapoport    2017-02-24  241  
1c9e8def43a345 Mike Kravetz     2017-02-22  242  		vm_shared = dst_vma->vm_flags & VM_SHARED;
60d4d2d2b40e44 Mike Kravetz     2017-02-22  243  	}
60d4d2d2b40e44 Mike Kravetz     2017-02-22  244  
60d4d2d2b40e44 Mike Kravetz     2017-02-22  245  	if (WARN_ON(dst_addr & (vma_hpagesize - 1) ||
60d4d2d2b40e44 Mike Kravetz     2017-02-22  246  		    (len - copied) & (vma_hpagesize - 1)))
60d4d2d2b40e44 Mike Kravetz     2017-02-22  247  		goto out_unlock;
60d4d2d2b40e44 Mike Kravetz     2017-02-22  248  
60d4d2d2b40e44 Mike Kravetz     2017-02-22  249  	/*
1c9e8def43a345 Mike Kravetz     2017-02-22  250  	 * If not shared, ensure the dst_vma has a anon_vma.
60d4d2d2b40e44 Mike Kravetz     2017-02-22  251  	 */
60d4d2d2b40e44 Mike Kravetz     2017-02-22  252  	err = -ENOMEM;
1c9e8def43a345 Mike Kravetz     2017-02-22  253  	if (!vm_shared) {
60d4d2d2b40e44 Mike Kravetz     2017-02-22  254  		if (unlikely(anon_vma_prepare(dst_vma)))
60d4d2d2b40e44 Mike Kravetz     2017-02-22  255  			goto out_unlock;
1c9e8def43a345 Mike Kravetz     2017-02-22  256  	}
60d4d2d2b40e44 Mike Kravetz     2017-02-22  257  
60d4d2d2b40e44 Mike Kravetz     2017-02-22  258  	while (src_addr < src_start + len) {
60d4d2d2b40e44 Mike Kravetz     2017-02-22  259  		pte_t dst_pteval;
60d4d2d2b40e44 Mike Kravetz     2017-02-22  260  
60d4d2d2b40e44 Mike Kravetz     2017-02-22  261  		BUG_ON(dst_addr >= dst_start + len);
60d4d2d2b40e44 Mike Kravetz     2017-02-22 @262  		VM_BUG_ON(dst_addr & ~huge_page_mask(h));
60d4d2d2b40e44 Mike Kravetz     2017-02-22  263  
60d4d2d2b40e44 Mike Kravetz     2017-02-22  264  		/*
ddeaab32a89f04 Mike Kravetz     2019-01-08  265  		 * Serialize via hugetlb_fault_mutex
60d4d2d2b40e44 Mike Kravetz     2017-02-22  266  		 */
b43a9990055958 Mike Kravetz     2018-12-28  267  		idx = linear_page_index(dst_vma, dst_addr);
ddeaab32a89f04 Mike Kravetz     2019-01-08  268  		mapping = dst_vma->vm_file->f_mapping;
2b52c262f0e75d Wei Yang         2019-10-05  269  		hash = hugetlb_fault_mutex_hash(mapping, idx, dst_addr);
60d4d2d2b40e44 Mike Kravetz     2017-02-22  270  		mutex_lock(&hugetlb_fault_mutex_table[hash]);
60d4d2d2b40e44 Mike Kravetz     2017-02-22  271  
60d4d2d2b40e44 Mike Kravetz     2017-02-22  272  		err = -ENOMEM;
60d4d2d2b40e44 Mike Kravetz     2017-02-22  273  		dst_pte = huge_pte_alloc(dst_mm, dst_addr, huge_page_size(h));
60d4d2d2b40e44 Mike Kravetz     2017-02-22  274  		if (!dst_pte) {
60d4d2d2b40e44 Mike Kravetz     2017-02-22  275  			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
60d4d2d2b40e44 Mike Kravetz     2017-02-22  276  			goto out_unlock;
60d4d2d2b40e44 Mike Kravetz     2017-02-22  277  		}
60d4d2d2b40e44 Mike Kravetz     2017-02-22  278  
60d4d2d2b40e44 Mike Kravetz     2017-02-22  279  		err = -EEXIST;
60d4d2d2b40e44 Mike Kravetz     2017-02-22  280  		dst_pteval = huge_ptep_get(dst_pte);
60d4d2d2b40e44 Mike Kravetz     2017-02-22  281  		if (!huge_pte_none(dst_pteval)) {
60d4d2d2b40e44 Mike Kravetz     2017-02-22  282  			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
60d4d2d2b40e44 Mike Kravetz     2017-02-22  283  			goto out_unlock;
60d4d2d2b40e44 Mike Kravetz     2017-02-22  284  		}
60d4d2d2b40e44 Mike Kravetz     2017-02-22  285  
60d4d2d2b40e44 Mike Kravetz     2017-02-22  286  		err = hugetlb_mcopy_atomic_pte(dst_mm, dst_pte, dst_vma,
60d4d2d2b40e44 Mike Kravetz     2017-02-22  287  						dst_addr, src_addr, &page);
60d4d2d2b40e44 Mike Kravetz     2017-02-22  288  
60d4d2d2b40e44 Mike Kravetz     2017-02-22  289  		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
1c9e8def43a345 Mike Kravetz     2017-02-22  290  		vm_alloc_shared = vm_shared;
60d4d2d2b40e44 Mike Kravetz     2017-02-22  291  
60d4d2d2b40e44 Mike Kravetz     2017-02-22  292  		cond_resched();
60d4d2d2b40e44 Mike Kravetz     2017-02-22  293  
9e368259ad9883 Andrea Arcangeli 2018-11-30  294  		if (unlikely(err == -ENOENT)) {
60d4d2d2b40e44 Mike Kravetz     2017-02-22  295  			up_read(&dst_mm->mmap_sem);
60d4d2d2b40e44 Mike Kravetz     2017-02-22  296  			BUG_ON(!page);
60d4d2d2b40e44 Mike Kravetz     2017-02-22  297  
60d4d2d2b40e44 Mike Kravetz     2017-02-22  298  			err = copy_huge_page_from_user(page,
60d4d2d2b40e44 Mike Kravetz     2017-02-22  299  						(const void __user *)src_addr,
810a56b943e265 Mike Kravetz     2017-02-22  300  						pages_per_huge_page(h), true);
60d4d2d2b40e44 Mike Kravetz     2017-02-22  301  			if (unlikely(err)) {
60d4d2d2b40e44 Mike Kravetz     2017-02-22  302  				err = -EFAULT;
60d4d2d2b40e44 Mike Kravetz     2017-02-22  303  				goto out;
60d4d2d2b40e44 Mike Kravetz     2017-02-22  304  			}
60d4d2d2b40e44 Mike Kravetz     2017-02-22  305  			down_read(&dst_mm->mmap_sem);
60d4d2d2b40e44 Mike Kravetz     2017-02-22  306  
60d4d2d2b40e44 Mike Kravetz     2017-02-22  307  			dst_vma = NULL;
60d4d2d2b40e44 Mike Kravetz     2017-02-22  308  			goto retry;
60d4d2d2b40e44 Mike Kravetz     2017-02-22  309  		} else
60d4d2d2b40e44 Mike Kravetz     2017-02-22  310  			BUG_ON(page);
60d4d2d2b40e44 Mike Kravetz     2017-02-22  311  
60d4d2d2b40e44 Mike Kravetz     2017-02-22  312  		if (!err) {
60d4d2d2b40e44 Mike Kravetz     2017-02-22  313  			dst_addr += vma_hpagesize;
60d4d2d2b40e44 Mike Kravetz     2017-02-22  314  			src_addr += vma_hpagesize;
60d4d2d2b40e44 Mike Kravetz     2017-02-22  315  			copied += vma_hpagesize;
60d4d2d2b40e44 Mike Kravetz     2017-02-22  316  
60d4d2d2b40e44 Mike Kravetz     2017-02-22  317  			if (fatal_signal_pending(current))
60d4d2d2b40e44 Mike Kravetz     2017-02-22  318  				err = -EINTR;
60d4d2d2b40e44 Mike Kravetz     2017-02-22  319  		}
60d4d2d2b40e44 Mike Kravetz     2017-02-22  320  		if (err)
60d4d2d2b40e44 Mike Kravetz     2017-02-22  321  			break;
60d4d2d2b40e44 Mike Kravetz     2017-02-22  322  	}
60d4d2d2b40e44 Mike Kravetz     2017-02-22  323  
60d4d2d2b40e44 Mike Kravetz     2017-02-22  324  out_unlock:
60d4d2d2b40e44 Mike Kravetz     2017-02-22  325  	up_read(&dst_mm->mmap_sem);
60d4d2d2b40e44 Mike Kravetz     2017-02-22  326  out:
21205bf8f77b23 Mike Kravetz     2017-02-22  327  	if (page) {
21205bf8f77b23 Mike Kravetz     2017-02-22  328  		/*
21205bf8f77b23 Mike Kravetz     2017-02-22  329  		 * We encountered an error and are about to free a newly
1c9e8def43a345 Mike Kravetz     2017-02-22  330  		 * allocated huge page.
1c9e8def43a345 Mike Kravetz     2017-02-22  331  		 *
1c9e8def43a345 Mike Kravetz     2017-02-22  332  		 * Reservation handling is very subtle, and is different for
1c9e8def43a345 Mike Kravetz     2017-02-22  333  		 * private and shared mappings.  See the routine
1c9e8def43a345 Mike Kravetz     2017-02-22  334  		 * restore_reserve_on_error for details.  Unfortunately, we
1c9e8def43a345 Mike Kravetz     2017-02-22  335  		 * can not call restore_reserve_on_error now as it would
1c9e8def43a345 Mike Kravetz     2017-02-22  336  		 * require holding mmap_sem.
1c9e8def43a345 Mike Kravetz     2017-02-22  337  		 *
1c9e8def43a345 Mike Kravetz     2017-02-22  338  		 * If a reservation for the page existed in the reservation
1c9e8def43a345 Mike Kravetz     2017-02-22  339  		 * map of a private mapping, the map was modified to indicate
1c9e8def43a345 Mike Kravetz     2017-02-22  340  		 * the reservation was consumed when the page was allocated.
1c9e8def43a345 Mike Kravetz     2017-02-22  341  		 * We clear the PagePrivate flag now so that the global
21205bf8f77b23 Mike Kravetz     2017-02-22  342  		 * reserve count will not be incremented in free_huge_page.
21205bf8f77b23 Mike Kravetz     2017-02-22  343  		 * The reservation map will still indicate the reservation
21205bf8f77b23 Mike Kravetz     2017-02-22  344  		 * was consumed and possibly prevent later page allocation.
1c9e8def43a345 Mike Kravetz     2017-02-22  345  		 * This is better than leaking a global reservation.  If no
1c9e8def43a345 Mike Kravetz     2017-02-22  346  		 * reservation existed, it is still safe to clear PagePrivate
1c9e8def43a345 Mike Kravetz     2017-02-22  347  		 * as no adjustments to reservation counts were made during
1c9e8def43a345 Mike Kravetz     2017-02-22  348  		 * allocation.
1c9e8def43a345 Mike Kravetz     2017-02-22  349  		 *
1c9e8def43a345 Mike Kravetz     2017-02-22  350  		 * The reservation map for shared mappings indicates which
1c9e8def43a345 Mike Kravetz     2017-02-22  351  		 * pages have reservations.  When a huge page is allocated
1c9e8def43a345 Mike Kravetz     2017-02-22  352  		 * for an address with a reservation, no change is made to
1c9e8def43a345 Mike Kravetz     2017-02-22  353  		 * the reserve map.  In this case PagePrivate will be set
1c9e8def43a345 Mike Kravetz     2017-02-22  354  		 * to indicate that the global reservation count should be
1c9e8def43a345 Mike Kravetz     2017-02-22  355  		 * incremented when the page is freed.  This is the desired
1c9e8def43a345 Mike Kravetz     2017-02-22  356  		 * behavior.  However, when a huge page is allocated for an
1c9e8def43a345 Mike Kravetz     2017-02-22  357  		 * address without a reservation a reservation entry is added
1c9e8def43a345 Mike Kravetz     2017-02-22  358  		 * to the reservation map, and PagePrivate will not be set.
1c9e8def43a345 Mike Kravetz     2017-02-22  359  		 * When the page is freed, the global reserve count will NOT
1c9e8def43a345 Mike Kravetz     2017-02-22  360  		 * be incremented and it will appear as though we have leaked
1c9e8def43a345 Mike Kravetz     2017-02-22  361  		 * reserved page.  In this case, set PagePrivate so that the
1c9e8def43a345 Mike Kravetz     2017-02-22  362  		 * global reserve count will be incremented to match the
1c9e8def43a345 Mike Kravetz     2017-02-22  363  		 * reservation map entry which was created.
1c9e8def43a345 Mike Kravetz     2017-02-22  364  		 *
1c9e8def43a345 Mike Kravetz     2017-02-22  365  		 * Note that vm_alloc_shared is based on the flags of the vma
1c9e8def43a345 Mike Kravetz     2017-02-22  366  		 * for which the page was originally allocated.  dst_vma could
1c9e8def43a345 Mike Kravetz     2017-02-22  367  		 * be different or NULL on error.
21205bf8f77b23 Mike Kravetz     2017-02-22  368  		 */
1c9e8def43a345 Mike Kravetz     2017-02-22  369  		if (vm_alloc_shared)
1c9e8def43a345 Mike Kravetz     2017-02-22  370  			SetPagePrivate(page);
1c9e8def43a345 Mike Kravetz     2017-02-22  371  		else
21205bf8f77b23 Mike Kravetz     2017-02-22  372  			ClearPagePrivate(page);
60d4d2d2b40e44 Mike Kravetz     2017-02-22  373  		put_page(page);
21205bf8f77b23 Mike Kravetz     2017-02-22  374  	}
60d4d2d2b40e44 Mike Kravetz     2017-02-22  375  	BUG_ON(copied < 0);
60d4d2d2b40e44 Mike Kravetz     2017-02-22  376  	BUG_ON(err > 0);
60d4d2d2b40e44 Mike Kravetz     2017-02-22  377  	BUG_ON(!copied && !err);
60d4d2d2b40e44 Mike Kravetz     2017-02-22  378  	return copied ? copied : err;
60d4d2d2b40e44 Mike Kravetz     2017-02-22  379  }
60d4d2d2b40e44 Mike Kravetz     2017-02-22  380  #else /* !CONFIG_HUGETLB_PAGE */
60d4d2d2b40e44 Mike Kravetz     2017-02-22  381  /* fail at build time if gcc attempts to use this */
60d4d2d2b40e44 Mike Kravetz     2017-02-22  382  extern ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
60d4d2d2b40e44 Mike Kravetz     2017-02-22  383  				      struct vm_area_struct *dst_vma,
60d4d2d2b40e44 Mike Kravetz     2017-02-22  384  				      unsigned long dst_start,
60d4d2d2b40e44 Mike Kravetz     2017-02-22  385  				      unsigned long src_start,
60d4d2d2b40e44 Mike Kravetz     2017-02-22  386  				      unsigned long len,
60d4d2d2b40e44 Mike Kravetz     2017-02-22  387  				      bool zeropage);
60d4d2d2b40e44 Mike Kravetz     2017-02-22  388  #endif /* CONFIG_HUGETLB_PAGE */
60d4d2d2b40e44 Mike Kravetz     2017-02-22  389  

:::::: The code at line 262 was first introduced by commit
:::::: 60d4d2d2b40e44cd36bfb6049e8d9e2055a24f8a userfaultfd: hugetlbfs: add __mcopy_atomic_hugetlb for huge page UFFDIO_COPY

:::::: TO: Mike Kravetz <mike.kravetz@oracle.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
