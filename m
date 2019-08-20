Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FCAC3A5A0
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 03:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63DF722CEC
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 03:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="izmFJBS4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbfHTDGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 23:06:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35162 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728950AbfHTDGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 23:06:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=57X3GzTA6er/rWzLLE+ikSyKId99lgGWLFXTlO3Q1vU=; b=izmFJBS4VHqlxjMsuBdWcP0MD
        8/ROSNjzUDH0Bt/VmxP/PlECeAfBQMrNp5fRxeDjnVZWKOoiumDZyJb/QhsJGygJR65Oh1jw5Y4XF
        X2/KLy18535rZiuVI9jDbX9C9G2L0qW87vEWF7ClpOZVyqepPZNO8e8nZhINp5zVJzsQ/ibyx80t9
        KBYZzQZfUAljid0T6h7GTHKWmv/90Kd82y8LQqcRwTqd4L196oTG2U6OyQPOnv2/VvA69cigUiMqn
        dcGQ3HFRAvnSzde0xTpgy8Z/Yrd3CwdDY0hJ/B92eqAr32kima9TCNtubDsojQ3QXvuDp7kIsI/2o
        D0yowuuDg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hzuTp-0002xI-Pr; Tue, 20 Aug 2019 03:06:41 +0000
Date:   Mon, 19 Aug 2019 20:06:41 -0700
From:   "hch@infradead.org" <hch@infradead.org>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Allison Randal <allison@lohutok.net>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        "hch@infradead.org" <hch@infradead.org>
Subject: Re: [v2 PATCH] RISC-V: Optimize tlb flush path.
Message-ID: <20190820030641.GA24946@infradead.org>
References: <20190820004735.18518-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820004735.18518-1-atish.patra@wdc.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 05:47:35PM -0700, Atish Patra wrote:
> In RISC-V, tlb flush happens via SBI which is expensive.
> If the target cpumask contains a local hartid, some cost
> can be saved by issuing a local tlb flush as we do that
> in OpenSBI anyways. There is also no need of SBI call if
> cpumask is empty.
> 
> Do a local flush first if current cpu is present in cpumask.
> Invoke SBI call only if target cpumask contains any cpus
> other than local cpu.

Btw, you can use up your 70-ish chars per line for commit logs..

> +	if (cpumask_test_cpu(cpuid, cmask)) {
> +		/* Save trap cost by issuing a local tlb flush here */
> +		if ((start == 0 && size == -1) || (size > PAGE_SIZE))
> +			local_flush_tlb_all();
> +		else if (size == PAGE_SIZE)
> +			local_flush_tlb_page(start);
> +	}

This looks a little odd to m and assumes we never pass a size smaller
than PAGE_SIZE.  Whule that is probably true, why not something like:

	if (size < PAGE_SIZE && size != -1)
		local_flush_tlb_page(start);
	else
		local_flush_tlb_all();

?
