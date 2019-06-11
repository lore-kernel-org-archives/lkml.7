Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A3EC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 15:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52AB92145D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 15:17:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ODhUns9U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729286AbfFKPRz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 11:17:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48132 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727601AbfFKPRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 11:17:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=eVgOWDgLR7upfxnSi0/pPEtmnURMeK6qO9i2y3dCEiY=; b=ODhUns9UlpGQitCQA9RkQL2Jy
        i1FreyI7EgQ7P+ic2LLzUo6tC8GrCd9bZ5mbTHSiWZXdfZlHAsmZq/BB3YeqXh4/mKl0yrSujQrgS
        Y9dNPvpMaYnpbC2PmDu9xUa7deeVKZVG9G9fHJM5fR9FIWgtvzEZkh7Q/peJbnufAM+7Q/hAgl5Ml
        UE9vD6qJcKFpvo4aRTl8GVwB/1s6Hjttl8WCXc5xU4dZPpi+9It3siDXxW/Up4l3xNFQHOdTph4Qj
        fVgUCJ834WlgPgqGybCEDhME2Af/6fDouq+C0EZCMY93i8Ih39fFHmaC5KfijOMuC4he2Xin1uIyh
        eK/sGMgYA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1haiX3-00037l-SL; Tue, 11 Jun 2019 15:17:53 +0000
Date:   Tue, 11 Jun 2019 08:17:53 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Oded Gabbay <oded.gabbay@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 8/8] habanalabs: enable 64-bit DMA mask in POWER9
Message-ID: <20190611151753.GA11404@infradead.org>
References: <20190611092144.11194-1-oded.gabbay@gmail.com>
 <20190611095857.GB24058@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611095857.GB24058@kroah.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 11:58:57AM +0200, Greg KH wrote:
> That feels like a big hack.  ppc doesn't have any "what arch am I
> running on?" runtime call?  Did you ask on the ppc64 mailing list?  I'm
> ok to take this for now, but odds are you need a better fix for this
> sometime...

That isn't the worst part of it.  The whole idea of checking what I'm
running to set a dma mask just doesn't make any sense at all.
