Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A009C4CEC4
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 19:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 663912089F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 19:17:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733301AbfIWTRs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 15:17:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37930 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727327AbfIWTRr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 15:17:47 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B5F758535C;
        Mon, 23 Sep 2019 19:17:47 +0000 (UTC)
Received: from krava (ovpn-204-49.brq.redhat.com [10.40.204.49])
        by smtp.corp.redhat.com (Postfix) with SMTP id AB6E260852;
        Mon, 23 Sep 2019 19:17:45 +0000 (UTC)
Date:   Mon, 23 Sep 2019 21:17:44 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH 32/73] libperf: Move page_size into libperf
Message-ID: <20190923191744.GA12521@krava>
References: <20190913132355.21634-1-jolsa@kernel.org>
 <20190913132355.21634-33-jolsa@kernel.org>
 <20190923191036.GB13508@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190923191036.GB13508@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Mon, 23 Sep 2019 19:17:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 04:10:36PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Fri, Sep 13, 2019 at 03:23:14PM +0200, Jiri Olsa escreveu:
> > We need page_size in libperf, so moving it in there.
> > Adding libperf_init as a global libperf init functon.
> > 
> > Link: http://lkml.kernel.org/n/tip-g6auuaej31nsusuevuhcgxli@git.kernel.org
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/perf/lib/core.c                 | 7 +++++++
> >  tools/perf/lib/include/internal/lib.h | 2 ++
> >  tools/perf/lib/include/perf/core.h    | 1 +
> >  tools/perf/lib/lib.c                  | 2 ++
> >  tools/perf/lib/libperf.map            | 1 +
> >  tools/perf/perf.c                     | 4 ++--
> >  tools/perf/util/util.h                | 2 --
> 
> you forgot to remove it from tools/perf/util/util.c, I did it, and also
> added internal/lib.h to the places that use page_size, after this I'll
> remove that include from util/util.h, that header has to die :-)

ah right.. linker wouldn't fail because it's variable,
so there's no conflict..

thanks,
jirka
