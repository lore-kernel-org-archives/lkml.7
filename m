Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFBDC41514
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B41182085A
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565748889;
	bh=iJ2AphE6ZzRAGaRt+wJ0Bb8PjZEF33PHMvOmFqoDPGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DZNMMaQE91nR5YbzIAxIiiWa1jP6bt6wRmQFT8VA47LNjoYHPZo3rkkszRYch66g3
	 W3AMN9Po2P6zgQDhWSkjx3WEzTQY8C6Z62r0cBDXRpFXZ6Rkcn5Yfr36z8YnDFe57N
	 kZrROrQOELUZ21JDCMVaLZ04N8zF2rXg6H91dSfY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbfHNCOs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 22:14:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:46584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728775AbfHNCOi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 22:14:38 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38A0E20842;
        Wed, 14 Aug 2019 02:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565748877;
        bh=iJ2AphE6ZzRAGaRt+wJ0Bb8PjZEF33PHMvOmFqoDPGE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cL5CYvq7/Cv8FOGqwmdSByqQgVewWirETx/zy+GyT2/+FnK6tNGwg5AUBEnS+C+0+
         gHXRvZjH81vHDcEwNMU1J6A+3xp4iulJ/6Ov6bZzvnZvcs2OpD1Wr3EMWBPWygTJHw
         tJ8woZIbqUdHJFUapeol+7D816HUe5lCXhFvxSnQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jin Yao <yao.jin@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.2 119/123] perf pmu-events: Fix missing "cpu_clk_unhalted.core" event
Date:   Tue, 13 Aug 2019 22:10:43 -0400
Message-Id: <20190814021047.14828-119-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190814021047.14828-1-sashal@kernel.org>
References: <20190814021047.14828-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

[ Upstream commit 8e6e5bea2e34c61291d00cb3f47560341aa84bc3 ]

The events defined in pmu-events JSON are parsed and added into perf
tool. For fixed counters, we handle the encodings between JSON and perf
by using a static array fixed[].

But the fixed[] has missed an important event "cpu_clk_unhalted.core".

For example, on the Tremont platform,

  [root@localhost ~]# perf stat -e cpu_clk_unhalted.core -a
  event syntax error: 'cpu_clk_unhalted.core'
                       \___ parser error

With this patch, the event cpu_clk_unhalted.core can be parsed.

  [root@localhost perf]# ./perf stat -e cpu_clk_unhalted.core -a -vvv
  ------------------------------------------------------------
  perf_event_attr:
    type                             4
    size                             112
    config                           0x3c
    sample_type                      IDENTIFIER
    read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
    disabled                         1
    inherit                          1
    exclude_guest                    1
  ------------------------------------------------------------
...

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190729072755.2166-1-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/pmu-events/jevents.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index 58f77fd0f59fe..ed5423d8a95fd 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -450,6 +450,7 @@ static struct fixed {
 	{ "inst_retired.any_p", "event=0xc0" },
 	{ "cpu_clk_unhalted.ref", "event=0x0,umask=0x03" },
 	{ "cpu_clk_unhalted.thread", "event=0x3c" },
+	{ "cpu_clk_unhalted.core", "event=0x3c" },
 	{ "cpu_clk_unhalted.thread_any", "event=0x3c,any=1" },
 	{ NULL, NULL},
 };
-- 
2.20.1

