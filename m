Return-Path: <SRS0=w4Fx=WO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97343C3A59E
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 18:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D8B52146E
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 18:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UNGECtfw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbfHRSTQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 14:19:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52464 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfHRSTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 14:19:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UZxwsS+sToCSVH9D1qHD3g7wQSdFK43iName/Mf/0gQ=; b=UNGECtfwZ/M/wg7BohzTIdWDx
        ys7a7IjrLjwX75/mJaxwDNI3TZn73eiazi4SiwlEHPJTgOM/+yGAP6BsvkYtqNhpmY3sq3XzpNLqP
        L+HTZJid+x79jiiH11kQPO1yLC8X2DPUDOGsXl+OiZZH3+7wfSjEgX5BkADe/q1tQCt6Jd+dtP5qi
        l8mTLYEnPAhhDlMxXo5huGn7JAoWcVogDlNNypLi5RHpe1S4hmFPbXJF5pnoEKc652NspXA3XCOjB
        hyV1SI4Oyp63a1aHa3guXn9nH7VfpQ6wwnKXYcB7zroyvwZlnacvkK6infzRCfEF16Z1do9bt1I5V
        qlXnAM2mQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hzPlq-0006mQ-4u; Sun, 18 Aug 2019 18:19:14 +0000
Date:   Sun, 18 Aug 2019 11:19:14 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Anup Patel <Anup.Patel@wdc.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup@brainfault.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH] RISC-V: Fix FIXMAP area corruption on RV32 systems
Message-ID: <20190818181914.GB20217@infradead.org>
References: <20190816114915.4648-1-anup.patel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816114915.4648-1-anup.patel@wdc.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +#define FIXADDR_TOP      (VMALLOC_START)

Nit: no need for the braces, the definitions below don't use it
either.

> +#ifdef CONFIG_64BIT
> +#define FIXADDR_SIZE     PMD_SIZE
> +#else
> +#define FIXADDR_SIZE     PGDIR_SIZE
> +#endif
> +#define FIXADDR_START    (FIXADDR_TOP - FIXADDR_SIZE)
> +
>  /*
> - * Task size is 0x4000000000 for RV64 or 0xb800000 for RV32.
> + * Task size is 0x4000000000 for RV64 or 0x9fc00000 for RV32.
>   * Note that PGDIR_SIZE must evenly divide TASK_SIZE.
>   */
>  #ifdef CONFIG_64BIT
>  #define TASK_SIZE (PGDIR_SIZE * PTRS_PER_PGD / 2)
>  #else
> -#define TASK_SIZE VMALLOC_START
> +#define TASK_SIZE FIXADDR_START
>  #endif

Mentioning the addresses is a little weird.  IMHO this would be
a much nicer place to explain the high-level memory layout, including
maybe a little ASCII art.  Also we could have one #ifdef CONFIG_64BIT
for both related values.  Last but not least instead of saying that
something should be dividable it would be nice to have a BUILD_BUG_ON
to enforce it.

Either way we are late in the cycle, so I guess this is ok for now:

Reviewed-by: Christoph Hellwig <hch@lst.de>

But I'd love to see this area improved a little further as it is full
of mine fields.
