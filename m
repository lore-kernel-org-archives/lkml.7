Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE9DC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68AA522580
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559137125;
	bh=mfVl03+JldGddTH7mZZrjqAYZtBlRBS/GAL/B9LjS00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=el+OnD+lJ+lwo7R1enr5NtKcEWOlYDmJ9cTFYdVSshhg9gudLglQdqTTIMMkv79o8
	 3wvhtjgOwn8Bk3wIZiYmrIyE2a3dQBAY83GEV+vh5v367VJj9I7GTzlotnvbdbh2K7
	 pTApJ6t0IK/Z8sCEOU8xCoPIB5h4btz4q4nuo7FA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbfE2Nio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 09:38:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:54526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726863AbfE2Nio (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 09:38:44 -0400
Received: from quaco.ghostprotocols.net (unknown [177.195.211.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B77A223A1;
        Wed, 29 May 2019 13:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559137123;
        bh=mfVl03+JldGddTH7mZZrjqAYZtBlRBS/GAL/B9LjS00=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NeDKdOT8SudMdNsHMFrCv2+rU6zXsuHab9HZ7Hmr2A8Q7ussyD3jFOIkEcDbh93Mk
         qVqVoUaARBbhbLH6zG3jtbAe8fhvApZGfNEr42sDjitN6GwRMVhmvPaMGztwzAkvnt
         l3iZou/wUAFB1rXeHZLqJcGnKB9kh33fnzNSWgUc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 30/41] perf version: Append 12 git SHA chars to the version string
Date:   Wed, 29 May 2019 10:35:54 -0300
Message-Id: <20190529133605.21118-31-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190529133605.21118-1-acme@kernel.org>
References: <20190529133605.21118-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Bumping it from just 4:

Before:

  $ perf -v
  perf version 5.2.rc1.g80978f
  $

After:

  $ perf -v
  perf version 5.2.rc1.g80978fc864c5
  $

Requested-by: Ingo Molnar <mingo@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-p4yun2nxlo7eeeohyx5v4kw7@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/PERF-VERSION-GEN | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/PERF-VERSION-GEN b/tools/perf/util/PERF-VERSION-GEN
index 3802cee5e188..59241ff342be 100755
--- a/tools/perf/util/PERF-VERSION-GEN
+++ b/tools/perf/util/PERF-VERSION-GEN
@@ -19,7 +19,7 @@ TAG=
 if test -d ../../.git -o -f ../../.git
 then
 	TAG=$(git describe --abbrev=0 --match "v[0-9].[0-9]*" 2>/dev/null )
-	CID=$(git log -1 --abbrev=4 --pretty=format:"%h" 2>/dev/null) && CID="-g$CID"
+	CID=$(git log -1 --abbrev=12 --pretty=format:"%h" 2>/dev/null) && CID="-g$CID"
 elif test -f ../../PERF-VERSION-FILE
 then
 	TAG=$(cut -d' ' -f3 ../../PERF-VERSION-FILE | sed -e 's/\"//g')
-- 
2.20.1

