Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C2FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 07:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 292C420811
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 07:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R2NAJSEb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfC0Hyq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 03:54:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55596 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbfC0Hyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 03:54:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DZ9/Ue7HNRbk1aTbbT+Yo5wt9wx5JG/3ryNtYzLGuvg=; b=R2NAJSEbEyHqA2tbnDYpQrPie
        b97a3pqcJL1/0r9in7/Wo4N2lf6SF3zrlISxxsCcfI/BXfLaKa5f38+izY2a3Bu46BOFMzNvluRYA
        CGAJXzCDrr5qtTJDuHCO6EgTlKzDupx0ttE/XMd0vjuRzdWRTNGTJP58uYL3d8cH3tuEt1EevHHvx
        yYz/f/kdkk80dNBqXhqDSieXNbwu1lQAFyDKzPjrnGJ0UubAK8/MeiESSSxZ9U0RdByVpBX6K98vV
        fb7ZaixOABzrLAqk5CXLJ53vPzT943oSHBCUA0zQKP3sVGPPtKU/1Vbn+Kfi8Yvh/vpxA2JsHfb0G
        tE8ZDvNbw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h93OT-0001DD-Fo; Wed, 27 Mar 2019 07:54:41 +0000
Date:   Wed, 27 Mar 2019 00:54:41 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Anup Patel <anup@brainfault.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Atish Patra <Atish.Patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v3 4/4] RISC-V: Allow booting kernel from any 4KB aligned
 address
Message-ID: <20190327075441.GA29894@infradead.org>
References: <20190325092234.5451-1-anup.patel@wdc.com>
 <20190325092234.5451-5-anup.patel@wdc.com>
 <20190325113935.GD27843@infradead.org>
 <CAAhSdy2dds7pp8=XX+zbKbMoWbgjPxP6r4aMZJeHyqHV2MP4CQ@mail.gmail.com>
 <20190325145919.GB14826@infradead.org>
 <CAAhSdy2je-_=AHPawbV-8cUR0P7WvqDZ5wNdEmDVQkR-a88Eog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhSdy2je-_=AHPawbV-8cUR0P7WvqDZ5wNdEmDVQkR-a88Eog@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 09:46:59PM +0530, Anup Patel wrote:
> > Why do you even care about kernel mappings for non-existant ram.
> 
> We care because there will always be some buggy kernel driver/code going
> out-of-bound and accessing non-existent RAM. If we by default map all
> possible kernel virtual address then behaviour of buggy accesses will be
> unpredictable.
> 
> Further, I think we should also make .text and .rodata sections of kernel
> as read-only. This will protect kernel code and rodata.

All of that is useful at the final_setup_vm() time - but none of it
matters during early setup_vm where life is complicated.

Mike suggested on the previous iteration that you only do smaller
mappings when setting up the final mapping to avoid the ops churn,
and I fully agree with him. 

So I would suggest we avoid complicated the fiddly early boot changes
that just add complxity, and you instead redirect your efforts to
say implemented proper ro and non-executable sections using 4k mappings
in the final VM setup only.  That should actuall lead to less code
and complexity, and provide more benefits.
