Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E98C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 14:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1905206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 14:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JIoZosSH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729969AbfH0OqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 10:46:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50338 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfH0OqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 10:46:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DUDQG5TZbypFhWn8SYXtr7ARPttxIZNVZZiOPmrz2p0=; b=JIoZosSHZEWfdznPJN54SIYlA
        YnujNP9yY/TnsrEm+xtKejudybZQdzbILANco4KcQkpGzlDOAj0ng23H4hHxSly8X1gQApR3ndOHl
        n0kLcbfcclAWk5ZPMkKhnGXrmW/Nvsf394t+nGYpvQODxCqABy28HqBZvSTeJLVGzbX1uelp9mhQE
        pl3MYlGo/wVE+sOXN0JviQy8UYiZMxwFpnnmL/fR0vi0LNwxkwds2SB0x6wDE3S7aqdZBU8aFTTQ9
        VMdR12kGq0eAT2u7t/iwxg1ETMeoK3RwchFcyjy0Ap+Bj5qzvqmIoyXnuLmQNQT0zcPW4QaMn7cpQ
        NxzZQbPxg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i2cjo-0006Sj-Fw; Tue, 27 Aug 2019 14:46:24 +0000
Date:   Tue, 27 Aug 2019 07:46:24 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Alan Kao <alankao@andestech.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Gary Guo <gary@garyguo.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-riscv@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH 0/2] Add support for SBI version to 0.2
Message-ID: <20190827144624.GA18535@infradead.org>
References: <20190826233256.32383-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826233256.32383-1-atish.patra@wdc.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2019 at 04:32:54PM -0700, Atish Patra wrote:
> This patch series aims to add support for SBI specification version
> v0.2. It doesn't break compatibility with any v0.1 implementation.
> Internally, all the v0.1 calls are just renamed to legacy to be in
> sync with specification [1].
> 
> The patches for v0.2 support in OpenSBI are available at
> http://lists.infradead.org/pipermail/opensbi/2019-August/000422.html
> 
> [1] https://github.com/riscv/riscv-sbi-doc/blob/master/riscv-sbi.adoc

I really don't like the current design of that SBI 0.2 spec,
and don't think implementing it as-is is helpful.

For one the way how the extension id is placed creates a compatibilty
problem, not allowing your to implement a backwards compatible sbi,
which seems bad.

Second just blindly moving all the existing calls to a single legacy
extension doesn't seem useful.  We need to differenciate the existing
calls:

 (1) actually board specific and have not place in a cpu abstraction
     layer: getchar/putchar, these should just never be advertised in a
      non-legacy setup, and the drivers using them should not probe
      on a sbi 0.2+ system
 (2) useful for currently taped out cpus and in the long run for
     virtualization to avoid mmio traps:  ipis, timers, tlb shootdown.
     These should stay backwards compatible, but for sbi 0.2 be
     negotiated individually
 (3) in theory useful, but given how much of a big hammer sfence.i
     not useful in theory: SBI_REMOTE_FENCE_I we can decide if we want
     to either not allow it for sbi 0.2+ or also negotiate it.  I'd
     personally favor not advertising it and just use ipis to implement
     it.  If we want useful acceleration of i-cache synchronization
     we'll need actual instructions that are much more fine grained
     in the future.
