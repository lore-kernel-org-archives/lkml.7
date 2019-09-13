Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 417B8C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17A1820640
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568381225;
	bh=f3AngrYfoygmVrQlEy/1PjIN9stcDHA5CB18RXpeG5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YLbgaFzWcNuy4ayY2ws3X01yZABtme8jaoc42ha+ClkMfY/pQCLOmqHL5klARkdEa
	 SeFa/DqHpUGtisBGIKK6/SLf81zWJTPL1O+tEL14beVVDY2TFtlwVzz1d/cWmUd1KP
	 G9hrvNs9pH+XfeB4GwtRzcQDeOLx09FZBy8fJAw4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403857AbfIMN0o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:26:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49144 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391576AbfIMN0l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:26:41 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4531387521D;
        Fri, 13 Sep 2019 13:26:41 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9C56F5C1D4;
        Fri, 13 Sep 2019 13:26:39 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 68/73] libperf: Add _GNU_SOURCE define to compilation
Date:   Fri, 13 Sep 2019 15:23:50 +0200
Message-Id: <20190913132355.21634-69-jolsa@kernel.org>
In-Reply-To: <20190913132355.21634-1-jolsa@kernel.org>
References: <20190913132355.21634-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.68]); Fri, 13 Sep 2019 13:26:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Link: http://lkml.kernel.org/n/tip-m7t1e9kgea4jc3piyvjju7ps@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/Makefile       | 1 +
 tools/perf/lib/tests/Makefile | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/tools/perf/lib/Makefile b/tools/perf/lib/Makefile
index 0f233638ef1f..20396f68fcad 100644
--- a/tools/perf/lib/Makefile
+++ b/tools/perf/lib/Makefile
@@ -73,6 +73,7 @@ override CFLAGS += -Werror -Wall
 override CFLAGS += -fPIC
 override CFLAGS += $(INCLUDES)
 override CFLAGS += -fvisibility=hidden
+override CFLAGS += -D_GNU_SOURCE
 
 all:
 
diff --git a/tools/perf/lib/tests/Makefile b/tools/perf/lib/tests/Makefile
index a43cd08c5c03..78c3d8c83c53 100644
--- a/tools/perf/lib/tests/Makefile
+++ b/tools/perf/lib/tests/Makefile
@@ -12,6 +12,8 @@ else
   CFLAGS := -g -Wall
 endif
 
+CFLAGS += -D_GNU_SOURCE
+
 all:
 
 include $(srctree)/tools/scripts/Makefile.include
-- 
2.21.0

