Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15EE0C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 12:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC59B22527
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 12:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K4OU1h42"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729335AbfLLMwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 07:52:35 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58008 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729226AbfLLMwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 07:52:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7pKItzcvRmGDzsdHn+yvX60yz4s7uBXmcUGpY7N6CTM=; b=K4OU1h42I6mEbHwlvyklqn6cb
        FeGoZALO7xdzfBOOlkAnvlULbEYj+/iHLfIM6ARigU02mXABboBgIQVWyzsK5rrNpNPQOq/vvSNCT
        RgoDzm3SSeaSg3M6i33ZTu38MRICswGbWYmGwempGNUpBy4LsdkkzBaMQsc34TV8nKAi5r336d5YE
        s0S0UV3I7x1JzSOmsx0e0TOS9S5uKiDGlGnLYbTdkfLH6Lox5NZRMjjHxCtADnGxcnGlSuC/tsT6W
        yt4er2iiIv7+fCe8H+/fcF3esBCC73FSOsp4ndJZN8ECXxmkG6X6WTFce3HtCKaDpbH0t+LVcfVin
        krKAgJHWA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ifNx8-0002KC-Ty; Thu, 12 Dec 2019 12:52:22 +0000
Date:   Thu, 12 Dec 2019 04:52:22 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] powerpc/irq: inline call_do_irq() and
 call_do_softirq() on PPC32
Message-ID: <20191212125222.GB3381@infradead.org>
References: <72a6cd86137b2a7ab835213cf5c74df6ed2f6ea7.1575739197.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72a6cd86137b2a7ab835213cf5c74df6ed2f6ea7.1575739197.git.christophe.leroy@c-s.fr>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 07, 2019 at 05:20:04PM +0000, Christophe Leroy wrote:
> call_do_irq() and call_do_softirq() are simple enough to be
> worth inlining.
> 
> Inlining them avoids an mflr/mtlr pair plus a save/reload on stack.
> It also allows GCC to keep the saved ksp_limit in an nonvolatile reg.
> 
> This is inspired from S390 arch. Several other arches do more or
> less the same. The way sparc arch does seems odd thought.

Any reason you only do this for 32-bit and not 64-bit as well?
