Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B80C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 17:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7680D24680
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 17:19:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WmVimipA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbfLTRTR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 12:19:17 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59636 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbfLTRTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 12:19:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hN0hcdDPad7tpO1bvn605tmZ+zdb16RbEbSmhVKnHko=; b=WmVimipA8h5VrSmq32OQNW8PJ
        bKAWUTXnvol9OuRLAS7HNTsAf7lldEhaBVG5lNTdHxjWAxdLEgbFDEUP/6lxxaGMWq69Kiq3kOlUV
        kgQm79U+I+ozg8aGXa0XBo3/UiJLqiIzz3zHUjeYTtWXsPuFRjzmI3mzJ3BSGUaemHghfGL5U4skm
        izxGQGWdbVvrXR5Gi4j0sLFWO+y0zUvsRzsVJdyaX3RLD1WX9rYEz0KjLCs16t1esA2P3xlscLo+/
        B0Q7lHIeiFig9eOp/Iw8YzQGBJsMWiZwkBM8bHLDEt1C+47f4+Yhq/e9HHYEn7eEtlvOnccXNLIkB
        ADI/OJcBA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iiLvg-0004sL-Id; Fri, 20 Dec 2019 17:19:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C450A30038D;
        Fri, 20 Dec 2019 18:17:42 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B755E20244791; Fri, 20 Dec 2019 18:19:06 +0100 (CET)
Date:   Fri, 20 Dec 2019 18:19:06 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Will Deacon <will@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Tejun Heo <tj@kernel.org>, Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH v1] devres: align devres.data strictly only for
 devm_kmalloc()
Message-ID: <20191220171906.GR2827@hirez.programming.kicks-ass.net>
References: <74ae22cd-08c1-d846-3e1d-cbc38db87442@free.fr>
 <bf020a68-00fd-2bb7-c3b6-00f5befa293a@free.fr>
 <20191220102218.GA2259862@kroah.com>
 <20191220102256.GB2259862@kroah.com>
 <5b12b473-bf9a-6dc9-838c-f9312eb10635@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b12b473-bf9a-6dc9-838c-f9312eb10635@free.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2019 at 01:05:43PM +0100, Marc Gonzalez wrote:
> If "fixing" the kmalloc strict alignment requirement on arm64 is too
> hard, maybe it would be possible to shave some of the devm memory
> waste by working with (chained) arrays of devm nodes, instead
> of a straight-up linked list. (Akin to a C++ vector) Removal would
> be expensive, but that's supposed to be a rare operation, right?

xarray might be what you're looking for.
