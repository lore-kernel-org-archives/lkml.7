Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEDF4C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 08:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E4A320850
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 08:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IAe1TLu1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbfDMIB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 04:01:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42850 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbfDMIB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 04:01:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3vllFzFMPO37wu0NMKvD5Z8CRVSUwa/lYv/Pg2RfA5M=; b=IAe1TLu1o1Z6y6/xMwIHH1N23
        FhX1USEYTM/bQS7Xcsz+0hjWV99pEzZxYJxw+IXRsY4H4nn9y3ubcbsOJd05sYZtxvmYez2OIff2P
        Qvoo/KmhTBm0uU/8o566+RgQVX0lUuet7OP9fVPchAZH+zHx87eEdOVB9kwLjA46+grPXtPQ95Z0R
        cOiGnZ6nDSd/YmjCtoGTdkM4mSVGzYU10iyf6Uyz0BNdx15j674HQKcQkY69gXQZ4m8M7io1kIevk
        mJdTPg0bpwqUoJhirzSMSharYlRr3HvrERyCcaYeKV8gtIskS62TsFBbZWUqRQfqXzD6HhFn1aV0o
        j/jivQkOQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hFDbq-0002fX-A2; Sat, 13 Apr 2019 08:01:58 +0000
Date:   Sat, 13 Apr 2019 01:01:58 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Mao Han <han_mao@c-sky.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, guoren@kernel.org
Subject: Re: [PATCH 2/3] riscv: Add support for perf registers sampling
Message-ID: <20190413080158.GA3891@infradead.org>
References: <cover.1554961908.git.han_mao@c-sky.com>
 <20190411141435.GA8343@infradead.org>
 <20190412093851.GA4961@vmh-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190412093851.GA4961@vmh-VirtualBox>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 05:38:53PM +0800, Mao Han wrote:
> > 
> > > +	fp = user_backtrace(entry, fp, regs->ra);
> > > +	while ((entry->nr < entry->max_stack) &&
> > > +		fp && !((unsigned long)fp & 0x3))
> > > +		fp = user_backtrace(entry, fp, 0);
> > 
> > Please don't indent the condition continuation and the loop body
> > by the same amount.
> 
> Like this?
> 	while ((entry->nr < entry->max_stack) &&
> 					fp && !((unsigned long)fp & 0x3))
> 		fp = user_backtrace(entry, fp, 0);

We tend to either use indentations to the same level as the condition,
or two tabs indents.  But I also noticed that we shouldn't even need
the cast here as fp already is unsigned long, so it should all fit on
one line anyway:

	while (fp && !(fp & 0x3) && entry->nr < entry->max_stack)
		fp = user_backtrace(entry, fp, 0);
