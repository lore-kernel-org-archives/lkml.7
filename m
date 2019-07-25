Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 742CEC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47BFD22BF5
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ag0sWRS2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387905AbfGYOLq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 10:11:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34912 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfGYOLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 10:11:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rVU3OdYVB/xxhc+Jxe+Jl0rvuIWAAmVPWnVC1lgwyac=; b=ag0sWRS2Qau6/riWg3p8KEakN
        879W/vBUC7KhSFSuRmVrddLtdB+ukxtpMcsgoDdTk3iHr0s+Xw6ewyntMvp4Eerrw5vUjV2JrKI5+
        BRjfvW0r7QfVyp4L8LfjZMW3yS+muIPpdCptG0YM8vfE7w7c9aPH0JHWs2QzvzBPt9loTWP1nyZ4T
        58pi6b0FzZdPCa8JKojNGEy+/57NctfhMHMuztnzLcUMBqmfvwgUKmcGmX35Dsdb+f980RoRtTDht
        H3JKkAp4EfelUoFFPn6BU18hLE2pz3Igtrej1ytLc6NVvgVgF5Y5yPGrJWBGTUr8c6pWpy1YdaLm2
        LHbtTAczg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hqeTA-0004Hq-RH; Thu, 25 Jul 2019 14:11:44 +0000
Date:   Thu, 25 Jul 2019 07:11:44 -0700
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
Message-ID: <20190725141144.GA14609@infradead.org>
References: <20190624194908.121273-1-john.stultz@linaro.org>
 <20190624194908.121273-5-john.stultz@linaro.org>
 <20190718100840.GB19666@infradead.org>
 <CALAqxLWLx_tHVjZqrSNWfQ_M2RGGqh4qth3hi9GGRdSPov-gcw@mail.gmail.com>
 <20190724065958.GC16225@infradead.org>
 <8e6f8e4f-20fc-1f1f-2228-f4fd7c7c5c1f@ti.com>
 <20190725125014.GD20286@infradead.org>
 <0eae0024-1fdf-bd06-a8ff-1a41f0af3c69@ti.com>
 <20190725140448.GA25010@infradead.org>
 <8e2ec315-5d18-68b2-8cb5-2bfb8a116d1b@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e2ec315-5d18-68b2-8cb5-2bfb8a116d1b@ti.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 10:10:08AM -0400, Andrew F. Davis wrote:
> Pages yes, but not "normal" pages from the kernel managed area.
> page_to_pfn() will return bad values on the pages returned by this
> allocator and so will any of the kernel sync/map functions. Therefor
> those operations cannot be common and need special per-heap handling.

Well, that means this thing is buggy and abuses the scatterlist API
and we can't merge it anyway, so it is irrelevant.
