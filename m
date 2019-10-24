Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89306CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 15:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5485421D81
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 15:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P5Z9s7tQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409645AbfJXPPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 11:15:11 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36634 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409599AbfJXPPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 11:15:10 -0400
Received: by mail-qk1-f195.google.com with SMTP id y189so23757095qkc.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 08:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iAgomrDaaw+p9SyPDKe+DIwZEIKyPHeJdp6rMCsSqrc=;
        b=P5Z9s7tQX1G3oEdM4YkZvIy9JwZJm7c9n9mVSVcigEo+f08pPSB15O+iIGQQpa8iIM
         G3oOT++5AX46oumLuNw63gqOs1XcA+8gU94YEpASQyvBUu/+Vb1sPvW4JclYvp0wRC/Q
         YMSPhO+qnod1JwlDRe86ke+XVh6Pzokns3VnnCtu2LgOaBZWmk50vQILLjP1CdDojU6L
         wR4o17+y954XBO3kwDwXAPhXqd0Bb0kWtboPY48cuDnhNzrXBTyOH2SPpOXwC+g4rYLu
         1L+1AljcwUuqwQQdJXineJMQK76V3ejsnirZjuwI0dMsBTPJ5nZG9MyDB9R1slKaECww
         JAfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iAgomrDaaw+p9SyPDKe+DIwZEIKyPHeJdp6rMCsSqrc=;
        b=KNwrHhrQSiiFlvXVhiwcswncpV1XUdxNu+xKw3lg2ukpQx5bPwXutzNAe/wTAdFwu/
         uaCnqzpQ34UKTO3u4RLnjXFSXa242umG6a2zh3VAb4Gkgc/0YnLAnu3roGYAiAe42RF2
         N8w10cfOydIQ9aCUeiEgoRjak1jvwxn2T+5hOgpb7zGSGL8WH/CMoOKpcirSGVjk4WJm
         IVqnogLFaO218kgdKyQvIHqZz1VUlx7z4FfooLdIO19m3kQz3IJ/N0r9TFgNNJWHrFbX
         Vp67WsEcikJguYW4H7gv+vXhdTC+1QxQU6QnYFIP54HBd3zxdz0jKwKPol5Z4JOUf3Vv
         9DFQ==
X-Gm-Message-State: APjAAAWTSrWcB2rmzgXas7F3uBC8Oa+K1iIruAwXLQ+Vgj8HqqtQeOri
        HvaFOTBKp25W6W7Q8PxRxY1S6g==
X-Google-Smtp-Source: APXvYqzlH3likrYVsNYXLQ5BlmwDmJjy4QCkXxBYjW7RbaO6cE+XDl6ZAOSajy7ViS/coV1V3YT1lQ==
X-Received: by 2002:a37:f514:: with SMTP id l20mr1916565qkk.331.1571930109291;
        Thu, 24 Oct 2019 08:15:09 -0700 (PDT)
Received: from localhost.localdomain (li937-157.members.linode.com. [45.56.119.157])
        by smtp.gmail.com with ESMTPSA id l5sm4346073qtj.52.2019.10.24.08.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 08:15:08 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Coresight ML <coresight@lists.linaro.org>,
        Robert Walker <robert.walker@arm.com>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 1/4] perf cs-etm: Continuously record last branches
Date:   Thu, 24 Oct 2019 23:13:22 +0800
Message-Id: <20191024151325.28623-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191024151325.28623-1-leo.yan@linaro.org>
References: <20191024151325.28623-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Every time synthesize instruction sample, the last branches recording
will be reset.  This would be fine if the instruction period is big
enough, for example if we use the option '--itrace=i100000', the last
branch array is reset for every instruction sample (10000 instructions
per period); before generate the next instruction sample, there has the
enough packets coming to fill last branch array.  On the other hand,
if set a very small period, the packets will be significantly reduced
between two continuous instruction samples, thus if the last branch
array is reset for the previous instruction sample, it's almost empty
for the next instruction sample.

To allow the last branches to work for any instruction periods, this
patch avoids to reset the last branches for every instruction sample
and only reset it when flush the trace data.  The last branches will
be reset only for two cases, one is for trace starting, another case
is for discontinuous trace; thus it can continuously record last
branches.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/cs-etm.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index f5f855fff412..8be6d010ae84 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1153,9 +1153,6 @@ static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
 			"CS ETM Trace: failed to deliver instruction event, error %d\n",
 			ret);
 
-	if (etm->synth_opts.last_branch)
-		cs_etm__reset_last_branch_rb(tidq);
-
 	return ret;
 }
 
@@ -1486,6 +1483,10 @@ static int cs_etm__flush(struct cs_etm_queue *etmq,
 		tidq->prev_packet = tmp;
 	}
 
+	/* Reset last branches after flush the trace */
+	if (etm->synth_opts.last_branch)
+		cs_etm__reset_last_branch_rb(tidq);
+
 	return err;
 }
 
-- 
2.17.1

