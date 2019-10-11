Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C427BECE58E
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 21:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CBD72190F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 21:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570829557;
	bh=kvNNeJghIHNqYqDMckjP1d9KcYViiPE0BC0buXkxp1c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=NXzvCkkFxSnRm4YWMKkx+YziU0ThJsFNUFIpGXGN8rUgYURoeDjUUV14Oi1LQIUgI
	 XTGvxX007+Ciuc83srlHmJ5PB/4ALk7xZnMdbFSPp1wfpoptGhYwrRKQKtv8nq80v4
	 qyh2KPY3k2BFWQTQKCc1zKFduAjV5bXjeR6ivKNw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729132AbfJKVcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 17:32:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:56734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726255AbfJKVcg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 17:32:36 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C6CF206CD;
        Fri, 11 Oct 2019 21:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570829554;
        bh=kvNNeJghIHNqYqDMckjP1d9KcYViiPE0BC0buXkxp1c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=STO7w8VBNrpR/Hf0V3c5LV1Zsf5R6ppG57RPbf9QX7ow61uvbZtOP9Xee5Pw1PMqS
         5rcpiALEeuFu0SMOaVO4jbYgViTXdMrKQfs6h+oa+rT8EegybJ2lTplBurja+NH58c
         omJn6NY/bqEt/YPER6sIm9fW962XwLJOY5J+QOzg=
Date:   Fri, 11 Oct 2019 14:32:31 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Minchan Kim <minchan@kernel.org>, linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sahkeel Butt <shakeelb@google.com>,
        Minchan Kim <minchan@google.com>
Subject: Re: [PATCH] mm: annotate refault stalls from swap_readpage
Message-Id: <20191011143231.e338e0ef337492e83233ad39@linux-foundation.org>
In-Reply-To: <20191010191747.GA31673@cmpxchg.org>
References: <20191010152134.38545-1-minchan@kernel.org>
        <20191010191747.GA31673@cmpxchg.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Oct 2019 15:17:47 -0400 Johannes Weiner <hannes@cmpxchg.org> wrote:

> On Thu, Oct 10, 2019 at 08:21:34AM -0700, Minchan Kim wrote:
> > From: Minchan Kim <minchan@google.com>
> > 
> > If block device supports rw_page operation, it doesn't submit bio
> > so annotation in submit_bio for refault stall doesn't work.
> > It happens with zram in android, especially swap read path which
> > could consume CPU cycle for decompress. It is also a problem for
> > zswap which uses frontswap.
> > 
> > Annotate swap_readpage() to account the synchronous IO overhead
> > to prevent underreport memory pressure.
> > 
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Signed-off-by: Minchan Kim <minchan@google.com>
> 
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> Can you please add a comment to the caller? Lifted from submit_bio():
> 
> 	/*
> 	 * Count submission time as memory stall. When the device is
> 	 * congested, or the submitting cgroup IO-throttled,
> 	 * submission can be a significant part of overall IO time.
> 	 */

This?

--- a/mm/page_io.c~mm-annotate-refault-stalls-from-swap_readpage-fix
+++ a/mm/page_io.c
@@ -361,6 +361,11 @@ int swap_readpage(struct page *page, boo
 	VM_BUG_ON_PAGE(!PageLocked(page), page);
 	VM_BUG_ON_PAGE(PageUptodate(page), page);
 
+	/*
+	 * Count submission time as memory stall. When the device is congested,
+	 * or the submitting cgroup IO-throttled, submission can be a
+	 * significant part of overall IO time.
+	 */
 	psi_memstall_enter(&pflags);
 
 	if (frontswap_load(page) == 0) {
_

