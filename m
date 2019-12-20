Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 636A6C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 17:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31639206D3
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 17:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Sstg1BhJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbfLTROY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 12:14:24 -0500
Received: from merlin.infradead.org ([205.233.59.134]:58490 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727362AbfLTROY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 12:14:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CWMLNuWoRKapPDrLtoeUFvhjshGIgztAHqDVEXQJ5Jo=; b=Sstg1BhJ2zXAUsD1rwa7Tn7xl
        kLz2zyXnk8wGdadR9f4iP8vgQl0fa6IolhNyW8VYf/HplyMFGq6tUJtylPZlXQW2K/EyE8LBuasqb
        HQuTebHGYgNpURPXu3rD1kYIKPmnkfC0FVkmrIaHGyqLp5u8AaKbRmN9DwWqLuISGTCo4V+1vrjAE
        AfSIpio1XRCq6MsX1hCB+KTw9adW7qh4RSsYTgzseYQ9af1dRHHHQ7Kh5rJEzJv5crDYSx9cYJ4pW
        hoD9jUBiyTo0h/VH4OVdBVBCEmVo/nBnQfz5TYqkeWYL4IIzNsM5Ong16GGP/N/1uA/QPQPBkuCE/
        u0RIsgRnQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iiLqk-0006GU-16; Fri, 20 Dec 2019 17:14:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5A96D300DB7;
        Fri, 20 Dec 2019 18:12:35 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 61419203A6F24; Fri, 20 Dec 2019 18:13:59 +0100 (CET)
Date:   Fri, 20 Dec 2019 18:13:59 +0100
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
Message-ID: <20191220171359.GP2827@hirez.programming.kicks-ass.net>
References: <74ae22cd-08c1-d846-3e1d-cbc38db87442@free.fr>
 <bf020a68-00fd-2bb7-c3b6-00f5befa293a@free.fr>
 <20191220140655.GN2827@hirez.programming.kicks-ass.net>
 <9be1d523-e92c-836b-b79d-37e880d092a0@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9be1d523-e92c-836b-b79d-37e880d092a0@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2019 at 03:01:03PM +0000, Robin Murphy wrote:
> On 2019-12-20 2:06 pm, Peter Zijlstra wrote:

> > 	data = kmalloc(size + sizeof(struct devres), GFP_KERNEL);
> 
> At this point, you'd still need to special-case devm_kmalloc() to ensure
> size is rounded up to the next ARCH_KMALLOC_MINALIGN granule, or you'd go
> back to the original problem of the struct devres fields potentially sharing
> a cache line with the data buffer. That needs to be avoided, because if the
> devres list is modified while the buffer is mapped for noncoherent DMA
> (which could legitimately happen as they are nominally distinct allocations
> with different owners) there's liable to be data corruption one way or the
> other.

Wait up, why are you allowing non-coherent DMA at less than page size
granularity? Is that really sane? Is this really supported behaviour for
devm ?
