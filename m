Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC99C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BF3E217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IyuKo35E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbfDYIBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 04:01:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38850 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbfDYIBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 04:01:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ngfucRm9mRSqPXOAsceAoTEMgwoelpwNqK4YINL730s=; b=IyuKo35EE+AtOk161XHE6JGzm
        iIZ2BtmQQj/NdT8IePxxCDpC/vtrFRkKnPdhJPgJpTcXgQJ1p70Kv6pNVZ3G/SORyGOCiL6mT2CV3
        L2ponKjYsyBE60NnwIw1cYuSGOuJcgajqJ9toVKhTPsbepAE/za9E+JrME6zcRaQies5Bwuw+GoB4
        oQNlTRwgTYP0ILwv4a96IO4go5o7OuyNDosmioC2Bpl7uL27Oc2Nq6G21pOJlilnhVRRjHACCvadP
        HUBtI3eCXMEqn30Ly9B4AR0CcTQDpRF0vc2UqO28RsdSamtRNiU2s8tEbJRq0kPCz7KqXJeZZPYcj
        5lGdgQvZw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJZJl-0002j3-9m; Thu, 25 Apr 2019 08:01:17 +0000
Date:   Thu, 25 Apr 2019 01:01:17 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Anup Patel <anup@brainfault.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v4 2/3] RISC-V: Add interrupt related SCAUSE defines in
 asm/csr.h
Message-ID: <20190425080117.GA3575@infradead.org>
References: <20190425055015.45487-1-anup.patel@wdc.com>
 <20190425055015.45487-3-anup.patel@wdc.com>
 <20190425055757.GA30545@infradead.org>
 <CAAhSdy36q1R8HQRG3kXDqj5JoJbO_drignvO7wCHJ3-6wkE5rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhSdy36q1R8HQRG3kXDqj5JoJbO_drignvO7wCHJ3-6wkE5rw@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 12:46:52PM +0530, Anup Patel wrote:
> On Thu, Apr 25, 2019 at 11:28 AM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > > +#ifdef CONFIG_64BIT
> > > +#define SCAUSE_IRQ_FLAG              _AC(0x8000000000000000, UL)
> > > +#else
> > > +#define SCAUSE_IRQ_FLAG              _AC(0x80000000, UL)
> > > +#endif
> >
> > Please keep the existing defintion that doesn't need an ifdef..
> 
> Sure, will do.

While we're at it: I don't think we need both INTERRUPT_CAUSE_FLAG and
SCAUSE_IRQ_FLAG.
