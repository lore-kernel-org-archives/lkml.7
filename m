Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F251C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 04:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF0D72173B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 04:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573016317;
	bh=OYGZe4Y6kWI8ux52zLIbquW9cR6zY7hfuBXqrqwr1wc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=rmxNrqkhE3rZS0sCNtgG8c5mzdVuI9ayBfHVAsbJRmu6r/87yV9UC9SY5leEIyAYn
	 LVDED50eJtUgj4q5vVdudUs0OEeLprkhRRACIguFbvKnKL5hTAyajAYuKA+KO66GzH
	 1b31J6NKmuiP3jP/5nO/QhaXRdANcYw+l/ch9oT4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731210AbfKFE6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 23:58:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:34594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727266AbfKFE6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 23:58:35 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6CF8214D8;
        Wed,  6 Nov 2019 04:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573016315;
        bh=OYGZe4Y6kWI8ux52zLIbquW9cR6zY7hfuBXqrqwr1wc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TBhoVGJQTZ+E9SIiFJuABeDLvEI/E0N9x+RZWx/Z58ToEhwc4O/fkSZjjtCsQoPNS
         jnzyWCyPc3f6sracKxKYaehf4aAMtvZW2LISMAi9wwZCHqvWVhQ8NvahdN0QLN4igo
         Mpaax3WS3XRmlGZo0wqSvu4ccQPNeHIUMgHb7bhw=
Date:   Tue, 5 Nov 2019 20:58:34 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "matthew.wilcox@oracle.com" <matthew.wilcox@oracle.com>,
        Kernel Team <Kernel-team@fb.com>,
        "william.kucharski@oracle.com" <william.kucharski@oracle.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Johannes Weiner" <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v3] mm,thp: recheck each page before collapsing file THP
Message-Id: <20191105205834.aaebbbfead54637d17a84775@linux-foundation.org>
In-Reply-To: <9DC29F5B-1DF5-408F-BEDF-FD1FBAAB1361@fb.com>
References: <20191018180345.4188310-1-songliubraving@fb.com>
        <20191018181712.91dd9e9f9941642300e1b8d9@linux-foundation.org>
        <9DC29F5B-1DF5-408F-BEDF-FD1FBAAB1361@fb.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Oct 2019 05:24:00 +0000 Song Liu <songliubraving@fb.com> wrote:

> > We don't have a ref on that page.  After we've released the xarray lock
> > we have no business playing with *page at all, correct?
> 
> Yeah, this piece is not just redundant, but also buggy. I am also 
> including some information about it. 
> 
> Updated commit log:
> 
> ============================= 8< =============================
> 
> In collapse_file(), for !is_shmem case, current check cannot guarantee 
> the locked page is up-to-date. Specifically, xas_unlock_irq() should not
> be called before lock_page() and get_page(); and it is necessary to 
> recheck PageUptodate() after locking the page. 
> 
> With this bug and CONFIG_READ_ONLY_THP_FOR_FS=y, madvise(HUGE)'ed .text 
> may contain corrupted data. This is because khugepaged mistakenly 
> collapses some not up-to-date sub pages into a huge page, and assumes the 
> huge page is up-to-date. This will NOT corrupt data in the disk, because 
> the page is read-only and never written back. Fix this by properly 
> checking PageUptodate() after locking the page. This check replaces 
> "VM_BUG_ON_PAGE(!PageUptodate(page), page);". 
> 
> Also, move PageDirty() check after locking the page. Current khugepaged 
> should not try to collapse dirty file THP, because it is limited to 
> read-only .text. Add a warning with the PageDirty() check as it should 
> not happen. This warning is added after page_mapping() check, because 
> if the page is truncated, it might be dirty.

I've lost the plot on this patch.  I have the v3 patch plus these fixes:

http://lkml.kernel.org/r/20191028221414.3685035-1-songliubraving@fb.com
http://lkml.kernel.org/r/20191022191006.411277-1-songliubraving@fb.com
http://lkml.kernel.org/r/20191030200736.3455046-1-songliubraving@fb.com

and there's a v4 which I can't correlate with the above.  And there has
been discussion about deferring some of the filemap_flush() changes
until later.

So I think it's best if we just start again.  Can you please prepare
and send out a v5 (which might be a 2-patch series)?
