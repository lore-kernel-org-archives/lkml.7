Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C039AC43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 10:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B66920830
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 10:38:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ItMXoLP3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbfCCKgc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 05:36:32 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42436 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfCCKgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 05:36:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7IjQzc5Ln//S4zZ0N/Bu05+ec8v0TqIieGmd+VE3W7Q=; b=ItMXoLP3yks8/7WyF9vb0YQaH
        MlFHx37O+YpCoKsjv/SMuXP7P2rtGXJwojaGMfnaK4VExz5UO9zuXk0LPf/wfWxPLcg8dp0YwOpH2
        DAGYq7D4EmXaIFsfwwbUc2kUOhNfPhkyxRA6NGNOYfbGGfX8iFF6M7do24b1WD8C+uEYeGhyZvhJ3
        N3XTiKCzfJlgT7RSbu4GE1/BFTzFgvcbTv/7SXtSyzGo8yGr7YasEL8N/V9a4+0z3Cx+4JMMs8l9d
        Ys+hjkCaMlv/snb94QYorxk0u+oPqoETL33hyxsPSBZPB5aV8FmzlDC37tJBg2YSNMAJXSvSKLyzV
        8FBH+16OA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h0OTj-0002AB-9S; Sun, 03 Mar 2019 10:36:19 +0000
Date:   Sun, 3 Mar 2019 02:36:19 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Jan Stancek <jstancek@redhat.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        peterz@infradead.org, riel@surriel.com, mhocko@suse.com,
        ying.huang@intel.com, jrdr.linux@gmail.com, jglisse@redhat.com,
        aneesh.kumar@linux.ibm.com, david@redhat.com, aarcange@redhat.com,
        raquini@redhat.com, rientjes@google.com, kirill@shutemov.name,
        mgorman@techsingularity.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm/memory.c: do_fault: avoid usage of stale
 vm_area_struct
Message-ID: <20190303103619.GQ11592@bombadil.infradead.org>
References: <20190302185144.GD31083@redhat.com>
 <5b3fdf19e2a5be460a384b936f5b56e13733f1b8.1551595137.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b3fdf19e2a5be460a384b936f5b56e13733f1b8.1551595137.git.jstancek@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 03, 2019 at 08:28:04AM +0100, Jan Stancek wrote:
> Cache mm_struct to avoid using potentially stale "vma".
> 
> [1] https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/mem/mtest06/mmap1.c
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> Reviewed-by: Andrea Arcangeli <aarcange@redhat.com>

Reviewed-by: Matthew Wilcox <willy@infradead.org>
