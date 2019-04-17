Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8085C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 07:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8509217D7
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 07:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728788AbfDQHiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 03:38:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34696 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727013AbfDQHiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 03:38:02 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8AC00C049D7C;
        Wed, 17 Apr 2019 07:38:02 +0000 (UTC)
Received: from krava (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with SMTP id DDE37608C1;
        Wed, 17 Apr 2019 07:38:00 +0000 (UTC)
Date:   Wed, 17 Apr 2019 09:38:00 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH] perf tools: Fix perf_env__find_bpf_prog_info rb tree
 lookup
Message-ID: <20190417073800.GE17024@krava>
References: <20190416134151.15282-1-jolsa@kernel.org>
 <20190416142028.GH11294@kernel.org>
 <20190416143452.GB10125@krava>
 <20190416143554.GB2459@kernel.org>
 <20190416143748.GC2459@kernel.org>
 <48CA4238-740E-4B42-BDB1-C2DD85A558C3@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48CA4238-740E-4B42-BDB1-C2DD85A558C3@fb.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Wed, 17 Apr 2019 07:38:02 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 08:25:17PM +0000, Song Liu wrote:
> 
> 
> > On Apr 16, 2019, at 7:37 AM, Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:
> > 
> > Em Tue, Apr 16, 2019 at 11:35:54AM -0300, Arnaldo Carvalho de Melo escreveu:
> >> Em Tue, Apr 16, 2019 at 04:34:52PM +0200, Jiri Olsa escreveu:
> >>> On Tue, Apr 16, 2019 at 11:20:28AM -0300, Arnaldo Carvalho de Melo wrote:
> >>>> Em Tue, Apr 16, 2019 at 03:41:51PM +0200, Jiri Olsa escreveu:
> >>>>> We currently don't return NULL in case we don't find
> >>>>> the bpf_prog_info_node, fixing that.
> >>>> 
> >>>> Can you please try to figure out what was the changeset that introduced
> >>>> this problem so that we can have a Fixes: tag that helps me determine if
> >>>> this should go to perf/urgent (likely) or (perf/core) and to help the
> >>>> stable guys as well?
> >>> 
> >>> sry, I keep forgetting this..
> >>> 
> >>> Fixes: e4378f0cb90b ("perf bpf: Save bpf_prog_info in a rbtree in perf_env")
> >> 
> >> I had just added:
> >> 
> >> Fixes: e4378f0cb90b ("perf bpf: Save bpf_prog_info in a rbtree in perf_env")
> >> 
> >> matches, good :-)
> >> 
> >> At firts I thought hey the look checks for NULL, then, hey, different
> >> variable... good catch!
> > 
> > Ah, I also changed the summary from:
> > 
> >   "perf tools: Fix perf_env__find_bpf_prog_info rb tree"
> > 
> > to:
> > 
> >  perf bpf: Return NULL when RB tree lookup fails in perf_env__find_bpf_prog_info()
> > 
> > Thanks,
> > 
> > - Arnaldo
> 
> Thanks Jiri and Arnaldo!
> 
> I think we will need similar fix for perf_env__find_btf(). 

right, I'll post it

thanks,
jirka
