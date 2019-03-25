Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D92BDC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAEAF2082C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HHVrHBtL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729450AbfCYO7e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 10:59:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47132 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbfCYO7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 10:59:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uZxxKHsKjW+PswDc9k478yvO7h0IIbEDD16w1VE0qq0=; b=HHVrHBtLew0aieKyFzYt31zbb
        aNkEsjBuOjYqGtQ1k6FUT2LiKmOMIXTlGoEpGx+OJBtaOlR55PxVACuauMHfr0KHtTdrS+BHzjEsS
        rwtupcuTNAYPQzHvfM8xFHibIdRyg7zFLzxydPPqiPzrCyo2SlgJ2Fm4sVP3PbNuigm81tzar8xjh
        HKMxsqbYndjMVr3EomKUKdZAeRfBF3XO9hG2MlmAWO6INHJ3hwbGTEgS8Vd55paXLHaCxPeZRBfoR
        R+3AMoJonNBgPDIHxAlf8kS8B1zFVCu6R9ADZbvjt3Chbk3JRg53/c0SW7Rmod0D+LBdZDUH4mGjR
        N6Nc9bvJA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h8R4J-0005rt-V1; Mon, 25 Mar 2019 14:59:19 +0000
Date:   Mon, 25 Mar 2019 07:59:19 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Anup Patel <anup@brainfault.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Anup Patel <Anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v3 4/4] RISC-V: Allow booting kernel from any 4KB aligned
 address
Message-ID: <20190325145919.GB14826@infradead.org>
References: <20190325092234.5451-1-anup.patel@wdc.com>
 <20190325092234.5451-5-anup.patel@wdc.com>
 <20190325113935.GD27843@infradead.org>
 <CAAhSdy2dds7pp8=XX+zbKbMoWbgjPxP6r4aMZJeHyqHV2MP4CQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhSdy2dds7pp8=XX+zbKbMoWbgjPxP6r4aMZJeHyqHV2MP4CQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 06:18:45PM +0530, Anup Patel wrote:
> We trying to addresses following issues in current code:
> 1. The current setup_vm() maps all possible kernel virtual addresses (128GB
> on 64bit system and 1GB on 32bit system). The amount RAM present on
> real systems might be much less so we should not have kernel mappings for
> non-existent RAM. Of course, we don't know amount of RAM available in
> setup_vm() so we have to split page table setup in two parts and do minimal
> required mapping in setup_vm().

Why do you even care about kernel mappings for non-existant ram.

> 2. NOMMU kernel requires a swapper_pg_dir with identity mapping (VA == PA)

Bullshit.  nommu per defintion does not have page tables, and thus

> 3. For both NOMMU with tiny memory and MMU with tiny memory, the current
> setup_vm() is not allowing us to place kernel on non-2M (or non-4M) aligned
> addressed there by causing memory below kernel to be wasted.

As mentioned a few times - nommu per defintion does not have page
tables, and in my uptodate nommu port none of this code is even compiled
in.  If someone still compiles that code in some codebase that is just
a bug that needs to be fixed.

For MMU with tiny memory is is a theoretical case, but I still haven't
seen a good rationale why we'd care for that case.

> 4. For MMU based kernel, the current setup_vm() is hard-wired for fixed 2M
> mapping size. It will require more changes if we want to do 1G mappings.

And why do we care?  Even if we come up with a good reason for 1G
mappings we'd better find a way to select it at run time and not require
a gazillion of options to select how to map the kernel.
