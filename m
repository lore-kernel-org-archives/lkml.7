Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE8B3C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 08:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 889D62086C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 08:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbfHSIVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 04:21:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51206 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726366AbfHSIVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 04:21:41 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A6BB13060850;
        Mon, 19 Aug 2019 08:21:40 +0000 (UTC)
Received: from krava (unknown [10.43.17.33])
        by smtp.corp.redhat.com (Postfix) with SMTP id 8AABA17585;
        Mon, 19 Aug 2019 08:21:38 +0000 (UTC)
Date:   Mon, 19 Aug 2019 10:21:37 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH 28/79] libperf: Add perf_cpu_map struct
Message-ID: <20190819082137.GA9637@krava>
References: <20190721112506.12306-1-jolsa@kernel.org>
 <20190721112506.12306-29-jolsa@kernel.org>
 <20190818140436.GA21854@roeck-us.net>
 <20190818194032.GA10666@krava>
 <20190818212816.GA23921@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190818212816.GA23921@roeck-us.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Mon, 19 Aug 2019 08:21:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 18, 2019 at 02:28:16PM -0700, Guenter Roeck wrote:
> On Sun, Aug 18, 2019 at 09:40:32PM +0200, Jiri Olsa wrote:
> > On Sun, Aug 18, 2019 at 07:04:36AM -0700, Guenter Roeck wrote:
> > > On Sun, Jul 21, 2019 at 01:24:15PM +0200, Jiri Olsa wrote:
> > > > Adding perf_cpu_map struct into libperf.
> > > > 
> > > > It's added as a declaration into into:
> > > >   include/perf/cpumap.h
> > > > which will be included by users.
> > > > 
> > > > The perf_cpu_map struct definition is added into:
> > > >   include/internal/cpumap.h
> > > > 
> > > > which is not to be included by users, but shared
> > > > within perf and libperf.
> > > > 
> > > > We tried the total separation of the perf_cpu_map struct
> > > > in libperf, but it lead to complications and much bigger
> > > > changes in perf code, so we decided to share the declaration.
> > > > 
> > > > Link: http://lkml.kernel.org/n/tip-vhtr6a8apr7vkh2tou0r8896@git.kernel.org
> > > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > 
> > > Hi,
> > > 
> > > this patch causes out-of-tree builds (make O=<destdir>) to fail.
> > > 
> > > In file included from tools/include/asm/atomic.h:6:0,
> > >                  from include/linux/atomic.h:5,
> > > 		 from tools/include/linux/refcount.h:41,
> > > 		 from cpumap.c:4: tools/include/asm/../../arch/x86/include/asm/atomic.h:11:10:
> > > fatal error: asm/cmpxchg.h: No such file or directory
> > > 
> > > Bisect log attached.
> > 
> > hi,
> > I dont see any problem with v5.3-rc4, could you please send
> > the full compilation log (after make clean) from:
> > 
> >   $ make V=1 <your options>
> > 
> > also I can't make sense of that bisect, because I can't find
> > some of those commits.. what tree are you in?
> > 
> This is with -next, not with mainline. More specifically, with
> next-20190816, though the problem has been seen since at least
> next-20190801. Mainline builds fine.
> 
> Here is the script I used to bisect the problem:
> 
> make mrproper
> rm -rf /tmp/linux
> mkdir /tmp/linux
> make ARCH=x86_64 O=/tmp/linux defconfig
> make -j40 ARCH=x86_64 O=/tmp/linux tools/perf
> 
> It looks like the problem is related to "ARCH=x86_64". In mainline,
> x86_64 is replaced in the build command with x86. This is no longer
> the case, and make now tries to include from tools/arch/x86_64/include/,
> which doesn't exist. As it turns out, O=<destdir> is not needed to
> reproduce the problem, only ARCH=x86_64 (or ARCH=i386).

aaargh.. you're right ;-) it's the SRCARCH, which should
be used in libperf instead of ARCH

change below fixes that for me

thanks,
jirka


---
diff --git a/tools/perf/lib/Makefile b/tools/perf/lib/Makefile
index 8a9ae50818e4..a67efb8d9d39 100644
--- a/tools/perf/lib/Makefile
+++ b/tools/perf/lib/Makefile
@@ -59,7 +59,7 @@ else
   CFLAGS := -g -Wall
 endif
 
-INCLUDES = -I$(srctree)/tools/perf/lib/include -I$(srctree)/tools/include -I$(srctree)/tools/arch/$(ARCH)/include/ -I$(srctree)/tools/arch/$(ARCH)/include/uapi -I$(srctree)/tools/include/uapi
+INCLUDES = -I$(srctree)/tools/perf/lib/include -I$(srctree)/tools/include -I$(srctree)/tools/arch/$(SRCARCH)/include/ -I$(srctree)/tools/arch/$(SRCARCH)/include/uapi -I$(srctree)/tools/include/uapi
 
 # Append required CFLAGS
 override CFLAGS += $(EXTRA_WARNINGS)
