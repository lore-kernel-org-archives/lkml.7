Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8150C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 12:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B97221951
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 12:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HxCqORj8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389432AbfGYMwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 08:52:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43480 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387586AbfGYMwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 08:52:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=d/Ysj7kh7KPJXSRnD+7pXkEpijt1uOPkmGiBPwEU0NY=; b=HxCqORj8GBkaWezV1GQRjNvVZ
        +BFTh80S74cUb74cD5mbtq97mvtsPXISwyW/qBwnCLNSMIvHoknTZJY7iy69qaYqLqxXFrOGZ0yWP
        4nEDrGR+e5C7NVDIE0WDt4s3AcAoxLLQ5LyPar2PwR4zroWRVaWf1Fm3jBQ4xIKaz5Xnwy17yKn8v
        EfDQSRkw4jU3WtiosYKG0GN15/EvYANWvDyqgAHPn88wuV8iGFAhmRNqD+3aGAYj3Bds6KCk0l0LD
        mxUCUEEg30Rz5e0VO57VcEBJ/NV/hR1ljwMhgMNoo6lLbBeOog3VhwjMdhV/EktJ/lqctFGNSM7xM
        hDYm5eeYQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hqdE6-0002T5-Ad; Thu, 25 Jul 2019 12:52:06 +0000
Date:   Thu, 25 Jul 2019 05:52:06 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Sudipto Paul <Sudipto.Paul@arm.com>,
        "Andrew F . Davis" <afd@ti.com>,
        Xu YiPing <xuyiping@hisilicon.com>,
        "Chenfeng (puck)" <puck.chen@hisilicon.com>,
        butao <butao@hisilicon.com>,
        "Xiaqing (A)" <saberlily.xia@hisilicon.com>,
        Yudongbin <yudongbin@hisilicon.com>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v6 4/5] dma-buf: heaps: Add CMA heap to dmabuf heaps
Message-ID: <20190725125206.GE20286@infradead.org>
References: <20190624194908.121273-1-john.stultz@linaro.org>
 <20190624194908.121273-5-john.stultz@linaro.org>
 <20190718100840.GB19666@infradead.org>
 <CALAqxLWLx_tHVjZqrSNWfQ_M2RGGqh4qth3hi9GGRdSPov-gcw@mail.gmail.com>
 <20190724065958.GC16225@infradead.org>
 <CALAqxLUbsz+paJ=P2hwKecuN8DQjJt9Vj4MENCnFuEh6waxsXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALAqxLUbsz+paJ=P2hwKecuN8DQjJt9Vj4MENCnFuEh6waxsXg@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 11:46:24AM -0700, John Stultz wrote:
> I'm still not understanding how this would work. Benjamin and Laura
> already commented on this point, but for a simple example, with the
> HiKey boards, the DRM driver requires contiguous memory for the
> framebuffer, but the GPU can handle non-contiguous. Thus the target
> framebuffers that we pass to the display has to be CMA allocated, but
> all the other graphics buffers that the GPU will render to and
> composite can be system.

But that just means we need a flag that memory needs to be contiguous,
which totally makes sense at the API level.  But CMA is not the only
source of contigous memory, so we should not conflate the two.

> Laura already touched on this, but similar logic can be used for
> camera buffers, which can make sure we allocate from a specifically
> reserved CMA region that is only used for the camera so we can always
> be sure to have N free buffers immediately to capture with, etc.

And for that we already have per-device CMA areas hanging off struct
device, which this should reuse instead of adding another duplicate
CMA area lookup scheme.
