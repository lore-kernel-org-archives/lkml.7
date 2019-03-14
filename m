Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A7ACC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C33D72184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GD8Z4IVc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbfCNQA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 12:00:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39054 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727367AbfCNQA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 12:00:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0BRZmjWpl5Sc1xK8Fz95Tal8y+zU630oI+RCC6+Hs4Q=; b=GD8Z4IVcQkEnA7tmQZRmDMsZD
        acod4OPFsUrsOfuR1FLKJ7jA6erX0GyfzkAUFalRqQTr0Wc3TKoZdJNJn8bnGOw1Tuwdk0yZnf64/
        pHdMOlRrDmx/7IEqQ2GJCttrttVDEbZnPlnVXa/Qa5+V4mhw8zHKfWPeKpTViw6WFl+GFz/H2TmaG
        4qFtmgaq3A/Nx1q4BNCMbmX10cEE5rq+9ERqls/hf1LDnS18ontilivt/3dX71VKoTcfON3Jd9RIv
        iAQfJKRmrX3ZqBsjJswgiXTngc2vG+33cgA8AIHPVWsNtlDueAJM3S6t3N16/Dfynz5q0V1zwwby5
        vq3znBuDQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h4Smr-0005gI-10; Thu, 14 Mar 2019 16:00:53 +0000
Date:   Thu, 14 Mar 2019 09:00:52 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        linux-kernel@vger.kernel.org,
        William Kucharski <william.kucharski@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: mm/memory.c:3968:21: sparse: incorrect type in assignment
 (different base types)
Message-ID: <20190314160052.GM19508@bombadil.infradead.org>
References: <201903140301.VeDCo2VR%lkp@intel.com>
 <CAFqt6zaA1t1+vPL8hk7Rm6B4ZqG6maK+Z1HAkL0aF93=q4MeOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqt6zaA1t1+vPL8hk7Rm6B4ZqG6maK+Z1HAkL0aF93=q4MeOQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 03:10:19PM +0530, Souptick Joarder wrote:
> > >> mm/memory.c:3968:21: sparse: incorrect type in assignment (different base types) @@    expected restricted vm_fault_t [usertype] ret @@    got e] ret @@
> >    mm/memory.c:3968:21:    expected restricted vm_fault_t [usertype] ret
> >    mm/memory.c:3968:21:    got int
> 
> Looking into https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> hugetlb_fault() is converted to return vm_fault_t. Not sure, why sparse is
> still throwing warnings.

Because there are two definitions of hugetlb_fault():

$ git grep -wn hugetlb_fault
include/linux/hugetlb.h:108:vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
include/linux/hugetlb.h:206:#define hugetlb_fault(mm, vma, addr, flags) ({ BUG(); 0; })


