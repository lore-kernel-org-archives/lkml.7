Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE3CFC0650F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 06:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B3AE20843
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 06:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nNjq/9jK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbfHNGbG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 02:31:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38884 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbfHNGbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 02:31:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=U4IdTV78FsPfI1DcGuq/VJWnEgDTS2/i20t6j7jbmAU=; b=nNjq/9jKjp3TgScQoIA0PaajSm
        I+nF/VZU+awFuii2M9QQmEYmpz7kFngpkeM+GMdGeNiXqwSOy02R7RkbYZ4+Re81TryuRXnS00Kk8
        BKE3VVZoV+5A2QyMl/MDMUDFaievGQuuCQq7FeEERHXM06pYBBewwzy8331i4uPsMf2UWMJm7K/qY
        Dnn3PvTeVN86yedN7DJFvbKL3jt7Ors/rJ7rv6JOJZug4XenViaHJlPhkfnZOxjvyqMaUZvq5FYfG
        BmA68PKRlXTGSa7X7ImXocXF7upPaH076Dw+nEOFTEl0oDyDirE9gzEzuH9j+TK4WAtl8hBcrG1Cq
        5HbZOoGA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hxmo6-0003jz-0j; Wed, 14 Aug 2019 06:30:50 +0000
Date:   Tue, 13 Aug 2019 23:30:49 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 10/10] powerpc/mm: refactor ioremap_range() and use
 ioremap_page_range()
Message-ID: <20190814063049.GA3981@infradead.org>
References: <6bc35eca507359075528bc0e55938bc1ce8ee485.1565726867.git.christophe.leroy@c-s.fr>
 <bd784c8091cbf41231a862f73b52fd2a356ec8f1.1565726867.git.christophe.leroy@c-s.fr>
 <20190814054941.GC27497@infradead.org>
 <3f866bc8-7cc3-cb09-92f3-016dfb906526@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3f866bc8-7cc3-cb09-92f3-016dfb906526@c-s.fr>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 08:23:54AM +0200, Christophe Leroy wrote:
> Le 14/08/2019 à 07:49, Christoph Hellwig a écrit :
> > Somehow this series is missing a cover letter.
> > 
> > While you are touching all this "fun" can you also look into killing
> > __ioremap?  It seems to be a weird non-standard version of ioremap_prot
> > (probably predating ioremap_prot) that is missing a few lines of code
> > setting attributes that might not even be applicable for the two drivers
> > calling it.
> > 
> 
> ocm_init_node() [arch/powerpc/platforms/4xx/ocm.c] calls __ioremap() with
> _PAGE_EXEC set while ioremap_prot() clears _PAGE_EXEC

Indeed.  But I don't see anything marking this intentional.  Then again
the driver is entirely unused, so we might as well kill it off now.
