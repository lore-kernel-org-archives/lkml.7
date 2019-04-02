Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2816C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 07:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E93D206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 07:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UeIxR64x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729403AbfDBHDZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 03:03:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45512 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbfDBHDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 03:03:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Twlfz8G50ke+hX01Kn8nXDq6rAzgF1VGtVh8Qv0+Rtc=; b=UeIxR64x9YuCiWu5Dse+Nb4yx
        guGu9kyRSETJCUCX6PgsUb/dHW0hx0em4xS+JQICqK42YXH+iaiBC/zGs9zyP3wuDttwd3tN8i/iF
        BQ0Yna+Ha8qtTSGa/DN3IopWlUPIu29Ji1UaeROw3MVeRPfN87lTe+8ZTlupmVairCS1VkmvrOWl4
        WiYpD0JFY1v7m9rSjV5fAgZPAVZhBgmkbV7I4SIieEQmhSRFXM43m6EcfE1FJF+3M6FGq08DDjB1z
        0+ca11bCsPc0UzWnOX4/Quak6YeFQOTizvxpdI6X/HIRNdE3nDDLEkDeUlFez2eEqGzhB9LvvX0dK
        wfvOD7hlg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hBDS6-0007ex-FA; Tue, 02 Apr 2019 07:03:22 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 051F3203CBE11; Tue,  2 Apr 2019 09:03:20 +0200 (CEST)
Date:   Tue, 2 Apr 2019 09:03:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     tglx@linutronix.de, David Miller <davem@davemloft.net>,
        ard.biesheuvel@linaro.org, yamada.masahiro@socionext.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, oss-drivers@netronome.com,
        alexei.starovoitov@gmail.com
Subject: Re: [PATCH 0/3] locking/static_key: improve rate limited labels
Message-ID: <20190402070319.GF12232@hirez.programming.kicks-ass.net>
References: <20190330000854.30142-1-jakub.kicinski@netronome.com>
 <20190401112153.2f9e87ba@cakuba.hsd1.ca.comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190401112153.2f9e87ba@cakuba.hsd1.ca.comcast.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 11:21:53AM -0700, Jakub Kicinski wrote:
> On Fri, 29 Mar 2019 17:08:51 -0700, Jakub Kicinski wrote:
> > Hi!
> > 
> > This will be used to fix the static branch disabling in the TLS
> > code.  The net/tls/ code should be using the deferred static
> > branch type, because unprivileged users can flip the branch
> > on and off quite easily with CONFIG_TLS_DEVICE=y.
> > 
> > Second of all we shouldn't take the jump label locks from
> > the RX path, when the socket is destroyed.  This can be avoided
> > with some slight code refactoring in deferred static_key as
> > it already runs from a workqueue.
> > 
> > This the series (and a simple tls patch which makes use of it)
> > applied opening 0.5M TLS connections to localhost (just calling
> > setsockopt, no data exchange) goes down from 37.9s to 12.4s.
> 
> Once/if we get positive feedback from locking folks, would it be
> possible to merge these via net-next tree alongside the patch
> converting TLS to rate limited branches?

Sorry, I've been ill, I'll try and have a look at these patches soon.
