Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC4BAC7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 23:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A643C21783
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 23:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VgBhx7Sj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731496AbfGQXss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 19:48:48 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44428 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbfGQXss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 19:48:48 -0400
Received: by mail-qt1-f195.google.com with SMTP id 44so25200387qtg.11
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 16:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zMchTV0CYGbg84sqbUscTEiGoh4ZNOfQBOF6+rYvMvM=;
        b=VgBhx7SjnU3aZWxmPPQ2OoUR9AH7Ta3hf+GdlK3DVLa2MW+A0jF0E2jD69VmSHpxPv
         lL82mFXM7Qwr+KqED4MQHbVdf36MgHttYMYWfpGU0+uWWf4gx6EbKz/NlD0xhdtpwdkV
         DdbF+5BarySc6ilWcFeO0g35W58aj7t8yBh/tvvpU/kZ8GKVa10uv/Aba+8e4AYEvTOR
         daqWQh2Wd0xc6UzedoxtaSO7uzNR2oybC28KnGQDEyGzcyjkVaT3CgWUO9Cv2GiGh7pQ
         0B8RFd7cDzjrJKMoWDfc7413dzcnwPdjVBTsLL3+hI436TV9jAIvMbDKC4sA14yr8K3L
         RU4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zMchTV0CYGbg84sqbUscTEiGoh4ZNOfQBOF6+rYvMvM=;
        b=brxZYrVSNGtdVfufzxEc8ODvTdJ+DOrJtmACiDo8CPqM3tjCsOCDfeByu2N8brbmlj
         X5iHZaLXTQUeY8wsky0/mnoiLUebbL3xLASJvFSWgjRjwD3HnoE6jXAjektqkbEjWpBe
         VblKQfqWckVgzg4JrfFL5LPgAYGGaqs1lYK57hQw/C/6D/47t/Rp/nfVjhhL/WEamZcI
         hLk+JrdesRnwI/RhYuwdlzzn6kF1H+jFcWCybNXGpqWFGL+1jR8tiz3yxTRpQyEpY3+y
         agkGjGrDjS5DgIww0KQ2IAb55PE5S5HTxMwVFZbZ4qXZNvdaSFE30RWrZWg0TYls7CHS
         q9QQ==
X-Gm-Message-State: APjAAAU1Dr6Q2iR+Ucb+oQcyaNbrc8RNBXfa8BIfpwGQ69cEPqEZaaQb
        LakSGetJ3rO+8jkGXVpKz9E=
X-Google-Smtp-Source: APXvYqzlSQQ+b4nkykJC7U4GMAh2MVDrTs/BEs9rkpDbWwTUiFAuTrY7RGOHX+VTyxc6JU7RBgWlbQ==
X-Received: by 2002:ac8:2379:: with SMTP id b54mr30357888qtb.168.1563407326563;
        Wed, 17 Jul 2019 16:48:46 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id t6sm11477750qkh.129.2019.07.17.16.48.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 17 Jul 2019 16:48:45 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4BD6C40340; Wed, 17 Jul 2019 20:48:43 -0300 (-03)
Date:   Wed, 17 Jul 2019 20:48:43 -0300
To:     Igor Lubashev <ilubashe@akamai.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        James Morris <jmorris@namei.org>
Subject: Re: [PATCH 1/3] perf: Add capability-related utilities
Message-ID: <20190717234843.GK3624@kernel.org>
References: <1562112605-6235-1-git-send-email-ilubashe@akamai.com>
 <1562112605-6235-2-git-send-email-ilubashe@akamai.com>
 <20190716084643.GA22317@krava>
 <20190717210551.GI3624@kernel.org>
 <20190717234652.GJ3624@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190717234652.GJ3624@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jul 17, 2019 at 08:46:52PM -0300, Arnaldo Carvalho de Melo escreveu:
> I'll do it if there is any difficulty, just not right now as I'm busy
> and want to get a pull req out of the door.

Also please find the first patch fixed up wrt a conflict with the
pythong binding, please use it instead as that is what applies to my
current perf/core branch.

It has the ack from Alexey and one I think Jiri would provide, judging
from his positive tone to the patches :)

- Arnaldo

commit 8048a0884a3f98bae2434d141711d72382b784b0
Author: Igor Lubashev <ilubashe@akamai.com>
Date:   Wed Jul 17 20:39:03 2019 -0300

    perf tools: Add capability-related utilities
    
    Add utilities to help checking capabilities of the running process.
    Make perf link with libcap.
    
    Signed-off-by: Igor Lubashev <ilubashe@akamai.com>
    Acked-by: Alexey Budankov <alexey.budankov@linux.intel.com>
    Acked-by: Jiri Olsa <jolsa@kernel.org>
    CC: Alexander Shishkin <alexander.shishkin@linux.intel.com>
    Cc: James Morris <jmorris@namei.org>
    Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
    Link: https://lkml.kernel.org/r/1562112605-6235-2-git-send-email-ilubashe@akamai.com
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 89ac5a1f1550..b9cf084f32d7 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -259,7 +259,7 @@ CXXFLAGS += -Wno-strict-aliasing
 # adding assembler files missing the .GNU-stack linker note.
 LDFLAGS += -Wl,-z,noexecstack
 
-EXTLIBS = -lpthread -lrt -lm -ldl
+EXTLIBS = -lpthread -lrt -lm -ldl -lcap
 
 ifeq ($(FEATURES_DUMP),)
 include $(srctree)/tools/build/Makefile.feature
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 14f812bb07a7..61ed1a3005d4 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -1,6 +1,7 @@
 perf-y += annotate.o
 perf-y += block-range.o
 perf-y += build-id.o
+perf-y += cap.o
 perf-y += config.o
 perf-y += ctype.o
 perf-y += db-export.o
diff --git a/tools/perf/util/cap.c b/tools/perf/util/cap.c
new file mode 100644
index 000000000000..c42ea32663cf
--- /dev/null
+++ b/tools/perf/util/cap.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Capability utilities
+ */
+#include "cap.h"
+#include <stdbool.h>
+#include <sys/capability.h>
+
+bool perf_cap__capable(cap_value_t cap)
+{
+	cap_flag_value_t val;
+	cap_t caps = cap_get_proc();
+
+	if (!caps)
+		return false;
+
+	if (cap_get_flag(caps, cap, CAP_EFFECTIVE, &val) != 0)
+		val = CAP_CLEAR;
+
+	if (cap_free(caps) != 0)
+		return false;
+
+	return val == CAP_SET;
+}
diff --git a/tools/perf/util/cap.h b/tools/perf/util/cap.h
new file mode 100644
index 000000000000..5521de78b228
--- /dev/null
+++ b/tools/perf/util/cap.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __PERF_CAP_H
+#define __PERF_CAP_H
+
+#include <stdbool.h>
+#include <sys/capability.h>
+
+bool perf_cap__capable(cap_value_t cap);
+
+#endif /* __PERF_CAP_H */
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 1f1da6082806..b4128f72f2e8 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -851,6 +851,7 @@ void  cpu_map_data__synthesize(struct cpu_map_data *data, struct cpu_map *map,
 void event_attr_init(struct perf_event_attr *attr);
 
 int perf_event_paranoid(void);
+bool perf_event_paranoid_check(int max_level);
 
 extern int sysctl_perf_event_max_stack;
 extern int sysctl_perf_event_max_contexts_per_stack;
diff --git a/tools/perf/util/python-ext-sources b/tools/perf/util/python-ext-sources
index ceb8afdf9a89..afba10684b65 100644
--- a/tools/perf/util/python-ext-sources
+++ b/tools/perf/util/python-ext-sources
@@ -9,6 +9,7 @@ util/python.c
 ../lib/ctype.c
 util/evlist.c
 util/evsel.c
+util/cap.c
 util/cpumap.c
 util/memswap.c
 util/mmap.c
diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index a61535cf1bca..4f0da8a03697 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -16,10 +16,12 @@
 #include <string.h>
 #include <errno.h>
 #include <limits.h>
+#include <linux/capability.h>
 #include <linux/kernel.h>
 #include <linux/log2.h>
 #include <linux/time64.h>
 #include <unistd.h>
+#include "cap.h"
 #include "strlist.h"
 #include "string2.h"
 
@@ -443,6 +445,13 @@ int perf_event_paranoid(void)
 
 	return value;
 }
+
+bool perf_event_paranoid_check(int max_level)
+{
+	return perf_cap__capable(CAP_SYS_ADMIN) ||
+			perf_event_paranoid() <= max_level;
+}
+
 static int
 fetch_ubuntu_kernel_version(unsigned int *puint)
 {
