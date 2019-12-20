Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F859C2D0D2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 20:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C700206D8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 20:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FV0ppH6c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbfLTUYA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 15:24:00 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37518 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbfLTUYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 15:24:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DgxQx9+28OG7P/tSoTPUj1RwIIkipr7p1feEqqcd1ig=; b=FV0ppH6cMvMfOYZcK2cAjPpro
        XAcw8l+Fo8vfo6cc0aXGtjdbs8NhjUA0aEsJiXVuXsJPZ2oiOEDsw5QGrL4FlbRKSbVLMWVa4kgnT
        0mIqhgi909xSTmSgRZyZRJBPzFQnydtZqvfrLQ1AayVs2gQmGaB46x2jM0v3+5cdubGnDNuEcElon
        6bUdPako3fOTHFvABl/qvWwPnke0y/7AsTnmm7ZVYJIbJsp+M9RHicZ0RUVnwe2Fk5Dk96o0mpmdL
        HrFEh8R9tvCLabSgtMn3dTO1Bwv4t0SVqFl2zBNFyQa8FskumqrsznpbSbRoRKkP0OhmvGQPmTv/N
        H6IjIA0Xw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iiOoO-0006ZS-Cg; Fri, 20 Dec 2019 20:23:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F2FA33007F2;
        Fri, 20 Dec 2019 21:22:21 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 12A0C2024479A; Fri, 20 Dec 2019 21:23:46 +0100 (CET)
Date:   Fri, 20 Dec 2019 21:23:46 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Will Deacon <will@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Tejun Heo <tj@kernel.org>, Mark Brown <broonie@kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: Re: [RFC PATCH v1] devres: align devres.data strictly only for
 devm_kmalloc()
Message-ID: <20191220202346.GT2827@hirez.programming.kicks-ass.net>
References: <74ae22cd-08c1-d846-3e1d-cbc38db87442@free.fr>
 <bf020a68-00fd-2bb7-c3b6-00f5befa293a@free.fr>
 <20191220140655.GN2827@hirez.programming.kicks-ass.net>
 <9be1d523-e92c-836b-b79d-37e880d092a0@arm.com>
 <CY4PR1201MB012011E554FC69F7B074B7E2A12D0@CY4PR1201MB0120.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR1201MB012011E554FC69F7B074B7E2A12D0@CY4PR1201MB0120.namprd12.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2019 at 07:32:16PM +0000, Alexey Brodkin wrote:

> Well it somehow used to work for quite some time now with the data-buffer
> being allocated with 4 words offset (which is 16 bytes for 32-bit platform

3 words, devres_node is 3 words.

Which is exactly why we had to change it, the odd alignment caused ARC
to explode.

> and 32 for 64-bit which is still much less than mentioned 128 bytes).
> Or we just never managed to identify those rare cases when data corruption
> really happened?

The races are rather rare methinks, you'd have to get a list-op
concurrently with a DMA.

If you get the list corrupted, I'm thinking the crash is fairly likely,
albeit really difficuly to debug.

> > No matter which way round you allocate devres and data, by necessity
> > they're always going to consume the same total amount of memory.
> 
> So then the next option I guess is to separate meta-data from data buffers
> completely. Are there any reasons to not do that

Dunno, should work just fine I think.

> other than the hack we're
> discussing here (meta-data in the beginning of the buffer) used to work OK-ish?

If meta-data at the beginngin used to work, I don't see why meta-data at
the end wouldn't work equally well. They'd be equally broken.

But I'm still flabbergasted at the fact that they're doing non-coherent
DMA to kmalloc memory, I thought we had a DMA api for that, with a
special allocator and everything (but what do I know, I've never used
that).
