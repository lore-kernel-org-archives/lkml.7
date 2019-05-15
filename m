Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B72C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 14:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2732A20843
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 14:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uCVDsA4d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbfEOOn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 10:43:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43902 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfEOOn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 10:43:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=msiRUtVZ8HSn4DdePbxIYPVfN3e75W0NOasQGN4KIA4=; b=uCVDsA4d940++i/x0z86awqY8K
        10/9BCM/Z2Mr0+jfdFAvIZQ4drczdD3cJM+hemK6nb+JfJXaTqwxb0gGKHFpfGsTvCMsUJTVWLOqt
        kTf9wmMtnOPMinxGJ+hKQ1cekn6o7hZxCTGnqq43/5e009Lcr9KYZqFqHeejj+WL/2gNniCr+IT/R
        xmvRstEmckj37vMCYFbw+sL9rOJk749p9X9qdx9gwByu10InW7Vz2azwPG37Ie5NnbtWk/M7C3B3E
        AKkKCe/4Qu7sAQkWJFIzAEME8T6aQjyKTQe2R6ZpdVHQXiPBPwItazGv8RDsdZLdhKqJOO78WvqX1
        ytPC6/6Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hQv8K-0006cq-SW; Wed, 15 May 2019 14:43:52 +0000
Date:   Wed, 15 May 2019 07:43:52 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Lech Perczak <l.perczak@camlintechnologies.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Eric Dumazet <edumazet@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Piotr Figiel <p.figiel@camlintechnologies.com>,
        Krzysztof =?utf-8?Q?Drobi=C5=84ski?= 
        <k.drobinski@camlintechnologies.com>,
        Pawel Lenkow <p.lenkow@camlintechnologies.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Recurring warning in page_copy_sane (inside copy_page_to_iter)
 when running stress tests involving drop_caches
Message-ID: <20190515144352.GC31704@bombadil.infradead.org>
References: <d68c83ba-bf5a-f6e8-44dd-be98f45fc97a@camlintechnologies.com>
 <14c9e6f4-3fb8-ca22-91cc-6970f1d52265@camlintechnologies.com>
 <011a16e4-6aff-104c-a19b-d2bd11caba99@camlintechnologies.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <011a16e4-6aff-104c-a19b-d2bd11caba99@camlintechnologies.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > W dniu 25.04.2019 o 11:25, Lech Perczak pisze:
> >> Some time ago, after upgrading the Kernel on our i.MX6Q-based boards to mainline 4.18, and now to LTS 4.19 line, during stress tests we started noticing strange warnings coming from 'read' syscall, when page_copy_sane() check failed. Typical reproducibility is up to ~4 events per 24h. Warnings origin from different processes, mostly involved with the stress tests, but not necessarily with block devices we're stressing. If the warning appeared in process relating to block device stress test, it would be accompanied by corrupted data, as the read operation gets aborted. 
> >>
> >> When I started debugging the issue, I noticed that in all cases we're dealing with highmem zero-order pages. In this case, page_head(page) == page, so page_address(page) should be equal to page_address(head).
> >> However, it isn't the case, as page_address(head) in each case returns zero, causing the value of "v" to explode, and the check to fail.

You're seeing a race between page_address(page) being called twice.
Between those two calls, something has caused the page to be removed from
the page_address_map() list.  Eric's patch avoids calling page_address(),
so apply it and be happy.

Greg, can you consider 6daef95b8c914866a46247232a048447fff97279 for
backporting to stable?  Nobody realised it was a bugfix at the time it
went in.  I suspect there aren't too many of us running HIGHMEM kernels
any more.

