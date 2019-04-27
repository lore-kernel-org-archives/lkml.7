Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C46C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 06:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09F7D208C2
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 06:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sQgZM+n9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbfD0GAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 02:00:17 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33277 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbfD0GAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 02:00:16 -0400
Received: by mail-pf1-f195.google.com with SMTP id h5so2735314pfo.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 23:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=9mSKg2SIvsOs/xLgAIl2pXj2eMJ9JaMiTd4MI5nAg04=;
        b=sQgZM+n9Be/cWtzN8fNus9HazrNXXo2P9TnRXJ3OGXR/7LV1xuaW4rJA/roFhqf0TY
         mQCS64dg1TtuGiotH0xCet3pe1hS8IOvRcqAhBIgfyzwhLE/9ZwL2Gwe40/zd/NnkU+7
         VrpMs8JFZ+ZUVmL6NL9u579BqupyJRMM5thKTY4byen+ygGpp6uuta11/qVxM0mde7gT
         NUJBfmXhweZUqn604h85jwvMEvFMmU1yG1Zy3ng8ZZlB4JTgg7O9/oy6VPt9CsqUZm4n
         K+HJubSlTziMfSj9ObPIOHOr59uF1HZw9VN8rdH7MqooI+xJn3y98FDtNsW803OpqSrv
         MhuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=9mSKg2SIvsOs/xLgAIl2pXj2eMJ9JaMiTd4MI5nAg04=;
        b=ZOD8PS7TckjBnnfGqCMmj9g5YnRPurGEPkqWSH673DNE0x7onap1LGL3gnCy8OvDDu
         fbTptW0LBaGwV6eqKBnVQhjIkzi8pzvOVI4gaHAXyb1ohg9r4YkOQUoCC7ipNUjz4BE+
         5JnpvmKixKvBlyN7dALKHjCxRvVkPyDTCobXGPcM13DHjFduYFI8JYvOmIQXNuV//Q+a
         DCxM0a3BrP4wZXd0i8O9SyMhERtgjT4cXs+VBlKhJwO25IOavsXJz84qUfRZ4Syf2pd+
         tjKes+GRb79fYGFKD/xoC60yiSFjSbp65WBfeti99oS6MwF44MJT6YdC9wtd28n91orh
         tb8A==
X-Gm-Message-State: APjAAAW3Kx4ujJp0R3WE5WVQB6sRBZO9l2pooy+kyRIOAy4Y+dEJR/aH
        AfZRM7yxP8TAqyRby7k59lCBYQ==
X-Google-Smtp-Source: APXvYqxBrLQLYOhjC06ttH0oS4iTEZciWxGcpCjxLxO6REBckClVky6ibhEZSIdbT3pUDWmo5ZD8Gw==
X-Received: by 2002:a65:408b:: with SMTP id t11mr8911128pgp.372.1556344814717;
        Fri, 26 Apr 2019 23:00:14 -0700 (PDT)
Received: from google.com ([2620:15c:2cd:202:668d:6035:b425:3a3a])
        by smtp.gmail.com with ESMTPSA id u62sm44711410pfa.124.2019.04.26.23.00.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 23:00:13 -0700 (PDT)
Date:   Fri, 26 Apr 2019 23:00:10 -0700
From:   Michel Lespinasse <walken@google.com>
To:     Laurent Dufour <ldufour@linux.ibm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
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
Message-ID: <20190427060010.GB174296@google.com>
References: <20190416134522.17540-1-ldufour@linux.ibm.com>
 <CANN689F1h9XoHPzr_FQY2WfN5bb2TTd6M3HLqoJ-DQuHkNbA7g@mail.gmail.com>
 <aadc7b03-9121-6800-341b-6f2849088a09@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aadc7b03-9121-6800-341b-6f2849088a09@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 08:01:20PM +0200, Laurent Dufour wrote:
> Le 22/04/2019 à 23:29, Michel Lespinasse a écrit :
> > Hi Laurent,
> > 
> > Thanks a lot for copying me on this patchset. It took me a few days to
> > go through it - I had not been following the previous iterations of
> > this series so I had to catch up. I will be sending comments for
> > individual commits, but before tat I would like to discuss the series
> > as a whole.
> 
> Hi Michel,
> 
> Thanks for reviewing this series.
> 
> > I think these changes are a big step in the right direction. My main
> > reservation about them is that they are additive - adding some complexity
> > for speculative page faults - and I wonder if it'd be possible, over the
> > long term, to replace the existing complexity we have in mmap_sem retry
> > mechanisms instead of adding to it. This is not something that should
> > block your progress, but I think it would be good, as we introduce spf,
> > to evaluate whether we could eventually get all the way to removing the
> > mmap_sem retry mechanism, or if we will actually have to keep both.
> 
> Until we get rid of the mmap_sem which seems to be a very long story, I
> can't see how we could get rid of the retry mechanism.

Short answer: I'd like spf to be extended to handle file vmas,
populating page tables, and the vm_normal_page thing, so that we
wouldn't have to fall back to the path that grabs (and possibly
has to drop) the read side mmap_sem.

Even doing the above, there are still cases spf can't solve - for
example, gup, or the occasional spf abort, or even the case of a large
mmap/munmap delaying a smaller one. I think replacing mmap_sem with a
reader/writer interval lock would be a very nice generic solution to
this problem, allowing false conflicts to proceed in parallel, while
synchronizing true conflicts which is exactly what we want. But I
don't think such a lock can be implemented efficiently enough to be
put on the page fault fast-path, so I think spf could be the solution
there - it would allow us to skip taking that interval lock on most
page faults. The other places where we use mmap_sem are not as critical
for performance (they normally operate on a larger region at a time)
so I think we could afford the interval lock in those places.

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
