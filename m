Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80276C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 14:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F355214AE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 14:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rOXZk5Fu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbfCMOVu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 10:21:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42844 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbfCMOVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 10:21:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qhm8Lr5hnFfgUvoGYultIFT6xnErP++SakeNfih78Mw=; b=rOXZk5FuXurDzuueRpFx2i3gp
        21S9A1jam2CZyrAaiBlXHzuZBWs+/WA6SDs39Mbfb3/XQ4XLejxCnn26y2msKmCow64PT11bek1QB
        o+XmUQI7KBC2xU72EGtNa9zZgPrjr6AlA0V+Yj0fHlecUlu9Y9+YjXikWzB/pb/+46ub+xAg6F59S
        Gx877e5StWHo+z3xCcI4QY+w1OVLOFekyp+SUThgjqW4RDnYlsAtf/L30fsrNSDrjvfx4Rl87FHd2
        5oazK4HwBupcspy+jgyeICjsSix8hgB5woymEknKzNQSfDcU956SRcsumIqTs+C9hR0tF0Lzj5Vq9
        e5W7n4mjw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h44lM-0001GR-Jt; Wed, 13 Mar 2019 14:21:44 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0AD3420298565; Wed, 13 Mar 2019 15:21:43 +0100 (CET)
Date:   Wed, 13 Mar 2019 15:21:43 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Qian Cai <cai@lca.pw>, Jason Gunthorpe <jgg@mellanox.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] mm/debug: add a cast to u64 for atomic64_read()
Message-ID: <20190313142142.GE5996@hirez.programming.kicks-ass.net>
References: <20190310183051.87303-1-cai@lca.pw>
 <20190311035815.kq7ftc6vphy6vwen@linux-r8p5>
 <20190311122100.GF22862@mellanox.com>
 <1552312822.7087.11.camel@lca.pw>
 <CAK8P3a0QB7+oPz4sfbW_g2EGZZmC=LMEnkMNLCW_FD=fEZoQPA@mail.gmail.com>
 <20190313091844.GA24390@hirez.programming.kicks-ass.net>
 <CAK8P3a3_2O7KBKTSD-QC5tcpohy8bkVVHsdAJnanTU1B+H12-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3_2O7KBKTSD-QC5tcpohy8bkVVHsdAJnanTU1B+H12-w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 02:46:55PM +0100, Arnd Bergmann wrote:
> I thiunk it needs an '__attribute__((aligned(8)))' annotation at least on
> x86-32, 

I _hate_ that s64 isn't already natively aligned.

Anyway, yes, unaligned atomics are a _bad_ idea if they work at all.
