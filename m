Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8DDEC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 15:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B7C02084E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 15:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557932651;
	bh=35dYv7cUrj9box5GYfZLkLxBHkEcek2CZmiVu9HLksA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EbDme7UHhzdslDxjzHm2MVoUq1QUpj3G0KiAgjrjiN567tpgnRnDhbWmBSokw6cZ5
	 hoC2smC3ldGtS0j1zQLujir6zy9C0zy0LK1SnuskSjq7f3/FgU5j0JyTiDzttnDald
	 ZUoet6BIL6JkHgXz5733ujK5F0HW+Ks6MDZkpZVk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbfEOPEK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 11:04:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:56766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726583AbfEOPEK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 11:04:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D396720818;
        Wed, 15 May 2019 15:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557932649;
        bh=35dYv7cUrj9box5GYfZLkLxBHkEcek2CZmiVu9HLksA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u8ZxO+aIhqlvTlqv5offOKjWeovz/LLOQMt+n6wfRE3fY6Id8zD51XO3GFgKVxRBd
         +OBfpOCFQHP4uYuF5BdcEv4Nyid7GcUUVqS5LhlbJaoIiy8XgNtIBbbBfFg1oXxZ07
         B+ETbWC1AsIJB/rVtskuygrba2bnCMpjLU/Jfr1o=
Date:   Wed, 15 May 2019 17:04:06 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Lech Perczak <l.perczak@camlintechnologies.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Eric Dumazet <edumazet@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Piotr Figiel <p.figiel@camlintechnologies.com>,
        Krzysztof =?utf-8?Q?Drobi=C5=84ski?= 
        <k.drobinski@camlintechnologies.com>,
        Pawel Lenkow <p.lenkow@camlintechnologies.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: Recurring warning in page_copy_sane (inside copy_page_to_iter)
 when running stress tests involving drop_caches
Message-ID: <20190515150406.GA22540@kroah.com>
References: <d68c83ba-bf5a-f6e8-44dd-be98f45fc97a@camlintechnologies.com>
 <14c9e6f4-3fb8-ca22-91cc-6970f1d52265@camlintechnologies.com>
 <011a16e4-6aff-104c-a19b-d2bd11caba99@camlintechnologies.com>
 <20190515144352.GC31704@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190515144352.GC31704@bombadil.infradead.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 07:43:52AM -0700, Matthew Wilcox wrote:
> > > W dniu 25.04.2019 o 11:25, Lech Perczak pisze:
> > >> Some time ago, after upgrading the Kernel on our i.MX6Q-based boards to mainline 4.18, and now to LTS 4.19 line, during stress tests we started noticing strange warnings coming from 'read' syscall, when page_copy_sane() check failed. Typical reproducibility is up to ~4 events per 24h. Warnings origin from different processes, mostly involved with the stress tests, but not necessarily with block devices we're stressing. If the warning appeared in process relating to block device stress test, it would be accompanied by corrupted data, as the read operation gets aborted. 
> > >>
> > >> When I started debugging the issue, I noticed that in all cases we're dealing with highmem zero-order pages. In this case, page_head(page) == page, so page_address(page) should be equal to page_address(head).
> > >> However, it isn't the case, as page_address(head) in each case returns zero, causing the value of "v" to explode, and the check to fail.
> 
> You're seeing a race between page_address(page) being called twice.
> Between those two calls, something has caused the page to be removed from
> the page_address_map() list.  Eric's patch avoids calling page_address(),
> so apply it and be happy.
> 
> Greg, can you consider 6daef95b8c914866a46247232a048447fff97279 for
> backporting to stable?  Nobody realised it was a bugfix at the time it
> went in.  I suspect there aren't too many of us running HIGHMEM kernels
> any more.
> 

Sure, what kernel version(s) should this go to?  4.19 and newer?

thanks,

greg k-h
