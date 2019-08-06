Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F22BC31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 13:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 436FE214C6
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 13:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dfTE8QFW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731652AbfHFNfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 09:35:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41880 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbfHFNfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 09:35:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LSrTDhsJpuHztoZ1vcQuO446UAhMwmMAYnYunQdQJVw=; b=dfTE8QFWDKasKNrl8PXCKENnA
        IsKrDnUGP/zpSEhJ0QG5ygHuuJTq3B7DlBi+/eJWeBsvzw8dnTtST1kAD3YyRToBtRJP58aeFUkiB
        3+HRTgVlp4K8xeDLEison7I8LUYJzN3p7U7CWFDZb7K/qvO/C8zZRSiIQHkz+hR0W88uBNtqkGpe1
        Ppo6E5ronvOPCj5A8eBSS4I6gwTQ6BRzRzAeoXB2LvkUug8dmGHFuyFsE1IBOgJAViCJagElvFJgJ
        iAMHMYibhwEkKHFLQBQdjiRlRVhKF2doWfHNqHwVh8YNPrflGEylFt9NBAx6TV5/ZlXTEVvfpBxWM
        VFYR7EQTA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1huzcF-0005L9-Op; Tue, 06 Aug 2019 13:35:03 +0000
Date:   Tue, 6 Aug 2019 06:35:03 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     linux-mm@kvack.org,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jan Kara <jack@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mm/migrate: clean up useless code in
 migrate_vma_collect_pmd()
Message-ID: <20190806133503.GC30179@bombadil.infradead.org>
References: <1565078411-27082-1-git-send-email-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565078411-27082-1-git-send-email-kernelfans@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This needs something beyond the subject line.  Maybe ...

After these assignments, we either restart the loop with a fresh variable,
or we assign to the variable again without using the value we've assigned.

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

>  			goto next;
>  		}
> -		pfn = page_to_pfn(page);

After you've done all this, as far as I can tell, the 'pfn' variable is
only used in one arm of the conditions, so it can be moved there.

ie something like:

-               unsigned long mpfn, pfn;
+               unsigned long mpfn;
...
-               pfn = pte_pfn(pte);
...
+                       unsigned long pfn = pte_pfn(pte);
+

