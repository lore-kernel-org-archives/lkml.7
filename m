Return-Path: <SRS0=w4Fx=WO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA641C3A589
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 18:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B71912146E
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 18:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ElJUEGwh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfHRSQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 14:16:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52124 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfHRSQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 14:16:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wAtvIQm+9fZorihibCedTR8npfvGof1HohdZn5ZFmRA=; b=ElJUEGwhVp3PVLmYwUkCYcqpF
        WPblB8Qo7jtF5ARfK27csiFKD3wil62EUoaYzpbF8l52OD3MM40CMzBso5NiiHjksdp5wGNAGmgvv
        z1oBMqyunuPu4Wxhq1p7xzJfS4euqEfHtLleCqA+VUICayy+O1eG1hoAbFnXzUgyDsyQ29VHrFwhq
        4JIgiBBzitjMV4l2xoVI4KD0N9sgz6B4RQpcEQ4j+HiVjEYSJhzQJn1dhY8BPLlRaQKucAvFXkla1
        fsiCDObT30RbWQedhV2IlRYdEMINpocLlW05CM7NbOg1UGk/f6H389Y/gsUtjw24nWfEo9/TUz5xf
        LZI65Idow==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hzPjC-0006UO-Bi; Sun, 18 Aug 2019 18:16:30 +0000
Date:   Sun, 18 Aug 2019 11:16:30 -0700
From:   "hch@infradead.org" <hch@infradead.org>
To:     Atish Patra <Atish.Patra@wdc.com>
Cc:     "hch@infradead.org" <hch@infradead.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "johan@kernel.org" <johan@kernel.org>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: [v5 PATCH] RISC-V: Fix unsupported isa string info.
Message-ID: <20190818181630.GA20217@infradead.org>
References: <20190807182316.28013-1-atish.patra@wdc.com>
 <20190812150215.GF26897@infradead.org>
 <3fb8d4f0383b005ecd932a69c4dd295a79b6fb1a.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fb8d4f0383b005ecd932a69c4dd295a79b6fb1a.camel@wdc.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 07:21:52PM +0000, Atish Patra wrote:
> > > +	if (isa[0] != '\0') {
> > > +		/* Add remainging isa strings */
> > > +		for (e = isa; *e != '\0'; ++e) {
> > > +#if !defined(CONFIG_VIRTUALIZATION)
> > > +			if (e[0] != 'h')
> > > +#endif
> > > +				seq_write(f, e, 1);
> > > +		}
> > > +	}
> > 
> > This one I don't get.  Why do we want to check CONFIG_VIRTUALIZATION?
> > 
> 
> If CONFIG_VIRTUALIZATION is not enabled, it shouldn't print that
> hypervisor extension "h" in isa extensions.

CONFIG_VIRTUALIZATION doesn't change anything in the kernels
capabilities, it just enables other config options.  But more
importantly the 'h' extension is only relevant for S-mode software
anyway.

> This is just an information to the userspace that some of the mandatory
> ISA extensions ("mafdcsu") are not supported in kernel which may lead
> to undesirable results.

I think we need to sit down decide what the purpose of /proc/cpuinfo
is.  IIRC on other architectures is just prints what the hardware
supports, not what you can actually make use of.  How else would you
find out that you'd need to enable more kernel options to fully
utilize the hardware?

Also printing this warning to the kernel log when someone reads the
procfs file is very strange.
