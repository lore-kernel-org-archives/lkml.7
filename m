Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26229C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E01E720811
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:28:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nj/UAzBo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbfDWJ2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 05:28:13 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46956 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfDWJ2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 05:28:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=f/iLXaVA4u+TazdBjYinG9bUUB+MWLz5zrXVIQCfKNM=; b=nj/UAzBo31hclTqz5KOaLs3kN
        9+Wb0SdOYy0J9KD+QyJt7yQ9LGkIckSf3t6Viqscs1prUQ4Nt0h+LzExLOrhIw4owyz+uu7FAHuG3
        C71Ebgg/MAqlvq9jb6UjD/kM1r8gJIbubPgfyoRFrQF2yz+qPrZJsT/XWTY7IlvtHtNy8J3fwaByD
        EwipeXzyx6RcPe7VVCz2UCcTO/i/sdll1PXi3cBGsw3ByxE0j39YXUg26M35ZBMoWBEL2hNXhm/vB
        E+Vg6nFM30vsFHp2cPMVfjZedrFAK5S3nGHSEHY4WDip3zj+r68oY4/UkvjhHmLcExsJDw0t9dw27
        scs2myCjQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hIrho-0001lo-VN; Tue, 23 Apr 2019 09:27:13 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E48FE29B47DCE; Tue, 23 Apr 2019 11:27:10 +0200 (CEST)
Date:   Tue, 23 Apr 2019 11:27:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Laurent Dufour <ldufour@linux.ibm.com>
Cc:     akpm@linux-foundation.org, mhocko@kernel.org, kirill@shutemov.name,
        ak@linux.intel.com, dave@stgolabs.net, jack@suse.cz,
        Matthew Wilcox <willy@infradead.org>,
        aneesh.kumar@linux.ibm.com, benh@kernel.crashing.org,
        mpe@ellerman.id.au, paulus@samba.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, hpa@zytor.com,
        Will Deacon <will.deacon@arm.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        sergey.senozhatsky.work@gmail.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        kemi.wang@intel.com, Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Rientjes <rientjes@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Ganesh Mahendran <opensource.ganesh@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        Punit Agrawal <punitagrawal@gmail.com>,
        vinayak menon <vinayakm.list@gmail.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        zhong jiang <zhongjiang@huawei.com>,
        Haiyan Song <haiyanx.song@intel.com>,
        Balbir Singh <bsingharora@gmail.com>, sj38.park@gmail.com,
        Michel Lespinasse <walken@google.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        haren@linux.vnet.ibm.com, npiggin@gmail.com,
        paulmck@linux.vnet.ibm.com, Tim Chen <tim.c.chen@linux.intel.com>,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: Re: [PATCH v12 21/31] mm: Introduce find_vma_rcu()
Message-ID: <20190423092710.GI11158@hirez.programming.kicks-ass.net>
References: <20190416134522.17540-1-ldufour@linux.ibm.com>
 <20190416134522.17540-22-ldufour@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416134522.17540-22-ldufour@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 03:45:12PM +0200, Laurent Dufour wrote:
> This allows to search for a VMA structure without holding the mmap_sem.
> 
> The search is repeated while the mm seqlock is changing and until we found
> a valid VMA.
> 
> While under the RCU protection, a reference is taken on the VMA, so the
> caller must call put_vma() once it not more need the VMA structure.
> 
> At the time a VMA is inserted in the MM RB tree, in vma_rb_insert(), a
> reference is taken to the VMA by calling get_vma().
> 
> When removing a VMA from the MM RB tree, the VMA is not release immediately
> but at the end of the RCU grace period through vm_rcu_put(). This ensures
> that the VMA remains allocated until the end the RCU grace period.
> 
> Since the vm_file pointer, if valid, is released in put_vma(), there is no
> guarantee that the file pointer will be valid on the returned VMA.

What I'm missing here, and in the previous patch introducing the
refcount (also see refcount_t), is _why_ we need the refcount thing at
all.

My original plan was to use SRCU, which at the time was not complete
enough so I abused/hacked preemptible RCU, but that is no longer the
case, SRCU has all the required bits and pieces.

Also; the initial motivation was prefaulting large VMAs and the
contention on mmap was killing things; but similarly, the contention on
the refcount (I did try that) killed things just the same.

So I'm really sad to see the refcount return; and without any apparent
justification.
