Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A523EC28EB3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 09:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DF9C20868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 09:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xvEQkpFW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbfFFJtU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 05:49:20 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:43955 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727840AbfFFJtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 05:49:20 -0400
Received: by mail-yw1-f66.google.com with SMTP id t2so604671ywe.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 02:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9i+39qzlLlaj4ZIJyuysO0V74pT4jxs4rHh5xzjVecc=;
        b=xvEQkpFW7U+cyfXABrk8OGQT+iMDWfuf5C9izUay98hemQXRn3UvCf2XQZAhqeKbaY
         /HPKE5mNFJPLJ+MTNCbLBTR1uDHjxMtYu5EF2B1FpffQXMyok0Hz8OTS3775SFYIZfw/
         DMIo5SI91aay1zX2lMniEIhb19rXUi/eVBzpm4U5HXUjhmDLRajWqMrBDLz2GC6wsKlS
         /NV1SeA9mN2R/AWMr4/PmWPPS2nBek24yhnuY6ENbh7zJ6OYdhVtBop5R2RFxXkkyBmL
         QOiwh1PEjWETnYXNQVS4hVhUNRlaieNO0/kMGBzfCTEV7dwtrF8OnipFjO7s260W0xg4
         b9xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9i+39qzlLlaj4ZIJyuysO0V74pT4jxs4rHh5xzjVecc=;
        b=UJI6tfWHdRePZP/uJsbxPSRBRPh0JtEK/pCH3tAVv3izssprvcSxMouAr3XtiEIHlZ
         F7TNh/EN+3grV7AL7WXMjM0N1O2YChZLimBT3XTOpOc/1mRlKJjYGDYI0A9sn/7Cw09T
         njVCbbUsTSqHPXJ45RxTLb/RwbYn3vUwUTMd9IpmNz1UxM+V6tUgs3/h9HHyfZkCVZPR
         sQUksXqLS5uaK7n59LdpU7Q/NT4L+He0TimYtZ86cEswEpkFoLCIzqlknQ00IJe4+aUE
         dIoznyI6LTo1yigGAzK6tcBEY5k/UOBWZBBczwohtifpm61HChJFjUFgQBT4pDE9Upx3
         NSJw==
X-Gm-Message-State: APjAAAWs4CzkItMwalIknVu8xi6JoF9IWbZUKQQCKnaSjyyWg5bWLHs3
        IPaj1KvKI/q49q+mLUOEPOwwKA==
X-Google-Smtp-Source: APXvYqwDSr3ftmtzGq2Eavu2mXsep/ph3M2uO8tVmzY2rXGXL7dsLXs+WeafPr3rFrhn3KEV7e5wNQ==
X-Received: by 2002:a0d:ea91:: with SMTP id t139mr16181530ywe.119.1559814559608;
        Thu, 06 Jun 2019 02:49:19 -0700 (PDT)
Received: from localhost.localdomain (li1322-146.members.linode.com. [45.79.223.146])
        by smtp.gmail.com with ESMTPSA id 85sm357652ywm.64.2019.06.06.02.49.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 02:49:18 -0700 (PDT)
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
Subject: [PATCH v2 2/4] perf augmented_raw_syscalls: Remove duplicate macros
Date:   Thu,  6 Jun 2019 17:48:43 +0800
Message-Id: <20190606094845.4800-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190606094845.4800-1-leo.yan@linaro.org>
References: <20190606094845.4800-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macro SYS_EXECVE has been defined twice, remove the duplicate one.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/examples/bpf/augmented_raw_syscalls.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/perf/examples/bpf/augmented_raw_syscalls.c
index 68a3d61752ce..5c4a4e715ae6 100644
--- a/tools/perf/examples/bpf/augmented_raw_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_raw_syscalls.c
@@ -90,7 +90,6 @@ struct augmented_filename {
 /* syscalls where the second arg is a string */
 
 #define SYS_PWRITE64            18
-#define SYS_EXECVE              59
 #define SYS_RENAME              82
 #define SYS_QUOTACTL           179
 #define SYS_FSETXATTR          190
-- 
2.17.1

