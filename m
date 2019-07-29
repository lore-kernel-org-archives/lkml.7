Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09546C76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD4A6206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Nvj7mcvG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388687AbfG2Ves (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 17:34:48 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60063 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388600AbfG2Ves (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 17:34:48 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6TLYVLH2941388
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 29 Jul 2019 14:34:31 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6TLYVLH2941388
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564436072;
        bh=2Q+gAWKnOwqPd2IiB5D58yU98y/gLGjiukjiCr8EDFs=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Nvj7mcvGZ+30ZxUvug23GrbFVML9KsM44FhzPopNJcUk1Pfv5gSDa4QyftKh722YE
         hk6UjlHqsWLD71WN3MJ6qXghu0RmqGyURxnEoEUX80WCmQowh92TGf/GACdo+zMJ3u
         /KgchqgaWnmQAhUnu8WwPz4Y2ogcJ4tWii1YwdKrbf3YQMJy+LuUlsAUbQuYNo+TNC
         v/552f8/D6sjYV6InqAq+EltZUjOiYRuFKOYl1FMeoADRR25/VLDi4/4v0zpM/jjXo
         1ZFmrY6e/M5khx2t+LrjWK0TxB8CKYxODyLODxvRqq8+V1UkZ8vvKG7Uyph1ZUUVA/
         lVCblWcqgUMxQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6TLYVji2941384;
        Mon, 29 Jul 2019 14:34:31 -0700
Date:   Mon, 29 Jul 2019 14:34:31 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Vince Weaver <tipbot@zytor.com>
Message-ID: <tip-7622236ceb167aa3857395f9bdaf871442aa467e@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, vincent.weaver@maine.edu,
        mingo@kernel.org, alexander.shishkin@linux.intel.com,
        peterz@infradead.org, hpa@zytor.com, acme@redhat.com,
        namhyung@kernel.org, tglx@linutronix.de, jolsa@redhat.com
Reply-To: tglx@linutronix.de, jolsa@redhat.com, namhyung@kernel.org,
          peterz@infradead.org, acme@redhat.com, hpa@zytor.com,
          alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
          mingo@kernel.org, vincent.weaver@maine.edu
In-Reply-To: <alpine.DEB.2.21.1907231100440.14532@macbook-air>
References: <alpine.DEB.2.21.1907231100440.14532@macbook-air>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf header: Fix divide by zero error if
 f_header.attr_size==0
Git-Commit-ID: 7622236ceb167aa3857395f9bdaf871442aa467e
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  7622236ceb167aa3857395f9bdaf871442aa467e
Gitweb:     https://git.kernel.org/tip/7622236ceb167aa3857395f9bdaf871442aa467e
Author:     Vince Weaver <vincent.weaver@maine.edu>
AuthorDate: Tue, 23 Jul 2019 11:06:01 -0400
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 09:03:43 -0300

perf header: Fix divide by zero error if f_header.attr_size==0

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
 
