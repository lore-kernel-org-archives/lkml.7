Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F72C28D1A
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 07:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABF5620866
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 07:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MM6OcPwA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbfFFH4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 03:56:48 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:39670 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbfFFH4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 03:56:46 -0400
Received: by mail-yb1-f195.google.com with SMTP id c5so600318ybk.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 00:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TbM9vdATYDfk/+/NGyr5Ij8vLHhNayhJciB4ayq0pHE=;
        b=MM6OcPwAJE1POnI9pGXHiBCNozL4ZBtxEn7ju0XByHG94g+QwzU/iiSy44DRpp3Unm
         FYPVos2EGcDv26xHAbZRORvla6calNQz4bJPO419a6f/RVB0FqB0wnH1K0bpliXR0snw
         7ot9cbH/X6rWk2AYvw88dVCramLl96KtBpZ1KfzV2MpsNBY4AyKGEvjdqNYoBwh/sjkW
         gUEd8CXA/N5zkn4EkSVFtCQDgodRSQ8TkO+0BilrhFBNsCQ9aIwwObLfuDN5/Oj/vvQl
         TW6ZP85+pOrzanq+88wrhLAf+HYTSw9GTGEEHwRyRLCTKy19juEFCNEovH81pwPXf6dP
         ohkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TbM9vdATYDfk/+/NGyr5Ij8vLHhNayhJciB4ayq0pHE=;
        b=U+BJ6df1akpHpsyYlKZMMEe+/LggLHU2HLulqrCNIwsxnd5ZY2twADtTGyFReRlohl
         U1Ln+t6C5ClmPOQTh1UFOHno/fxVKDNlnYa52FEru2XdtVyA/PVS3b4zJZE86aCeRTY0
         c2DDu4q7s3ujOXVLBFL3DvHiuQ4+FeAcoQ0mP/4gFjdBmFdTLuvvnHdEqvrt4YmSomVF
         NUI1B2PMn314VUO38ObRlSxkBX/6BoufUe1N00JhBxhieWyHicRlUwRE6Bj2PETSONlU
         MOiEp8CLHW5I4gm9cEFyLp/GtuMA7+lsPilgNMIFQDcXCJrFZABvdVK6a30JAL2b1aAT
         3I4g==
X-Gm-Message-State: APjAAAU/Pv/t2y5mCxqFkWlFwkVTDPoq8me+FDjRW3S6jFMuQknper6s
        mc0He6qxTTrPSE4DemukQGCYOQ==
X-Google-Smtp-Source: APXvYqyWosIZanguJxKE04Kd7LwXDfXHs6VXKz4KUpNZjHz3aUn6GagJhTSRzUxbsFQg51yD4tu8FA==
X-Received: by 2002:a25:410f:: with SMTP id o15mr20004920yba.328.1559807806138;
        Thu, 06 Jun 2019 00:56:46 -0700 (PDT)
Received: from localhost.localdomain (li1322-146.members.linode.com. [45.79.223.146])
        by smtp.gmail.com with ESMTPSA id 14sm316343yws.16.2019.06.06.00.56.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 00:56:45 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 1/4] perf trace: Exit when build eBPF program failure
Date:   Thu,  6 Jun 2019 15:56:14 +0800
Message-Id: <20190606075617.14327-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190606075617.14327-1-leo.yan@linaro.org>
References: <20190606075617.14327-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On my Juno board with ARM64 CPUs, perf trace command reports the eBPF
program building failure but the command will not exit and continue to
run.  If we define an eBPF event in config file, the event will be
parsed with below flow:

  perf_config()
    `> trace__config()
	 `> parse_events_option()
	      `> parse_events__scanner()
	           `-> parse_events_parse()
	                 `> parse_events_load_bpf()
	                      `> llvm__compile_bpf()

Though the low level functions return back error values when detect eBPF
building failure, but parse_events_option() returns 1 for this case and
trace__config() passes 1 to perf_config(); perf_config() doesn't treat
the returned value 1 as failure and it continues to parse other
configurations.  Thus the perf command continues to run even without
enabling eBPF event successfully.

This patch changes error handling in trace__config(), when it detects
failure it will return -1 rather than directly pass error value (1);
finally, perf_config() will directly bail out and perf will exit for
this case.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-trace.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 54b2d0fd0d02..4b5d004aab74 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3664,6 +3664,14 @@ static int trace__config(const char *var, const char *value, void *arg)
 					       "event selector. use 'perf list' to list available events",
 					       parse_events_option);
 		err = parse_events_option(&o, value, 0);
+
+		/*
+		 * When parse option successfully parse_events_option() will
+		 * return 0, otherwise means the paring failure.  And it
+		 * returns 1 for eBPF program building failure; so adjust the
+		 * err value to -1 for the failure.
+		 */
+		err = err ? -1 : 0;
 	} else if (!strcmp(var, "trace.show_timestamp")) {
 		trace->show_tstamp = perf_config_bool(var, value);
 	} else if (!strcmp(var, "trace.show_duration")) {
-- 
2.17.1

