Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF620C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 07:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99382207FC
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 07:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qAmxzUva"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392437AbfIFHUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 03:20:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45824 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388816AbfIFHUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 03:20:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=v3xn7ZmePc/fMKLKQSmvzLjNcXGMc4XAThIjZvc9sl8=; b=qAmxzUvaJuz3UwjvBMHXuwGzmM
        8R12gdx167llfTzuU/WpDqbwal5N7P77md/C8rsYcdi1tYSWyr2lQh6aRBdqQMqR5f1sTAV3S5L0V
        SOC0cnKU0t1s0CSntJCSWKwIYnBcHKkQVKEWo7JDvgvlUMlPVLA7kRov6RUCK+DFZ2y/+4z3p4UtI
        8ibbU3JWQxRA7Y380QUG6hVJ2myXnOwufOhCJkUD5q9J23OK6k0xb2hUnjzZnDV7WXhxN4LBfGP+J
        f97XeltIvOXmIirfysBpic3IAIhisIJOU38OgVRVkEkNRdyiwsOa3bTGOqCODeUlR1hAoXcxKlnjl
        2HN+zx4w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i68Xt-0007fI-Fh; Fri, 06 Sep 2019 07:20:37 +0000
Date:   Fri, 6 Sep 2019 00:20:37 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Thomas =?iso-8859-1?Q?Hellstr=F6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org,
        "pv-drivers@vmware.com" <pv-drivers@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: dma_mmap_fault discussion
Message-ID: <20190906072037.GA29459@infradead.org>
References: <20190905103541.4161-1-thomas_os@shipmail.org>
 <20190905103541.4161-2-thomas_os@shipmail.org>
 <608bbec6-448e-f9d5-b29a-1984225eb078@intel.com>
 <b84d1dca-4542-a491-e585-a96c9d178466@shipmail.org>
 <20190905152438.GA18286@infradead.org>
 <cbbb0e95-8df1-9ab8-59ad-81bd7f3933fa@shipmail.org>
 <20190906063203.GA25415@infradead.org>
 <fcb71585-7fae-c6a0-81f0-1aa632ea621b@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fcb71585-7fae-c6a0-81f0-1aa632ea621b@shipmail.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2019 at 09:10:08AM +0200, Thomas Hellström (VMware) wrote:
> It's definitely possible. I was just wondering whether it was necessary, but
> it seems like it.

Yepp.

I've pushed a new version out (even hotter off the press) that doesn't
require the region for dma_mmap_prepare, and also uses PAGE_SIZE units
for the offset / length in dma_mmap_fault, which simplifies a few
things.
