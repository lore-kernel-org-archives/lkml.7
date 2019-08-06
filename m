Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB5C7C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 740062189E
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565127404;
	bh=7zP639Yf+JAZfevormF1ky6aQLsAHxhcE9zk56ebQ14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2AOu4Y0UiwiYmilJVC3DqU2A16HxlgfFfB9z+Tk4DPMAY99zfxjk1yzTAcRfU3HZC
	 ad1Ox9CXJmMLn5jkshE9Fi6Owfok4bqrhWQRH9Zl3BTO7cVy1c7+lIUZf8ItTukQx/
	 qRt5UeEYoEQGjvgUsgnv2Wrs/25hyPiXyS3CRXHo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729066AbfHFVgn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 17:36:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:54454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727901AbfHFVgj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 17:36:39 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4F2E21873;
        Tue,  6 Aug 2019 21:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565127398;
        bh=7zP639Yf+JAZfevormF1ky6aQLsAHxhcE9zk56ebQ14=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c63xiqmLcBCbWhXDtmxPfWSubPlvdW7aJZVnLaCh2n2liRE0xwEN23n1TLgf/dHm5
         kwBXZHRPFexfPPdrETUmqLOY3mz2UtP69ZyzizdFQ6cnTXeAG9hdqHoZo1y0Gyqguw
         8wBEmEp7wLczWivctBn+CcnN+I9YODKm1ABSMS5I=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vince Weaver <vincent.weaver@maine.edu>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 07/25] perf header: Fix divide by zero error if f_header.attr_size==0
Date:   Tue,  6 Aug 2019 17:36:04 -0400
Message-Id: <20190806213624.20194-7-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190806213624.20194-1-sashal@kernel.org>
References: <20190806213624.20194-1-sashal@kernel.org>
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
index 26437143c9406..c78c2ed009ea0 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -2901,6 +2901,13 @@ int perf_session__read_header(struct perf_session *session)
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

