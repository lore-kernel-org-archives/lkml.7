Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87CAFC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 20:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48CCB206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 20:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bbz8xNwS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbfHLU1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 16:27:12 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45419 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbfHLU1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 16:27:11 -0400
Received: by mail-qk1-f196.google.com with SMTP id m2so4146949qki.12
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 13:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9zeU09HvL8h4sQQ/WE4AQZf/AMEHoTVJyw4VstGuzg0=;
        b=bbz8xNwSmE0ajseU9lAnpKEuAIcEunhMu4RccUlNeUCFdhCL9MFdQ/KaQFJ/9JP+Ef
         K49I5xb4koGhAod6mCKlHr4At6WEmrK1SZkSzJQndo85oyyDkBr0+KtAQUBR8HJYpcST
         JTv5eI4q8DNxOZTus2sj4XKqXAsRKagTdM0I/HcLNGRzaMeoB/1C0qpNwsbtqyAfSuvD
         mI0ln3TjFFG9sR8nn3/x673FV5RdNdFhGXDS82l4+eIBeECJtK50cqMmHAOIDOwlHzTQ
         FScL9xCuWs4QJHn+R3El0eqm2cejEYwIL5fwxXdZ00zCmJlIevsbFysi6MOFL965x6wd
         POQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9zeU09HvL8h4sQQ/WE4AQZf/AMEHoTVJyw4VstGuzg0=;
        b=I7J3xJemrtrKSat+3XV6KOv9fr87YzV+ii8hx7SYwlGwLFJpb5d9A5kUvEKyyhwf0m
         EeND1ZtRvkGEC34hOnuzKZbXyz5MUJ3Lnu2I5KPMwBpcJJq4NfSZ3cSOn8hFrb3hPNie
         Ho/NpttAI5rMJtX7lO/GCIJjT4HcKHvuFIv2yAHu+/MMx0/mJI54e9jxq4U404HNsjwY
         mObsJ0B0oHTdIHwHsZvrXEQAlp31qfi68JNKskTitNnzx9U8j4rWLUgG6/9VUzHeamOf
         hC7ArDK9JPgsMy+XIUPTYBXIy/xulter99aq6tGkTd4Vyd7EFjpWR5B80zA6QHmRHTOq
         vC5Q==
X-Gm-Message-State: APjAAAVSV6uDrmqyjR+RlH2S0Lr52mafy6srjL9God4WN854QIY9+Mio
        qY4FdhSUOdWLjw1R98tgJtQ=
X-Google-Smtp-Source: APXvYqxtGY6lLemTlys1bRmIOk/IUxz9wbXRq/fv3QDB1ZrLtFk/1sLAFxqz6JTiOmiRoJgeGESzeQ==
X-Received: by 2002:a37:d245:: with SMTP id f66mr30971706qkj.59.1565641630935;
        Mon, 12 Aug 2019 13:27:10 -0700 (PDT)
Received: from quaco.ghostprotocols.net (187-26-98-68.3g.claro.net.br. [187.26.98.68])
        by smtp.gmail.com with ESMTPSA id t5sm2359942qkt.93.2019.08.12.13.27.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 13:27:10 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 70EC640340; Mon, 12 Aug 2019 17:27:06 -0300 (-03)
Date:   Mon, 12 Aug 2019 17:27:06 -0300
To:     Igor Lubashev <ilubashe@akamai.com>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@redhat.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        James Morris <jmorris@namei.org>
Subject: Re: [PATCH v3 4/4] perf: Use CAP_SYS_ADMIN instead of euid==0 with
 ftrace
Message-ID: <20190812202706.GH9280@kernel.org>
References: <cover.1565188228.git.ilubashe@akamai.com>
 <bd8763b72ed4d58d0b42d44fbc7eb474d32e53a3.1565188228.git.ilubashe@akamai.com>
 <20190812202251.GG9280@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812202251.GG9280@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Aug 12, 2019 at 05:22:51PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Aug 07, 2019 at 10:44:17AM -0400, Igor Lubashev escreveu:
> > Kernel requires CAP_SYS_ADMIN instead of euid==0 to mount debugfs for ftrace.
> > Make perf do the same.
> > 
> > Signed-off-by: Igor Lubashev <ilubashe@akamai.com>
> > ---
> >  tools/perf/builtin-ftrace.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> > index ae1466aa3b26..d09eac8a6d57 100644
> > --- a/tools/perf/builtin-ftrace.c
> > +++ b/tools/perf/builtin-ftrace.c
> > @@ -13,6 +13,7 @@
> >  #include <signal.h>
> >  #include <fcntl.h>
> >  #include <poll.h>
> > +#include <linux/capability.h>
> >  
> >  #include "debug.h"
> >  #include <subcmd/parse-options.h>
> > @@ -21,6 +22,7 @@
> >  #include "target.h"
> >  #include "cpumap.h"
> >  #include "thread_map.h"
> > +#include "util/cap.h"
> >  #include "util/config.h"
> >  
> >  
> > @@ -281,7 +283,7 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
> >  		.events = POLLIN,
> >  	};
> >  
> > -	if (geteuid() != 0) {
> > +	if (!perf_cap__capable(CAP_SYS_ADMIN)) {
> >  		pr_err("ftrace only works for root!\n");
> 
> I guess we should update the error message too? 
> 

I.e. I applied this as a follow up patch:

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 01a5bb58eb04..ba8b65c2f9dc 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -284,7 +284,12 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
 	};
 
 	if (!perf_cap__capable(CAP_SYS_ADMIN)) {
-		pr_err("ftrace only works for root!\n");
+		pr_err("ftrace only works for %s!\n",
+#ifdef HAVE_LIBCAP_SUPPORT
+		"users with the SYS_ADMIN capability"
+#else
+		"root"
+#endif
 		return -1;
 	}
 
