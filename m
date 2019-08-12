Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA519C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 14:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 781B5206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 14:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f3wRAa9V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfHLOnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 10:43:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56268 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbfHLOni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 10:43:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8cJ8XWkMcW1fbjEa/tqUxP5Phy+u1hULETSofu2DyP0=; b=f3wRAa9V/S2KQCUUbYss5W/HV
        qUPeYDMJymadqdQ4GsAujyHvGAbKSgFomKfz+t+sw5BenNS9EnJOoOkuUUqBqIfNOkXoYfpKumEY4
        actXl9cAeGZB062k0Od9PwMtPoFCGpzVKTSfzXlN5KYGXBXN5wDSolrkTO3BwsrFlfb11k0gi823V
        UFixWyN/hRPN1UgR9DUoERlBhrsrZuX3x3ay5AvBjUtKJw64i5dtLzasrZMJev880atT1Q88DaEgC
        SonyXHIFCnxllUFqNVaguvULFqMnTOMhbKlCl3fOt5tNVNpFtfYau/O4s2jhxteKCgrJQVMqIEIXV
        5vWG9caCw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hxBXt-0007NY-Ny; Mon, 12 Aug 2019 14:43:37 +0000
Date:   Mon, 12 Aug 2019 07:43:37 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     linux-riscv@lists.infradead.org, schwab@suse.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: fix flush_tlb_range() end address for
 flush_tlb_page()
Message-ID: <20190812144337.GA26897@infradead.org>
References: <alpine.DEB.2.21.9999.1908080923320.31070@viisi.sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.9999.1908080923320.31070@viisi.sifive.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  #define flush_tlb_range(vma, start, end) \
>  	remote_sfence_vma(mm_cpumask((vma)->vm_mm), start, (end) - (start))
> -#define flush_tlb_mm(mm) \
> +
> +static inline void flush_tlb_page(struct vm_area_struct *vma,
> +				  unsigned long addr) {
> +	flush_tlb_range(vma, addr, addr + PAGE_SIZE);
> +}

Please put the opening brace on a line of its own.

Otherwise looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>
