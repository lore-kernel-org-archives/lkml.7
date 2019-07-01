Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49EADC0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 08:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B942208C4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 08:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SMUqxFM4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbfGAI2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 04:28:07 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33220 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727128AbfGAI2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 04:28:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oszolt4orpn1bZybcUau2wyUN6L/sUDbXOH91rXVyy0=; b=SMUqxFM4P4C2UiBbKHy3FMNb6
        MnhsZZ01N/kzN5zFGsMVT6qgPyH9/IO47w8NTvhHeRGGD+ogjJtk472nfTLeo1IJpwmsHmlxfiHJH
        DUBqGijMNHXcOlEQxexGVeEZWdbbqYegkQX+Nnse4YcY7ncJmkPtQYwbkzmz5iyP+vrAIbDA8gacT
        zKIdqHIxvD3troqQPGpzNEPSmQhIm1eZN/6dBcWXldfR44nFGip/EghWtubw/AdQkE6kOs2cDWFio
        l41aY1itmzf24lKJvMPMwHQyk4RUPrXTg8CB88kXARQaCnWaXq331uuROsc6alK47JBSbl1dluQiN
        rqYH0XfFg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hhreu-0004an-HB; Mon, 01 Jul 2019 08:27:32 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1268320963E24; Mon,  1 Jul 2019 10:27:31 +0200 (CEST)
Date:   Mon, 1 Jul 2019 10:27:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     mingo@redhat.com, rostedt@goodmis.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org, lizefan@huawei.com,
        cgroups@vger.kernel.org, Prateek Sood <prsood@codeaurora.org>
Subject: Re: [PATCH v8 6/8] cgroup/cpuset: Change cpuset_rwsem and hotplug
 lock order
Message-ID: <20190701082731.GP3402@hirez.programming.kicks-ass.net>
References: <20190628080618.522-1-juri.lelli@redhat.com>
 <20190628080618.522-7-juri.lelli@redhat.com>
 <20190628130308.GU3419@hirez.programming.kicks-ass.net>
 <20190701065233.GA26005@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701065233.GA26005@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 01, 2019 at 08:52:33AM +0200, Juri Lelli wrote:
> Hi,
> 
> On 28/06/19 15:03, Peter Zijlstra wrote:
> > On Fri, Jun 28, 2019 at 10:06:16AM +0200, Juri Lelli wrote:
> > > cpuset_rwsem is going to be acquired from sched_setscheduler() with a
> > > following patch. There are however paths (e.g., spawn_ksoftirqd) in
> > > which sched_scheduler() is eventually called while holding hotplug lock;
> > > this creates a dependecy between hotplug lock (to be always acquired
> > > first) and cpuset_rwsem (to be always acquired after hotplug lock).
> > > 
> > > Fix paths which currently take the two locks in the wrong order (after
> > > a following patch is applied).
> > > Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> > 
> > This all reminds me of this:
> > 
> >   https://lkml.kernel.org/r/1510755615-25906-1-git-send-email-prsood@codeaurora.org
> > 
> > Which sadly got reverted again. If we do this now (I've always been a
> > proponent), then we can make that rebuild synchronous again, which
> > should also help here IIRC.
> 
> Why was that reverted? Perf regression of some type?

IIRC TJ figured it wasn't strictly required to fix the lock invertion at
that time and they sorted it differently. If I (re)read the thread
correctly the other day, he didn't have fundamental objections against
it, but wanted the simpler fix.
