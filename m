Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00DE8C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 12:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D02A522CF7
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 12:46:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729880AbfHTMq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 08:46:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33894 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727006AbfHTMq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 08:46:28 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A5B7E3084246;
        Tue, 20 Aug 2019 12:46:27 +0000 (UTC)
Received: from krava (unknown [10.43.17.33])
        by smtp.corp.redhat.com (Postfix) with SMTP id 7E60410016E9;
        Tue, 20 Aug 2019 12:46:25 +0000 (UTC)
Date:   Tue, 20 Aug 2019 14:46:24 +0200
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
Subject: [PATCH] libperf: Fix arch include paths
Message-ID: <20190820124624.GG24105@krava>
References: <20190721112506.12306-1-jolsa@kernel.org>
 <20190721112506.12306-29-jolsa@kernel.org>
 <20190818140436.GA21854@roeck-us.net>
 <20190818194032.GA10666@krava>
 <20190818212816.GA23921@roeck-us.net>
 <20190819082137.GA9637@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819082137.GA9637@krava>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Tue, 20 Aug 2019 12:46:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 10:21:37AM +0200, Jiri Olsa wrote:

SNIP

> > next-20190816, though the problem has been seen since at least
> > next-20190801. Mainline builds fine.
> > 
> > Here is the script I used to bisect the problem:
> > 
> > make mrproper
> > rm -rf /tmp/linux
> > mkdir /tmp/linux
> > make ARCH=x86_64 O=/tmp/linux defconfig
> > make -j40 ARCH=x86_64 O=/tmp/linux tools/perf
> > 
> > It looks like the problem is related to "ARCH=x86_64". In mainline,
> > x86_64 is replaced in the build command with x86. This is no longer
> > the case, and make now tries to include from tools/arch/x86_64/include/,
> > which doesn't exist. As it turns out, O=<destdir> is not needed to
> > reproduce the problem, only ARCH=x86_64 (or ARCH=i386).
> 
> aaargh.. you're right ;-) it's the SRCARCH, which should
> be used in libperf instead of ARCH
> 
> change below fixes that for me

attaching the full patch

jirka


---
Guenter Roeck reported problem with compilation
when the ARCH is specified:

  $ make ARCH=x86_64
  In file included from tools/include/asm/atomic.h:6:0,
                   from include/linux/atomic.h:5,
                   from tools/include/linux/refcount.h:41,
                   from cpumap.c:4: tools/include/asm/../../arch/x86/include/asm/atomic.h:11:10:
  fatal error: asm/cmpxchg.h: No such file or directory

The problem is that we don't use SRCARCH (the sanitized ARCH
version) and we don't get the proper include path.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Link: http://lkml.kernel.org/n/tip-408wq8mtajlvs9iir7qo9c84@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
-- 
2.21.0

