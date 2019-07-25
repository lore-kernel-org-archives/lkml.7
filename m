Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 349EFC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 12:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04B97217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 12:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Q/tA4mT0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389245AbfGYMsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 08:48:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40706 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388497AbfGYMsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 08:48:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=05xwHelLjSHHBuReW+EIr66fHPltEo6bHo2T1pZhDCg=; b=Q/tA4mT0PXt+o9525krpx7Q7B
        zuIKWtu8R3tg8EuI2BRFi4bwQ/bBDfZgR2BOsraAY6TDYT7CQcExzTW7WgqRcRKS0ElmcHclHcxpy
        jHZB2p/o8KKMODwWQdjcxX7n5sQXs5BJfDe3OI7KOd/Z69BRd39yfyhAbPnfE4s7ScMJeuuPP1xe1
        Ijj8fw4A3Gx9s3oLKRbrN7CYJQAdl7lfBfrLgPdzj3WiiY14YAnWy6VGHCEeT0/UFL/ssx+cmQDAr
        QHCahuSme8WRIkn7skl0W0g+F4m7ygHjF4rdrGQJhNGZUgfTKpFJVUbGmXKDj2J6Y+lMrx9HHo05J
        TGNY1nDeA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hqdAS-0000dx-3H; Thu, 25 Jul 2019 12:48:20 +0000
Date:   Thu, 25 Jul 2019 05:48:20 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Laura Abbott <labbott@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
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
Message-ID: <20190725124820.GC20286@infradead.org>
References: <20190624194908.121273-1-john.stultz@linaro.org>
 <20190624194908.121273-5-john.stultz@linaro.org>
 <20190718100840.GB19666@infradead.org>
 <CALAqxLWLx_tHVjZqrSNWfQ_M2RGGqh4qth3hi9GGRdSPov-gcw@mail.gmail.com>
 <20190724065958.GC16225@infradead.org>
 <25353c4f-5389-0352-b34e-78698b35e588@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25353c4f-5389-0352-b34e-78698b35e588@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 07:38:07AM -0400, Laura Abbott wrote:
> It's not just an optimization for Ion though. Ion was designed to
> let the callers choose between system and multiple CMA heaps.

Who cares about ion?  That some out of tree android crap that should
not be relevant for upstream except as an example for how not to design
things..

> On other
> systems there may be multiple CMA regions dedicated to a specific
> purpose or placed at a specific address. The callers need to
> be able to choose exactly whether they want a particular CMA region
> or discontiguous regions.

At least in cma is only used either with the global pool or a per-device
cma pool.  I think if you want to make this new dma-buf API fit in with
the rest with the kernel you follow that model, and pass in a struct
device to select the particular cma area, similar how the DMA allocator
works.
