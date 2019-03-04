Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 151DAC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 17:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D94D4206DD
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 17:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iYANKdF1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbfCDRt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 12:49:56 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51814 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbfCDRt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 12:49:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SA9232haIRmJODNUh4w9IqZ1KWBeRevlsEsRGvAriXY=; b=iYANKdF1OJXf8VyhCikkh0gbg
        1VPNaxlvoxLWdKNPAytiyXvF2JTyVHoyOCYqQghRbmIW4oQC5mQrMaAOvkJmr/erFyv8okgmmZyEm
        fBytIF9mHmedmSgPcew1O3rCEdtIr4KlT4fojBOudsBE6/H0ANlbp2rAb/baiBpE4NdihPtfQnOL6
        pX1+hM9YD9VgXMg8GCWPJQOBmvVApRw2Oa7lFAYhWnuhWzu6YH+W5dz3FrHf13eGrUGAAOL68cBsC
        Wwpvmxngoq2JE8URACBAggPLGNr7CYDq0CXJjfTE2EK+mCKAU5VSKRCuqK9s3KGzdBsMShg2HIIe5
        vJh4kL5pQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h0rip-0006Ra-0a; Mon, 04 Mar 2019 17:49:51 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8216020288BA6; Mon,  4 Mar 2019 18:49:49 +0100 (CET)
Date:   Mon, 4 Mar 2019 18:49:49 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     =?utf-8?B?V2FuZywgVmluY2VudCAo546L5LqJKQ==?= 
        <Vincent.Wang@unisoc.com>,
        =?utf-8?B?WmhhbmcsIENodW55YW4gKOW8oOaYpeiJsyk=?= 
        <Chunyan.Zhang@unisoc.com>, Ingo Molnar <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: =?utf-8?B?562U5aSNOiBbUEFUQ0ggVjRdIHNj?=
 =?utf-8?Q?hed=2Fcpufreq=3A_initializ?= =?utf-8?Q?e?= iowait_boost_max and
 iowait_boost with cpu capacity
Message-ID: <20190304174949.GP32494@hirez.programming.kicks-ass.net>
References: <1550831866-32749-1-git-send-email-chunyan.zhang@unisoc.com>
 <20190222105957.wxhlcmoag5f3i4fi@queper01-lin>
 <9099990618e242e1bab77ce3f9d9b1e3@BJMBX02.spreadtrum.com>
 <20190304135810.rq2ojnbn5vezrab3@queper01-lin>
 <20190304152616.GM32494@hirez.programming.kicks-ass.net>
 <20190304164816.4fnxxesjwzdoqria@queper01-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190304164816.4fnxxesjwzdoqria@queper01-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2019 at 04:48:16PM +0000, Quentin Perret wrote:
> On Monday 04 Mar 2019 at 16:26:16 (+0100), Peter Zijlstra wrote:
> > On Mon, Mar 04, 2019 at 01:58:12PM +0000, Quentin Perret wrote:
> > > You could also update the values in sugov_get_util() at the cost of a
> > > small overhead to compute 'min'. I'm not sure what's preferable since
> > > we wanted to avoid that kind of overhead in the first place ...
> > 
> > Or,... we could actually make things simpler.
> > 
> > How's the below? I have a feq questions wrt min, mostly:
> > 
> >  - what's the difference between policy->min and
> >    policy->cpuinfo.min_freq; it used to be the former, the below uses
> >    the latter.
> 
> As mentioned on IRC, IIRC policy->min is something that can be written
> from userspace (for example) to cap the min freq. OTOH, cpuinfo.min_freq
> is read-only and just reports the lowest OPP.
> 
> Rafael is this correct ?
> 
> >  - should we have a min_freq based value, instead of a constant; the
> >    difference being that with this the actual boost speed depends in the
> >    gap between min/max.
> 
> If the above is correct, then I agree. Looking at min_freq simplifies
> things quite a bit since it doesn't need to be updated all the time,
> and the whole policy->min stuff is dealt with at the CPUFreq core level
> so it's not obvious sugov should care.

Using a constant value (my dice seem to like 128 for some reason) would
result in the boost curve being independent of the available frequencies
-- and thus the same for all machines.

With that particular value, we need 9 consecutive IOWAIT wakeups to
reach MAX, instead of some random number (7 for your juno r0).
