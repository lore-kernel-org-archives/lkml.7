Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC944C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 15:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D760208CB
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 15:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="H/OhkOf4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731485AbfFYP5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 11:57:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55226 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731329AbfFYP5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 11:57:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=B9eoPw20HASOxL1FJnUSxIMcBCOFd6N9WoXGivJBC4M=; b=H/OhkOf4ah75DUgvQ5LCQw4Tde
        o7NXkY7m71OlcJP6zPfJbJtrFXNM74QYKl3co4ljSRNsFefNAV5nogKWFgUiPHx97w8TKO+xtZXZU
        +9HTUFARZkun3fcE/T1bxk18Xe8ZuRWkYAzFnOJd0PlEVuDzIpmJpVMBJKz1BDj4yXzVqBChzqrFq
        BCzjhYcBv50Os3rhVd1ZvRF7wL+NZGuTFuYttR7QAH+bMUeEKSy1OaMHjXA9GH4wbonl/AnJS39Hr
        yMbC1OpKbu6E6+doC9HCVvkdXdChaPwGijL+IqhDumxEC0iq2h6Sk3Mg96o4wlpq29/iaelBdB+X3
        KC87KP+A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hfnpM-00030H-1P; Tue, 25 Jun 2019 15:57:48 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8F50B209C957E; Tue, 25 Jun 2019 17:57:45 +0200 (CEST)
Date:   Tue, 25 Jun 2019 17:57:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qian Cai <cai@lca.pw>
Cc:     mingo@redhat.com, valentin.schneider@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched/core: silence a warning in sched_init()
Message-ID: <20190625155745.GF3419@hirez.programming.kicks-ass.net>
References: <1561466662-22314-1-git-send-email-cai@lca.pw>
 <20190625135238.GA3419@hirez.programming.kicks-ass.net>
 <1561471459.5154.70.camel@lca.pw>
 <20190625142508.GE3419@hirez.programming.kicks-ass.net>
 <1561475229.5154.74.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1561475229.5154.74.camel@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 11:07:09AM -0400, Qian Cai wrote:
> On Tue, 2019-06-25 at 16:25 +0200, Peter Zijlstra wrote:
> > On Tue, Jun 25, 2019 at 10:04:19AM -0400, Qian Cai wrote:
> > > On Tue, 2019-06-25 at 15:52 +0200, Peter Zijlstra wrote:
> > > Yes, -Wmissing-prototype makes no sense, but "-Wunused-but-set-variable" is
> > > pretty valid to catch certain developer errors. For example,
> > > 
> > > https://lists.linuxfoundation.org/pipermail/iommu/2019-May/035680.html
> > > 
> > > > 
> > > > As to this one, ideally the compiler would not be stupid, and understand
> > > > the below, but alas.
> > > 
> > > Pretty sure that won't work, as the compiler will complain something like,
> > > 
> > > ISO C90 forbids mixed declarations and code
> > 
> > No, it builds just fine, it's a new block and C allows new variables at
> > every block start -- with the scope of that block.
> 
> I remember I tried that before but recalled the error code wrong. Here it is,
> 
> kernel/sched/core.c:5940:17: warning: unused variable 'ptr' [-Wunused-variable]
>                 unsigned long ptr = (unsigned long)kzalloc(alloc_size,
> GFP_NOWAIT);

Yes, I know, I tried. And GCC is a moron because of it.
