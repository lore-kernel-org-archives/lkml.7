Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2943BC7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 08:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBAB1217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 08:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbfGXI5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 04:57:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35212 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725999AbfGXI5j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 04:57:39 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0E1D830C1E3F;
        Wed, 24 Jul 2019 08:57:39 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id 44A8D60BFC;
        Wed, 24 Jul 2019 08:57:37 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 24 Jul 2019 10:57:38 +0200 (CEST)
Date:   Wed, 24 Jul 2019 10:57:36 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     lkml <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Matthew Wilcox <matthew.wilcox@oracle.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kernel Team <Kernel-team@fb.com>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH v7 2/4] uprobe: use original page when all uprobes are
 removed
Message-ID: <20190724085736.GA21599@redhat.com>
References: <20190625235325.2096441-1-songliubraving@fb.com>
 <20190625235325.2096441-3-songliubraving@fb.com>
 <20190715152513.GD1222@redhat.com>
 <EA58E3BD-7EB1-4433-8F7F-1E3894F8D563@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EA58E3BD-7EB1-4433-8F7F-1E3894F8D563@fb.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Wed, 24 Jul 2019 08:57:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/24, Song Liu wrote:
>
>
> > On Jul 15, 2019, at 8:25 AM, Oleg Nesterov <oleg@redhat.com> wrote:
> >
> >> +	if (!is_register) {
> >> +		struct page *orig_page;
> >> +		pgoff_t index;
> >> +
> >> +		index = vaddr_to_offset(vma, vaddr & PAGE_MASK) >> PAGE_SHIFT;
> >> +		orig_page = find_get_page(vma->vm_file->f_inode->i_mapping,
> >> +					  index);
> >> +
> >> +		if (orig_page) {
> >> +			if (pages_identical(new_page, orig_page)) {
> >
> > Shouldn't we at least check PageUptodate?
>
> For page cache, we only do ClearPageUptodate() on read failures,

Hmm. I don't think so.

> so
> this should be really rare case. But I guess we can check anyway.

Can? I think we should or this code is simply wrong...

> > and I am a bit surprised there is no simple way to unmap the old page
> > in this case...
>
> The easiest way I have found requires flush_cache_page() plus a few
> mmu_notifier calls around it.

But we need to do this anyway? At least with your patch replace_page() still
does this after page_add_file_rmap().

> I think current solution is better than
> that,

perhaps, I won't argue,

> as it saves a page fault.

I don't think it matters in this case.

Oleg.

