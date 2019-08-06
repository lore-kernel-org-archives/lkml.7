Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F93C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEC06218A6
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565127229;
	bh=9bJwhWoAq+fbPmlFOuszd3F4ICZ/q/B+B0LzeDuXGVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Alq/gP4hz2/Z3vyHhB37MT8DuuvYN1iRMQpNU5AwbgsQ4XR8Ybza71gKVX8uGHJ9H
	 KT/ejvqj1Oq+Vhi2Psu/mQoryCWIRumksOYHBaU5CEtjyt6nM9JOPDKaicHdmUD6TW
	 yQHFqaXbxXAW1nIZSPc6epZ7KAdPeWhRd8UKxdNQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbfHFVds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 17:33:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:51612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726238AbfHFVdq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 17:33:46 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC6EA217D7;
        Tue,  6 Aug 2019 21:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565127225;
        bh=9bJwhWoAq+fbPmlFOuszd3F4ICZ/q/B+B0LzeDuXGVM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z1xIFCY5QIJwI7NJj+d7QEcg3nErrJo8nzUN+dTdyEoIga+j89p494sFG++UahHI1
         fz//Lx2gHii3ObvRish8qDarCLH6RdIXVtc+r26lPxFScZIzIswyESMp75YdxY/vHS
         oKUvYz81Yas8tjOM3u6nMV1IpN9bdDJHRtGoK9aE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vince Weaver <vincent.weaver@maine.edu>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.2 16/59] perf header: Fix divide by zero error if f_header.attr_size==0
Date:   Tue,  6 Aug 2019 17:32:36 -0400
Message-Id: <20190806213319.19203-16-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190806213319.19203-1-sashal@kernel.org>
References: <20190806213319.19203-1-sashal@kernel.org>
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
index b82d4577d9694..fd543f209bd0a 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3478,6 +3478,13 @@ int perf_session__read_header(struct perf_session *session)
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
2.20.1

