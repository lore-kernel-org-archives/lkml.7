Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4132C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 09:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86CC9218C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 09:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cezOvxZC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbfCOJHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 05:07:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35274 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728667AbfCOJGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 05:06:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XmqefP1Bm/5cDFSiCMOElThZks0xyz9N25l34qq6/CM=; b=cezOvxZCHmY/Ce7l4r7zN+2cR
        W6y+Bq/SUrsZgSetS7fb1kF/yVmCLZo3wIqPBfzQZWI09v4cTbv2NaSPYS75VucxARejk8yk56IIx
        XtT7mxypK1C2gWEGh5rBoOvD1rr3QK/88ZqQdhk1ub4kPT7GGia2PhW9QHkvVdTYu/vVcS1RIeav3
        jMroo9HpHF/eH6b/SMT99ORi1AAgdRfzBsuTtFj7YKSTmL2CZ+1RP4aPDW8+sV0PJyLo1rTQoqN2K
        a3kTT1f7QJHM8gxFGFfNOHZKY3tdK9jITcSRLcrExvv+MMjFNO4NTM62PL6qpxdX/hGc3YhnP8ah9
        fWHfy+XWw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h4ink-0008Ha-DN; Fri, 15 Mar 2019 09:06:52 +0000
Date:   Fri, 15 Mar 2019 02:06:52 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "Andrew F . Davis" <afd@ti.com>, Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [RFC][PATCH 4/5 v2] dma-buf: heaps: Add CMA heap to dmabuf heapss
Message-ID: <20190315090652.GE4470@infradead.org>
References: <1551819273-640-1-git-send-email-john.stultz@linaro.org>
 <1551819273-640-5-git-send-email-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551819273-640-5-git-send-email-john.stultz@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2019 at 12:54:32PM -0800, John Stultz wrote:
> This adds a CMA heap, which allows userspace to allocate
> a dma-buf of contiguous memory out of a CMA region.

With my previous suggestion of DMA API usage you'd get CMA support for
free in the system one instead of all this duplicate code..
