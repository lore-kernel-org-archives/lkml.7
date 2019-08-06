Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B921C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4444421874
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565127533;
	bh=X0bt+3bsoL7JQXhTEl0wIgpBBJJbdIw+VmG3y1NgqqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DxgRhQ8Llaiy6VfQIb2xAOn5Q6700lrZYmuW2Fpuq/39voDTj+XblgbmpTkVvHBBc
	 BgRBSJJa1CRmyv6FMLFULZOYmCLGEswZWoh343jxeS8Tt36IYE8FNe8lA4Z1L1Dqqc
	 AZt+9ikavl892tSlRugRrvcDcfnNLCBqUh0Dd6w4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729577AbfHFViC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 17:38:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:55644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729552AbfHFVh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 17:37:58 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CC622189E;
        Tue,  6 Aug 2019 21:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565127477;
        bh=X0bt+3bsoL7JQXhTEl0wIgpBBJJbdIw+VmG3y1NgqqE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hr5XxbBzjZqNCnCeehdDUy3EjhzIsfe+Bm1a00qjABKFwOgQmVCz3pGrSCjKDqj8z
         CfTNIt+WeCa21+cx2Qv3LfzdLFxi/9w3yadUy3ID5Sblr4DI3sNVGdCo6+SPkQtj/r
         HNFddmiUFSWWxkegix9+CDfdx2qQouX/3MuM3hjc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vince Weaver <vincent.weaver@maine.edu>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 04/14] perf header: Fix divide by zero error if f_header.attr_size==0
Date:   Tue,  6 Aug 2019 17:37:38 -0400
Message-Id: <20190806213749.20689-4-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190806213749.20689-1-sashal@kernel.org>
References: <20190806213749.20689-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vince Weaver <vincent.weaver@maine.edu>

[ Upstream commit 7622236ceb167aa3857395f9bdaf871442aa467e ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/header.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 304f5d7101436..0102dd46fb6da 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -2591,6 +2591,13 @@ int perf_session__read_header(struct perf_session *session)
 			   file->path);
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
2.20.1

