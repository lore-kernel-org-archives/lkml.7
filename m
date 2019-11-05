Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FAB3C5DF60
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 20:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEBC521929
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 20:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Lte/JsUd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729312AbfKEUQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 15:16:28 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46826 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbfKEUQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 15:16:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VeD7M+kok91AM62yaKIfmwagN54YDmvxDwDCuPkuOns=; b=Lte/JsUdR5b+7q9J0O2hiuAUn
        DXXScohGAz1tglK9ZBdLGrkuOqN0SvsoD5VeQ2qer//ZQ1scH49kjPPw7Kf3V009ScK3zwXR0W6e6
        eHD9jAgXFwbiZR3qC8evovqEQc4Nd2ixcysE9+GS9ewW04C3aHXrR5azB3R1xT02x79XrmWoBZ76C
        nkr14Af93PMGc4IvNeL7mtc2b73nIUC2fHjsvumozbYkO2IDx3qpvxiUtOpqtPLt4eN5rYTNfpdPV
        jOGSyHjJvvUWBpRgYS6754+DWebnczMv4wB83WR+hhMufJX9PawjfbORjAeUSKeS+1HHiPHPJCxJT
        BMhhTUw4g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iS5FZ-0003PY-BT; Tue, 05 Nov 2019 20:16:25 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 585F9980D26; Tue,  5 Nov 2019 21:16:23 +0100 (CET)
Date:   Tue, 5 Nov 2019 21:16:23 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "acme@kernel.org" <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v6] perf: Sharing PMU counters across compatible events
Message-ID: <20191105201623.GG3079@worktop.programming.kicks-ass.net>
References: <20190919052314.2925604-1-songliubraving@fb.com>
 <20191031124332.GQ4131@hirez.programming.kicks-ass.net>
 <19AE6C78-C54C-4C37-BBD2-0396BB97A474@fb.com>
 <98A6264C-B833-4930-95A0-2A3186519D87@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98A6264C-B833-4930-95A0-2A3186519D87@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2019 at 05:11:08PM +0000, Song Liu wrote:

> > I think we can use one of the event as master. We need to be careful when
> > the master event is removed, but it should be doable. Let me try. 
> 
> Actually, there is a bigger issue when we use one event as the master: what
> shall we do if the master event is not running? Say it is an cgroup event, 
> and the cgroup is not running on this cpu. An extra master (and all these
> array hacks) help us get O(1) complexity in such scenario. 
> 
> Do you have suggestions on how to solve this problem? Maybe we can keep the 
> extra master, and try get rid of the double alloc? 

Right, you have to consider scope when sharing. The master should be the
largest scope event and any slaves should be complete subsets.

Without much thought this seems a fairly straight forward constraint;
that is, given cgroups I'm not immediately seeing how we can violate
that.

Basically, pick the cgroup event nearest to the root as the master.
We have to have logic to re-elect the master anyway for deletion, so
changing it on add shouldn't be different.

(obviously the root-cgroup is cpu-wide and always on, and if you have
two events from disjoint subtrees they have no overlap, so it doesn't
make sense to share anyway)

