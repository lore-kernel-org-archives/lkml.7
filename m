Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CAECC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 14:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50F4522D6D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 14:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nVaIIUy0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729373AbfHUOl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 10:41:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47074 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727696AbfHUOl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 10:41:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WLdMgKL9F4ocb2m4Cezobxzumw/uB2f+PsOX+jMhtPE=; b=nVaIIUy0Jo14WrISgLM5s81Z4
        9NFOmGL1jKZT/zUwvWM3PnHzXOKdp7Ckwr9tQkwdURuIES6vU4HodYBX4L+k50ZmIyeF4QLj6qxbN
        tGHAe/vaBlsQwJjvnGvH/NgKx9aurnHiVTJTqiQzYs7C2/21qN2d+QykemIv447kCe8p9VZSBh3EI
        dmWs0lAEq5xyRsgmz22xKgl6fUdTzCoXwDA8dM/0oZgt3s2GumpPthNVVTTabTy7QeCKv2wxymaMp
        Lyri0QzhTWYExzHvefFUL5NRYka5K22/a+k5HtaZxW8ILW2b2qwVI+J4AjH/abv+h4gO1WM+GrxY+
        OhFdM6IiQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i0RoA-00044n-UA; Wed, 21 Aug 2019 14:41:54 +0000
Date:   Wed, 21 Aug 2019 07:41:54 -0700
From:   "hch@infradead.org" <hch@infradead.org>
To:     Atish Patra <Atish.Patra@wdc.com>
Cc:     "anup@brainfault.org" <anup@brainfault.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "schwab@linux-m68k.org" <schwab@linux-m68k.org>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "allison@lohutok.net" <allison@lohutok.net>
Subject: Re: [v2 PATCH] RISC-V: Optimize tlb flush path.
Message-ID: <20190821144154.GA4925@infradead.org>
References: <20190820004735.18518-1-atish.patra@wdc.com>
 <CAAhSdy3uQ=CSg4pHb_BYCEOh_MMTyLf8SW2o9SCn0UZDYwgGpg@mail.gmail.com>
 <171bb233718ba2897fa5fd48853721108825d22c.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171bb233718ba2897fa5fd48853721108825d22c.camel@wdc.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 08:29:47PM +0000, Atish Patra wrote:
> Sounds good to me. Christoph has already mm/tlbflush.c in his mmu
> series. I will rebase on top of it.

It was't really intended for the nommu series but for the native
clint prototype.  But the nommu series grew so many cleanups and
micro-optimizations by now that I think I'll split those into
another prep series and will include a version of this.
