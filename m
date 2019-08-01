Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1282DC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 14:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C88B420665
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 14:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ohFMWjGo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731249AbfHAOnc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 10:43:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41742 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727936AbfHAOnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 10:43:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=l28Rr3sLG1uA7yv0wpAMp/X8wH/AkVxOmiBC8jnRkGE=; b=ohFMWjGoxybNp/3LcJm+JWpDS
        UiYRB9CC05T4PplcOW/Zm0Ay0hn6SZAUVy8K8HIdVpumCUiQkXS41O4cI05GA6v1RIn9i/llR0n/0
        f6dlKQtACz6knAUpweZhZ/aNojjP3sET7coLkfrCTPjWv3J5MBplBxFu4HhwNML4m1JQJU0egzsV2
        UBxzaJSNt7Or68ThWbul8G/S56wdbZPOeJlWbB2L0e7Rz1DOLHr77ONCyLcD86PJUo3MAgxRUBWij
        87m8aKGAJYstZ6mxSoXBMzujITfUyH92U/rnhiFzYolbLVGSTe6G7HkJdAbxtervAt72767gZmP6L
        q1m5OLkmA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1htCIk-0000JI-B1; Thu, 01 Aug 2019 14:43:30 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A20002029F4C9; Thu,  1 Aug 2019 16:43:27 +0200 (CEST)
Date:   Thu, 1 Aug 2019 16:43:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH 2/5] rcu/tree: Fix SCHED_FIFO params
Message-ID: <20190801144327.GB31398@hirez.programming.kicks-ass.net>
References: <20190801111348.530242235@infradead.org>
 <20190801111541.742613597@infradead.org>
 <20190801135103.GI5913@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801135103.GI5913@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2019 at 06:51:03AM -0700, Paul E. McKenney wrote:
> On Thu, Aug 01, 2019 at 01:13:50PM +0200, Peter Zijlstra wrote:
> > A rather embarrasing mistake had us call sched_setscheduler() before
> > initializing the parameters passed to it.
> > 
> > Cc: Juri Lelli <juri.lelli@redhat.com>
> > Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
> 
> Thank you for having CCed me this time.  ;-)

Yeah, pretty much everything about that last time seems to have gone
wrong...
