Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC5BAC2D0D1
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 10:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE6E82072E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 10:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qxDusWjv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgAFKFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 05:05:18 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52184 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbgAFKFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 05:05:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+r5qrDtI/8MxA6roL/AaQoMQsqo1NbwF3DMmkPvjPAA=; b=qxDusWjv6hcOzqQdl6O56m8Tf
        L+2LDJanP0A8qi6C/SvaV96bZjQYNTO4MC+4CME8ebUr4Ri1kjeluQZBmmPiajjfPuO/E6z8P3xD0
        Ii0c1BjX1Hc1bWPL5L0vjk79glqK5gvxLdjXYPsN70sbXdfWKWMtZ81nB6T+a2z/Jfb83Xr32Ck18
        1LhGW2H8oGhJpmsQJpEqR7bcyC29M0/Iw+BV8UBQYOF2KPlAooW34UaoUudp9/f8+SZBEKoENFBGe
        3PZ/lo9yafS5KsRnD2D4gAQACQvvwR853zCvz3D7cTaLzi2htittH4NkhrOOb7sXDceW0/Jn+y5Qt
        2V/taHdjg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ioPFw-00071l-Qd; Mon, 06 Jan 2020 10:05:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F19B5306368;
        Mon,  6 Jan 2020 11:03:29 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DAF302B627477; Mon,  6 Jan 2020 11:05:01 +0100 (CET)
Date:   Mon, 6 Jan 2020 11:05:01 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Will Deacon <will@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Tejun Heo <tj@kernel.org>, Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH v1] devres: align devres.data strictly only for
 devm_kmalloc()
Message-ID: <20200106100501.GM2844@hirez.programming.kicks-ass.net>
References: <74ae22cd-08c1-d846-3e1d-cbc38db87442@free.fr>
 <bf020a68-00fd-2bb7-c3b6-00f5befa293a@free.fr>
 <20191220140655.GN2827@hirez.programming.kicks-ass.net>
 <9be1d523-e92c-836b-b79d-37e880d092a0@arm.com>
 <20191220171359.GP2827@hirez.programming.kicks-ass.net>
 <b2e0e322-a4e7-af26-d64a-1ba226e48476@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2e0e322-a4e7-af26-d64a-1ba226e48476@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2019 at 10:02:13PM +0000, Robin Murphy wrote:
> There is also the streaming API for one-off transfers
> of data already existing at a given kernel address (think network packets,
> USB URBs, etc), which on non-coherent architectures is achieved with
> explicit cache maintenance plus an API contract that buffers must not be
> explicitly accessed by CPUs for the duration of the mapping. Addresses from
> kmalloc() are explicitly valid for dma_map_single() (and indeed are about
> the only thing you'd ever reasonably feed it), which is the primary reason
> why ARCH_KMALLOC_MINALIGN gets so big on architectures which can be
> non-coherent and also suffer from creative cache designs.

Would it make sense to extend KASAN (or something) to detect violations
of this 'promise'? Because most obvious this was broken for the longest
time and was only accidentally fixed due to the ARC alignment thingy.
Who knows how many other sites are subtly broken too.

Have the dma_{,un}map_single() things mark the memory as
uninitialized/unaccessible such that any concurrent access will trigger
a splat.
