Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E875FC7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 15:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEEDD2067D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 15:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387896AbfG2PFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 11:05:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45014 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387494AbfG2PFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 11:05:43 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F0972308FC5F;
        Mon, 29 Jul 2019 15:05:42 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1250810016E9;
        Mon, 29 Jul 2019 15:05:40 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 29 Jul 2019 17:05:42 +0200 (CEST)
Date:   Mon, 29 Jul 2019 17:05:40 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     akpm@linux-foundation.org
Cc:     kirill.shutemov@linux.intel.com, matthew.wilcox@oracle.com,
        peterz@infradead.org, rostedt@goodmis.org, songliubraving@fb.com,
        srikar@linux.vnet.ibm.com, william.kucharski@oracle.com,
        linux-kernel@vger.kernel.org
Subject: Re: + uprobe-use-original-page-when-all-uprobes-are-removed.patch
 added to -mm tree
Message-ID: <20190729150539.GB11349@redhat.com>
References: <20190726230333.drvM6x-wz%akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726230333.drvM6x-wz%akpm@linux-foundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Mon, 29 Jul 2019 15:05:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I didn't see this version, so let me reply here.

On 07/26, Andrew Morton wrote:
>
> +	/* try orig_page only for unregister and anonymous old_page */
> +	if (!is_register && PageAnon(old_page)) {

Well, this is confusing... nothing really wrong, but we certainly do not
want to install the new anonymous page if !is_register && !PageAnon(old).
And in this case we do not even want to call __replace page().

OK, I won't insist, this should almost never happen, but again, please
see https://lore.kernel.org/lkml/20190726084423.GA16112@redhat.com/

> +		struct page *orig_page;
> +		pgoff_t index;
> +
> +		index = vaddr_to_offset(vma, vaddr & PAGE_MASK) >> PAGE_SHIFT;
> +		orig_page = find_get_page(vma->vm_file->f_inode->i_mapping,
> +					  index);
> +
> +		if (orig_page) {
> +			if (PageUptodate(orig_page) &&
> +			    pages_identical(new_page, orig_page)) {
> +				/* let go new_page */
> +				put_page(new_page);
> +				new_page = NULL;
> +
> +				/* dec_mm_counter for old_page */
> +				dec_mm_counter(mm, MM_ANONPAGES);

this assumes that __replace_page() can't fail, but it can. I think you
should move this into into __replace_page().

Oleg.

