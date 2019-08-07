Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E344C19759
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 05:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BE0521BF2
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 05:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SXgLtFQJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfHGFmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 01:42:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34760 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbfHGFmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 01:42:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yZWIGwD45qaQCTjIISsahFCcEdFYVcGpIOjQahUL7O0=; b=SXgLtFQJoFlctH/cb3yg1ES6z
        zDO5haCp9wf+i9WoU5MSK0tknTzCq6i4CeLM/kEi5pwmz4n8HGlYTiWJM7iUzlUwgLbw5KAVDKq9s
        yk4PjAc83Q/0xZoeYq40FppnUWJNk56PpX3LDPDLHHSlg+mYQVQ67GOX1kFtn5lQ7/n1WurgiWveK
        GkmCYgjVeLcwKwRap5RTKcopYMn/cJEadzp976WF+jdU74to9+BDlYcn8Wcu8cDbGBWzD21Fmxkdd
        qcKuPCcgAFwNeJbYS5i/1x+cJ7CrBqByukUtKa3V52Qys7xtyBSKcUTGV0+xlymzU6LJJ81eIvXZx
        QcakcU0uQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hvEik-0002Bp-3E; Wed, 07 Aug 2019 05:42:46 +0000
Date:   Tue, 6 Aug 2019 22:42:46 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Ghiti <alex@ghiti.fr>
Subject: Re: [PATCH] riscv: kbuild: add virtual memory system selection
Message-ID: <20190807054246.GB1398@infradead.org>
References: <alpine.DEB.2.21.9999.1907261259420.26670@viisi.sifive.com>
 <20190802084453.GA1410@infradead.org>
 <alpine.DEB.2.21.9999.1908061648220.13971@viisi.sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.9999.1908061648220.13971@viisi.sifive.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 05:02:03PM -0700, Paul Walmsley wrote:
> The rationale is to encourage others to start laying the groundwork for 
> future Sv48 support.  The immediate trigger for it was Alex's mmap 
> randomization support patch series, which needs to set some Kconfig 
> options differently depending on the selection of Sv32/39/48.  

Writing a formal todo list is much better encouragement than adding
dead code.  Th latter has a tendency of lingering around forever and
actually hurting people.

> 
> > but actively harmful, which is even worse.
> 
> Reflecting on this assertion, the only case that I could come up with is 
> that randconfig or allyesconfig build testing could fail.  Is this the 
> case that you're thinking of, or is there a different one?  If that's the 
> one, I do agree that it would be best to avoid this case, and it looks 
> like there's no obvious way to work around that issue.

randconfig or just a user thinking bigger is better and picking it.

> > Even if we assume we want to implement Sv48 eventually (which seems
> > to be a bit off), we need to make this a runtime choice and not a
> > compile time one to not balloon the number of configs that distributions
> > (and kernel developers) need to support.
> 
> The expectation is that kernels that support multiple virtual memory 
> system modes at runtime will probably incur either a performance or a 
> memory layout penalty for doing so.  So performance-sensitive embedded 
> applications will select only the model that they use, while distribution 
> kernels will likely take the performance hit for broader single-kernel 
> support.

Even if we want to support Sv39 only or Sv39+Sv39 the choice in the
patch doesn't make any sense.  So better do the whole thing when its
ready than doing false "groundwork".
