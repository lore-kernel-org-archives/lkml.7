Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F2ADC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 15:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4B062084E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 15:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hwwkkVyu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbfEOPUj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 11:20:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58380 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbfEOPUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 11:20:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2jOakzpA8HKNq+MMsYE/nSV1Gu2XO1Vws64soAe0Eko=; b=hwwkkVyuaLcdnbwQd2fZShmvB
        IvrVb7LY6X+R+frjUuT7TpC4b1FzEjCxx0QoqzwleoMNaGqbqJpGJK2BdtaqJFqqcNIS1m0W3oTmB
        pVM9ErECGTK4io52yDjGq/aXBr+xeiQAatOgNO1bf6JnAHvopKYSr29gfew6ibjVXDELWatWjGoyj
        H0S3BWvLQKDvzsusmplujOJX9mzeuAIYavwj4W7A+z/xRj84uLXxtzEGTasqLQgUKHriszFqSRZFS
        f5L5njCt5zdARgmv6dggXtZQhuyFcxSLR4NAzXcQ+bUJPAMPePX6SQ9pn/HfSWLXTOjSS2/Cec2f9
        pz2eECTLw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hQvhr-0003gl-Rb; Wed, 15 May 2019 15:20:35 +0000
Date:   Wed, 15 May 2019 08:20:35 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
Message-ID: <20190515152035.GE31704@bombadil.infradead.org>
References: <d68c83ba-bf5a-f6e8-44dd-be98f45fc97a@camlintechnologies.com>
 <14c9e6f4-3fb8-ca22-91cc-6970f1d52265@camlintechnologies.com>
 <011a16e4-6aff-104c-a19b-d2bd11caba99@camlintechnologies.com>
 <20190515144352.GC31704@bombadil.infradead.org>
 <20190515150406.GA22540@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515150406.GA22540@kroah.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 05:04:06PM +0200, Greg Kroah-Hartman wrote:
> > Greg, can you consider 6daef95b8c914866a46247232a048447fff97279 for
> > backporting to stable?  Nobody realised it was a bugfix at the time it
> > went in.  I suspect there aren't too many of us running HIGHMEM kernels
> > any more.
> > 
> 
> Sure, what kernel version(s) should this go to?  4.19 and newer?

Looks like the problem was introduced with commit
a90bcb86ae700c12432446c4aa1819e7b8e172ec so 4.14 and newer, I think.
