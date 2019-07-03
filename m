Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC75C5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 23:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C3C42187F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 23:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KPX2+IgE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbfGCXFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 19:05:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52934 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727126AbfGCXFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 19:05:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=coQkLMKjijH/VoIpxmOMP2Tv/LPuLRus1VVk2ZdcuYw=; b=KPX2+IgE9oLBkxEZGniqI9YQMo
        mw6FFpY9KWKcv4FzevrbTQ45j68jdRQ5UGoOJwM/T1SPIIzZdFBMKTkQdsfkOogzKTgoPNmlohLad
        zKp6L+/7pNwKzUdV89O6XZPe00o0YW54GW9U4dBa7c9AzAFLYocnl4omSM+0HXVmPefqy3spN7aS6
        MVJCO+zt54oYwh9xoU2sa3klxyJ7Le7AxOl8rt9HyEidxW2pR5dza6c6Q3vVTdVNwAQAQzFS7cAnW
        cHAAF2n0qYNKkwlEhMnESD6M/avAlaHyppZRCf9y5DbJuyJoL2fIPJYo+Xqp2ScJuCjlgFne75Smi
        1vV564DQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hioJA-0001Ff-16; Wed, 03 Jul 2019 23:05:00 +0000
Date:   Wed, 3 Jul 2019 16:04:59 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Hanjun Guo <guohanjun@huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 0/2] Hugetlbfs support for riscv
Message-ID: <20190703230459.GA26830@infradead.org>
References: <20190701175900.4034-1-alex@ghiti.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190701175900.4034-1-alex@ghiti.fr>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 01, 2019 at 01:58:58PM -0400, Alexandre Ghiti wrote:
>   - icache-hygiene succeeds after patch #3 of this series which lowers           
>     the base address of mmap.                                                    

I think іcache-hygiene will also need a call to riscv_flush_icache in
cacheflush().

