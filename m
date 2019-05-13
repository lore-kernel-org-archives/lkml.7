Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D47DC04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 08:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B6B920818
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 08:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nv7h/UvJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbfEMILH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 04:11:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56410 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfEMILG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 04:11:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wWOMWrWF1Ur0bcF3/YS5svtmVGvjX6Ex1p7xTjESYDk=; b=nv7h/UvJuBJ7dWul7XRjKHR1P
        sU+SUaWmGuZxMAzUXcqvq2DK1a8b7gCdfsRGMENSoeFmGPCOBY0eBtIoAMg16WaGlLBKaiyp/CveN
        sl8JS6Df2QUVKd5djT7l/TU7A8269cG2R9tK5A782crET+cspGuX/yNAt4lNhG671H1CORukHmXFZ
        9XsNffWGvd10f8micKvsvmiwb9aHfxpV/DEMQo8BnAFiHfdN41HhgRfAttc9CMMP3A+QDSuZ1hDuE
        JeoTsqe6NpW7B+hdYSsVcbrbg5j1gHHHyMdh46Wdy8nh74pgysUHlGKUu9RTRydtou3PhEpZ5H204
        v/W6l0tdA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hQ62w-0003NE-GI; Mon, 13 May 2019 08:10:54 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4F0FC2029FD7A; Mon, 13 May 2019 10:10:52 +0200 (CEST)
Date:   Mon, 13 May 2019 10:10:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        andrea.parri@amarulasolutions.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>, joelaf@google.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Question about sched_setaffinity()
Message-ID: <20190513081052.GJ2623@hirez.programming.kicks-ass.net>
References: <20190430105129.GA3923@linux.ibm.com>
 <20190430115551.GT2623@hirez.programming.kicks-ass.net>
 <20190501191213.GX3923@linux.ibm.com>
 <20190501151655.51469a4c@gandalf.local.home>
 <20190501202713.GY3923@linux.ibm.com>
 <20190507221613.GA11057@linux.ibm.com>
 <20190509173654.GA23530@linux.ibm.com>
 <20190509193625.GA12455@linux.ibm.com>
 <20190510120819.GR2589@hirez.programming.kicks-ass.net>
 <20190510230742.GY3923@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190510230742.GY3923@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2019 at 04:07:42PM -0700, Paul E. McKenney wrote:
> > The below trace explain the issue. Some Paul person did it, see below.
> > It's broken per construction :-)
> 
> *facepalm*  Hence the very strange ->cpus_allowed mask.  I really
> should have figured that one out.

I guess it's called a torture framework for a reason ;-)

