Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C89ECE58C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 15:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9F4521721
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 15:39:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XngeCDSo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbfJHPj3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 11:39:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56454 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfJHPj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 11:39:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XrQwPYJ9ZxtAK55jxj1ROP1SF0zdgUGUTqfiib/SpJ4=; b=XngeCDSoSquz9UNqpG9IqIOMw
        g80aeCv7meKmzZllrXkgxMG8xhyW4i6s6xhdFF5J1SUC9dZwcUhhu/HZPFY4HE9uiLNjM1iBjYXTg
        H25tJ/QNXPfPF2ssYk9zIRNZc3AnsoavpXdPsDxzSvXptuLXDXoje/hE43+NzjaQWBqM4QME4MA6R
        YAE1ejYqKB6XjbW7lc2fajOWbkoYopdPt6NZkpVYqfXwbt39RXYpVQteWSf2JwfuUnUL8Dlx2StbR
        mKezoiwSvka2UkCMWyziw4eSGlLtFIr/m5hoWcXcWU3LNJ4RibDOeoiPcnpXNbMjYgPpTKpIxkH4p
        AjusAdTUA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHra8-0005PO-Co; Tue, 08 Oct 2019 15:39:24 +0000
Date:   Tue, 8 Oct 2019 08:39:24 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Anup Patel <anup@brainfault.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alan Kao <alankao@andestech.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Atish Patra <atish.patra@wdc.com>, Gary Guo <gary@garyguo.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>
Subject: Re: [PATCH v2 3/3] RISC-V: Move SBI related macros under uapi.
Message-ID: <20191008153924.GA20318@infradead.org>
References: <20190927000915.31781-1-atish.patra@wdc.com>
 <20190927000915.31781-4-atish.patra@wdc.com>
 <20190927222107.GC4700@infradead.org>
 <CAAhSdy2kAze4bt17kVA3tB4H6qXPMSUroi5ybPcTvFB_=p48oQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhSdy2kAze4bt17kVA3tB4H6qXPMSUroi5ybPcTvFB_=p48oQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2019 at 11:00:05AM +0530, Anup Patel wrote:
> These defines are indeed part of KVM userspace API because we will
> be forwarding SBI calls not handled by KVM RISC-V kernel module to
> KVM userspace (QEMU/KVMTOOL). The forwarded SBI call details
> are passed to userspace via "struct kvm_run" of KVM_RUN ioctl.

At best your are passing through a hardware interface.  We don't expose
e.g. the nvme headers to userspace either.  We keep the headers clean
enough that userspace can copy them (and a few projects do), but they
really are not a kernel interface in any classic way.
