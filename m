Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9108C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 15:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86A8320848
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 15:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551799561;
	bh=r1A7pWQ6KLlFBl7c5XiSrrDKjq2oBeWfuNRsthOxMh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JoDcg502mWL/UF+QcZ+1wTLMZeLuSWFqPDbUfG1caX3Vv7+jG4whQLU9fpCnsCGBy
	 jMMyV+b2wJXtYs9IJAhuEnp4PbSpFohFKbzreGL/BMus3rAvpUALCqbmMb3ZreUYMJ
	 Kjm7/BeoMAkRK76VRMK/CDC+smqhmTjEDatOwRBw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728850AbfCEP0A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 10:26:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49422 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727739AbfCEPZ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 10:25:57 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8057BC0495A1;
        Tue,  5 Mar 2019 15:25:57 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.112])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4E6EC1001DF0;
        Tue,  5 Mar 2019 15:25:55 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
        Nageswara R Sastry <nasastry@in.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 7/8] perf tools: Fix double free in perf_data__close
Date:   Tue,  5 Mar 2019 16:25:35 +0100
Message-Id: <20190305152536.21035-8-jolsa@kernel.org>
In-Reply-To: <20190305152536.21035-1-jolsa@kernel.org>
References: <20190305152536.21035-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 05 Mar 2019 15:25:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can't call perf_data__close and subsequently
perf_session__delete, because it will call
perf_data__close again and cause double free
for data->file.path.

  $ perf report -i .
  incompatible file format (rerun with -v to learn more)
  free(): double free detected in tcache 2
  Aborted (core dumped)

In fact we don't need to call perf_data__close
at all, because at the time the got out_close
is reached, session->data is already initialized,
so the perf_data__close call will be triggered
from perf_session__delete.

Fixes: 2d4f27999b88 ("perf data: Add global path holder")
Link: http://lkml.kernel.org/n/tip-2g1zaoxmgmaxbuz8yvopq32v@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/session.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index c764bbc91009..db643f3c2b95 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -140,7 +140,7 @@ struct perf_session *perf_session__new(struct perf_data *data,
 
 		if (perf_data__is_read(data)) {
 			if (perf_session__open(session) < 0)
-				goto out_close;
+				goto out_delete;
 
 			/*
 			 * set session attributes that are present in perf.data
@@ -181,8 +181,6 @@ struct perf_session *perf_session__new(struct perf_data *data,
 
 	return session;
 
- out_close:
-	perf_data__close(data);
  out_delete:
 	perf_session__delete(session);
  out:
-- 
2.17.2

