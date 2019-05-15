Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A74C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 15:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86BB52084E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 15:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tB4V3nQd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbfEOPSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 11:18:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54306 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbfEOPSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 11:18:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nKlUy/hi0pOvOwp9+flkg2CxiT2GvqwO6wvGfA+BWbw=; b=tB4V3nQd2C2I75CfF3dnpH/D8
        afJxcTTl3v9s5M27ZpBjsj2FhoMDXtk+xX300GkyzknTnwHOMK7dFZjDUJLFVbJqFfsykTYTqkTDd
        xtBfoJcdtvTjztwwz/gvFno5ysKIRrGqF5indcfeedmRa6tF45nuDcZn/H1icaLOk2mcvpkjRrqQM
        fHFal71CVmW2uWOVt5CER3FpAXZWYR0dcbZadz0A2WREgGofJx6X0X6kbxK0FfjFbs2Znq+9CVJWT
        CqJc7Ye+8NeGL+5n6K1Z/Nnj3JmuO3SQ7Jl9TdkEiK4CnHtzUdnpVcgd9nhX1aoFGpAHDxb2MHZlM
        xG4tl8AuQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hQvfb-0001fU-1F; Wed, 15 May 2019 15:18:15 +0000
Date:   Wed, 15 May 2019 08:18:14 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Eric Dumazet <edumazet@google.com>
Cc:     Lech Perczak <l.perczak@camlintechnologies.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Piotr Figiel <p.figiel@camlintechnologies.com>,
        Krzysztof =?utf-8?Q?Drobi=C5=84ski?= 
        <k.drobinski@camlintechnologies.com>,
        Pawel Lenkow <p.lenkow@camlintechnologies.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Recurring warning in page_copy_sane (inside copy_page_to_iter)
 when running stress tests involving drop_caches
Message-ID: <20190515151814.GD31704@bombadil.infradead.org>
References: <d68c83ba-bf5a-f6e8-44dd-be98f45fc97a@camlintechnologies.com>
 <14c9e6f4-3fb8-ca22-91cc-6970f1d52265@camlintechnologies.com>
 <011a16e4-6aff-104c-a19b-d2bd11caba99@camlintechnologies.com>
 <20190515144352.GC31704@bombadil.infradead.org>
 <CANn89iJ0r116a8q_+jUgP_8wPX4iS6WVppQ6HvgZFt9v9CviKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89iJ0r116a8q_+jUgP_8wPX4iS6WVppQ6HvgZFt9v9CviKA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 08:02:17AM -0700, Eric Dumazet wrote:
> On Wed, May 15, 2019 at 7:43 AM Matthew Wilcox <willy@infradead.org> wrote:
> > You're seeing a race between page_address(page) being called twice.
> > Between those two calls, something has caused the page to be removed from
> > the page_address_map() list.  Eric's patch avoids calling page_address(),
> > so apply it and be happy.
> 
> Hmm... wont the kmap_atomic() done later, after page_copy_sane() would
> suffer from the race ?
> 
> It seems there is a real bug somewhere to fix.

No.  page_address() called before the kmap_atomic() will look through
the list of mappings and see if that page is mapped somewhere.  We unmap
lazily, so all it takes to trigger this race is that the page _has_
been mapped before, and its mapping gets torn down during this call.

While the page is kmapped, its mapping cannot be torn down.
