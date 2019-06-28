Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1866AC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 07:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E026B204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 07:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b/ykUGbi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbfF1HhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 03:37:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58470 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbfF1HhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 03:37:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ulB8gERFcCFCNdqcSV+205kvuWNqhalFvyHNRs8lhUk=; b=b/ykUGbiznfMCDxHcs6NZU3Ss
        Rvhaui/DWboVWlAmov8/kejb5aLlpMud+Isrdh87hMEokPKCj+SSbBmkN3zHQJkaqws3ylWXSEIAc
        huqlDc8TZymGw/n6SjEHhTXb7E9kThjpSCibHfH6AKSx3DbhRTZW2X2DkoAwt4buUPLDdu51TamyE
        AA/yrOgb5mUgs3ORy/U1Nl5H0M/xLYkml25Lc2jIu2ycmkfrOlLmUvM8hMBHyAuM+YIudKPs+mf0s
        nfo1M8YSQk1Q0wqJ92ZfYWsa8nvIXQLQofp4YDV1zpBLng6jxbHOFikcmZTa0/j+fpxVbyMK1uTOg
        4w2EIETLw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hglRb-0006Hp-3N; Fri, 28 Jun 2019 07:37:15 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9B03D20A56C31; Fri, 28 Jun 2019 09:37:12 +0200 (CEST)
Date:   Fri, 28 Jun 2019 09:37:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de
Subject: Re: [PATCH] time/tick-broadcast: Fix tick_broadcast_offline()
 lockdep complaint
Message-ID: <20190628073712.GR3419@hirez.programming.kicks-ass.net>
References: <20190624231222.GA17497@lerouge>
 <20190624234422.GP26519@linux.ibm.com>
 <20190625004300.GB17497@lerouge>
 <20190625075139.GT3436@hirez.programming.kicks-ass.net>
 <20190625122514.GA23880@lenoir>
 <20190625135430.GW26519@linux.ibm.com>
 <20190625140538.GC3419@hirez.programming.kicks-ass.net>
 <20190625141624.GX26519@linux.ibm.com>
 <20190625162058.GB23880@lenoir>
 <20190625165238.GJ26519@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625165238.GJ26519@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 09:52:38AM -0700, Paul E. McKenney wrote:
> Very well, the commit is as shown below.  This is on current -rcu,
> but feel free to take it if you would like, Peter.  Just let me know
> and I will mark it so that I don't push it myself.  (I need to keep
> it in -rcu until I rebase onto a version of mainline that contains
> it so as to avoid spurious rcutorture failures.)

Looks good. I'll pick it up and then we need to take care when all lands
in tip.
