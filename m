Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E20C10F03
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88BF92083D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XqfiRmxw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbfCVNdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 09:33:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38834 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728162AbfCVNdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 09:33:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fP5uIdbxx/wgS3q71bDfcKAiuve42W3kM1/G6wmggA8=; b=XqfiRmxwMYdGLn4GdwrpfcXUK
        NHISslbGIA/820atL2I2BG7G3enYubtqtgjozWVmIxe45Ss1JYi8dkfJct/bbla7kcvNBOt1cjccJ
        5UhdXeGu9b1LdhRi/nshlEOaAjmaTqmamQ4fpvV+Nyu8KWwMwFhAOHFTejAAcOO3BFGDsgkGsqLkp
        WkRBavFvJgVOME0RYTWSB2Yp9RPPrBAIJbUYgv6NNMlnoInjvimXiml+HbitZ7s3BDnmVrlTvaxmm
        cYW8gNcM2g4rzPro3XxODMCTDJMj547TidhY/iWSTxDQUx3FjDIteSGDH722iBYHhvgU1JQ2rmFg/
        CzTRr3J+w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h7KIc-0002q8-QA; Fri, 22 Mar 2019 13:33:30 +0000
Date:   Fri, 22 Mar 2019 06:33:30 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Anup Patel <Anup.Patel@wdc.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v2 4/5] RISC-V: Remove redundant trampoline page table
Message-ID: <20190322133330.GB32464@infradead.org>
References: <20190321094710.16552-1-anup.patel@wdc.com>
 <20190321094710.16552-5-anup.patel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321094710.16552-5-anup.patel@wdc.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  
> -	/* Compute satp for kernel page tables, but don't load it yet */
> +	/* Compute satp for kernel page directory, but don't load it yet */


>  	/*
> -	 * Load trampoline page directory, which will cause us to trap to
> +	 * Load kernel page directory, which will cause us to trap to
>  	 * stvec if VA != PA, or simply fall through if VA == PA
>  	 */

If we want to nitpick comments I think this should take about the
page table root or something like that.

Otherwise the idea looks good, but I really think we should do this
before all the changes to the setup_vm code.
