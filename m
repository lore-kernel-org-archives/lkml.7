Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF0FC606C5
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 17:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 790502086D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 17:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oIfcgycO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730952AbfGHRfm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 13:35:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36538 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbfGHRfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 13:35:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=n9fo3wNw7aw0RbIvRpzphALTB15Qd7wOzZ709YJZYuY=; b=oIfcgycOcXRvCrTXgzSUV3Bbf
        KxQgqOLbwzHQGVNcZ7LSDii9CxBNLC5dofvJT19StoJNVlTzLJeQMrZ4MDiLx8JWqU9/dAlS8j4rs
        x3Cjiih3NScNZa19n6elIHzrcKQNF/BnylzXlnLZ6FbTZCo0oVYG5LuOfOj3yMH5DmF5nlBBi/lCi
        QKu8WOzXkvlFv4ag30R/h4cbVeI3BCx11EqJI5VVi7aT+6gD0MS493/D0mhY+otM0exYLPWc79BJ4
        5/ffMw6ehL1nj9mt8Yo3CRY11wQVVZ6ZR3lTUgVce2PL8EKpnd2GtWPjkUGTpACd3m3/PQudvUw6z
        n0VyKrmZA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hkXY6-0006it-Eo; Mon, 08 Jul 2019 17:35:34 +0000
Date:   Mon, 8 Jul 2019 10:35:34 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Pengfei Li <lpf.vector@gmail.com>
Cc:     akpm@linux-foundation.org, urezki@gmail.com, rpenyaev@suse.de,
        peterz@infradead.org, guro@fb.com, rick.p.edgecombe@intel.com,
        rppt@linux.ibm.com, aryabinin@virtuozzo.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/vmalloc.c: Remove always-true conditional in
 vmap_init_free_space
Message-ID: <20190708173534.GF32320@bombadil.infradead.org>
References: <20190708170631.2130-1-lpf.vector@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190708170631.2130-1-lpf.vector@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 09, 2019 at 01:06:31AM +0800, Pengfei Li wrote:
> When unsigned long variables are subtracted from one another,
> the result is always non-negative.
> 
> The vmap_area_list is sorted by address.
> 
> So the following two conditions are always true.
> 
> 1) if (busy->va_start - vmap_start > 0)
> 2) if (vmap_end - vmap_start > 0)
> 
> Just remove them.

That condition won't be true if busy->va_start == vmap_start.
