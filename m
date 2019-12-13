Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86DB2C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 00:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 583BC2173E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 00:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O/yuRss+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731714AbfLMALJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 19:11:09 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35249 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731574AbfLMAH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 19:07:59 -0500
Received: by mail-pf1-f194.google.com with SMTP id b19so397423pfo.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 16:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=TS0VnFP4wmXpcgCTt3VYjH+yAnIJ0NLMtHmpsTJa70s=;
        b=O/yuRss+BmZ0/IH2KRo97L+6BZmXdi3DpHxPfoVh2jQ3ueWoHUSRG7f/nZ2tXcFePX
         t7hVQ2MzfV2M9LIiTlTZSck/vK4+qW4P2UYOjnYJiKW+flXb/33cDmhArQ5csCgbhZ2q
         8Hv6DdbCeZnPRoQOp23dWt9nsaZFojFhLZscMYxiPvVzc6UJxWiOxmqkdd0AeYxBZrde
         XcI/dd/wvFdLDrxBKyLOCY+eDBr4ctN//dre2jP+c4Q1RQV8FXJJrK02IJxHtmj7eq1c
         uel8zAyvN2cBnlPr27m7WKBd/j0A4xvfIDapzLqaQouB8RkJIQgE7Podaj9OjV8c3gFl
         tOEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=TS0VnFP4wmXpcgCTt3VYjH+yAnIJ0NLMtHmpsTJa70s=;
        b=kWzE3thOqzSoDfxExGsYCGEENZ6WZ8B+c7FWD5oFLI9igCPB991J2cmqBI1JGEDRZe
         zQtKCYQQXP9iTkfG0PpJJmFpbRPif4uTvD1M+Mp/j2jrh9UTxPwnD8qEOMG8nvHCvCya
         F5dW0/plXMQO+w08msZM1VG0LOrrnS4E0QyWE7/Y8TPdCqtdy8mQWJ0n6aURZaAGAFRL
         7n9/Gorpbn+7SrYNyuo7Qbg7tLt0AjwHrS/XzVSVVLckPkYnHWBl2HTjesr+Fw4EeyVw
         6Sa2q7NfNYn3fEXHOZfFbeaAqgSADTwbPtN73MlHkzUSR7/kGB6+bAT3VTwqmBSjZgv4
         Lhjg==
X-Gm-Message-State: APjAAAXxKHyr+1jME0ZSZfdV91snUIMUPQrmiTkMjwc5rGe7irkXtFPx
        51YQWVYsH01V1I/avyuAGBPNfNUca+I=
X-Google-Smtp-Source: APXvYqx/i0ywI7DTLrKi/bBPr/aFnvWO3tdi/Z2760zPqzRzVEImTZT+GZuvpFTW34rG0LzAjoEd6Q==
X-Received: by 2002:a62:7986:: with SMTP id u128mr13463087pfc.192.1576195678234;
        Thu, 12 Dec 2019 16:07:58 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id g8sm8537407pfh.43.2019.12.12.16.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 16:07:56 -0800 (PST)
Date:   Thu, 12 Dec 2019 16:07:56 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Christoph Hellwig <hch@lst.de>
cc:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        "Singh, Brijesh" <brijesh.singh@amd.com>,
        Ming Lei <ming.lei@redhat.com>,
        Peter Gonda <pgonda@google.com>,
        Jianxiong Gao <jxgao@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: Re: [bug] __blk_mq_run_hw_queue suspicious rcu usage
In-Reply-To: <20191128064056.GA19822@lst.de>
Message-ID: <alpine.DEB.2.21.1912121550230.148507@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1909041434580.160038@chino.kir.corp.google.com> <20190905060627.GA1753@lst.de> <alpine.DEB.2.21.1909051534050.245316@chino.kir.corp.google.com> <alpine.DEB.2.21.1909161641320.9200@chino.kir.corp.google.com>
 <alpine.DEB.2.21.1909171121300.151243@chino.kir.corp.google.com> <1d74607e-37f7-56ca-aba3-5a3bd7a68561@amd.com> <20190918132242.GA16133@lst.de> <alpine.DEB.2.21.1911271359000.135363@chino.kir.corp.google.com> <20191128064056.GA19822@lst.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Nov 2019, Christoph Hellwig wrote:

> > So we're left with making dma_pool_alloc(GFP_ATOMIC) actually be atomic 
> > even when the DMA needs to be unencrypted for SEV.  Christoph's suggestion 
> > was to wire up dmapool in kernel/dma/remap.c for this.  Is that necessary 
> > to be done for all devices that need to do dma_pool_alloc(GFP_ATOMIC) or 
> > can we do it within the DMA API itself so it's transparent to the driver?
> 
> It needs to be transparent to the driver.  Lots of drivers use GFP_ATOMIC
> dma allocations, and all of them are broken on SEV setups currently.
> 

Not my area, so bear with me.

Since all DMA must be unencrypted in this case, what happens if all 
dma_direct_alloc_pages() calls go through the DMA pool in 
kernel/dma/remap.c when force_dma_unencrypted(dev) == true since 
__PAGE_ENC is cleared for these ptes?  (Ignoring for a moment that this 
special pool should likely be a separate dma pool.)

I assume a general depletion of that atomic pool so 
DEFAULT_DMA_COHERENT_POOL_SIZE becomes insufficient.  I'm not sure what 
size any DMA pool wired up for this specific purpose would need to be 
sized at, so I assume dynamic resizing is required.

It shouldn't be *that* difficult to supplement kernel/dma/remap.c with the 
ability to do background expansion of the atomic pool when nearing its 
capacity for this purpose?  I imagine that if we just can't allocate pages 
within the DMA mask that it's the only blocker to dynamic expansion and we 
don't oom kill for lowmem.  But perhaps vm.lowmem_reserve_ratio is good 
enough protection?

Beyond that, I'm not sure what sizing would be appropriate if this is to 
be a generic solution in the DMA API for all devices that may require 
unecrypted memory.
