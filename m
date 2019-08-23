Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8654DC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 14:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 587C022CE3
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 14:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YLE6RsUw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395273AbfHWOcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 10:32:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52346 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731800AbfHWOcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 10:32:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pnn9KaN+pK2kYnyudiesQA+zAvF4RHkMA0EV9YcosOY=; b=YLE6RsUwUaTVFUUoAYJO2a7vZ
        GBu6plbi8Yt1L2RJR9LDEFMgQRupHF1ccqicm/0NnuRU4CPChor2PuizMEMhJb5pwRh73EdlWokkw
        +y2L/L1J0cMOC7T9vw+7cqP8rJsRil0j7eGDvGJuHd874HuO+PA8QRKKNZjwvsC2avF5c/iKffPZp
        ZJQz0O/4S3P6gKrSvp090YNtkarwXctOIcIhHcTgWZH6osEP8JRumMx0PQm/p7J5owqpBtw2zx8DW
        QOkQUl5bBxbY9xXfhM4zVzi9vyU3qMTAqJecDxmemhIQXo/Yj1L6lyJE983/5cSR7rTvw5wZo3Yq1
        mKsVjBZBg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i1Abe-0006MR-Md; Fri, 23 Aug 2019 14:31:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C134B30759B;
        Fri, 23 Aug 2019 16:31:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 05CF4202245C6; Fri, 23 Aug 2019 16:31:55 +0200 (CEST)
Date:   Fri, 23 Aug 2019 16:31:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] x86: remove set_memory_x and set_memory_nx
Message-ID: <20190823143155.GD2332@hirez.programming.kicks-ass.net>
References: <20190813090146.26377-1-hch@lst.de>
 <20190813090146.26377-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813090146.26377-5-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 11:01:44AM +0200, Christoph Hellwig wrote:
> These wrappers don't provide a real benefit over just using
> set_memory_x and set_memory_nx.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/x86/include/asm/set_memory.h  |  2 --
>  arch/x86/kernel/machine_kexec_32.c |  4 ++--
>  arch/x86/mm/init_32.c              |  2 +-
>  arch/x86/mm/pageattr.c             | 16 ----------------
>  4 files changed, 3 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/x86/include/asm/set_memory.h b/arch/x86/include/asm/set_memory.h
> index 899ec9ae7cff..fd549c3ebb17 100644
> --- a/arch/x86/include/asm/set_memory.h
> +++ b/arch/x86/include/asm/set_memory.h
> @@ -75,8 +75,6 @@ int set_pages_array_wb(struct page **pages, int addrinarray);
>  
>  int set_pages_uc(struct page *page, int numpages);
>  int set_pages_wb(struct page *page, int numpages);
> -int set_pages_x(struct page *page, int numpages);
> -int set_pages_nx(struct page *page, int numpages);
>  int set_pages_ro(struct page *page, int numpages);
>  int set_pages_rw(struct page *page, int numpages);

$Subject and patch content don't match up.

Other than that,

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

for all x86 patches.
