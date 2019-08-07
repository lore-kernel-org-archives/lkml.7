Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A3BC19759
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 06:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50FAA21BF6
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 06:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YJrEb1Zc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbfHGGs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 02:48:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39124 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbfHGGs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 02:48:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ItuiI1nEL9n9Nxw+XWQajVlOCCCyLRSiWGhG344XYv4=; b=YJrEb1ZcSEjgwW+qIRSuabjCE
        SbypNPGblw2rxsiHHnQXXnZP6hMD001vd1scpRoWLHiqvmilre2TUX5bFArLWPFMPgM0LDZ0mIqwT
        3w666+BcQZkdKaDcBPNo//OY5HQAdaZjHGwVcFBBeKAKAZkGvSg+Levl0muvHBX+nFCuXBkWTqUZY
        97KlMW1zChKtPl33yL+ZpvLmj4CdJAeDXOOBfNERiWI1qsmN2YwKZvNkYLJBUYRXsBVgwEE1/kzVe
        kIs3r+upWlLcqt0/5yGaG9bhYhsWqMHqOAaZosv1f3e1v/ZguUX47MmNeb4OGfD1ZW5IjEbt5pVuz
        5RZ9i7RHw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hvFkn-0001tR-8b; Wed, 07 Aug 2019 06:48:57 +0000
Date:   Tue, 6 Aug 2019 23:48:57 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: delay: use do_div() instead of __udivdi3()
Message-ID: <20190807064857.GA6942@infradead.org>
References: <alpine.DEB.2.21.9999.1908061906240.25231@viisi.sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.9999.1908061906240.25231@viisi.sifive.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> diff --git a/arch/riscv/lib/delay.c b/arch/riscv/lib/delay.c
> index 87ff89e88f2c..8c686934e0f6 100644
> --- a/arch/riscv/lib/delay.c
> +++ b/arch/riscv/lib/delay.c
> @@ -81,9 +81,14 @@ EXPORT_SYMBOL(__delay);
>  void udelay(unsigned long usecs)
>  {
>  	u64 ucycles = (u64)usecs * lpj_fine * UDELAY_MULT;
> +	u64 n;
> +	u32 rem;
>  
>  	if (unlikely(usecs > MAX_UDELAY_US)) {
> -		__delay((u64)usecs * riscv_timebase / 1000000ULL);
> +		n = (u64)usecs * riscv_timebase;
> +		rem = do_div(n, 1000000);
> +
> +		__delay(n);
>  		return;

A few comments on the variable usage:

I think you really want a variable of type u64 that contains the usecs
value instead of casting it three times.

n and rem can be easily declared inside the branch.
