Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84783C04A6B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 02:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5298A2053B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 02:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbfEICMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 22:12:40 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:42732 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725842AbfEICMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 22:12:40 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07487;MF=aaron.lu@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0TRDJ4vp_1557367904;
Received: from aaronlu(mailfrom:aaron.lu@linux.alibaba.com fp:SMTPD_---0TRDJ4vp_1557367904)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 09 May 2019 10:11:50 +0800
Date:   Thu, 9 May 2019 10:11:44 +0800
From:   Aaron Lu <aaron.lu@linux.alibaba.com>
To:     Julien Desfossez <jdesfossez@digitalocean.com>
Cc:     Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Phil Auld <pauld@redhat.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v2 00/17] Core scheduling v2
Message-ID: <20190509021144.GA24577@aaronlu>
References: <20190423180238.GG22260@pauld.bos.csb>
 <20190423184527.6230-1-vpillai@digitalocean.com>
 <20190429035320.GB128241@aaronlu>
 <20190506193937.GA10264@sinkpad>
 <20190508023009.GA89792@aaronlu>
 <20190508174909.GA18516@sinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190508174909.GA18516@sinkpad>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 08, 2019 at 01:49:09PM -0400, Julien Desfossez wrote:
> On 08-May-2019 10:30:09 AM, Aaron Lu wrote:
> > On Mon, May 06, 2019 at 03:39:37PM -0400, Julien Desfossez wrote:
> > > On 29-Apr-2019 11:53:21 AM, Aaron Lu wrote:
> > > > This is what I have used to make sure no two unmatched tasks being
> > > > scheduled on the same core: (on top of v1, I thinks it's easier to just
> > > > show the diff instead of commenting on various places of the patches :-)
> > > 
> > > We imported this fix in v2 and made some small changes and optimizations
> > > (with and without Peter’s fix from https://lkml.org/lkml/2019/4/26/658)
> > > and in both cases, the performance problem where the core can end up
> > 
> > By 'core', do you mean a logical CPU(hyperthread) or the entire core?
> No I really meant the entire core.
> 
> I’m sorry, I should have added a little bit more context. This relates
> to a performance issue we saw in v1 and discussed here:
> https://lore.kernel.org/lkml/20190410150116.GI2490@worktop.programming.kicks-ass.net/T/#mb9f1f54a99bac468fc5c55b06a9da306ff48e90b
> 
> We proposed a fix that solved this, Peter came up with a better one
> (https://lkml.org/lkml/2019/4/26/658), but if we add your isolation fix
> as posted above, the same problem reappears. Hope this clarifies your
> ask.

It's clear now, thanks.
I don't immediately see how my isolation fix would make your fix stop
working, will need to check. But I'm busy with other stuffs so it will
take a while.

> 
> I hope that we did not miss anything crucial while integrating your fix
> on top of v2 + Peter’s fix. The changes are conceptually similar, but we
> refactored it slightly to make the logic clear. Please have a look and
> let us know

I suppose you already have a branch that have all the bits there? I
wonder if you can share that branch somewhere so I can start working on
top of it to make sure we are on the same page?

Also, it would be good if you can share the workload, cmdline options,
how many workers need to start etc. to reproduce this issue.

Thanks.
