Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85460C48BE3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 21:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53A8521670
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 21:12:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hSK4P6Q+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbfFTVMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 17:12:52 -0400
Received: from merlin.infradead.org ([205.233.59.134]:48528 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfFTVMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 17:12:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0HS7QabWzOE0lGuJDgN7eO3a8AHNo77B8NNsl00ZW0o=; b=hSK4P6Q+aI2V2fmtzKj+TQxXo
        lrhLG1E7AMA1xbQLLK07+LL+mXPu8KhTZQ76R545mLSN9WmUWPt1E63AkTrbmoIb4wXqK7CJ6wC/5
        054RxSHYBpNn1Grm+DlQH7ZrcGoMnHRT7XifZ6MN7HKdXRUEov1B+lY2/dGCnIQoRQBNHqQxeBk9T
        7M2I64up3RntotM2+FGRXXIzcJHDpORozcAaWfGuGOumWnhi1Undr3aKlhSU2gczm3hzbq5ysJ7hG
        1FiNUONvRUnzH7yNGCCJqEdkkjifRsFMcxbr0TauDBGulnw4+3BSwbiU4fqCfZgd0LUAvlzF5/KVr
        tB5VVvItA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1he4MO-0002m8-H1; Thu, 20 Jun 2019 21:12:44 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 30EE52021E583; Thu, 20 Jun 2019 23:12:42 +0200 (CEST)
Date:   Thu, 20 Jun 2019 23:12:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc:     "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>,
        "jbaron@redhat.com" <jbaron@redhat.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH] ARC: ARCv2: jump label: implement jump label patching
Message-ID: <20190620211242.GB3436@hirez.programming.kicks-ass.net>
References: <20190614164049.31626-1-Eugeniy.Paltsev@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA2307501A252CCC3@us01wembx1.internal.synopsys.com>
 <20190619081227.GL3419@hirez.programming.kicks-ass.net>
 <50a5120f512e7d6784efa403a7597c159074c8c1.camel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50a5120f512e7d6784efa403a7597c159074c8c1.camel@synopsys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 06:34:29PM +0000, Eugeniy Paltsev wrote:
> On Wed, 2019-06-19 at 10:12 +0200, Peter Zijlstra wrote:
> > On Tue, Jun 18, 2019 at 04:16:20PM +0000, Vineet Gupta wrote:

> > I'm assuming you've looked at what x86 currently does and found
> > something like that doesn't work for ARC?
> 
> To be honest I've mostly look at arm/arm64 implementation :)

Yeah, but that's fixed instruction width RISC. They have it easy.
