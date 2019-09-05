Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE45C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 08:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8584820870
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 08:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="smk8E7Pf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732187AbfIEIbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 04:31:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50172 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfIEIbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 04:31:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fp8eBYz/kzKBULebM5HWUHnX6du+0lSaxjkyi7TgD2Y=; b=smk8E7Pf118vl5Sb9vHNO/qwp
        WrgYpMzFq++wmk1vpQ5C5e3uGt20R30eogQ9ar7yKSafJBO58IgNxsauGh+JAAo7MwNeDx/FtTqnc
        N3EOFeXFPPDEQCcregjIrlpTU+kdson5EHbN4VSECsJCcE5GrT1ImcyRvYfbnXl4mqYppYHHQU3Ul
        yG0YqXHVfYTac4W/W+gMsXC8YQn947jKfrsuMWcac4U0l1N88OT0vyX4ExCQy9fgnU3ayMciPshB0
        QhLJL5inEGAGV1qw6EWScu/AcTwVjbnBWmSUdUVQ9CJ3WoQCdrJysTFPewLToeLQo5KideGrmu5IH
        KoN61n6Ew==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i5nAv-0007ow-FU; Thu, 05 Sep 2019 08:31:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5D52B305E47;
        Thu,  5 Sep 2019 10:30:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 42FD620EFA5D9; Thu,  5 Sep 2019 10:31:27 +0200 (CEST)
Date:   Thu, 5 Sep 2019 10:31:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     subhra mazumdar <subhra.mazumdar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        steven.sistare@oracle.com, dhaval.giani@oracle.com,
        daniel.lezcano@linaro.org, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, tim.c.chen@linux.intel.com,
        mgorman@techsingularity.net, parth@linux.ibm.com,
        patrick.bellasi@arm.com
Subject: Re: [RFC PATCH 1/9] sched,cgroup: Add interface for latency-nice
Message-ID: <20190905083127.GA2332@hirez.programming.kicks-ass.net>
References: <20190830174944.21741-1-subhra.mazumdar@oracle.com>
 <20190830174944.21741-2-subhra.mazumdar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830174944.21741-2-subhra.mazumdar@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 10:49:36AM -0700, subhra mazumdar wrote:
> Add Cgroup interface for latency-nice. Each CPU Cgroup adds a new file
> "latency-nice" which is shared by all the threads in that Cgroup.

*sigh*, no. We start with a normal per task attribute, and then later,
if it is needed and makes sense, we add it to cgroups.

Also, your Changelog fails on pretty much every point. It doesn't
explain why, it doesn't describe anything and so on.

From just reading the above, I would expect it to have the range
[-20,19] just like normal nice. Apparently this is not so.
