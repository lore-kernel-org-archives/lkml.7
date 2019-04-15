Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F87C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 05:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8FDF2073F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 05:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XHeHfHSb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbfDOFt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 01:49:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43452 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbfDOFt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 01:49:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=a1VJTNMW3pQia6PT6i5I9qegHUb/oIDBT98ASKlNgXk=; b=XHeHfHSb09meeOs4O20Ylr+p9
        /djbd/DxJggfJ7/Hf/+bIMB6fvxaFV2wJHlo8fptNIpvkFu8V0FBT64sBydLyZpnj1CHWGbRoVJHL
        RIORrDN2s0zvuCBy2VLwKnjYrteoYUMyAQbH0PMVaf0b2zd+gDAcjbEga5dmGVTRWqKvDXf9pYGi1
        b5etWdvDMlmTLh+xkw2rfm7zZ7OnP1uPomlHCKmw3rB4o6iLjEBq/1oHdDfiX3EYpB0m3Wf9w0PJk
        ZFS0Zpbp/aD8ErQJm+x3O2ZfNzCx+yIVWVyOESWov8jNz4J6udFICuPHUgwu4Ta9btfTg70Czrmmy
        HopipSCRg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hFuV3-000149-68; Mon, 15 Apr 2019 05:49:49 +0000
Date:   Sun, 14 Apr 2019 22:49:49 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Anup Patel <Anup.Patel@wdc.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] RISC-V: Add separate asm/encoding.h for spec
 related defines
Message-ID: <20190415054949.GA9279@infradead.org>
References: <20190413153807.116227-1-anup.patel@wdc.com>
 <20190413153807.116227-2-anup.patel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190413153807.116227-2-anup.patel@wdc.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 13, 2019 at 03:38:35PM +0000, Anup Patel wrote:
> It's better to have all RISC-V spec related defines in one place
> so this patch adds separate asm/encoding.h for such defines which
> can be included in assembly as well as C code.

As per the discussion of version 1 on Saturday I disagree with this
move.  There is both a philosophical and a practical reason for that:

 a) in RISC-V CSR access is really nicely split out into a separate
    number space, just accessed through a few special instructions.
    It has no overlap with the rest of instruction encoding
 b) <asm/csr.h> is pulled into just about every file build in the kernel
    though <asm/irqflags.h>, <asm/switch_to.h> and <asm/thread_info.h>

So even if you want to later add a new <asm/encoding.h> for instruction
encoding details later, I'd rather prefer to keep CSR access separate
from it.
