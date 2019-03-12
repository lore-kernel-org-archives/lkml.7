Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BECD2C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 04:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8032E214D8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 04:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="dPZiNMzA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbfCLEfQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 00:35:16 -0400
Received: from a9-46.smtp-out.amazonses.com ([54.240.9.46]:54406 "EHLO
        a9-46.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725792AbfCLEfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 00:35:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1552365315;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=IbeuS+zdcBFTccbustqiwuLJ9wpMqCNVsFWBtNbKAts=;
        b=dPZiNMzAgEKy+d5R3GmABBmXu0+p3BIgveTRcb7Y/V7shB2pxnRd55Rqpq7Yz/RQ
        7+pnOikBn+Tz2XvX+HJq2s3moWzsIlT6WXoDzB+cHCSn8yPHAMbQ+c+XWdpOzK9LIjj
        1sdDXaJUK9OT5kVjMh14wrdnAv2+iM2QHZ5z4Jjw=
Date:   Tue, 12 Mar 2019 04:35:15 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Roman Gushchin <guro@fb.com>
cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pekka Enberg <penberg@cs.helsinki.fi>,
        Matthew Wilcox <willy@infradead.org>,
        Tycho Andersen <tycho@tycho.ws>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 02/15] slub: Add isolate() and migrate() methods
In-Reply-To: <20190311215106.GA7915@tower.DHCP.thefacebook.com>
Message-ID: <01000169702ee357-fe8b85e5-e601-41da-8ba2-25e8b7db52eb-000000@email.amazonses.com>
References: <20190308041426.16654-1-tobin@kernel.org> <20190308041426.16654-3-tobin@kernel.org> <20190311215106.GA7915@tower.DHCP.thefacebook.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.03.12-54.240.9.46
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Mar 2019, Roman Gushchin wrote:

> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -4325,6 +4325,34 @@ int __kmem_cache_create(struct kmem_cache *s, slab_flags_t flags)
> >  	return err;
> >  }
> >
> > +void kmem_cache_setup_mobility(struct kmem_cache *s,
> > +			       kmem_cache_isolate_func isolate,
> > +			       kmem_cache_migrate_func migrate)
> > +{
>
> I wonder if it's better to adapt kmem_cache_create() to take two additional
> argument? I suspect mobility is not a dynamic option, so it can be
> set on kmem_cache creation.

One other idea that prior versions of this patchset used was to change
kmem_cache_create() so that the ctor parameter becomes an ops vector.

However, in order to reduce the size of the patchset I dropped that. It
could be easily moved back to the way it was before.

> > +	/*
> > +	 * Sadly serialization requirements currently mean that we have
> > +	 * to disable fast cmpxchg based processing.
> > +	 */
>
> Can you, please, elaborate a bit more here?

cmpxchg based processing does not lock the struct page. SMO requires to
ensure that all changes on a slab page can be stopped. The page->lock will
accomplish that. I think we could avoid dealing with actually locking the
page with some more work.
