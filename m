Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4648CA9ED4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 23:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78FAE206B8
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 23:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tEW4v9A/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730051AbfKDXxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 18:53:43 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34950 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729714AbfKDXxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 18:53:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hKQIOkvsEVy33JAGixmFXbJUTJzULvc42wk0hYwJ+hI=; b=tEW4v9A/ErwCu+FB/NjUEr8VU
        Qea9oQmy5T7hF2x7dZiQkO1vmZjaLTBfE2dhrF7txTiinFDZ/ZyfVp2Gp9iUbuZRYYfogTmVg/cK/
        5kc3UlQ4qPKI9VCRgiPu9WUghW6yao3Ex3Ybw49A2OZzB6Lq/PpWc9rrsQs4cBnnADF5MKtbAOPZN
        PbaAWqAFj0iDYudecR62IvYI3RqkvHYgTSXnsSj0Qxaq4CImGzBmlDNmiM/Z99Gkym+cWcbwyJnoG
        FuLryGYuGlBiQeoAGLYL76OZYy2vYYJ4/1CBWC8fFSJTRXRCeDFdGRdyIRntGAQvJlD7LQu8Ks0Uh
        Kuzkwvo6Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iRmAG-0003id-5y; Mon, 04 Nov 2019 23:53:40 +0000
Date:   Mon, 4 Nov 2019 15:53:40 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-spdx@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: spdxcheck.py complains about the second OR?
Message-ID: <20191104235340.GA13961@infradead.org>
References: <CAK7LNASwF9y+MkhkvCRATu0qXSJkxx8fZ-DUjQTfWOi9+1YrfQ@mail.gmail.com>
 <alpine.DEB.2.21.1911042310040.17054@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1911042310040.17054@nanos.tec.linutronix.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2019 at 11:11:53PM +0100, Thomas Gleixner wrote:
> On Fri, 1 Nov 2019, Masahiro Yamada wrote:
> > scripts/spdxcheck.py warns the following two files.
> > 
> > $ ./scripts/spdxcheck.py
> > drivers/net/ethernet/pensando/ionic/ionic_if.h: 1:52 Syntax error: OR
> > drivers/net/ethernet/pensando/ionic/ionic_regs.h: 1:52 Syntax error: OR
> > 
> > I do not understand what is wrong with them.
> > 
> > I think "A OR B OR C" is sane.
> 
> Yes it is, but obviously we did not expect files with 3 possible
> alternative licenses.

And I'm kinda happy about this warning because people are overdoing it.
There is no point for the Linux-OpenIB license in this case, as it
is just a BSD license with copy and paste errors.  I think the right
fix is to ask the authors to just drop it.
