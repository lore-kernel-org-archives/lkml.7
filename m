Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E875C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 16:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0593D2177B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 16:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jTF0ls4c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbfEJQQj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 12:16:39 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:38070 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727271AbfEJQQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 12:16:39 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4AG8faU027900;
        Fri, 10 May 2019 16:16:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=ikyWD5tw3+Fa2klAswpQ3zG257Y/SYQKpSWVthHNaDQ=;
 b=jTF0ls4cyPu4lSedw8dhdKuv+vpLCt0VH3bLgDV9dvGWnvAVyKs31jEKWxt23CxWULLe
 KdKut0Bqm/TJKO/jJzsWynABfRlBIs8SJs4xOeoYPDb3KD0IHG7KBeJo5FxJgkD+AhXw
 CFZOeUR/vri7jNs8vQaK2dJgqlPlpR8RMPBLJXtdvnovfc14TIJ+JFvbc6f+Fi9by9yA
 RWK/2h22VkMcoqAg4JfIVgk6812bBv2eGY1biLyyCsCZxQB2gRme7+xocJJq6CDx/Fnz
 MrTVuCkawwTYm0ebBeD30KgDpatU8Jk+d022WGuXpOS2WXl2+Vd4j5rJ6u5GvvCCouIE Jg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2s94bgj6dx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 May 2019 16:16:21 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4AGFATp008060;
        Fri, 10 May 2019 16:16:21 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2schw0gr97-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 May 2019 16:16:21 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4AGGIAk029191;
        Fri, 10 May 2019 16:16:18 GMT
Received: from ubuette (/75.80.107.76)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 10 May 2019 16:16:17 +0000
Date:   Fri, 10 May 2019 09:16:07 -0700
From:   Larry Bassel <larry.bassel@oracle.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Larry Bassel <larry.bassel@oracle.com>, mike.kravetz@oracle.com,
        dan.j.williams@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
Subject: Re: [PATCH, RFC 2/2] Implement sharing/unsharing of PMDs for FS/DAX
Message-ID: <20190510161607.GB27674@ubuette>
References: <1557417933-15701-1-git-send-email-larry.bassel@oracle.com>
 <1557417933-15701-3-git-send-email-larry.bassel@oracle.com>
 <20190509164914.GA3862@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190509164914.GA3862@bombadil.infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9252 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905100110
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9252 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905100110
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09 May 19 09:49, Matthew Wilcox wrote:
> On Thu, May 09, 2019 at 09:05:33AM -0700, Larry Bassel wrote:
> > This is based on (but somewhat different from) what hugetlbfs
> > does to share/unshare page tables.
> 
> Wow, that worked out far more cleanly than I was expecting to see.

Yes, I was pleasantly surprised. As I've mentioned already, I 
think this is at least partially due to the nature of DAX.

> 
> > @@ -4763,6 +4763,19 @@ void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
> >  				unsigned long *start, unsigned long *end)
> >  {
> >  }
> > +
> > +unsigned long page_table_shareable(struct vm_area_struct *svma,
> > +				   struct vm_area_struct *vma,
> > +				   unsigned long addr, pgoff_t idx)
> > +{
> > +	return 0;
> > +}
> > +
> > +bool vma_shareable(struct vm_area_struct *vma, unsigned long addr)
> > +{
> > +	return false;
> > +}
> 
> I don't think you need these stubs, since the only caller of them is
> also gated by MAY_SHARE_FSDAX_PMD ... right?

These are also called in mm/hugetlb.c, but those calls are gated by
CONFIG_ARCH_WANT_HUGE_PMD_SHARE. In fact if this is not set (though
it is the default), then one wouldn't get FS/DAX sharing even if
MAY_SHARE_FSDAX_PMD is set. I think that this isn't what we want
(perhaps the real question is how should these two config options interact?).
Removing the stubs would fix this and I will make that change.

Maybe these two functions should be moved into mm/memory.c as well.

> 
> > +	vma_interval_tree_foreach(svma, &mapping->i_mmap, idx, idx) {
> > +		if (svma == vma)
> > +			continue;
> > +
> > +		saddr = page_table_shareable(svma, vma, addr, idx);
> > +		if (saddr) {
> > +			spmd = huge_pmd_offset(svma->vm_mm, saddr,
> > +					       vma_mmu_pagesize(svma));
> > +			if (spmd) {
> > +				get_page(virt_to_page(spmd));
> > +				break;
> > +			}
> > +		}
> > +	}
> 
> I'd be tempted to reduce the indentation here:
> 
> 	vma_interval_tree_foreach(svma, &mapping->i_mmap, idx, idx) {
> 		if (svma == vma)
> 			continue;
> 
> 		saddr = page_table_shareable(svma, vma, addr, idx);
> 		if (!saddr)
> 			continue;
> 
> 		spmd = huge_pmd_offset(svma->vm_mm, saddr,
> 					vma_mmu_pagesize(svma));
> 		if (spmd)
> 			break;
> 	}
> 
> 
> > +	if (!spmd)
> > +		goto out;
> 
> ... and move the get_page() down to here, so we don't split the
> "when we find it" logic between inside and outside the loop.
> 
> 	get_page(virt_to_page(spmd));
> 
> > +
> > +	ptl = pmd_lockptr(mm, spmd);
> > +	spin_lock(ptl);
> > +
> > +	if (pud_none(*pud)) {
> > +		pud_populate(mm, pud,
> > +			    (pmd_t *)((unsigned long)spmd & PAGE_MASK));
> > +		mm_inc_nr_pmds(mm);
> > +	} else {
> > +		put_page(virt_to_page(spmd));
> > +	}
> > +	spin_unlock(ptl);
> > +out:
> > +	pmd = pmd_alloc(mm, pud, addr);
> > +	i_mmap_unlock_write(mapping);
> 
> I would swap these two lines.  There's no need to hold the i_mmap_lock
> while allocating this PMD, is there?  I mean, we don't for the !may_share
> case.
> 

These were done in the style of functions already in mm/hugetlb.c and I was
trying to change as little as necessary in my copy of those. I agree that
these are good suggestions. One could argue that if these changes
were made, they should also be made in mm/hugetlb.c, though
this is perhaps beyond the scope of getting FS/DAX PMD sharing
implemented -- your thoughts?

Thanks for the review, I'll wait a few more days for other comments
and then send out a v2.

Larry
