Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 202BBC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 23:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFD232177B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 23:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561590941;
	bh=0Jq+Gi01hm8xr98U/7QJrcZzZaNW00Tq+R6w9xmYElM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ps6deAqwFRlRGXJyIWFJpB+PBuPO7alKKiw1xz6JKoOsb/RxkfLqjPyMnxwAxHkZq
	 0VxKNT+tX6X4zVQgmY905xuDm4/oHvDUp2ai5ESbvq8Qigh+Zt7hzFmZUBJNetkF1m
	 Wfd6ozDTZSzKsZn+3oIYXG4wkKTTCVTlUtFF0bG8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbfFZXPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 19:15:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:41198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbfFZXPj (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 19:15:39 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54CF421738;
        Wed, 26 Jun 2019 23:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561590938;
        bh=0Jq+Gi01hm8xr98U/7QJrcZzZaNW00Tq+R6w9xmYElM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uTJS3ibnxftVoPyYA/8YeyMEeGDcIszJf5JIXpLQcw3XJInC4JVGwHZV/uQlqMf+q
         kVzlgurXyK9w99/0YaZ4Z2EpTw90T7hdzuVlfHQS0VhWvnNeoAe5hv+YeENsvtfKlF
         gqqDW8oXyejimuteeE6l7sSE4DgKyE+XRRi0l/Oc=
Date:   Wed, 26 Jun 2019 16:15:37 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     Linux-mm@kvack.org, Ira Weiny <ira.weiny@intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Hubbard <jhubbard@nvidia.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Linux-kernel@vger.kernel.org
Subject: Re: [PATCHv4] mm/gup: speed up check_and_migrate_cma_pages() on
 huge page
Message-Id: <20190626161537.ae9fcca4f727c12b2a44b471@linux-foundation.org>
In-Reply-To: <1561554600-5274-1-git-send-email-kernelfans@gmail.com>
References: <1561554600-5274-1-git-send-email-kernelfans@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jun 2019 21:10:00 +0800 Pingfan Liu <kernelfans@gmail.com> wrote:

> Both hugetlb and thp locate on the same migration type of pageblock, since
> they are allocated from a free_list[]. Based on this fact, it is enough to
> check on a single subpage to decide the migration type of the whole huge
> page. By this way, it saves (2M/4K - 1) times loop for pmd_huge on x86,
> similar on other archs.
> 
> Furthermore, when executing isolate_huge_page(), it avoid taking global
> hugetlb_lock many times, and meanless remove/add to the local link list
> cma_page_list.
> 
> ...
>
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1342,19 +1342,22 @@ static long check_and_migrate_cma_pages(struct task_struct *tsk,
>  	LIST_HEAD(cma_page_list);
>  
>  check_again:
> -	for (i = 0; i < nr_pages; i++) {
> +	for (i = 0; i < nr_pages;) {
> +
> +		struct page *head = compound_head(pages[i]);
> +		long step = 1;
> +
> +		if (PageCompound(head))

I suspect this would work correctly if the PageCompound test was simply
removed.  Not that I'm really suggesting that it be removed - dunno.

> +			step = (1 << compound_order(head)) - (pages[i] - head);

I don't understand this statement.  Why does the position of this page
in the pages[] array affect anything?  There's an assumption about the
contents of the skipped pages, I assume.

Could we please get a comment in here whcih fully explains the logic
and any assumptions?

