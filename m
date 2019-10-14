Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 827B1C47404
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 06:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49225205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 06:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="g/7d6Lj5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730038AbfJNGpl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 02:45:41 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:2039 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729656AbfJNGpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 02:45:40 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5da419950000>; Sun, 13 Oct 2019 23:45:41 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Sun, 13 Oct 2019 23:45:39 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Sun, 13 Oct 2019 23:45:39 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 14 Oct
 2019 06:45:39 +0000
Received: from [10.2.173.58] (172.20.13.39) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 14 Oct
 2019 06:45:38 +0000
Subject: Re: [PATCH 2/2] mm/gup: fix a misnamed "write" argument: should be
 "flags"
To:     kbuild test robot <lkp@intel.com>
CC:     <kbuild-all@lists.01.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Keith Busch <keith.busch@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Christoph Hellwig <hch@lst.de>
References: <20191013221155.382378-3-jhubbard@nvidia.com>
 <201910141316.DHpeevy3%lkp@intel.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <d431c2cf-22bf-13be-05e5-c93512ac9ae5@nvidia.com>
Date:   Sun, 13 Oct 2019 23:43:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <201910141316.DHpeevy3%lkp@intel.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1571035541; bh=HtIDdAJxmRTbCOCnYRZivqbYMR39l4cMWjhrGLronnw=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=g/7d6Lj5Z4epMh5MIW7HJOBvnD1mgP1zooBmwUkkukc8e2f2stiBkxUl6aNmLanYp
         rKawF6vuWHDUOCHmXlm5lG8G6rrGjpBQtlq/5K8Ailkjlu1PNhHGqB7zo+R22hyTrc
         XFFV96ed6eO/KwEawT1SX0c7TSat/IPk4cR34ntYmcN0Wat8DetLfLrm56EbAQaa/N
         prOfAfXrZEMgkVR2SY+5zS+/8n752DjJwRUKslM0cDloExgv8DM/69ci3PtsQYgkOj
         89HsyWOFktj77um8a25mepEsOc2XZhknFB/h95Z72EBaXbAjeSxH5w0L+r4inhiviH
         8TDlDPH1CNBYg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/19 11:12 PM, kbuild test robot wrote:
> Hi John,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on linus/master]
> [cannot apply to v5.4-rc3 next-20191011]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> 
> url:    https://github.com/0day-ci/linux/commits/John-Hubbard/gup-c-gup_benchmark-c-trivial-fixes-before-the-storm/20191014-114158
> config: powerpc-defconfig (attached as .config)
> compiler: powerpc64-linux-gcc (GCC) 7.4.0
> reproduce:
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # save the attached .config to linux build tree
>          GCC_VERSION=7.4.0 make.cross ARCH=powerpc
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>     mm/gup.c: In function 'gup_hugepte':
>>> mm/gup.c:1990:33: error: 'write' undeclared (first use in this function); did you mean 'writeq'?
>       if (!pte_access_permitted(pte, write))
>                                      ^~~~~
>                                      writeq
>     mm/gup.c:1990:33: note: each undeclared identifier is reported only once for each function it appears in
> 

OK, so this shows that my cross-compiler test scripts are faulty lately,
sorry I missed this.

But more importantly, the above missed case is an example of when "write" really
means "write", as opposed to meaning flags.

Please put this patch on hold or drop it, until we hear from the authors as to how
they would like to resolve this. I suspect it will end up as something like:

	bool write = (flags & FOLL_WRITE);

...perhaps?


thanks,
-- 
John Hubbard
NVIDIA


> vim +1990 mm/gup.c
> 
> cbd34da7dc9afd Christoph Hellwig 2019-07-11  1974
> cbd34da7dc9afd Christoph Hellwig 2019-07-11  1975  static int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
> cc492e4c15e804 John Hubbard      2019-10-13  1976  		       unsigned long end, int flags, struct page **pages,
> cc492e4c15e804 John Hubbard      2019-10-13  1977  		       int *nr)
> cbd34da7dc9afd Christoph Hellwig 2019-07-11  1978  {
> cbd34da7dc9afd Christoph Hellwig 2019-07-11  1979  	unsigned long pte_end;
> cbd34da7dc9afd Christoph Hellwig 2019-07-11  1980  	struct page *head, *page;
> cbd34da7dc9afd Christoph Hellwig 2019-07-11  1981  	pte_t pte;
> cbd34da7dc9afd Christoph Hellwig 2019-07-11  1982  	int refs;
> cbd34da7dc9afd Christoph Hellwig 2019-07-11  1983
> cbd34da7dc9afd Christoph Hellwig 2019-07-11  1984  	pte_end = (addr + sz) & ~(sz-1);
> cbd34da7dc9afd Christoph Hellwig 2019-07-11  1985  	if (pte_end < end)
> cbd34da7dc9afd Christoph Hellwig 2019-07-11  1986  		end = pte_end;
> cbd34da7dc9afd Christoph Hellwig 2019-07-11  1987
> cbd34da7dc9afd Christoph Hellwig 2019-07-11  1988  	pte = READ_ONCE(*ptep);
> cbd34da7dc9afd Christoph Hellwig 2019-07-11  1989
> cbd34da7dc9afd Christoph Hellwig 2019-07-11 @1990  	if (!pte_access_permitted(pte, write))
> cbd34da7dc9afd Christoph Hellwig 2019-07-11  1991  		return 0;
> cbd34da7dc9afd Christoph Hellwig 2019-07-11  1992
> cbd34da7dc9afd Christoph Hellwig 2019-07-11  1993  	/* hugepages are never "special" */
> cbd34da7dc9afd Christoph Hellwig 2019-07-11  1994  	VM_BUG_ON(!pfn_valid(pte_pfn(pte)));
> cbd34da7dc9afd Christoph Hellwig 2019-07-11  1995
> cbd34da7dc9afd Christoph Hellwig 2019-07-11  1996  	refs = 0;
> cbd34da7dc9afd Christoph Hellwig 2019-07-11  1997  	head = pte_page(pte);
> cbd34da7dc9afd Christoph Hellwig 2019-07-11  1998
> cbd34da7dc9afd Christoph Hellwig 2019-07-11  1999  	page = head + ((addr & (sz-1)) >> PAGE_SHIFT);
> cbd34da7dc9afd Christoph Hellwig 2019-07-11  2000  	do {
> cbd34da7dc9afd Christoph Hellwig 2019-07-11  2001  		VM_BUG_ON(compound_head(page) != head);
> cbd34da7dc9afd Christoph Hellwig 2019-07-11  2002  		pages[*nr] = page;
> cbd34da7dc9afd Christoph Hellwig 2019-07-11  2003  		(*nr)++;
> cbd34da7dc9afd Christoph Hellwig 2019-07-11  2004  		page++;
> cbd34da7dc9afd Christoph Hellwig 2019-07-11  2005  		refs++;
> cbd34da7dc9afd Christoph Hellwig 2019-07-11  2006  	} while (addr += PAGE_SIZE, addr != end);
> cbd34da7dc9afd Christoph Hellwig 2019-07-11  2007
> 01a369160bbea4 Christoph Hellwig 2019-07-11  2008  	head = try_get_compound_head(head, refs);
> 01a369160bbea4 Christoph Hellwig 2019-07-11  2009  	if (!head) {
> cbd34da7dc9afd Christoph Hellwig 2019-07-11  2010  		*nr -= refs;
> cbd34da7dc9afd Christoph Hellwig 2019-07-11  2011  		return 0;
> cbd34da7dc9afd Christoph Hellwig 2019-07-11  2012  	}
> cbd34da7dc9afd Christoph Hellwig 2019-07-11  2013
> cbd34da7dc9afd Christoph Hellwig 2019-07-11  2014  	if (unlikely(pte_val(pte) != pte_val(*ptep))) {
> cbd34da7dc9afd Christoph Hellwig 2019-07-11  2015  		/* Could be optimized better */
> cbd34da7dc9afd Christoph Hellwig 2019-07-11  2016  		*nr -= refs;
> cbd34da7dc9afd Christoph Hellwig 2019-07-11  2017  		while (refs--)
> cbd34da7dc9afd Christoph Hellwig 2019-07-11  2018  			put_page(head);
> cbd34da7dc9afd Christoph Hellwig 2019-07-11  2019  		return 0;
> cbd34da7dc9afd Christoph Hellwig 2019-07-11  2020  	}
> cbd34da7dc9afd Christoph Hellwig 2019-07-11  2021
> 520b4a4496f12b Christoph Hellwig 2019-07-11  2022  	SetPageReferenced(head);
> cbd34da7dc9afd Christoph Hellwig 2019-07-11  2023  	return 1;
> cbd34da7dc9afd Christoph Hellwig 2019-07-11  2024  }
> cbd34da7dc9afd Christoph Hellwig 2019-07-11  2025
> 
> :::::: The code at line 1990 was first introduced by commit
> :::::: cbd34da7dc9afd521e0bea5e7d12701f4a9da7c7 mm: move the powerpc hugepd code to mm/gup.c
> 
> :::::: TO: Christoph Hellwig <hch@lst.de>
> :::::: CC: Linus Torvalds <torvalds@linux-foundation.org>
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 
