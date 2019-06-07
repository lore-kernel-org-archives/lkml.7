Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 749DBC468BC
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 19:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AC76212F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 19:13:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729843AbfFGTN4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 15:13:56 -0400
Received: from mga07.intel.com ([134.134.136.100]:13955 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728752AbfFGTN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 15:13:56 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jun 2019 12:13:54 -0700
X-ExtLoop1: 1
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 07 Jun 2019 12:13:52 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 0BAED526; Fri,  7 Jun 2019 22:13:49 +0300 (EEST)
Date:   Fri, 7 Jun 2019 22:13:49 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Hugh Dickins <hughd@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Peter Xu <peterx@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 1/1] coredump: fix race condition between
 collapse_huge_page() and core dumping
Message-ID: <20190607191349.wvhhnnsd63vrz7xo@black.fi.intel.com>
References: <20190607161558.32104-1-aarcange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607161558.32104-1-aarcange@redhat.com>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 07, 2019 at 04:15:58PM +0000, Andrea Arcangeli wrote:
> When fixing the race conditions between the coredump and the mmap_sem
> holders outside the context of the process, we focused on
> mmget_not_zero()/get_task_mm() callers in commit
> 04f5866e41fb70690e28397487d8bd8eea7d712a, but those aren't the only
> cases where the mmap_sem can be taken outside of the context of the
> process as Michal Hocko noticed while backporting that commit to
> older -stable kernels.
> 
> If mmgrab() is called in the context of the process, but then the
> mm_count reference is transferred outside the context of the process,
> that can also be a problem if the mmap_sem has to be taken for writing
> through that mm_count reference.
> 
> khugepaged registration calls mmgrab() in the context of the process,
> but the mmap_sem for writing is taken later in the context of the
> khugepaged kernel thread.
> 
> collapse_huge_page() after taking the mmap_sem for writing doesn't
> modify any vma, so it's not obvious that it could cause a problem to
> the coredump, but it happens to modify the pmd in a way that breaks an
> invariant that pmd_trans_huge_lock() relies upon. collapse_huge_page()
> needs the mmap_sem for writing just to block concurrent page faults
> that call pmd_trans_huge_lock().
> 
> Specifically the invariant that "!pmd_trans_huge()" cannot become
> a "pmd_trans_huge()" doesn't hold while collapse_huge_page() runs.
> 
> The coredump will call __get_user_pages() without mmap_sem for
> reading, which eventually can invoke a lockless page fault which will
> need a functional pmd_trans_huge_lock().
> 
> So collapse_huge_page() needs to use mmget_still_valid() to check it's
> not running concurrently with the coredump... as long as the coredump
> can invoke page faults without holding the mmap_sem for reading.
> 
> This has "Fixes: khugepaged" to facilitate backporting, but in my view
> it's more a bug in the coredump code that will eventually have to be
> rewritten to stop invoking page faults without the mmap_sem for
> reading. So the long term plan is still to drop all
> mmget_still_valid().
> 
> Cc: <stable@vger.kernel.org>
> Fixes: ba76149f47d8 ("thp: khugepaged")
> Reported-by: Michal Hocko <mhocko@suse.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
