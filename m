Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF50C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 924FE2077C
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:39:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kWZNVI2H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfDWJjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 05:39:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46250 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfDWJjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 05:39:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KZ1+LpzJjt1lQaO/zhhBXmd8ItG9I8H/NFkBPqdSKp4=; b=kWZNVI2H88CgPB45rHhvEagQy
        YUXAwoj4UqliNhOdCXov/GLt6lWALi4JYUG0WNlU4GGG3JAvPyBRkffyWJOG+EG0Ur9Kx1yB1ZEA+
        crqGIkZ0RR5dJvoHX2bSDFkFQfGDGgb5JKkpIhgWbRSNdH1EQU51xgOLzcuH2d142hpvgjzx2md9s
        rcVXo+iDvqNoRr/AvulifTy23sAkOmmfbsKuOe7LAQCmEVmiq9pYQuCW4a42z6Hp8dQhMHJiCING8
        JI1Nlc06RH+pKcvLROVBIO1pkNJZOFlAGmkC/NPAI0mOHNypwGzvg0dMbMU4fZTqeqtbbpL0yyKJd
        YyIrsQdsw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hIrt8-0003WC-3I; Tue, 23 Apr 2019 09:38:55 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6922229B47DCF; Tue, 23 Apr 2019 11:38:51 +0200 (CEST)
Date:   Tue, 23 Apr 2019 11:38:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Michel Lespinasse <walken@google.com>
Cc:     Laurent Dufour <ldufour@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>, dave@stgolabs.net,
        Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        aneesh.kumar@linux.ibm.com,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        mpe@ellerman.id.au, Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
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
        Mike Rapoport <rppt@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, haren@linux.vnet.ibm.com,
        Nick Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: Re: [PATCH v12 00/31] Speculative page faults
Message-ID: <20190423093851.GJ11158@hirez.programming.kicks-ass.net>
References: <20190416134522.17540-1-ldufour@linux.ibm.com>
 <CANN689F1h9XoHPzr_FQY2WfN5bb2TTd6M3HLqoJ-DQuHkNbA7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANN689F1h9XoHPzr_FQY2WfN5bb2TTd6M3HLqoJ-DQuHkNbA7g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2019 at 02:29:16PM -0700, Michel Lespinasse wrote:
> The proposed spf mechanism only handles anon vmas. Is there a
> fundamental reason why it couldn't handle mapped files too ?
> My understanding is that the mechanism of verifying the vma after
> taking back the ptl at the end of the fault would work there too ?
> The file has to stay referenced during the fault, but holding the vma's
> refcount could be made to cover that ? the vm_file refcount would have
> to be released in __free_vma() instead of remove_vma; I'm not quite sure
> if that has more implications than I realize ?

IIRC (and I really don't remember all that much) the trickiest bit was
vs unmount. Since files can stay open past the 'expected' duration,
umount could be delayed.

But yes, I think I had a version that did all that just 'fine'. Like
mentioned, I didn't keep the refcount because it sucked just as hard as
the mmap_sem contention, but the SRCU callback did the fput() just fine
(esp. now that we have delayed_fput).
