Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9310CC433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 12:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62F9F2086D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 12:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565007200;
	bh=arDSwSwx9DPKLDnb31ij2wSMJ0HnKhWIs23mlSMx7O8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QecqU8ofOKt6oiLzt8fYICNP1CpxuvGMCRYIJ0SC+PNbUVM/0vFlcjcP+BD8W44TP
	 SPGjFffvxbZW7V5IhaSP7kk8n3i7tV4nCQk7ca8+pO7xBRRAN6TGvQPYvMeae6QmjF
	 jlIBsZUi7Wi6OuhNoM8V0q7j1/4EUGsUI+03VO2w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbfHEMNT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 08:13:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:44478 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727349AbfHEMNS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 08:13:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 86CCFB63C;
        Mon,  5 Aug 2019 12:13:17 +0000 (UTC)
Date:   Mon, 5 Aug 2019 14:13:14 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Is it safe to kmalloc a large size of memory in interrupt
 handler?
Message-ID: <20190805121314.GN7597@dhcp22.suse.cz>
References: <CABXRUiSuZc+W7884ek9YifKdx1eiJ_pmyRM42KK0ZhSK9xTkFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABXRUiSuZc+W7884ek9YifKdx1eiJ_pmyRM42KK0ZhSK9xTkFw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 05-08-19 19:57:54, Fuqian Huang wrote:
> In the implementation of kmalloc.
> when the allocated size is larger than KMALLOC_MAX_CACHE_SIZE,
> it will call kmalloc_large to allocate the memory.
> kmalloc_large ->
> kmalloc_order_trace->kmalloc_order->alloc_pages->alloc_pages_current->alloc_pages_nodemask->get_page_from_freelist->node_reclaim->__node_reclaim->shrink_node->shrink_node_memcg->get_scan_count

You shouldn't really get there when using GFP_NOWAIT/GFP_ATOMIC.

> get_scan_count will call spin_unlock_irq which enables local interrupt.
> As the local interrupt should be disabled in the interrupt handler.
> It is safe to use kmalloc to allocate a large size of memory in
> interrupt handler?

It will work very unreliably because larger physically contiguous memory
is not generally available without doing compaction after a longer
runtime. In general I would recommend to use pre allocated buffers or
defer the actual handling to a less restricted context if possible.

-- 
Michal Hocko
SUSE Labs
