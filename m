Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB41C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 14:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F89A20679
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 14:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vCianp2j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbfHLO4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 10:56:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57304 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726831AbfHLO4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 10:56:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=J7eOk4wkvl1ZRHOqJ/6BItrpvzWshj+n4R5L+gfBXQc=; b=vCianp2jMfu2wigM8bEhV1sSx
        +7uMHMOupRKqQ2TXmJ7ZXiZU+ZrN5Gn8ULUshK26A44BuxVQzaf51pPTMXqgdW3pPK2gz3U0h/h/z
        g65Xg+s7rxkPHWAg4+T4azezNwWPPz7qWGgJEx4OhvZJPis/nMt5qkR/BeW6Mjv0+2Oj1LmbznMqP
        7Wnqb4DcoZhF0lLGZfGw0Paxid9kyuJwpMnxibVwc0I1D02gTdbQWkHigRBNcaaR2UKQ8FQaU30bL
        n8fPd7VBTNONWW9xtGPGuInnPPWe8HVvOMV1Et1E+g0IR8HfUaFZEGPA8+0XXnySul9uUWlsUObyg
        7+XwURRNA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hxBkN-0003Jt-5S; Mon, 12 Aug 2019 14:56:31 +0000
Date:   Mon, 12 Aug 2019 07:56:31 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Anup Patel <anup.patel@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org,
        Allison Randal <allison@lohutok.net>
Subject: Re: [PATCH] RISC-V: Issue a local tlb flush if possible.
Message-ID: <20190812145631.GC26897@infradead.org>
References: <20190810014309.20838-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190810014309.20838-1-atish.patra@wdc.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I agree with the comment that we really should move this out of line
now, and also that we can simplify it further, which also includes
not bothering with the SBI call if we were the only online CPU.
I also thing we need to use get_cpu/put_cpu to be preemption safe.

Also why would we need to do a local flush if we have a mask that
doesn't include the local CPU?

How about something like:

void __riscv_flush_tlb(struct cpumask *cpumask, unsigned long start,
		unsigned long size)
{
	unsigned int cpu;

	if (!cpumask)
		cpumask = cpu_online_mask;

	cpu = get_cpu();
	if (!cpumask || cpumask_test_cpu(cpu, cpumask) {
		if ((start == 0 && size == -1) || size > PAGE_SIZE)
			local_flush_tlb_all();
		else if (size == PAGE_SIZE)
			local_flush_tlb_page(start);
		cpumask_clear_cpu(cpuid, cpumask);
	}

	if (!cpumask_empty(cpumask)) {
	  	struct cpumask hmask;

		riscv_cpuid_to_hartid_mask(cpumask, &hmask);
		sbi_remote_sfence_vma(hmask.bits, start, size);
	}
	put_cpu();
}
