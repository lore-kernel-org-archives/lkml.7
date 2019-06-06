Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A1CC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 14:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3811620866
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 14:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728920AbfFFOqU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 10:46:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57544 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727603AbfFFOqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 10:46:20 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 09BF03082B5A;
        Thu,  6 Jun 2019 14:46:19 +0000 (UTC)
Received: from krava (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id B5EA95C68C;
        Thu,  6 Jun 2019 14:46:15 +0000 (UTC)
Date:   Thu, 6 Jun 2019 16:46:14 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     ufo19890607 <ufo19890607@gmail.com>, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, dsahern@gmail.com, namhyung@kernel.org,
        milian.wolff@kdab.com, arnaldo.melo@gmail.com,
        yuzhoujian@didichuxing.com, adrian.hunter@intel.com,
        wangnan0@huawei.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, acme@redhat.com
Subject: Re: [PATCH] perf record: Add support to collect callchains from
 kernel or user space only.
Message-ID: <20190606144614.GC12056@krava>
References: <1559222962-22891-1-git-send-email-ufo19890607@gmail.com>
 <20190606142644.GA21245@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606142644.GA21245@kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Thu, 06 Jun 2019 14:46:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2019 at 11:26:44AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, May 30, 2019 at 02:29:22PM +0100, ufo19890607 escreveu:
> > From: yuzhoujian <yuzhoujian@didichuxing.com>
> > 
> > One can just record callchains in the kernel or user space with
> > this new options. We can use it together with "--all-kernel" options.
> > This two options is used just like print_stack(sys) or print_ustack(usr)
> > for systemtap.
> > 
> > Show below is the usage of this new option combined with "--all-kernel"
> > options.
> > 	1. Configure all used events to run in kernel space and just
> > collect kernel callchains.
> > 	$ perf record -a -g --all-kernel --kernel-callchains
> > 	2. Configure all used events to run in kernel space and just
> > collect user callchains.
> > 	$ perf record -a -g --all-kernel --user-callchains
> > 
> > Signed-off-by: yuzhoujian <yuzhoujian@didichuxing.com>
> > ---
> >  tools/perf/Documentation/perf-record.txt | 6 ++++++
> >  tools/perf/builtin-record.c              | 4 ++++
> >  tools/perf/perf.h                        | 2 ++
> >  tools/perf/util/evsel.c                  | 4 ++++
> >  4 files changed, 16 insertions(+)
> > 
> > diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
> > index de269430720a..b647eb3db0c6 100644
> > --- a/tools/perf/Documentation/perf-record.txt
> > +++ b/tools/perf/Documentation/perf-record.txt
> > @@ -490,6 +490,12 @@ Configure all used events to run in kernel space.
> >  --all-user::
> >  Configure all used events to run in user space.
> >  
> > +--kernel-callchains::
> > +Collect callchains from kernel space.
> 
> Ok, changing this to:
> 
> Collect callchains only from kernel space. I.e. this option sets
> perf_event_attr.exclude_callchain_user to 1,
> perf_event_attr.exclude_callchain_kernel to 0.
> 
> > +
> > +--user-callchains::
> > +Collect callchains from user space.
> 
> And this one to:
> Collect callchains only from user space. I.e. this option sets
> 
> perf_event_attr.exclude_callchain_kernel to 1,
> perf_event_attr.exclude_callchain_user to 0.
> 
> 
> So that the user don't try using:
> 
>     pref record --user-callchains --kernel-callchains
> 
> expecting to get both user and kernel callchains and instead gets
> nothing.

good catch.. we should add the logic to keep both (default)
in this case.. so do nothing ;-)

jirka
