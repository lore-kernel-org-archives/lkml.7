Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40FF4C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 06:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 197D721928
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 06:00:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="G3g0kAOi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404547AbfIJGAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 02:00:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44066 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730117AbfIJGAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 02:00:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=y8nRBwCxQbRJ1ORTI4kUAnB42Mm+X+rnmLm76oBhkHY=; b=G3g0kAOi6XagZFmgYYt5xqqRY
        ZnxNd19bNJSB1d4t5109Uy2UnVpryS0kGiKwfuJG4xKYM12izJ0xFX1yxozLozSe+QSabRJ7ykMh2
        PwrOrC2MOTS0SMcA5Rw2xn5dPkI2c4a/aaa6Owkpeex0I6Tf2Wk9lWn7gtI8zK3w3tv2f2a23uQm/
        UnIicVEp0F9K6lfzMg3FROJ5OYLUkcBS8byvt+Iide/Rai0s2UJ8OT+rKziZ95GVdgIJ6T7EkasLj
        kgOp0Cg/CFBz0JCFnx6mSru1ar2jhHugxCOAZjn32q3Da/bokiZQVuC6TiNuHCujp6U0o6hp6pDMM
        8ApVVlUSA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i7ZCE-0002mj-RI; Tue, 10 Sep 2019 06:00:10 +0000
Date:   Mon, 9 Sep 2019 23:00:10 -0700
From:   "hch@infradead.org" <hch@infradead.org>
To:     Atish Patra <Atish.Patra@wdc.com>
Cc:     "hch@infradead.org" <hch@infradead.org>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "johan@kernel.org" <johan@kernel.org>
Subject: Re: [v5 PATCH] RISC-V: Fix unsupported isa string info.
Message-ID: <20190910060010.GA6027@infradead.org>
References: <20190807182316.28013-1-atish.patra@wdc.com>
 <20190812150215.GF26897@infradead.org>
 <3fb8d4f0383b005ecd932a69c4dd295a79b6fb1a.camel@wdc.com>
 <20190818181630.GA20217@infradead.org>
 <67e670a4600d7dc7ec3c7a7374e330b9a1dbe654.camel@wdc.com>
 <4615b682352a2e67094d327fa058ec7dd287423f.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4615b682352a2e67094d327fa058ec7dd287423f.camel@wdc.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2019 at 11:27:57PM +0000, Atish Patra wrote:
> > Agreed. May be something like this ?
> > 
> > Let's say f/d is enabled in kernel but cpu doesn't support it.
> > "unsupported isa" will only appear if there are any unsupported isa.
> > 
> > processor       : 3
> > hart            : 4
> > isa             : rv64imac
> > unsupported isa	: fd
> > mmu             : sv39
> > uarch           : sifive,u54-mc
> > 
> > May be I am just trying over optimize one corner case :) :).
> > /proc/cpuinfo should just print all the isa string. That's it.
> > 
> 
> Ping ?

Yes, I agree with the "dumb" reporting of all capabilities.
