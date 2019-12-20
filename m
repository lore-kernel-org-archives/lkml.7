Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A192C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 17:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D74D2467F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 17:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="E20//NVN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbfLTRSU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 12:18:20 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59208 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727270AbfLTRST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 12:18:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dbcK1inj+h2RxyFaYXeSVig25gBfCN0oPg+u7BnDMHs=; b=E20//NVNuQ9QEzchrXT343niN
        Pw98yJZe0JpU17W0EUpm6V8PenWtfzMpxlmNvPe/2/V3W8LIzvDMGvuDNPNPpovMhEvrq+c1kGtby
        k1yRW40HIHxLLVYKYZ2M/saQBDFe+ee6OPb+rfdsEReRD9e14wSRDP1ECORH//KFdaWm2mxK9W7vq
        q+4Q9m1uJlZdknYetUFoNxXBY+ZJVRdIcZ70sufZR177OQduQTl12kQl+vLiFTJL2c7L4Jw2dtVBw
        FAp18kaoa+VFT9vNhKOqsIlRrvVdg+H5xya0mVTZvsIaolhgvs+pvOjfg5azPvBINS9wxW5d0wRAj
        LA3PO3inw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iiLui-0004pl-Qd; Fri, 20 Dec 2019 17:18:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D24DF3007F2;
        Fri, 20 Dec 2019 18:16:42 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DB0802024477C; Fri, 20 Dec 2019 18:18:06 +0100 (CET)
Date:   Fri, 20 Dec 2019 18:18:06 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched: rt: Make RT capacity aware
Message-ID: <20191220171806.GQ2827@hirez.programming.kicks-ass.net>
References: <20191009104611.15363-1-qais.yousef@arm.com>
 <20191028143749.GE4114@hirez.programming.kicks-ass.net>
 <20191028140147.036a0001@grimm.local.home>
 <20191028205034.GL4643@worktop.programming.kicks-ass.net>
 <20191220160149.fj5gdkaxm763fhfl@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191220160149.fj5gdkaxm763fhfl@e107158-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2019 at 04:01:49PM +0000, Qais Yousef wrote:
> On 10/28/19 21:50, Peter Zijlstra wrote:
> > On Mon, Oct 28, 2019 at 02:01:47PM -0400, Steven Rostedt wrote:
> > > On Mon, 28 Oct 2019 15:37:49 +0100
> > > Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > > > Works for me; Steve you OK with this?
> > > 
> > > Nothing against it, but I want to take a deeper look before we accept
> > > it. Are you OK in waiting a week? I'm currently at Open Source Summit
> > > and still have two more talks to write (giving them Thursday). I wont
> > > have time to look till next week.
> > 
> > Sure, I'll keep it in my queue, but will make sure it doesn't hit -tip
> > until you've had time.
> 
> Reviewers are happy with this now. It'd be nice if you can pick it up again for
> the next round to -tip.
> 

Sorry, I missed Steve's and Dietmar's replies. It should shorty appear
in queue.git and I'll try and push to -tip over the weekend (provided
the robots don't come up with something fishy).
