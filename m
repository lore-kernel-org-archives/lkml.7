Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E61CC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 17:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74B0A20663
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 17:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CpEkLX+H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfHLRzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 13:55:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40612 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbfHLRzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 13:55:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=A5xx+suP+i+wlxI3r0bZSwnQIwSxHDhSzDl/aVQqy44=; b=CpEkLX+HQLoCnKFPMleBcK4Xn
        mKlxeuVobdx5mF93JGhdufQwe0ywW5R1UusFok0w7dl5HYo1L/cJTtUn4YJOv6otPtNKfHoYA8ZEX
        JgsCd3Dxb2/wjkhI7M8k4+OD2O+Z0NdVgAS/pPUqHtPLcsE525zZIYd9evXf7tZGSL3jlQC1f19Qj
        26PeCW5S5Lo0FSCBAcWW0VctU4NPXPIg10lpE58scG80bmsk8FUnjBEoJZHG6OhidYhtvvcX1U+1a
        xmqES2hTCBjiokk8omo7hEaBoMvubeW+zV+HFbr5T1/aCpZFbRMRlfyfAuwYBXxwrCQ9CkTtorvm0
        AZZo0oyPw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hxEXl-000108-99; Mon, 12 Aug 2019 17:55:41 +0000
Date:   Mon, 12 Aug 2019 10:55:41 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Troy Benjegerdes <troy.benjegerdes@sifive.com>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Anup Patel <anup.patel@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org,
        Allison Randal <allison@lohutok.net>,
        ron minnich <rminnich@gmail.com>
Subject: Re: [PATCH] RISC-V: Issue a local tlb flush if possible.
Message-ID: <20190812175541.GA23733@infradead.org>
References: <20190810014309.20838-1-atish.patra@wdc.com>
 <118B0DE7-EDCC-4947-88E5-7FF133A757D8@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <118B0DE7-EDCC-4947-88E5-7FF133A757D8@sifive.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 10:36:25AM -0500, Troy Benjegerdes wrote:
> Is there anything other than convention and current usage that prevents
> the kernel from natively handling TLB flushes without ever making the SBI
> call?

Yes and no.

In all existing RISC-V implementation remote TLB flushes are simply
implementing using IPIs.  So you could trivially implement remote TLB
flush using IPIs, and in fact Gary Guo posted a series to do that a
while ago.

But: the RISC privileged spec requires that IPIs are only issued from
M-mode and only delivered to M-mode.  So what would be a trivial MMIO
write plus interupt to wakeup the remote hart actually turns into
a dance requiring multiple context switches between privile levels,
and without additional optimizations that will be even slower than the
current SBI based implementation.

I've started a prototype implementation and spec edits to relax this
and allow direct IPIs from S-mode to S-mode, which will speed up IPIs
by about an order of magnitude, and I hope this will be how future
RISC-V implementations work.

> Someone is eventually going to want to run the linux kernel in machine mode,
> likely for performance and/or security reasons, and this will require flushing TLBs
> natively anyway.

The nommu ports run in M-mode.  But running a MMU-enabled port in M-mode
is rather painful if not impossible (trust me, I've tried) due to how
the privileged spec says that M-mode generally runs without address
translation.  There is a workaround using the MPRV bit in mstatus, but
even that just uses the address translation for loads and stores, and
not for the program text.
