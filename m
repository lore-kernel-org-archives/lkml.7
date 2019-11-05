Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FCAEC5DF62
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 15:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14C52217F5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 15:48:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UR3LSp2F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389980AbfKEPsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 10:48:00 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52230 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389571AbfKEPr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 10:47:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DFt11oLLoMJgDFYS0MiPrq0J+nWr0aEDvBTZoCHPfhI=; b=UR3LSp2FcVIcBHnz8MSvcstQ1
        xBM3DXaklmz8A0CnRD5XWVvNfa6tt7Ao4dslaBcXRGAVy/WygA6beBC8kdI6r1OjpRzeorOEhetkt
        bFJaM8ZU/vZiAs7VaOHnE7388I7S6CdzIS6uRj/4mUIpeo3vhHeLzvRfLln+q6VUfYlR+ayLn1hPi
        CEtQ3UIWqysJ31OvlL1vh1NmxborXMTK5QJ+2W0DA+raFS9kuAGnKWxDSlyKy49cORs1rxbXw2thG
        ii7cjdspsx3AY/MTRptJAUSliPNp1doTS/qKPRfMPm01CYRbVlffBGg29w8dYAegqJUjcmvcQn7FZ
        5RIt9/dOA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iS13i-00059U-SN; Tue, 05 Nov 2019 15:47:54 +0000
Date:   Tue, 5 Nov 2019 07:47:54 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Joe Perches <joe@perches.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-spdx@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: spdxcheck.py complains about the second OR?
Message-ID: <20191105154754.GA18119@infradead.org>
References: <CAK7LNASwF9y+MkhkvCRATu0qXSJkxx8fZ-DUjQTfWOi9+1YrfQ@mail.gmail.com>
 <alpine.DEB.2.21.1911042310040.17054@nanos.tec.linutronix.de>
 <46615f063c973eee649e3fdb8261978102c89108.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46615f063c973eee649e3fdb8261978102c89108.camel@perches.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2019 at 02:24:23PM -0800, Joe Perches wrote:
> On Mon, 2019-11-04 at 23:11 +0100, Thomas Gleixner wrote:
> > On Fri, 1 Nov 2019, Masahiro Yamada wrote:
> > > scripts/spdxcheck.py warns the following two files.
> > > 
> > > $ ./scripts/spdxcheck.py
> > > drivers/net/ethernet/pensando/ionic/ionic_if.h: 1:52 Syntax error: OR
> > > drivers/net/ethernet/pensando/ionic/ionic_regs.h: 1:52 Syntax error: OR
> > > 
> > > I do not understand what is wrong with them.
> > > 
> > > I think "A OR B OR C" is sane.
> > 
> > Yes it is, but obviously we did not expect files with 3 possible
> > alternative licenses.
> 
> Perhaps just this, but the generic logic
> obviously isn't complete.

Can we please print a warning in that case even if we end up parsing
it correct?  tripple licensing always has a bit of a bad smell.
