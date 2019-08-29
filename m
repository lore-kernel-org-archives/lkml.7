Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F4A3C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 10:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4145A2053B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 10:56:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RK7ysFei"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbfH2K4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 06:56:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38976 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfH2K4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 06:56:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zGhLBR0A7qfv6CWZPkKZEbt0N93fufawom5jHSXyEHI=; b=RK7ysFeiNsDXvG/kes172+IWv
        LMy2DudogAzRVGxvCcqIqdLWIUn7xAhwMJ+rrZhs3zy/czK+l3s7wItfCqxBfqG24W3ss+2Kz530V
        Gg3lImidY9uYIJ5fOccCQZ8UdPAM4PRWGoTPHqntfjQ3nqqR325acokq2EXI2NcjO+c2eW4c4vI2K
        weMfwpqRA8ZlOaKgvQG8Va4MI9MJEeMxrA5/NnEeDXtO+pf1xIZAzb6Pb7WpKXtow4NgSOHVM4lv4
        HqOKuTDV5gXr/LFW7KpA+hdYXtc3BHs2z61F7AVTrU8wWLan8pqRash+CUwMKQugvHrhHE6HndtZZ
        V5oDci1+w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i3I6B-0002Mc-Gt; Thu, 29 Aug 2019 10:56:15 +0000
Date:   Thu, 29 Aug 2019 03:56:15 -0700
From:   "hch@infradead.org" <hch@infradead.org>
To:     Atish Patra <Atish.Patra@wdc.com>
Cc:     "hch@infradead.org" <hch@infradead.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "alankao@andestech.com" <alankao@andestech.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "alexios.zavras@intel.com" <alexios.zavras@intel.com>,
        "gary@garyguo.net" <gary@garyguo.net>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>
Subject: Re: [RFC PATCH 1/2] RISC-V: Mark existing SBI as legacy SBI.
Message-ID: <20190829105615.GA8968@infradead.org>
References: <20190826233256.32383-1-atish.patra@wdc.com>
 <20190826233256.32383-2-atish.patra@wdc.com>
 <20190827140304.GA21855@infradead.org>
 <ac3cfe4502090354a7c49fae277adb757ad900d5.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac3cfe4502090354a7c49fae277adb757ad900d5.camel@wdc.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 08:37:27PM +0000, Atish Patra wrote:
> That would split the implementation between C file & assembly file for
> no good reason.
> 
> How about moving everything in sbi.c and just write everything inline
> assembly there.

Well, if we implement it in pure assembly that would be the entire
implementation, wouldn't it?
