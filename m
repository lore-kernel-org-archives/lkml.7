Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78549C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 08:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 380BE21A49
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 08:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HGfs3DRy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731575AbfKFI42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 03:56:28 -0500
Received: from merlin.infradead.org ([205.233.59.134]:47806 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbfKFI41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 03:56:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=44GvMM++gfwG+DDWQL/KQ5WsRQ+No/syq2kMB/W9GJ4=; b=HGfs3DRyCNhEWmsj1R5Jv6sk0
        WaGfT1Y2+97W8sSYa2mDoMzk0MOa9GaQzsO8rMPDiZBJxLi+xVvJkJZIyn009ddCqLr/mac5IQkhP
        dlgaRCadah8JjUjDN+GIvzWWNi3moA52/OtcCq3Kc2hDLtRgqiTIygViShjEPknWZoUUHYZplwd+M
        Oppk/8w45DTSFi5CFbrodyPVDyScKt7Ujop0kt1bOtHaVh3RyIVG7Lp87TBjro/tT1v9AsLT7TYy/
        +30yrNLvoMtSpB31RKp8l9rkWchjQkKp4+hRk616PXzIxrul1uvpyyadfLtdcPH9dYUJAB0+10ZiJ
        gU5nrvNcQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iSH6v-0004iG-9P; Wed, 06 Nov 2019 08:56:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0968D300692;
        Wed,  6 Nov 2019 09:55:12 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 067A629A4C2C4; Wed,  6 Nov 2019 09:56:16 +0100 (CET)
Date:   Wed, 6 Nov 2019 09:56:15 +0100
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
Message-ID: <20191106085615.GW4114@hirez.programming.kicks-ass.net>
References: <20190919052314.2925604-1-songliubraving@fb.com>
 <FAD07921-FB10-4FDD-9A81-48300EE24F20@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FAD07921-FB10-4FDD-9A81-48300EE24F20@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2019 at 11:51:42PM +0000, Song Liu wrote:

> > We allocate a separate perf_event for perf_event_dup->master. This needs
> > extra attention, because perf_event_alloc() may sleep. To allocate the
> > master event properly, a new pointer, tmp_master, is added to perf_event.
> > tmp_master carries a separate perf_event into list_[add|del]_event().
> > The master event has valid ->ctx and holds ctx->refcount.
> 
> If we do GFP_ATOMIC in perf_event_alloc(), maybe with an extra option, we
> don't need the tmp_master hack. So we only allocate master when we will 
> use it. 

You can't, that's broken on -RT. ctx->lock is a raw_spinlock_t and
allocator locks are spinlock_t.
