Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D8AC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 10:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70ACC20679
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 10:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SUr9JmM4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729726AbfHTKB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 06:01:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47778 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728771AbfHTKB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 06:01:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Mx9j1vcA5ukrzYfKVo8S3K0ZE7gj7ysWvhR9rwqxaXg=; b=SUr9JmM42ibRVhASeJkxJr3Vu
        ZhXVVD6IyzLt+Izc0+5kVFLuUcCqt7qCkh/Oako/mXtnMM/zGy4dRJoKesKi+yvaY668Iy6sAYiCx
        YaiCl1o903cAs4LT48rRuVzK29PAowqC1RbOTznJjOat2MobRCfhnR0mH59DbaPJ6+HWqkg+j2ZYt
        3dVys26IXtM43ooHJgGs2btEDvjRK/YGE3we61VhNjO6rchkl9QkeJ6bkqwBBjSADAIszaSvlevkV
        kkBPF3UtQYQZ2HOOjh+2hrjx0libauJr2nwJvzlM7Bv1f75cjOSrG6RFrmYv6ucxzfdnu9CQOJC7H
        Jllb+0DFQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i00xg-0000mk-Sg; Tue, 20 Aug 2019 10:01:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 95E79307691;
        Tue, 20 Aug 2019 12:01:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A309520CE7747; Tue, 20 Aug 2019 12:01:54 +0200 (CEST)
Date:   Tue, 20 Aug 2019 12:01:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kyle Meyer <meyerk@hpe.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org,
        Russ Anderson <russ.anderson@hpe.com>,
        Kyle Meyer <kyle.meyer@hpe.com>
Subject: Re: [PATCH v3 0/6] perf: Replace MAX_NR_CPUS with dynamic
 alternatives
Message-ID: <20190820100154.GJ2332@hirez.programming.kicks-ass.net>
References: <20190819202241.87799-1-meyerk@stormcage.eag.rdlabs.hpecorp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819202241.87799-1-meyerk@stormcage.eag.rdlabs.hpecorp.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 03:22:41PM -0500, Kyle Meyer wrote:
> The purpose of this patch series is to replace MAX_NR_CPUS with a dynamic value
> throughout perf wherever possible using nr_cpus_online, the number of CPUs
> online during a record session, and cpu__max_cpu, the possible number of CPUs as
> defined in the sysfs. MAX_NR_CPUS is still used by DECLARE_BITMAP at compile
> time, however, it's replaced elsewhere.
> 
> This patch series was tested using "perf record -a -g" on both an eight socket
> (288 CPU) system and a single socket (36 CPU) system. Each system was then
> rebooted single socket and eight socket before "perf report" was used to read
> the perf.data out file. "perf report --header" was used to confirm that each
> perf.data file had information on the correct number of CPUs.
> 
> Change since v1:
>   Broke PATCH 2/2 into multiple patches.
> 
> Changes since v2:
>   Replaced env->sibling_cores and env->sibling threads with a local pointer and
>   refreshed perf/util/svghelper.
> 
>   Kyle Meyer (6):
>     perf: Refactor svg_build_topology_map
>     perf/util/svghelper: Replace MAX_NR_CPUS with env->nr_cpus_online
>     perf/util/stat: Replace MAX_NR_CPUS with cpu__max_cpu
>     perf/util/session: Replace MAX_NR_CPUS with nr_cpus_online
>     perf/util/machine: Replace MAX_NR_CPUS with nr_cpus_online
>     perf/util/header: Replace MAX_NR_CPUS with cpu__max_cpu

Your series isn't threaed; please play with your git-sendmail (or
whatever other tool you use) arguments.
