Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D646AC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DCFB2084F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BsprIxhl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731964AbfDXPBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 11:01:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57724 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbfDXPBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 11:01:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mIRASWJa8Jet8aFXz4+sIo0on+CEHG8MbfZJum+vzcc=; b=BsprIxhlCXAV5M+6uLJ2ugLUb
        KKBpGhT8ANS43pxXNPOIZRp0hPZdQ0v1Rfzet9CJtUO0o2aPPvhwnPuYzMlb4uzlUimu+zhVbTqGg
        BseMJHnj4q9VnGOMolVuURiW2Ti63rkEERSjhvtrVr5yuIKQVnltSp+Z+KVfm8JV4rVOlzDvlWocz
        HS0SRe52IAhMVwpDqJ7z2nIhg4pistEftXuKhL6eF30J93aRy2MS1rpWG1ujO8Sk/+EZqGrJcPoUw
        i7b5b+XCkcqSQ1JyZUIU+i2rI8WpzFKw6N8FPMbh3RfMGyZb0HdQ0cA4DStTuIKTdeGWwVqOfclak
        +AOiJQk4A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJJOy-0006Ho-3x; Wed, 24 Apr 2019 15:01:36 +0000
Date:   Wed, 24 Apr 2019 08:01:35 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Anup Patel <anup@brainfault.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v3 2/3] RISC-V: Add interrupt related SCAUSE defines in
 asm/csr.h
Message-ID: <20190424150135.GA19543@infradead.org>
References: <20190415093648.7525-1-anup.patel@wdc.com>
 <20190415093648.7525-3-anup.patel@wdc.com>
 <20190424062947.GB10400@infradead.org>
 <CAAhSdy1Xc9AjPKY0RzLL_qsBs6wax23fi2BTVtMhuS0mAoKZmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhSdy1Xc9AjPKY0RzLL_qsBs6wax23fi2BTVtMhuS0mAoKZmQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 12:15:45PM +0530, Anup Patel wrote:
> We need these defines for programming HIDELEG CSR in KVM kernel module
> so it will be used at multiple places.
> 
> >
> > http://git.infradead.org/users/hch/misc.git/commitdiff/1221f5c32345ebe7ea2c1cd6e8a01ad4b422aaba
> 
> You can certainly use these defines in your nommu commit by using
> "#ifdef CONFIG_M_MODE" in switch case of do_IRQ().

Or just keep them in the current format even when you move them, as
that allows everything to work with a single ifdef at their point
of declaration..
