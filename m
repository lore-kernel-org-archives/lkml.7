Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B919C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 00:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DB46206F0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 00:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573776663;
	bh=DAQm9GR3gvG9lmdRo4b+3ThCEzBJHxVOj3bJdvsKmUo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=1U3UIGLR5XvxedRB7KRxKPbkMPSagRe72qbpd39kc5ienaGplbw3TydE0tUqkp4lt
	 zI+fIGzg4psECAjDen+A6ggmKkFbjikAyD4xvXXDNevHnPhX/nphGCV3X9oqFFzowE
	 5HX3QWRdwrQ/Svz2Bcg1Q2JcfY9NBLTqj7r38cFs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbfKOALC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 19:11:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:49824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726767AbfKOALB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 19:11:01 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC916206B6;
        Fri, 15 Nov 2019 00:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573776661;
        bh=DAQm9GR3gvG9lmdRo4b+3ThCEzBJHxVOj3bJdvsKmUo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Z2BH+HyV6PzsdDums/qePKJ3B+BF0HrQS+1JcaUkD7oQrCeuFEbXYAxJFklnVh1sB
         FcltzugMbIC4Ehov24ga9fH6W+ocw0Sr8XWlf4uhyEEICK/JfMe4ILtZgwUhpaYxvY
         bey+zemAuH2Gab0bXTkIYqz+BB/xyUPskwOOZ/gA=
Date:   Thu, 14 Nov 2019 16:10:58 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        "matthew.wilcox@oracle.com" <matthew.wilcox@oracle.com>,
        Kernel Team <Kernel-team@fb.com>,
        "william.kucharski@oracle.com" <william.kucharski@oracle.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Hugh Dickins" <hughd@google.com>
Subject: Re: [PATCH v5 1/2] mm,thp: recheck each page before collapsing file
 THP
Message-Id: <20191114161058.e61d7b86c516da7a45259f21@linux-foundation.org>
In-Reply-To: <60961DFB-32CB-4E56-8921-B2945E8BCB88@fb.com>
References: <20191106060930.2571389-1-songliubraving@fb.com>
        <20191106060930.2571389-2-songliubraving@fb.com>
        <60961DFB-32CB-4E56-8921-B2945E8BCB88@fb.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Nov 2019 23:47:06 +0000 Song Liu <songliubraving@fb.com> wrote:

> 
> > On Nov 5, 2019, at 10:09 PM, Song Liu <songliubraving@fb.com> wrote:
> > 
> > In collapse_file(), for !is_shmem case, current check cannot guarantee
> > the locked page is up-to-date.  Specifically, xas_unlock_irq() should
> > not be called before lock_page() and get_page(); and it is necessary to
> > recheck PageUptodate() after locking the page.
> > 
> > With this bug and CONFIG_READ_ONLY_THP_FOR_FS=y, madvise(HUGE)'ed .text
> > may contain corrupted data.  This is because khugepaged mistakenly
> > collapses some not up-to-date sub pages into a huge page, and assumes
> > the huge page is up-to-date.  This will NOT corrupt data in the disk,
> > because the page is read-only and never written back.  Fix this by
> > properly checking PageUptodate() after locking the page.  This check
> > replaces "VM_BUG_ON_PAGE(!PageUptodate(page), page);".
> > 
> > Also, move PageDirty() check after locking the page.  Current
> > khugepaged should not try to collapse dirty file THP, because it is
> > limited to read-only .text. The only case we hit a dirty page here is
> > when the page hasn't been written since write. Bail out and retry when
> > this happens.
> > 
> > syzbot reported bug on previous version of this patch.
> > 
> > Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
> > Reported-by: syzbot+efb9e48b9fbdc49bb34a@syzkaller.appspotmail.com
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Cc: Hugh Dickins <hughd@google.com>
> > Cc: William Kucharski <william.kucharski@oracle.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Signed-off-by: Song Liu <songliubraving@fb.com>
> 
> I think we need this in 5.4 official, but I haven't seen it in Linus' 
> master branch. 
> 
> Hi Andrew,
> 
> Could you please send patch/pull-request for it? 

Yep, today or tomorrow...
