Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71932CA9EA1
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 08:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F15E21852
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 08:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rm90ugQI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409645AbfJRI40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 04:56:26 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34108 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731444AbfJRI4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 04:56:25 -0400
Received: by mail-qk1-f196.google.com with SMTP id f18so3985594qkm.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 01:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ugnrp2k1zFImPpsw0D6yHUbYeoEMpwYIr1OCnGwoTi0=;
        b=rm90ugQIlFRTFD3MXHb2shRtEJTxh2AB2m9p3GuCl7KTPQRvTRViHDwpf0aDzOuYL+
         r54vROHJxUMIMnj1pKiu76h3NwsR4hdCmPxdEluS2pCpKHmEKFVBA3BUYeMVT59T9Dru
         4r6xSPxGTABKsNBvulDht13i7zwI7gCRy0+epyFksMx5Ww9oqyYkLOuaDw/KnIKOZHQ9
         AMhpjHqAu5DGpSXDnBc9Ldra8tfgb2PIRp/3o61M/YBcI0b18iXtIhhiv7CwZUF2f6jX
         0y5hmOelHTDjVkjo5HGRgC0YPMd5wdt5v/I3HcY06hFjAtrJUIiHb7i/E2WEJ4v9pgjr
         3fGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ugnrp2k1zFImPpsw0D6yHUbYeoEMpwYIr1OCnGwoTi0=;
        b=OGeeiPD1DNPF8gNGcvFtIJOgk9S0sYC4vhasHKtIOLelDyZ1a7Ktn2gCpPlkEohzMt
         lFyZ6wQXSA8Ch8BtFzxVI3D4EcQqoWJJ3rkyxnen1jPeV1Thp6ZRe0ZOjKjceYQvpmTm
         62DaBbtLFEA0S3Fr1oR5oEHyPn2a0Epv94ZxNek51PPqZrgeuE8DEnlz/qFBg3o7hSIw
         8LNJ+dDGlQMvKyvrem5RUvg1YzkIjWRk9V8ArVXwCJrNTB7EOg2c0gRr8GmX7iRq/PBr
         bUDUFNelF0dZEifztJfDVvGQ31R1I+dc88L7o42I1JZlpyIvOLh2MFHt4yK32YhkWdfW
         NHwg==
X-Gm-Message-State: APjAAAXXHKjBpdx933Q8Ht8bX5vuEgHWckLGglarrk0chrZ1o6ha0/MP
        5OAehoUZAse6v/UartzyRMKbrA==
X-Google-Smtp-Source: APXvYqzWMjut/GzjYZr1AgNOOoXv3bfNuFdY/8K8RtGp7Ipc/gDTsb3ra7BkzpJPwclkmzGhTb7nOQ==
X-Received: by 2002:a05:620a:74b:: with SMTP id i11mr7490306qki.397.1571388984550;
        Fri, 18 Oct 2019 01:56:24 -0700 (PDT)
Received: from localhost.localdomain (li937-157.members.linode.com. [45.56.119.157])
        by smtp.gmail.com with ESMTPSA id a134sm3076571qkc.95.2019.10.18.01.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 01:56:24 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Song Liu <songliubraving@fb.com>, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 1/3] perf tests: Remove needless headers for bp_account
Date:   Fri, 18 Oct 2019 16:55:29 +0800
Message-Id: <20191018085531.6348-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A few headers are not needed and were introduced by copying from other
test file.  This patch removes the needless headers for the breakpoint
accounting testing.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/tests/bp_account.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tools/perf/tests/bp_account.c b/tools/perf/tests/bp_account.c
index 016bba2c142d..52ff7a462670 100644
--- a/tools/perf/tests/bp_account.c
+++ b/tools/perf/tests/bp_account.c
@@ -10,11 +10,7 @@
 #include <unistd.h>
 #include <string.h>
 #include <sys/ioctl.h>
-#include <time.h>
 #include <fcntl.h>
-#include <signal.h>
-#include <sys/mman.h>
-#include <linux/compiler.h>
 #include <linux/hw_breakpoint.h>
 
 #include "tests.h"
-- 
2.17.1

