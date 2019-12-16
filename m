Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF50C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 572AB206D3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RwNh+QmO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfLPRSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 12:18:42 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36698 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbfLPRSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 12:18:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cscWSzyLmPlZfTX0xDvWjfdOdN/mHzFVS9chZMvjXxY=; b=RwNh+QmO1PA4xtilpzeE8YyCC
        Uxn+HcpH+YWg1Xq4pVZoJXCJqYsBzJ3KcRH4xRLZmMHqjgHLDzbNImzdIIvYbOEqWH9hHwc223Y/D
        lCB5H5SKwtjQK/CqOA3mf6gWOImLCFmYRAgIte7fAY3/HfeKfUzsSnG97E27s/mXwvvfV6EyVGmCl
        T1uzfCb5mfWgP7CohImsfYREYe1ntreJdHYO3ZO8Uv9DFi9DtKwuKTaVGDPs0BUXQCKGI9xIxxBql
        Bl+j34P2mXQ7oA3KYR2SrdX/rh69a5z2wow6ZZ5XO0fxS+XK8eFbMOXNZuaFRg1cao7UcK/lkRqLj
        g8forvRtw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1igu10-0000aM-Ki; Mon, 16 Dec 2019 17:18:38 +0000
Date:   Mon, 16 Dec 2019 09:18:38 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, aneesh.kumar@linux.ibm.com
Subject: Re: [PATCH v2] mm/hugetlb: defer free_huge_page() to a workqueue
Message-ID: <20191216171838.GA32169@bombadil.infradead.org>
References: <20191211194615.18502-1-longman@redhat.com>
 <4fbc39a9-2c9c-4c2c-2b13-a548afe6083c@oracle.com>
 <32d2d4f2-83b9-2e40-05e2-71cd07e01b80@redhat.com>
 <0fcce71f-bc20-0ea3-b075-46592c8d533d@oracle.com>
 <20191212060650.ftqq27ftutxpc5hq@linux-p48b>
 <20191212063050.ufrpij6s6jkv7g7j@linux-p48b>
 <20191212190427.ouyohviijf5inhur@linux-p48b>
 <20191216133711.GH30281@dhcp22.suse.cz>
 <20191216161748.tgi2oictlfqy6azi@linux-p48b>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191216161748.tgi2oictlfqy6azi@linux-p48b>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 08:17:48AM -0800, Davidlohr Bueso wrote:
> On Mon, 16 Dec 2019, Michal Hocko wrote:
> > I am afraid that work_struct is too large to be stuffed into the struct
> > page array (because of the lockdep part).
> 
> Yeah, this needs to be done without touching struct page.
> 
> Which is why I had done the stack allocated way in this patch, but we
> cannot wait for it to complete in irq, so that's out the window. Andi
> had suggested percpu allocated work items, but having played with the
> idea over the weekend, I don't see how we can prevent another page being
> freed on the same cpu before previous work on the same cpu is complete
> (cpu0 wants to free pageA, schedules the work, in the mean time cpu0
> wants to free pageB and workerfn for pageA still hasn't been called).

Why is it that we can call functions after-an-RCU-period-has-elapsed time,
at returning-to-userspace time and after-exiting-hardirq-handler
time easily, but the mechanism for calling a function
after-we've-finished-handling-softirqs is so bloody hard to use?

That's surely the major problem we need to fix.

