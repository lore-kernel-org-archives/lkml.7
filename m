Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6501C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 05:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BBAA20835
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 05:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YA0NwyFM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfCGFmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 00:42:14 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51906 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfCGFmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 00:42:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RSeJbPGu4n5a8qO23ErfycH59ZLG3k2u2mICIayGNB0=; b=YA0NwyFMQiSXnMXoioBcdHS3W
        Nh2wfmA05jYW4qlMCb//96TL40myLK2rv9qBhSxzdB5wwDksTK+4qTs+0Q53H50ODWevv+lcFpo1b
        te8RUMK7WGJK6MMleQyocD3ReoXdM5ApJlfV9lHlGLByf51pxKaJpIKU/LE6yKa7sCHPBhyivpKJH
        puXRhhZ0kfOQ7L4Ko7PYhEQKlDETJBZyC/2aqcQSzjTQXNyY3EzPuX9Jz3eLhP8osIDhZWAvlZ481
        RmrcsbYRQzgcmRm4+1aKeQ1DZ0sybpYczO74DjPzQLaX6wG+1U2nfMibvX4ssYcPqjd+d2iPtjz1d
        hvm3SrHeQ==;
Received: from dvhart by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h1lnH-00047N-33; Thu, 07 Mar 2019 05:42:11 +0000
Date:   Wed, 6 Mar 2019 21:42:09 -0800
From:   Darren Hart <dvhart@infradead.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Shych <michaelsh@mellanox.com>,
        Vadim Pasternak <vadimp@mellanox.com>
Subject: Re: linux-next: manual merge of the drivers-x86 tree with the
 watchdog tree
Message-ID: <20190307054209.GD44339@wrath>
References: <20190304143735.308edd1e@canb.auug.org.au>
 <20190307052701.GC44339@wrath>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307052701.GC44339@wrath>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2019 at 09:27:01PM -0800, Darren Hart wrote:
> On Mon, Mar 04, 2019 at 02:37:35PM +1100, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Today's linux-next merge of the drivers-x86 tree got a conflict in:
> > 
> >   include/linux/platform_data/mlxreg.h
> > 
> > between commit:
> > 
> >   9f03161a1bd8 ("platform_data/mlxreg: additions for Mellanox watchdog driver.")
> > 
> > from the watchdog tree and commit:
> > 
> >   9b28aa1d0eae ("platform_data/mlxreg: Document fixes for core platform data")
> > 
> > from the drivers-x86 tree.
> > 
> > I fixed it up (see below) and can carry the fix as necessary. This
> > is now fixed as far as linux-next is concerned, but any non trivial
> > conflicts should be mentioned to your upstream maintainer when your tree
> > is submitted for merging.  You may also want to consider cooperating
> > with the maintainer of the conflicting tree to minimise any particularly
> > complex conflicts.
> 
> Thanks Stephen.
> 
> I suspect this will be a rare occurence. That said - Vadim - could you please
> ensure that all the mellanox driver changes Cc the platform driver x86 mailing
> list by adding it to MAINTAINERS?

And, turns out, not so rare. We've been down this road before. I'll just prepare
the patch for the MAINTAINERS.

-- 
Darren Hart
VMware Open Source Technology Center
