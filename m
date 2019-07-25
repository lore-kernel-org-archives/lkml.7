Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E8F2C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 472DB22BF5
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rSl543HC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbfGYOdh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 10:33:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48110 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728721AbfGYOdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 10:33:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FZTjzooOQfdeIEKO6c7B0Q4Q39gStipSBPssv7rm1tw=; b=rSl543HC94I1WsxY4q6FwLykM
        uOt0SEphra34W1vaXTw3cZj8K11hmmQm3EOjFcHVE0km8+dsyHdZcfjUHJJkT3SESQd5HnU5Gv+Kb
        EgF31ARnFL3BQj1MBaJN59M5cJsLEqt5UNo2ei0djAiRo9Njkz0V5WzY6AuoRvk8R7nhQLxIRRlfU
        L2JZkVs3KlmswNFZsUwtSA2r6+Mqgo4+B9CWjJP+LN62CiR8dGT6wB7Z9ck5gKdSgX7wmQSta54AG
        8CWAptGhRQb0mfSCmnwGGe1jFrbSY/GlKRccFxKYAM6LczHExn5FrNaFPlc9aenfYk339k/PjJvBB
        9TScD2FzA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hqeoJ-0007gg-VX; Thu, 25 Jul 2019 14:33:35 +0000
Date:   Thu, 25 Jul 2019 07:33:35 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
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
Message-ID: <20190725143335.GB21894@infradead.org>
References: <20190624194908.121273-1-john.stultz@linaro.org>
 <20190624194908.121273-5-john.stultz@linaro.org>
 <20190718100840.GB19666@infradead.org>
 <CALAqxLWLx_tHVjZqrSNWfQ_M2RGGqh4qth3hi9GGRdSPov-gcw@mail.gmail.com>
 <20190724065958.GC16225@infradead.org>
 <CALAqxLUbsz+paJ=P2hwKecuN8DQjJt9Vj4MENCnFuEh6waxsXg@mail.gmail.com>
 <20190725125206.GE20286@infradead.org>
 <CA+M3ks52ADKVCw_pZP9=LSNt+vhiEFyrtB-Jm2x=p62kSV7qVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+M3ks52ADKVCw_pZP9=LSNt+vhiEFyrtB-Jm2x=p62kSV7qVA@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 03:20:11PM +0200, Benjamin Gaignard wrote:
> > But that just means we need a flag that memory needs to be contiguous,
> > which totally makes sense at the API level.  But CMA is not the only
> > source of contigous memory, so we should not conflate the two.
> 
> We have one file descriptor per heap to be able to add access control
> on each heap.
> That wasn't possible with ION because the heap was selected given the
> flags in ioctl
> structure and we can't do access control based on that. If we put flag
> to select the
> allocation mechanism (system, CMA, other) in ioctl we come back to ION status.
> For me one allocation mechanism = one heap.

Well, I agree with your split for different fundamentally different
allocators.  But the point is that CMA (at least the system cma area)
fundamentally isn't a different allocator.  The per-device CMA area
still are kinda the same, but you can just have one fd for each
per-device CMA area to make your life simple.
