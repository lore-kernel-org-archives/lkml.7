Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D00AAC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 06:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DD99218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 06:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jm0Dj6ze"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729796AbfDXG3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 02:29:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49838 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfDXG3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 02:29:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=soP8bfePFCa3vF2pI6nO+hpW799S0o9ponhJLuJzWx4=; b=jm0Dj6zePjES+BGfcZzsILuJ0
        +D7YZP2SEF3lAC8AXkwqiCOC2SyfzNBa4yrdh8glTORMwKsbf3UbtrPtMK0cXsMrDyHTDk14ru4OZ
        i/JteeAJ3Gdjxu6BINOlAlJUK97S3Y5gr97D5xsyi7hQVVj3RzWXFMd1W8+/aCk9Ukf8m9VXoHfn1
        DBxAjZfgs2V/zhNvLANiLR3k7mS6ZOGcDEqqtRu8q2HmRvzKFNyB9DQVBIuw3UaLzM5yBW2UEsISW
        WqX6yPDXJuBHenwP07i0T0xalrOh7LZJeINXxAgNiGQuj1keUgDqpczMoSQwFXMtS+HP3VSZl5uw9
        OMwu0RQjA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJBPf-0004fT-Vh; Wed, 24 Apr 2019 06:29:47 +0000
Date:   Tue, 23 Apr 2019 23:29:47 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Anup Patel <Anup.Patel@wdc.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v3 2/3] RISC-V: Add interrupt related SCAUSE defines in
 asm/csr.h
Message-ID: <20190424062947.GB10400@infradead.org>
References: <20190415093648.7525-1-anup.patel@wdc.com>
 <20190415093648.7525-3-anup.patel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190415093648.7525-3-anup.patel@wdc.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 09:37:23AM +0000, Anup Patel wrote:
> This patch adds SCAUSE interrupt flag and SCAUSE interrupt related
> defines to asm/csr.h. We also use these defines in kernel/irq.c and
> express SIE/SIP flags in-terms of SCAUSE interrupt causes.

I'm not a fan of this.  For one this pollutes csr.h with bits not really
needed by most users, and it makes adding the M-mode nommu port which has
to use the M-mode causes much harder:

http://git.infradead.org/users/hch/misc.git/commitdiff/1221f5c32345ebe7ea2c1cd6e8a01ad4b422aaba
