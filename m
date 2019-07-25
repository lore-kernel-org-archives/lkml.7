Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 281B0C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F074E217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:05:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kvjs2WCz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbfGYOFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 10:05:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58450 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727681AbfGYOFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 10:05:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7+BaHSDvnuGwzorwA9PLsy47qF1uCR3WQcWR5zaTyNI=; b=kvjs2WCzSpxEm2zESW5YD+q0F
        CzKdE4yll5H3tpmhimv/8k1nTYfzoVJP8soDoM4DAL36nupKFBWWrEewd7t11jUT0YMhWq2/aTJoX
        obnXnQwwH9EGlB+sWNvRe31oMTImiEwVwW8M268jpyJzBicEXfGpxW+Hr96INfzfvaYqC+rbfeMrm
        lYVMqhMqijRYk7Kn9rwwBmIIS3lcyluwgWGiSErEMsmGrp7zqBpbYeIMzw1JPMzgmuEopyugsHcxw
        CnQ3Nh5GjF2K34II3Mck1qgywCMzWAbcgPfVRLVNuJZmU1NQch+lWcSat79lr7FQug1USD4VYaRjg
        +g4GE+bqQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hqeNQ-0000v9-21; Thu, 25 Jul 2019 14:05:48 +0000
Date:   Thu, 25 Jul 2019 07:05:48 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Andrew F. Davis" <afd@ti.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Laura Abbott <labbott@redhat.com>,
        John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
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
Message-ID: <20190725140548.GB25010@infradead.org>
References: <20190624194908.121273-1-john.stultz@linaro.org>
 <20190624194908.121273-5-john.stultz@linaro.org>
 <20190718100840.GB19666@infradead.org>
 <CALAqxLWLx_tHVjZqrSNWfQ_M2RGGqh4qth3hi9GGRdSPov-gcw@mail.gmail.com>
 <20190724065958.GC16225@infradead.org>
 <25353c4f-5389-0352-b34e-78698b35e588@redhat.com>
 <20190725124820.GC20286@infradead.org>
 <18975c1a-7e4e-fab3-eec8-387fbf9dcfe5@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18975c1a-7e4e-fab3-eec8-387fbf9dcfe5@ti.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 09:47:11AM -0400, Andrew F. Davis wrote:
> This is a central allocator, it is not tied to any one device. If we
> knew the one device ahead of time we would just use the existing dma_alloc.
> 
> We might be able to solve some of that with late mapping after all the
> devices attach to the buffer, but even then, which device's CMA area
> would we chose to use from all the attached devices?
> 
> I can agree that allocating from per-device CMA using Heaps doesn't make
> much sense, but for global pools I'm not sure I see any way to allow
> devices to select which pool is right for a specific use. They don't
> have the full use-case information like the application does, the
> selection needs to be made from the application.

Well, the examples we had before was that we clear want to use the
per-device CMA area.  And at least in upstream a CMA area either is
global or attached to a device, as we otherwise wouldn't find it.
