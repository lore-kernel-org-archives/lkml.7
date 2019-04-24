Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4C6C282E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 06:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6D342089F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 06:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CWkH1EDR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729716AbfDXGSP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 02:18:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46534 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfDXGSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 02:18:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6hPveqgRVTbNWeEOtVMTmwg5++3tigNGkiLLY9fL52g=; b=CWkH1EDRvtDdo2ed0PfVENCek
        BEn/b6rLJbw2WIyJk0DA4ksnJSo8NplcFmGrVYljoEOGtv8CK+XBwBrbvX9VjFak4qJTeXa8KKZb9
        09OK5DT1suigw6pnRmK3il8Haq1poVCNcmIyFqIo6OqS0SuGz7tseLtpt+TMjvTOsqmLOVSTs1zIi
        A6dyIWiPBQ1T75DWZbD/M3+uCmrJW4lntyFxbXeeA2NK2oNMKCnuh85bnFAaexPfyFY+2l3nW5l+/
        bfhDgDaS/gZQwbnTs/VH1DpNeeUSuODLyIgVnORHfbereERf6Fmhfn6IhF95gH+nMLibzVqfNyVYf
        XyzA/T+fQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJBE6-0000rj-7l; Wed, 24 Apr 2019 06:17:50 +0000
Date:   Tue, 23 Apr 2019 23:17:50 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Bogendoerfer <tbogendoerfer@suse.de>,
        Huacai Chen <chenhc@lemote.com>,
        Stefan Agner <stefan@agner.ch>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Juergen Gross <jgross@suse.com>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/12] mips: Enable OF_RESERVED_MEM config
Message-ID: <20190424061750.GA30717@infradead.org>
References: <20190423224748.3765-1-fancer.lancer@gmail.com>
 <20190423224748.3765-13-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423224748.3765-13-fancer.lancer@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 01:47:48AM +0300, Serge Semin wrote:
> Since memblock-patchset was introduced the reserved-memory nodes are
> supported being declared in dt-files. So these nodes are actually parsed
> during the arch setup procedure when the early_init_fdt_scan_reserved_mem()
> method is called. But some of the features like private reserved memory
> pools aren't available at the moment, since OF_RESERVED_MEM isn't enabled
> for the MIPS platform. Lets fix it by enabling the config.
> 
> But due to the arch-specific boot mem_map container utilization we need
> to manually call the fdt_init_reserved_mem() method after all the available
> and reserved memory has been moved to memblock. The function call performed
> before bootmem_init() fails due to the lack of any memblock memory regions
> to allocate from at that stage.

Architectures should not select this symbol directly, it will be
automatically enabled if either DMA_DECLARE_COHERENT or DMA_CMA
are enabled, which are required for the actual underlying memory
allocators.
