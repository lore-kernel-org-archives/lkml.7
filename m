Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF49C04AB3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 07:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B95F2070D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 07:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hsmtr1PN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbfE2H6U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 03:58:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38096 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbfE2H6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 03:58:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=eTzIyIsIhANQkHufqQlq2qJvls/5rd4T+vrQHg4KpWs=; b=hsmtr1PNQQf0yBzvqNzVtOf2/
        GvgmfM4f9gj2GHZ04EpguovXF7b5kZYz7bjdxA2HsR/3xcDgMxFyedU/S+/iPWqQrosPcxxxd1f68
        AOwkQ+wYXPpkfufTUff0QufKUcouxQos4yYdKrCxRnLUlzockuYykOL5cwYHewia/b9obdboHl8qm
        qYL3YAfbPQFikK8npSCgK/su5pHpe+xjEEsOAxWUxtLAepHDSJG8NValr1n4NfutMKFdaiDzLTKC+
        8SL47xnWGqFjHX93wfzYuHu9786Wbrm38vOB3sIDAm+diP7sS+HqeFrLBSXf/Ud9W30cGLCESQpIS
        hR+9iVjFw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hVtTU-0006QW-8A; Wed, 29 May 2019 07:58:16 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C066E201A7E41; Wed, 29 May 2019 09:58:14 +0200 (CEST)
Date:   Wed, 29 May 2019 09:58:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
Subject: Re: [PATCH 7/9] perf/x86/intel: Disable sampling read slots and
 topdown
Message-ID: <20190529075814.GC2623@hirez.programming.kicks-ass.net>
References: <20190521214055.31060-1-kan.liang@linux.intel.com>
 <20190521214055.31060-8-kan.liang@linux.intel.com>
 <20190528135224.GS2623@hirez.programming.kicks-ass.net>
 <27190331-6df7-239a-9ce7-f2e0a8c5d387@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27190331-6df7-239a-9ce7-f2e0a8c5d387@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 02:25:34PM -0400, Liang, Kan wrote:

> > > +static int icl_validate_group(struct cpu_hw_events *cpuc, int n)
> > > +{
> > > +	bool has_sampling_slots = false, has_metrics = false;
> > > +	struct perf_event *e;
> > > +	int i;
> > > +
> > > +	for (i = 0; i < n; i++) {
> > > +		e = cpuc->event_list[i];
> > > +		if (is_slots_event(e) && is_sampling_event(e))
> > > +			has_sampling_slots = true;
> > > +
> > > +		if (is_perf_metrics_event(e))
> > > +			has_metrics = true;
> > > +	}
> > > +	if (unlikely(has_sampling_slots && has_metrics))
> > > +		return -EINVAL;
> > > +	return 0;
> > > +}
> > 
> > Why this special hack, why not disallow sampling on SLOTS on creation?
> 
> You mean unconditionally disable SLOTS sampling?
> 
> The SLOTS doesn't have to be with Topdown metrics event.
> I think users may want to only sampling slot events. We should allow this
> usage.

Given the trainwreck these patches are, none of that is clear.
