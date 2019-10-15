Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2554CECE587
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 07:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E69ED21835
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 07:20:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NoT3fPLB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbfJOHUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 03:20:09 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52116 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbfJOHUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 03:20:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5tEG2p45gNP9BNrX79XMg7gvZhBjEXN9OW2kdIAxYUw=; b=NoT3fPLBTYLgapmnDFexbw5kz
        K1tHzkT3H0luJRy4GZ6vgQAkALQf6vMqgJw1fNfxII8cyxfCQGTNV1ASKjih0Ly1wCEdyrofTyYD3
        5xGbm4hieaoiHECWQlSirdGgxdXeyzseuqjM+6NkFx3uM6eGu5gCWLaBNnLIXVspBzzNnVQk6ViQ1
        vnweuSRWt95iHKK06uVbMnEi2u8UC/4VkdbBmkuzhA2ABPIV0GNcZlcVGSWrO2sOxk68PDeioeqHZ
        SHODzkccs5FCDB6XVvUSsIRQl6WvG8hKkhBm0hymsu5P1IL60P/83kBFSau33GxGZnfE+87B59+8h
        M7xdnUOWA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iKH7i-0002kX-IL; Tue, 15 Oct 2019 07:20:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 48AC930018A;
        Tue, 15 Oct 2019 09:19:05 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8A4E220238A89; Tue, 15 Oct 2019 09:19:59 +0200 (CEST)
Date:   Tue, 15 Oct 2019 09:19:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Manfred Spraul <manfred@colorfullife.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Waiman Long <longman@redhat.com>, 1vier1@web.de,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, parri.andrea@gmail.com
Subject: Re: [PATCH 6/6] Documentation/memory-barriers.txt: Clarify cmpxchg()
Message-ID: <20191015071959.GA2311@hirez.programming.kicks-ass.net>
References: <20191012054958.3624-1-manfred@colorfullife.com>
 <20191012054958.3624-7-manfred@colorfullife.com>
 <20191015012604.eonteqarhvgmrzuc@linux-p48b>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015012604.eonteqarhvgmrzuc@linux-p48b>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 06:26:04PM -0700, Davidlohr Bueso wrote:
> On Sat, 12 Oct 2019, Manfred Spraul wrote:
> > Invalid would be:
> > 	smp_mb__before_atomic();
> > 	atomic_set();
> 
> fyi I've caught a couple of naughty users:
> 
>   drivers/crypto/cavium/nitrox/nitrox_main.c
>   drivers/gpu/drm/msm/adreno/a5xx_preempt.c

Yes, there's still some of that. Andrea went and killed a buch a while
ago I think.
