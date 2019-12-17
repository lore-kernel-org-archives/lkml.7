Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7944C2D0CD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 15:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C6F12467B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 15:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576597539;
	bh=d7eBLm0I/s6DFoeNSrPqJMhc9kKOaXOaEqRZCmy2Vmo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dEn4MGS/rhkhU6oqWaYcxoTYQuIa5T7B84xlZpDU8d958zdCpBf4j8lPP56FiavzW
	 cYCVkUIaXIfVvaDWuf/zuTwh2ZuW4mF1n6EZDslDNFKgNESGPoYHsXb/m1VurUUEtJ
	 +ZvwVMBNbOt4vJjQLiqAGyUChr1qA0q164eM358k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbfLQPpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 10:45:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:35562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727161AbfLQPpi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 10:45:38 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F21DA2465E;
        Tue, 17 Dec 2019 15:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576597537;
        bh=d7eBLm0I/s6DFoeNSrPqJMhc9kKOaXOaEqRZCmy2Vmo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X4CsLVd0lOXz/T69EzqjaRx4hpxWylyCBLDEOxoWCqpBcgv0AQoJgp/WzvAF0Uv2C
         1oy4/yMfmBWnFF0OYpXtlKw52w3N3F8G42BsTSkH4bxP52b59/nA/4nX81hzQ/gr5b
         a8Dc+Hlb2npc3p/dnY0NONQD2QCl9sMekBmCVMps=
Date:   Tue, 17 Dec 2019 16:45:35 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Tejun Heo <tj@kernel.org>, Mark Brown <broonie@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFC PATCH v1] devres: align devres.data strictly only for
 devm_kmalloc()
Message-ID: <20191217154535.GA3718632@kroah.com>
References: <74ae22cd-08c1-d846-3e1d-cbc38db87442@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74ae22cd-08c1-d846-3e1d-cbc38db87442@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 04:30:54PM +0100, Marc Gonzalez wrote:
> Commit a66d972465d15 ("devres: Align data[] to ARCH_KMALLOC_MINALIGN")
> increased the alignment of devres.data unconditionally.
> 
> Some platforms have very strict alignment requirements for DMA-safe
> addresses, e.g. 128 bytes on arm64. There, struct devres amounts to:
> 	3 pointers + pad_to_128 + data + pad_to_256
> i.e. ~220 bytes of padding.
> 
> Let's enforce the alignment only for devm_kmalloc().
> 
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> ---
> I had not been aware that dynamic allocation granularity on arm64 was
> 128 bytes. This means there's a lot of waste on small allocations.
> I suppose there's no easy solution, though.
> ---
>  drivers/base/devres.c | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)

You need to get Alexey to agree with this, he's the one that hit this on
ARC :)

thanks,

greg k-h
