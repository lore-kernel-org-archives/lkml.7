Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F388EC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 12:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2490217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 12:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tBE4Mbdj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389281AbfGYMuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 08:50:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42088 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389217AbfGYMuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 08:50:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sCZEIVmVGag1Egj1E+yjyGvhHi5tCLTiY1ZkJsuHwvg=; b=tBE4MbdjsLwKSWHwdDkl8lvuY
        tAV5UcM6qphIcUwSQ6Khdv9Zq/EZ3oHJE9NET/SGaC+MDSuNoaSt6dM2Ye2A9fAJ4YgluQdLcBG3A
        xq56UM26WYZaH9sW9w350wSbtwvPthQ6ZA6xBFEobEMzHmnKhpb80Xr+++7NGfPTEKxwuE55l/g5C
        CamGc8MssEw5/YxIQvh2/GrQsDOQk3pqfnSo1vZ0cWFM1fzk6JmExZpCcjClGowpLZ+DtlUUTWvXY
        dt8IhP29tBwk91T3dpey/JmJ5Remdd9VUUCZHwb2/N8gVCk7f2UWYSL2Hu6M3BZ8gQ66MsQpPRYEk
        V9CeIx+9g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hqdCI-000294-6E; Thu, 25 Jul 2019 12:50:14 +0000
Date:   Thu, 25 Jul 2019 05:50:14 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Andrew F. Davis" <afd@ti.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Sudipto Paul <Sudipto.Paul@arm.com>,
        Xu YiPing <xuyiping@hisilicon.com>,
        "Chenfeng (puck)" <puck.chen@hisilicon.com>,
        butao <butao@hisilicon.com>,
        "Xiaqing (A)" <saberlily.xia@hisilicon.com>,
        Yudongbin <yudongbin@hisilicon.com>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v6 4/5] dma-buf: heaps: Add CMA heap to dmabuf heaps
Message-ID: <20190725125014.GD20286@infradead.org>
References: <20190624194908.121273-1-john.stultz@linaro.org>
 <20190624194908.121273-5-john.stultz@linaro.org>
 <20190718100840.GB19666@infradead.org>
 <CALAqxLWLx_tHVjZqrSNWfQ_M2RGGqh4qth3hi9GGRdSPov-gcw@mail.gmail.com>
 <20190724065958.GC16225@infradead.org>
 <8e6f8e4f-20fc-1f1f-2228-f4fd7c7c5c1f@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e6f8e4f-20fc-1f1f-2228-f4fd7c7c5c1f@ti.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 11:46:01AM -0400, Andrew F. Davis wrote:
> https://patchwork.kernel.org/patch/10863957/
> 
> It's actually a more simple heap type IMHO, but the logic inside is
> incompatible with the system/CMA heaps, if you move any of their code
> into the core framework then this heap stops working. Leading to out of
> tree hacks on the core to get it back functional. I see the same for the
> "complex" heaps with ION.

Well, this mostly is just another allocator (gen_pool).  And given that
the whole dma-buf infrastucture assumes things are backed by pages we
really shouldn't need much more than an alloc and a free callback (and
maybe the pgprot to map it) and handle the rest in common code.
