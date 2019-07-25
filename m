Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76745C76194
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 08:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 431FB22BED
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 08:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389208AbfGYIOS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 04:14:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38360 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389116AbfGYIOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 04:14:17 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 64CA485546;
        Thu, 25 Jul 2019 08:14:17 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5028B600C4;
        Thu, 25 Jul 2019 08:14:15 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 25 Jul 2019 10:14:17 +0200 (CEST)
Date:   Thu, 25 Jul 2019 10:14:14 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     lkml <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "matthew.wilcox@oracle.com" <matthew.wilcox@oracle.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        Kernel Team <Kernel-team@fb.com>,
        "william.kucharski@oracle.com" <william.kucharski@oracle.com>
Subject: Re: [PATCH v8 2/4] uprobe: use original page when all uprobes are
 removed
Message-ID: <20190725081414.GB4707@redhat.com>
References: <20190724083600.832091-1-songliubraving@fb.com>
 <20190724083600.832091-3-songliubraving@fb.com>
 <20190724113711.GE21599@redhat.com>
 <BCE000B2-3F72-4148-A75C-738274917282@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BCE000B2-3F72-4148-A75C-738274917282@fb.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 25 Jul 2019 08:14:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/24, Song Liu wrote:
>
>
> > On Jul 24, 2019, at 4:37 AM, Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > On 07/24, Song Liu wrote:
> >>
> >> 	lock_page(old_page);
> >> @@ -177,15 +180,24 @@ static int __replace_page(struct vm_area_struct *vma, unsigned long addr,
> >> 	mmu_notifier_invalidate_range_start(&range);
> >> 	err = -EAGAIN;
> >> 	if (!page_vma_mapped_walk(&pvmw)) {
> >> -		mem_cgroup_cancel_charge(new_page, memcg, false);
> >> +		if (!orig)
> >> +			mem_cgroup_cancel_charge(new_page, memcg, false);
> >> 		goto unlock;
> >> 	}
> >> 	VM_BUG_ON_PAGE(addr != pvmw.address, old_page);
> >>
> >> 	get_page(new_page);
> >> -	page_add_new_anon_rmap(new_page, vma, addr, false);
> >> -	mem_cgroup_commit_charge(new_page, memcg, false, false);
> >> -	lru_cache_add_active_or_unevictable(new_page, vma);
> >> +	if (orig) {
> >> +		lock_page(new_page);  /* for page_add_file_rmap() */
> >> +		page_add_file_rmap(new_page, false);
> >
> >
> > Shouldn't we re-check new_page->mapping after lock_page() ? Or we can't
> > race with truncate?
>
> We can't race with truncate, because the file is open as binary and
> protected with DENYWRITE (ETXTBSY).

No. Yes, deny_write_access() protects mm->exe_file, but not the dynamic
libraries or other files which can be mmaped.

> > and I am worried this code can try to lock the same page twice...
> > Say, the probed application does MADV_DONTNEED and then writes "int3"
> > into vma->vm_file at the same address to fool verify_opcode().
> >
>
> Do you mean the case where old_page == new_page?

Yes,

> I think this won't
> happen, because in uprobe_write_opcode() we only do orig_page for
> !is_register case.

See above.

!is_register doesn't necessarily mean the original page was previously cow'ed.
And even if it was cow'ed, MADV_DONTNEED can restore the original mapping.

Oleg.

