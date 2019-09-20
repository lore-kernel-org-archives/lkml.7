Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC84FC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 18:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE8582086A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 18:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T06PkeAM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406483AbfITS6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 14:58:09 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36224 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406417AbfITS6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 14:58:09 -0400
Received: by mail-qk1-f193.google.com with SMTP id y189so8364192qkc.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 11:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hr3MeVBdlQG42007SWnObV8sbZ+3LIr/i0LOy/XBd40=;
        b=T06PkeAM3zCg7WLjhfPgo8tMSc3VoETlqnkSDboSThVcx0bNMpAtjXxQGMHjt5UDXd
         5z5kbIu8Q/l5MbqRAnYGH0CsFQZmCeJHmOtcpwxRZFf4Hisz7iB6PEZKsIy8FvcVXXNu
         +Z6Fk+JLWaZYJ09Z+3mAAEHft1ViUFD62vW8ONjL1L7Y89ogbcKIQ6tv/tWU8La3nozG
         7O6is2Xll025bDAuuV23qN3vsmWmdadvQAnwCNQ5CJ5Ek9BTvgPh4aFZd44TlWijsgeA
         SS0oo6H57aDSUl4/5c5ZM6Wv036rgUuNIt1H5Y+U9PaLBrSSPlpjCwhEOlMJQmBf+sbd
         8rYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hr3MeVBdlQG42007SWnObV8sbZ+3LIr/i0LOy/XBd40=;
        b=mXj0HA8gGeVKDszaDZCWd3K0+sXbuqiguQzMNBSox+8WwGHJk/8ifNtB6Z7LSFQaGs
         8Ol0A6QFM1J5UemclrhMA7tBgsN5zLevTeVmF+7/ebrG04GztxlY8qmDwtlVx5C0KRs8
         uz1kNys/y9O0GFCZ/WRJMYKisbfhw++XjOpcGVBzMdQnVfbjaEHOFZ3nIrVIPoo2VtlD
         i3NgedmelK91Mhlz5sN9aXigWtXMTj2YY1HtCuWnFCnRAPcvZ4U9/acj+a1arIaig9rX
         fvnTDw2td/swJlnmsaYa8OFjOqQU3OgFkwiWhLgQAbWSHtZ7MGM6scfGhjYDnDzKFCST
         rR6A==
X-Gm-Message-State: APjAAAV5c54wkrbyPVz+uwLKJoMkZp2fSIuL0C9EpqHgqeLgC5h5DVzc
        Z3/E5UJ2dVLkgfc3H5KNQ1M=
X-Google-Smtp-Source: APXvYqw6MTa3wppv8MVGLLqqZeaG7jRmRguiVhzM6ZHFt4wjy19LtySsu1prwWUXfIiH6NZU0+eZ6A==
X-Received: by 2002:a37:ac01:: with SMTP id e1mr5317760qkm.140.1569005888291;
        Fri, 20 Sep 2019 11:58:08 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([187.65.7.29])
        by smtp.gmail.com with ESMTPSA id z13sm1263213qkj.34.2019.09.20.11.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 11:58:07 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E629940340; Fri, 20 Sep 2019 15:58:04 -0300 (-03)
Date:   Fri, 20 Sep 2019 15:58:04 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, jeremie.galarneau@efficios.com,
        shawn@git.icu, tstoyanov@vmware.com, tglx@linutronix.de,
        alexey.budankov@linux.intel.com, adrian.hunter@intel.com,
        songliubraving@fb.com, ravi.bangoria@linux.ibm.com
Subject: Re: [PATCH V2]Perf:Return error code for perf_session__new function
 on failure
Message-ID: <20190920185804.GG4865@kernel.org>
References: <20190822071223.17892.45782.stgit@localhost.localdomain>
 <20190822100718.GD28439@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822100718.GD28439@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Aug 22, 2019 at 12:07:18PM +0200, Jiri Olsa escreveu:
> On Thu, Aug 22, 2019 at 12:50:49PM +0530, Mamatha Inamdar wrote:
> > This Patch is to return error code of perf_new_session function
> > on failure instead of NULL
> > ----------------------------------------------
> > Test Results:
> > 
> > Before Fix:
> > 
> > $ perf c2c report -input
> > failed to open nput: No such file or directory
> > 
> > $ echo $?
> > 0
> > ------------------------------------------
> > After Fix:
> > 
> > $ ./perf c2c report -input
> > failed to open nput: No such file or directory
> > 
> > $ echo $?
> > 254
> 
> [root@krava perf]# ./perf c2c report -input
> failed to open nput: No such file or directory
> [root@krava perf]# echo $?
> 255
> 
> hum, not sure why I'm getting 255.. but it looks good now
> 
> Reviewed-by: Jiri Olsa <jolsa@redhat.com>

You guys missed this one, that I've corrected in my tree, i.e.
TEST_ASSERT_VAL expects that second arg to be NULL in case of failure,
so we need to invert the result of IS_ERR(session) to keep the
expectation.

- Arnaldo

diff --git a/tools/perf/tests/topology.c b/tools/perf/tests/topology.c
index 7d845d913d7d..4a800499d7c3 100644
--- a/tools/perf/tests/topology.c
+++ b/tools/perf/tests/topology.c
@@ -8,6 +8,7 @@
 #include "session.h"
 #include "evlist.h"
 #include "debug.h"
+#include <linux/err.h>
 
 #define TEMPL "/tmp/perf-test-XXXXXX"
 #define DATA_SIZE	10
@@ -39,7 +40,7 @@ static int session_write_header(char *path)
 	};
 
 	session = perf_session__new(&data, false, NULL);
-	TEST_ASSERT_VAL("can't get session", session);
+	TEST_ASSERT_VAL("can't get session", !IS_ERR(session));
 
 	session->evlist = perf_evlist__new_default();
 	TEST_ASSERT_VAL("can't get evlist", session->evlist);
@@ -70,7 +71,7 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 	int i;
 
 	session = perf_session__new(&data, false, NULL);
-	TEST_ASSERT_VAL("can't get session", session);
+	TEST_ASSERT_VAL("can't get session", !IS_ERR(session));
 
 	/* On platforms with large numbers of CPUs process_cpu_topology()
 	 * might issue an error while reading the perf.data file section
