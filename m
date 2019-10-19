Return-Path: <SRS0=/uHP=YM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDBECA9EAB
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 01:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7CE2222C6
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 01:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571447836;
	bh=YSDA0LTaYm8hf+ryniy6+Xi/I6lsN9xC1wzmmMaHRqw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=fYyfaGGTVwEAQ8jYD0yQp99yCtRMn3RWFIxOQodu0lR9c4P3BxdReghEgEyK5J+0T
	 TQgdFypFL5S+XOHb+8O4niXPpSiGioa0rDUDH9kt06QuXJMtC2RE38/W+KuPR2DEFP
	 WZkgwG4OuukXC08XmwFQRmqPY3AuGZIGPblNowPA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726033AbfJSBRO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 21:17:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:46232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbfJSBRN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 21:17:13 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDBAD222C5;
        Sat, 19 Oct 2019 01:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571447833;
        bh=YSDA0LTaYm8hf+ryniy6+Xi/I6lsN9xC1wzmmMaHRqw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nCA1LfoLCIO49G4uoXUsN/ZE/0GmrUfc7zMv3nVdr4yhB18lVhrw6QknGKxs116+f
         Me1B/Jo/gRiELN1blfBonF3x1X6ah3hp2jo5Vgywhuwty/vV/d3l2ja1EM2kXxgDWZ
         xYN7TwUYohNvp+RkX2ZzG9wRZNxSmiliUDbsaNRo=
Date:   Fri, 18 Oct 2019 18:17:12 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <matthew.wilcox@oracle.com>, <kernel-team@fb.com>,
        <william.kucharski@oracle.com>, <kirill.shutemov@linux.intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v3] mm,thp: recheck each page before collapsing file THP
Message-Id: <20191018181712.91dd9e9f9941642300e1b8d9@linux-foundation.org>
In-Reply-To: <20191018180345.4188310-1-songliubraving@fb.com>
References: <20191018180345.4188310-1-songliubraving@fb.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Oct 2019 11:03:45 -0700 Song Liu <songliubraving@fb.com> wrote:

> In collapse_file(), after locking the page, it is necessary to recheck
> that the page is up-to-date. Add PageUptodate() check for both shmem THP
> and file THP.
> 
> Current khugepaged should not try to collapse dirty file THP, because it
> is limited to read only text. Add a PageDirty check and warning for file
> THP. This is added after page_mapping() check, because if the page is
> truncated, it might be dirty.

When fixing a bug, please always fully describe the end-user visible
effects of that bug.  This is vital information for people who are
considering the fix for backporting.

I'm suspecting that you've found a race condition which can trigger a
VM_BUG_ON_PAGE(), which is rather serious.  But that was just a wild
guess.  Please don't make us wildly guess :(

The old code looked rather alarming:

			} else if (!PageUptodate(page)) {
				xas_unlock_irq(&xas);
				wait_on_page_locked(page);
				if (!trylock_page(page)) {
					result = SCAN_PAGE_LOCK;
					goto xa_unlocked;
				}
				get_page(page);

We don't have a ref on that page.  After we've released the xarray lock
we have no business playing with *page at all, correct?

