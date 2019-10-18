Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B83CBCA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 16:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81F0D222C5
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 16:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="G6xE3Ft2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634345AbfJRQci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 12:32:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44612 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392259AbfJRQc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 12:32:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=c+Y4hXBrATeNY/3cK81vXDxv8+6uxZrDXzoHPDjQStk=; b=G6xE3Ft2lhAFumpDeSWw0MUnh
        woneqZpDH0FD1kPmuRoyk8/n/08m8ja6QA2dW5guNsFR0vdbpVZ1mdFk9X3P9xSpG/vsg6KoFdeCl
        BU38bF1RDrYoqhA0hEJp6HStAZLoR+MPLno3uwCsiY1OYOsO6Z/RhEznGqavDAa7udcG2oHeYt+M3
        94K+2mWnUJ2dRPizTd/qlpwpRGxjBhH5aw4TjQV1Y6lpItqX9uoWNGyxDjQJ3TH4y12NNovcLkTS0
        k4YHfYXHjVTO5pQyIsDvZZo71JuszSrH6FswOoydRo3VQW459UP1pIldjlOMnsnDPlgKUQYcdZw53
        78JNC/aEg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iLVAs-0000wA-8s; Fri, 18 Oct 2019 16:32:22 +0000
Date:   Fri, 18 Oct 2019 09:32:22 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Philippe Liard <pliard@google.com>
Cc:     phillip@squashfs.org.uk, linux-kernel@vger.kernel.org,
        groeck@chromium.org
Subject: Re: [PATCH] squashfs: Migrate from ll_rw_block usage to BIO
Message-ID: <20191018163222.GA32033@infradead.org>
References: <20191018010846.186484-1-pliard@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018010846.186484-1-pliard@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I don't see why you still need buffer_heads at all.  Basically
if you replace each of your allocated buffer heads with a
simple page allocation the code will be much simpler (this version
adds more than 100 lines of code!) and probaby still a bit faster
as you don't need the squashfs_bio_request allocation either.
