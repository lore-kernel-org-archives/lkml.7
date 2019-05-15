Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE5CDC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 15:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90E2820873
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 15:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557934662;
	bh=lIwfUgZLsOETAqKmdIH6ivluhJ74dnvjF64W3zo7G3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=G5T358YWyn8WoIJpnicH0UF6bbhQ/u5jM0Lq8Iq0pwFVnu622cii/JeM6dqydOuhU
	 x4F1cqKerwHlSzO8MekS7C1Uc22Q1fW+DAtIvB+PXSYEkm7+9dEno00niiNQvHG0Za
	 NmCVTg8ynI3znD1aNLIsfD5ryajprjskGpVf5Dlc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbfEOPhl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 11:37:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:40910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726335AbfEOPhl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 11:37:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F41A20818;
        Wed, 15 May 2019 15:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557934660;
        bh=lIwfUgZLsOETAqKmdIH6ivluhJ74dnvjF64W3zo7G3U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=esXearoJXyErGlUIXkOrnIwNQRHkRzCAqnhw7vp9RJR39xntePk7hOYLZEhbxtgA4
         AaJRauP72JOUeasJHE7Wimfzcs5d/cquM0J5pC1xnS4aRGQ0Bcs/uw8xgNuQvJXYTk
         Ip/EGnYVhJ/lQ34norEhZKVj9l199Bg7B6z4b690=
Date:   Wed, 15 May 2019 17:37:38 +0200
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
Message-ID: <20190515153738.GA27219@kroah.com>
References: <d68c83ba-bf5a-f6e8-44dd-be98f45fc97a@camlintechnologies.com>
 <14c9e6f4-3fb8-ca22-91cc-6970f1d52265@camlintechnologies.com>
 <011a16e4-6aff-104c-a19b-d2bd11caba99@camlintechnologies.com>
 <20190515144352.GC31704@bombadil.infradead.org>
 <20190515150406.GA22540@kroah.com>
 <20190515152035.GE31704@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515152035.GE31704@bombadil.infradead.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 08:20:35AM -0700, Matthew Wilcox wrote:
> On Wed, May 15, 2019 at 05:04:06PM +0200, Greg Kroah-Hartman wrote:
> > > Greg, can you consider 6daef95b8c914866a46247232a048447fff97279 for
> > > backporting to stable?  Nobody realised it was a bugfix at the time it
> > > went in.  I suspect there aren't too many of us running HIGHMEM kernels
> > > any more.
> > > 
> > 
> > Sure, what kernel version(s) should this go to?  4.19 and newer?
> 
> Looks like the problem was introduced with commit
> a90bcb86ae700c12432446c4aa1819e7b8e172ec so 4.14 and newer, I think.

Ok, I'll look into it after this round of stable kernels are released,
thanks.

greg k-h
