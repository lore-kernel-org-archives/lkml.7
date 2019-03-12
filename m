Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D0AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 04:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87DCB2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 04:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="HOkQ7PsK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfCLEji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 00:39:38 -0400
Received: from a9-32.smtp-out.amazonses.com ([54.240.9.32]:40438 "EHLO
        a9-32.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726314AbfCLEjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 00:39:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1552365576;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=1LTMJfj2MpOeyw9WxqSJjQTwp4yTHH300l9armbyJC4=;
        b=HOkQ7PsKGu3GSQcfBqMosDF+daAGkgtFYWtLnhM6U0lGK0XdYQ+blRTjybq852/P
        0j3VXMrpX5d3eF+pwOtkhR78avcgymKf+t9Sz+WbQ0YmNes5jaMZRyZeX/jBxjICmh2
        dnAFEAl8z0SmxzqaOBHIrVvRtJ9+MEc0ZqhJHsaU=
Date:   Tue, 12 Mar 2019 04:39:36 +0000
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
Subject: Re: [RFC 04/15] slub: Enable Slab Movable Objects (SMO)
In-Reply-To: <20190311224842.GC7915@tower.DHCP.thefacebook.com>
Message-ID: <010001697032e074-f9658e7a-595f-4804-a7a0-fd4220ee8473-000000@email.amazonses.com>
References: <20190308041426.16654-1-tobin@kernel.org> <20190308041426.16654-5-tobin@kernel.org> <20190311224842.GC7915@tower.DHCP.thefacebook.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.03.12-54.240.9.32
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Mar 2019, Roman Gushchin wrote:

> > +static inline void *alloc_scratch(struct kmem_cache *s)
> > +{
> > +	unsigned int size = oo_objects(s->max);
> > +
> > +	return kmalloc(size * sizeof(void *) +
> > +		       BITS_TO_LONGS(size) * sizeof(unsigned long),
> > +		       GFP_KERNEL);
>
> I wonder how big this allocation can be?
> Given that the reason for migration is probably highly fragmented memory,
> we probably don't want to have a high-order allocation here. So maybe
> kvmalloc()?

The smallest object size is 8 bytes which is one word which would be
places in an order 0 page. So it comes out to about a page again.

Larger allocation orders are possible if the slab pages itself can have
larger orders of course. If you set the min_order to the huge page order
then we can have similar sized orders for the allocation of the scratch
space. However, that is not a problem since the allocations for the slab
pages itself are also already of that same order.

