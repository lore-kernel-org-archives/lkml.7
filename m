Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C79C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 11:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA1E02085A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 11:38:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HRMS1dmR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731010AbfCYLh7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 07:37:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36974 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728563AbfCYLh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 07:37:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HB8KtTyGTKkOG4Yv5CY5a2rJ7KWBvHwNaT0PVghE7+k=; b=HRMS1dmRSwGQHdYqG0PXZnKiE
        CrdyxP9r31gGBXuG/yBrtAOnkEl/IJ9jMMUioZVcXndRsbk3/lNZ00OPU6VxqGkDQXKcn9iPNmOWv
        pgbEDY2GmTJ2p6sjH/x+YLbiECtKWkFInhPnqNlNXwmng9/J36ONfmZFEtdO9sTIHGdXbg4d/jgX0
        4BFiMRCwVzcJcqRLil0pkbExXk9MSHMFIriCWIwEjXIm3L8otkQ+rLUjsoaWiQ1w1jaDVkupWd4Wn
        tgFB6Mjx68sh26pPm30CYOVLrCCsMte0OA1DZUDCxE3uTCJBoWHVcgY7GQ+e6tvmuPiXChLQ2E8kW
        pBRPJDnPA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h8NvI-0000NO-Hc; Mon, 25 Mar 2019 11:37:48 +0000
Date:   Mon, 25 Mar 2019 04:37:48 -0700
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
Subject: Re: [PATCH v3] RISC-V: Always compile mm/init.c with cmodel=medany
 and notrace
Message-ID: <20190325113748.GA27843@infradead.org>
References: <20190325083027.6393-1-anup.patel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325083027.6393-1-anup.patel@wdc.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +ifdef CONFIG_FTRACE
> +CFLAGS_REMOVE_init.o = -pg
> +endif
> +
>  obj-y += init.o
>  obj-y += fault.o
>  obj-y += extable.o
>  obj-y += ioremap.o
>  obj-y += cacheflush.o
> +
> +CFLAGS_init.o := -mcmodel=medany

Can you keep the two flags adjustments togther, preferably towards
the top of the file?

> +/*
> + * The setup_vm() is called from head.S with MMU-off.

s/The //g

Otherwis looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>
