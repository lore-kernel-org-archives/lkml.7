Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E8DC3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 04:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42C7321848
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 04:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730890AbfHVE1V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 00:27:21 -0400
Received: from verein.lst.de ([213.95.11.211]:43536 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728870AbfHVE1V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 00:27:21 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id ED3C668C4E; Thu, 22 Aug 2019 06:27:17 +0200 (CEST)
Date:   Thu, 22 Aug 2019 06:27:17 +0200
From:   "hch@lst.de" <hch@lst.de>
To:     Atish Patra <Atish.Patra@wdc.com>
Cc:     "hch@lst.de" <hch@lst.de>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "schwab@linux-m68k.org" <schwab@linux-m68k.org>,
        Anup Patel <Anup.Patel@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v3 1/3] RISC-V: Issue a local tlbflush if possible.
Message-ID: <20190822042717.GA14076@lst.de>
References: <20190822004644.25829-1-atish.patra@wdc.com> <20190822004644.25829-2-atish.patra@wdc.com> <20190822014642.GA11922@lst.de> <0f66583404f89ab2bd6c264ba653364ab8a3160e.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f66583404f89ab2bd6c264ba653364ab8a3160e.camel@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 04:01:24AM +0000, Atish Patra wrote:
> The downside of this is that for every !cmask case in true SMP (more
> common probably) it will execute 2 extra cpumask instructions. As
> tlbflush path is in performance critical path, I think we should favor
> more common case (SMP with more than 1 core).

Actually, looking at both the current mainline code, and the code from my
cleanups tree I don't think remote_sfence_vma / __sbi_tlb_flush_range
can ever be called with  NULL cpumask, as we always have a valid mm.

So this is a bit of a moot point, and we can drop andling that case
entirely.  With that we can also use a simple if / else for the local
cpu only vs remote case.  Btw, what was the reason you didn't like
using cpumask_any_but like x86, which should be more efficient than
cpumask_test_cpu + hweigt?
