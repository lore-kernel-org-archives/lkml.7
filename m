Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E32C282DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 05:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B9842073F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 05:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UKpX/udC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbfDOFvN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 01:51:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43670 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbfDOFvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 01:51:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=iVxXrYcFE2vJjuCK1yGc026zEMHQoQ9eI52sBK7Aa4E=; b=UKpX/udCRAZjP6CoPv6Ksncf2
        PulbRGWCkHm4QtgV9I2WfEE4T+8kQwxACPKiHpVZf6q8ZCHv6x/at3ByDUGLIGIfPdqaC6oDrRk3W
        MhXVorBHyts8objHwJCFF4fCy5aUTy/3db7qFPWyJxaFJrnv3O5xuact+pYo4Rr10l5xrFbbXxX6w
        +ar0DCZ2a9fnxEuwiwC4GECpE/McqSzHdAldTJXBRCxDw17QrjzPVXqxCpXWkaqyLras1lSuMo/Do
        n+DhWx9XDyZo+hZ37Hnjn3F97+x6VsY0NHqpdAQ9b5cmXLxpEBcLlFGUYhMfTwW9MYpi8weO8MJnE
        93h+wx4ew==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hFuWL-0002Ko-C2; Mon, 15 Apr 2019 05:51:09 +0000
Date:   Sun, 14 Apr 2019 22:51:09 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/1] arm: mm: Export __sync_icache_dcache() for
 xen-privcmd
Message-ID: <20190415055109.GB9279@infradead.org>
References: <20190413163052.11407-1-xypron.glpk@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190413163052.11407-1-xypron.glpk@gmx.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 13, 2019 at 06:30:52PM +0200, Heinrich Schuchardt wrote:
> This patch avoids
> ERROR: "__sync_icache_dcache" [drivers/xen/xen-privcmd.ko] undefined!
> observed when compiling v4.19.34.
> 
> The xen-privcmd driver, which can be modular, calls set_pte_at()
> which in turn may call __sync_icache_dcache().

Maybe that really is a sign that it should not be modular..
