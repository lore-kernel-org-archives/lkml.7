Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A70FBC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DF97218A0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559136997;
	bh=prJoLJpZvpsZ7UJpa2S3f+0ldYisIx7ao2Qz6rGLRPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FCIlKXDoX86ExVGFj2bVjwi6I0mz8Yn/zOewGwkSaaecsjqor5gIpupS7FTS6Vsij
	 5M0JTveyBHmviZoAhUqysKUL6/nHwKP/I9kIhJW9979Yc4dm2o5tUm1n+1jpVkGpgs
	 c32DBhLEkPHFiMHFicd/GGDIkCjmjb6aTozWoAuk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbfE2Ngg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 09:36:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:51478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726612AbfE2Nge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 09:36:34 -0400
Received: from quaco.ghostprotocols.net (unknown [177.195.211.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44F1D218DA;
        Wed, 29 May 2019 13:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559136993;
        bh=prJoLJpZvpsZ7UJpa2S3f+0ldYisIx7ao2Qz6rGLRPY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HN5hEzUTCGI5CbQvvtijWtU3iC/sD50QQGQw/fPE7bCkLBM0z+846kNRMqnnNTGVP
         gldpr+h12lgYxO57+W/K1u/BeUJOt1YnoPsWLu0J4H73im0273qsVb7Q67mXVY3vW3
         Uol8R0UiWRt7lJL6/sfhOw7LQHMIuclII0HWtBDk=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>, stable@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 04/41] perf intel-pt: Fix itrace defaults for perf script intel-pt documentation
Date:   Wed, 29 May 2019 10:35:28 -0300
Message-Id: <20190529133605.21118-5-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190529133605.21118-1-acme@kernel.org>
References: <20190529133605.21118-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Fix intel-pt documentation to reflect the change of itrace defaults for
perf script.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: stable@vger.kernel.org
Fixes: 4eb068157121 ("perf script: Make itrace script default to all calls")
Link: http://lkml.kernel.org/r/20190520113728.14389-4-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/intel-pt.txt | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/Documentation/intel-pt.txt b/tools/perf/Documentation/intel-pt.txt
index 115eaacc455f..60d99e5e7921 100644
--- a/tools/perf/Documentation/intel-pt.txt
+++ b/tools/perf/Documentation/intel-pt.txt
@@ -88,16 +88,16 @@ smaller.
 
 To represent software control flow, "branches" samples are produced.  By default
 a branch sample is synthesized for every single branch.  To get an idea what
-data is available you can use the 'perf script' tool with no parameters, which
-will list all the samples.
+data is available you can use the 'perf script' tool with all itrace sampling
+options, which will list all the samples.
 
 	perf record -e intel_pt//u ls
-	perf script
+	perf script --itrace=ibxwpe
 
 An interesting field that is not printed by default is 'flags' which can be
 displayed as follows:
 
-	perf script -Fcomm,tid,pid,time,cpu,event,trace,ip,sym,dso,addr,symoff,flags
+	perf script --itrace=ibxwpe -F+flags
 
 The flags are "bcrosyiABEx" which stand for branch, call, return, conditional,
 system, asynchronous, interrupt, transaction abort, trace begin, trace end, and
@@ -713,7 +713,7 @@ Having no option is the same as
 
 which, in turn, is the same as
 
-	--itrace=ibxwpe
+	--itrace=cepwx
 
 The letters are:
 
-- 
2.20.1

