Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F93FC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 09:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A1EC20652
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 09:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A6FUcOdL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfD3JKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 05:10:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40248 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbfD3JKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 05:10:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FCg9Iuj2GiaMMZAu3B04tO6kqMZ7lIOz4uSh53rMBAE=; b=A6FUcOdLNxyLVFxNBpkU9U3dh
        qJurdGp+bC7rIXgoiIg9+uxSDBm1bjWgOxh+mlJXipXDPmSgKNia1xepITpCZWgG3J+lI7qiNBrAm
        x7ihriPNWhjxMRz0y4tjs2ahP0bvj9UHld0NXOSpZSz+PzATtiUBNnP4eqSLvp8dKthitMRz6ONDo
        NZRSBTYTLU0RQqCpFzB2BJStzOg0XGcJce1fwwTjd0uloqC4sR21WwnD1qfkbiNMTL6eTUbZ4Eqn9
        L6y1O7RfpGh/0j6QTdJ07QPpH9CgcorTWEJWZE3F3d1Zndv5M6E01bFLRX5ab89hsfEss/C/YDlQg
        ttcravoUA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLOmY-0000eT-ND; Tue, 30 Apr 2019 09:10:34 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3B2EF29A242E4; Tue, 30 Apr 2019 11:10:33 +0200 (CEST)
Date:   Tue, 30 Apr 2019 11:10:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@kernel.org>,
        Eric W Biederman <ebiederm@xmission.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ying Huang <ying.huang@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] latencytop lock usage improvement
Message-ID: <20190430091033.GN2623@hirez.programming.kicks-ass.net>
References: <1556525011-28022-1-git-send-email-feng.tang@intel.com>
 <20190430080910.GI2623@hirez.programming.kicks-ass.net>
 <20190430083505.n5mozwybbnwydo3z@shbuild888>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430083505.n5mozwybbnwydo3z@shbuild888>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 04:35:05PM +0800, Feng Tang wrote:
> Hi Peter,
> 
> On Tue, Apr 30, 2019 at 10:09:10AM +0200, Peter Zijlstra wrote:
> > On Mon, Apr 29, 2019 at 04:03:28PM +0800, Feng Tang wrote:
> > > Hi All,
> > > 
> > > latencytop is a very nice tool for tracing system latency hotspots, and
> > > we heavily use it in our LKP test suites.
> > 
> > What data does latency-top give that perf cannot give you? Ideally we'd
> > remove latencytop entirely.
> 
> Thanks for the review. In 0day/LKP test service, we have many tools for
> monitoring and analyzing the test results, perf is the most important
> one, which has the most parts in our auto-generated comparing results.   
> For example to identify spinlock contentions and system hotspots.
> 
> latencytop is another tool we used to find why systems go idle, like why
> workload chose to sleep or waiting for something. 

You're not answering the question; why can't you use perf for that? ISTR
we explicitly added support for things like that.
