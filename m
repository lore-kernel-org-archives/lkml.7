Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111BDC4649B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 11:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D59612133F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 11:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WcsTqYvu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbfGELol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 07:44:41 -0400
Received: from merlin.infradead.org ([205.233.59.134]:34034 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728720AbfGELol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 07:44:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GB9z2X2kiSu/g+dTCQzNwQSctFKoJ3JMCuL514Sc+jA=; b=WcsTqYvu4k7W5e5FC/whLSmAh
        bbBbHlTReAt1qYaGfSUqc+vfDxYv9VWpnG0SeI8/57ORrtZf9fMNQY5eIJAWF/TU90Aiz0tm84tp7
        thqSqC7B4kQ9M4AO7cX7exgMZ+cau2RleHkQOpZCJHe3ADWW0a4eYDVlqmEUcbqisInjUwjk827RB
        YvS6y9M5VCydBAzFZLKCrjTtt9D3o0LC746RoxIxGlDH6o5/HnfvIyLLXUMdXtx5rC2FlG9fmXGCo
        +Oq7c1ds9LkJjM6B6aYJqDnctyeAWmCaXMdA5zVkVOWYOWh7VPUZDD/WToWLriVLAvW7X5FwLktGz
        qACEVbPpw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hjMdo-0001Ph-GS; Fri, 05 Jul 2019 11:44:37 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4130B2026E806; Fri,  5 Jul 2019 13:44:35 +0200 (CEST)
Date:   Fri, 5 Jul 2019 13:44:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, kan.liang@linux.intel.com,
        mingo@redhat.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        ak@linux.intel.com
Subject: Re: [PATCH] perf/x86/intel: Fix spurious NMI on fixed counter
Message-ID: <20190705114435.GQ3402@hirez.programming.kicks-ass.net>
References: <20190625142135.22112-1-kan.liang@linux.intel.com>
 <20190625145834.GA8480@krava>
 <a0722e4d-4cae-7212-c8ec-a8d0c9edc08c@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0722e4d-4cae-7212-c8ec-a8d0c9edc08c@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 05, 2019 at 08:23:37AM +0800, Jin, Yao wrote:
> 
> 
> On 6/25/2019 10:58 PM, Jiri Olsa wrote:
> > On Tue, Jun 25, 2019 at 07:21:35AM -0700, kan.liang@linux.intel.com wrote:
> > > From: Kan Liang <kan.liang@linux.intel.com>
> > > 
> > > If a user first sample a PEBS event on a fixed counter, then sample a
> > > non-PEBS event on the same fixed counter on Icelake, it will trigger
> > > spurious NMI. For example,
> > > 
> > >    perf record -e 'cycles:p' -a
> > >    perf record -e 'cycles' -a
> > > 
> > > The error message for spurious NMI.
> > > 
> > >    [June 21 15:38] Uhhuh. NMI received for unknown reason 30 on CPU 2.
> > >    [  +0.000000] Do you have a strange power saving mode enabled?
> > >    [  +0.000000] Dazed and confused, but trying to continue
> > > 
> > > The issue was introduced by the following commit:
> > > 
> > >    commit 6f55967ad9d9 ("perf/x86/intel: Fix race in intel_pmu_disable_event()")
> > > 
> > > The commit moves the intel_pmu_pebs_disable() after
> > > intel_pmu_disable_fixed(), which returns immediately.
> > > The related bit of PEBS_ENABLE MSR will never be cleared for the fixed
> > > counter. Then a non-PEBS event runs on the fixed counter, but the bit
> > > on PEBS_ENABLE is still set, which trigger spurious NMI.
> > > 
> > > Check and disable PEBS for fixed counter after intel_pmu_disable_fixed().
> > > 
> > > Reported-by: Yi, Ammy <ammy.yi@intel.com>
> > > Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> > > Fixes: 6f55967ad9d9 ("perf/x86/intel: Fix race in intel_pmu_disable_event()")

> > oops, I overlooed this, looks good
> > 
> > Acked-by: Jiri Olsa <jolsa@kernel.org>

Have it now, thanks!
