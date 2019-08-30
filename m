Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C042BC3A5A6
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 15:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 951CF22CE9
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 15:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iq6TkDDs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbfH3Px0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 11:53:26 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43008 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbfH3PxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 11:53:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zHweZvPv+qS/uw/ey2KytzqYKe6e+8sBiSgp7HEOu4A=; b=iq6TkDDssGGAfJpgik5ak2P6z
        k+EkNHyvUt5DYa6Mo/5qad5Y3LOTnrz+66CiqqQ0TzL71W+6ucF/ugiriFY1UtRSvtjc0yCoTPkMO
        MmWNDG83+xz3bqQ3N/LGn0Sr5FMx/T25D438R8GoSVQXSh0TsNZH91b1cJOs7LDjJXJha67qbRtb1
        4f9tK+z04lGEcyydrCw4/iB/wgv3vc4Dw35csJ2w5SClP0RZW68nJPIVZOhNUK9fbdzTmfIoLuCy7
        iLirIk7a044snRG40OuwH4IyqdkFukC1AicEsU7MBRZ6GnlBHnzNFRY705Nfq/sh9XYxmWSl7WUPi
        p2pSIggiQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i3jDG-0007w4-FQ; Fri, 30 Aug 2019 15:53:22 +0000
Date:   Fri, 30 Aug 2019 08:53:22 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [PATCH] riscv: add arch/riscv/Kbuild
Message-ID: <20190830155322.GA30046@infradead.org>
References: <20190821092658.32764-1-yamada.masahiro@socionext.com>
 <20190826113526.GA23425@infradead.org>
 <CAK7LNAQ_5Hz_CXAdx8W0bLjMWQ08KDWK3gG2pfDZOEE+cr0KEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAQ_5Hz_CXAdx8W0bLjMWQ08KDWK3gG2pfDZOEE+cr0KEw@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 02:14:59PM +0900, Masahiro Yamada wrote:
> There is a small documentation about "Makefile" vs "Kbuild"
> in Documentation/kbuild/modules.rst section 3.2

I know that part.

> 
> It is talking about external modules, but the benefit applies
> to arch/$(SRCARCH)/Kbuild as well.

I fail to fully understand this part, though.

> arch/$(SRCARCH)/Makefile is included by the top Makefile
> to specify arch-specific compiler flags, etc.
> 
> On the other hand, arch/$(SRCARCH)/Kbuild, if exists, is included
> when Kbuild actually descends into arch/$(SRCARCH)/.
> 
> This allows you to hierarchize the sub-directories to visit
> instead of specifying everything in flat in arch/$(SRCARCH)/Makefile.

Yes, but what is the plan in the long run?  arch/$(ARCH)/Makefile
is still a weird hodge-podge of overriding global variables and misc
Makefile targets, it now just has a tiny little work.  Is there any
actual benefit from using Kbuild for the build process?  Can we
eventually move the setting of variables in the Makefile into another
special purpose file?  Is the support for actually compiling kernel
source files from the arch/$(ARCH) Makefile eventually going away?
