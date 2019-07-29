Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE306C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFF51217D6
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564434939;
	bh=HYbER9iZ7+L0sdsBqbcYPADmrwv/PS2BEhCdnK6c1ro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AcXBordMH5vBq1dJFpeIaES5omImMiVXEFeGEfaR4L8pXcw1kFTdflomh4NtK9RlW
	 gfzHgsAQYJfXFzYYAOIXMbMyYGFCnFtuHxKEuHh0NjGsADswBD7VtMfp6NI35KRGao
	 bzSMPKsE1yT9roZ2Op+lCYBZbFn/AmNr7YmwcnTk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388820AbfG2VPi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 17:15:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:57520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388659AbfG2VPh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 17:15:37 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3735D2171F;
        Mon, 29 Jul 2019 21:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564434936;
        bh=HYbER9iZ7+L0sdsBqbcYPADmrwv/PS2BEhCdnK6c1ro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K1FKc4+nhwW5S0Y7szMNVuw/TCVDhnSPsa+JXYKlCXI7tSHocR4CwgP+8HfBvDHuk
         Jo7Z1md5uifrNKXXZYBFxe3t8smjYUMwt09IVINXmKDK7sl2LkC4bTyvMXgo8xffiu
         ndcXtu11Ug2mSCIbTAdkjScdbxhRheulT84w7sRY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Vince Weaver <vincent.weaver@maine.edu>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 09/12] perf header: Fix divide by zero error if f_header.attr_size==0
Date:   Mon, 29 Jul 2019 18:14:56 -0300
Message-Id: <20190729211456.6380-10-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190729211456.6380-1-acme@kernel.org>
References: <20190729211456.6380-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vince Weaver <vincent.weaver@maine.edu>

So I have been having lots of trouble with hand-crafted perf.data files
causing segfaults and the like, so I have started fuzzing the perf tool.

First issue found:

If f_header.attr_size is 0 in the perf.data file, then perf will crash
with a divide-by-zero error.

Committer note:

Added a pr_err() to tell the user why the command failed.

Signed-off-by: Vince Weaver <vincent.weaver@maine.edu>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/alpine.DEB.2.21.1907231100440.14532@macbook-air
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 20111f8da5cb..47877f0f6667 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3559,6 +3559,13 @@ int perf_session__read_header(struct perf_session *session)
 			   data->file.path);
 	}
 
+	if (f_header.attr_size == 0) {
+		pr_err("ERROR: The %s file's attr size field is 0 which is unexpected.\n"
+		       "Was the 'perf record' command properly terminated?\n",
+		       data->file.path);
+		return -EINVAL;
+	}
+
 	nr_attrs = f_header.attrs.size / f_header.attr_size;
 	lseek(fd, f_header.attrs.offset, SEEK_SET);
 
-- 
2.21.0

