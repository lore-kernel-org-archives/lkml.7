Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AFB9C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6E7120679
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UVKP3YSH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbfFMRtB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 13:49:01 -0400
Received: from merlin.infradead.org ([205.233.59.134]:57042 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbfFMRtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 13:49:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lx8YawAG1pWColSVLTKMtDDRHBBva9ug9vr135nBk+Q=; b=UVKP3YSHyn887sviVpjNVbtdy
        qPg2WDLYI/+7E81Ba+EwwUfpmVSSTgARjEmaxSKkENdYNYqTwhnTKa1HTQfYTSyQy9xFJjUvmlhlp
        BYN3OicUpIXgb5y9+Hs8QS8N/hHZ/PLaIev1pxldclYr9jdwL+YHvXQ2rfWHRhdqAG/X+wgTqm3Mk
        TyFFXkRHubTqMIgBdl96HDwCqd8qDMdBQ/yYzpILe+pMGn0P72mW+CMbQ3SatCQej5KK+0Zs1BnFp
        sPiqQIvQCxOeA6RsqbQEbu4KHa+sKpNufSTWJeuBjHre5xL5KDoDmJULcMjc0tzYkokLSRU6LTtbm
        ReOsYSbuQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hbTq7-0000XR-Af; Thu, 13 Jun 2019 17:48:43 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 68EAB209CC9A7; Thu, 13 Jun 2019 19:48:40 +0200 (CEST)
Date:   Thu, 13 Jun 2019 19:48:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Paul Burton <paul.burton@mips.com>
Cc:     "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "akiyks@gmail.com" <akiyks@gmail.com>,
        "andrea.parri@amarulasolutions.com" 
        <andrea.parri@amarulasolutions.com>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        "dlustig@nvidia.com" <dlustig@nvidia.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "j.alglave@ucl.ac.uk" <j.alglave@ucl.ac.uk>,
        "luc.maranget@inria.fr" <luc.maranget@inria.fr>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "paulmck@linux.ibm.com" <paulmck@linux.ibm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 0/4] atomic: Fixes to smp_mb__{before,after}_atomic()
 and mips.
Message-ID: <20190613174840.GN3436@hirez.programming.kicks-ass.net>
References: <20190613134317.734881240@infradead.org>
 <20190613163222.zqisgcqzibofmkd7@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613163222.zqisgcqzibofmkd7@pburton-laptop>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 04:32:24PM +0000, Paul Burton wrote:
> Hi Peter,
> 
> On Thu, Jun 13, 2019 at 03:43:17PM +0200, Peter Zijlstra wrote:
> > Paul, how do you want to route the MIPS bits?
> 
> Thanks for following up on these issues. I'd be happy to take the MIPS
> patches through the mips-fixes branch - do you have a preference?

That works for me; I'll make sure the x86 one goes through tip.

Thanks!
