Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 802D1C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 19:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FC9321D79
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 19:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eYIqj+e/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392600AbfIYT7e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 15:59:34 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:55851 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728589AbfIYT7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 15:59:34 -0400
Received: by mail-pf1-f201.google.com with SMTP id w126so4654198pfd.22
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 12:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=tbsA8ovtRUItOLcOsenhoWRrUuOUNM/5abtJVULw+eE=;
        b=eYIqj+e/ISr6zIU7vm6lgzqnv353s0qWfsdO6riWJo8eKDn4GmJQxeZ0qoJWe38xMw
         qVDz1Y0fpx21ZmtpI26/dmgR8MK2HwQO3v1bgsrQAeGtJxVB1mioq8ymS0oDm7I4Z7bP
         12HVILGWKae9G2AMflWzR8VoeCJBeZaej09EH7/c39b/ZEbU/Ft5jPpDsRQ0R00Ib+Jh
         P+UN3MN2Uku8JFzHN84zg/GMg+vehXgor5DX4Ma5BBCaj3XGvn91/KX6Wy0cuNqDVV3o
         TfLcxxpp16a/G5f5QFcIcuc+aAnuX12xsAJ0cu+JwsLl4tE+1vsHwNlXpI4q7Je+J42I
         PXcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=tbsA8ovtRUItOLcOsenhoWRrUuOUNM/5abtJVULw+eE=;
        b=ihGH8m5jHJIQQ8aDW/Gn0yQiQinYSuYKLih5M6ORIrtosRsDeX+NRbzvFYUHgSnbSc
         yVSl8Twj4hPxibjvarOGUncXc8PHFFICERJ6a2YCri2ULEfM9BKNpIovSMde0p2KFEcM
         Xcz7L03AH8UEtgu19vrUrql3mE76Yb8MLnyknakOzqZYNmhf38F9Cy7aGfYhHixbbmBN
         e82PzlP8StFH3Kk7CL2CfN1OTk6tqAbt4+nxQckJ8nLWBgKmIN5eztmmGspSm/1xAX4F
         kCBWzJmKrL34GT4HIIu2sakfOv43UeOrJucBTdph0XdLZR62d6lu+8kxZx5dZ85MbZay
         jFYQ==
X-Gm-Message-State: APjAAAXcqlYcR53EmSccjN0UAsPrHsISayPyeki6Vk3I/V0z9f7si8HW
        ppwycD0iqw4JSLqgxJJniYmvrr8jMtnX
X-Google-Smtp-Source: APXvYqwR6dIT9AZ+GvTkdrgbAR5RfRFSGsKdnziw1Ya8l0M3K/I6LmIzjUWT401bM5ZSjrNMTc6VN1S2KfQs
X-Received: by 2002:a65:678a:: with SMTP id e10mr1133081pgr.184.1569441573065;
 Wed, 25 Sep 2019 12:59:33 -0700 (PDT)
Date:   Wed, 25 Sep 2019 12:59:23 -0700
Message-Id: <20190925195924.152834-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
Subject: [PATCH 1/2] Make _FORTIFY_SOURCE defines dependent on the feature
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unconditionally defining _FORTIFY_SOURCE can break tools that don't work
with it, such as memory sanitizers:
https://github.com/google/sanitizers/wiki/AddressSanitizer#faq

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/subcmd/Makefile | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/lib/subcmd/Makefile b/tools/lib/subcmd/Makefile
index ed61fb3a46c0..5b2cd5e58df0 100644
--- a/tools/lib/subcmd/Makefile
+++ b/tools/lib/subcmd/Makefile
@@ -20,7 +20,13 @@ MAKEFLAGS += --no-print-directory
 LIBFILE = $(OUTPUT)libsubcmd.a
 
 CFLAGS := $(EXTRA_WARNINGS) $(EXTRA_CFLAGS)
-CFLAGS += -ggdb3 -Wall -Wextra -std=gnu99 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2 -fPIC
+CFLAGS += -ggdb3 -Wall -Wextra -std=gnu99 -fPIC
+
+ifeq ($(DEBUG),0)
+  ifeq ($(feature-fortify-source), 1)
+    CFLAGS += -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2
+  endif
+endif
 
 ifeq ($(CC_NO_CLANG), 0)
   CFLAGS += -O3
-- 
2.23.0.351.gc4317032e6-goog

