Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7709EC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 06:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D0522070B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 06:12:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dPkKWkMl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbfJGGMO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 02:12:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51492 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbfJGGMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 02:12:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+RE624T/XEpD1avT5GfVdjNCs+ZJWmT9YjXQaqBZM7k=; b=dPkKWkMlKUhZZB5fhKh1ODpeT
        16ZHXI5t8z+ddBZDENkb6wpNM1HVKrAosj7Kx1FCMvsG3y4CstGls4eJr+psTuhVbafWlARVZbDBy
        r18be1Pg7voEFXL8M37tV6X7RbxQ4hDCMRCYEIoJf8KRxQnyDRrfpUogj0h5XqrEiOF8i5EBLS/wd
        bQ71lm27gW6ic7Wq2zHwGP0MKH/7bdHidtC0AdBlXxA6RrI8Her5gSS3ZaL0YK/4bBSnRVedH+fYG
        CKA/0PWJiWAic++x07UfEEzYOapftae0PFbULcKoL0vh9s4E27jgwWtAszbsvT9SoSFPISpQHZVWl
        VYWnZrUHQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHMFg-0007yp-9K; Mon, 07 Oct 2019 06:12:12 +0000
Date:   Sun, 6 Oct 2019 23:12:12 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Alan Mikhak <alan.mikhak@sifive.com>, linux-kernel@vger.kernel.org,
        martin.petersen@oracle.com, alexios.zavras@intel.com,
        ming.lei@redhat.com, gregkh@linuxfoundation.org,
        tglx@linutronix.de, christophe.leroy@c-s.fr, palmer@sifive.com,
        paul.walmsley@sifive.com
Subject: Re: [PATCH] scatterlist: Validate page before calling PageSlab()
Message-ID: <20191007061212.GA17978@infradead.org>
References: <1569885755-10947-1-git-send-email-alan.mikhak@sifive.com>
 <20191001121623.GA22532@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001121623.GA22532@ziepe.ca>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 09:16:23AM -0300, Jason Gunthorpe wrote:
> > If the virtual address obtained from ioremap() is not
> > backed by a page struct, virt_to_page() returns an
> > invalid page pointer. However, sg_copy_buffer() can
> > correctly recover the original virtual address. Such
> > addresses can successfully be assigned to scatterlist
> > segments to transfer data across the PCI bus with
> > sg_copy_buffer() if it were not for the crash in
> > PageSlab() when called by sg_miter_stop().
> 
> I thought we already agreed in general that putting things that don't
> have struct page into the scatter list was not allowed?

Yes, that absolutely is the case.
