Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E85C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 10:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C5832175B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 10:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556016433;
	bh=5JHwWNTxDnLSWDGfvnXlo14z79f0zGUWxfLqGH3F0J0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BWE78usAWbv+3ukdqDTrimZweD4fT2LAcxQP7WHIF50dqafV00aYXIuA3jjAyqlH4
	 qu42rIgYDDzTnBdOCyH+9DFEx4DgLrDm+VB9j05v1649HnfT15jT+wlOLlWCWe1b2W
	 uhqMTzcioJpQhtv7qLrZYimfg+KV6lLLWOwrOrFE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbfDWKrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 06:47:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:48306 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726481AbfDWKrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 06:47:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5E467AF1C;
        Tue, 23 Apr 2019 10:47:09 +0000 (UTC)
Date:   Tue, 23 Apr 2019 12:47:07 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Michel Lespinasse <walken@google.com>
Cc:     Laurent Dufour <ldufour@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <20190423104707.GK25106@dhcp22.suse.cz>
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

On Mon 22-04-19 14:29:16, Michel Lespinasse wrote:
[...]
> I want to add a note about mmap_sem. In the past there has been
> discussions about replacing it with an interval lock, but these never
> went anywhere because, mostly, of the fact that such mechanisms were
> too expensive to use in the page fault path. I think adding the spf
> mechanism would invite us to revisit this issue - interval locks may
> be a great way to avoid blocking between unrelated mmap_sem writers
> (for example, do not delay stack creation for new threads while a
> large mmap or munmap may be going on), and probably also to handle
> mmap_sem readers that can't easily use the spf mechanism (for example,
> gup callers which make use of the returned vmas). But again that is a
> separate topic to explore which doesn't have to get resolved before
> spf goes in.

Well, I believe we should _really_ re-evaluate the range locking sooner
rather than later. Why? Because it looks like the most straightforward
approach to the mmap_sem contention for most usecases I have heard of
(mostly a mm{unm}ap, mremap standing in the way of page faults).
On a plus side it also makes us think about the current mmap (ab)users
which should lead to an overall code improvements and maintainability.

SPF sounds like a good idea but it is a really big and intrusive surgery
to the #PF path. And more importantly without any real world usecase
numbers which would justify this. That being said I am not opposed to
this change I just think it is a large hammer while we haven't seen
attempts to tackle problems in a simpler way.

-- 
Michal Hocko
SUSE Labs
