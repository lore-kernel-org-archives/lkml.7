Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 835CCC06513
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 10:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C1AB20836
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 10:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b3Ynb3mm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfGBKfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 06:35:03 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46048 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfGBKfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 06:35:02 -0400
Received: by mail-ot1-f67.google.com with SMTP id x21so16635304otq.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 03:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KMNCKIxUd7C3QCEkBdcu4g6ofRmUIVRG/BHPe4FFBiI=;
        b=b3Ynb3mmyQPqXrGhUFTeBcfcKHtyocPl8Z41p2F8I32GBNu0jF2BwO2+v3JgI33/vX
         jdTP5yPdtLr0AmtRijQulnFrapU3F7Wo1t9ouWCA8DB3JJmF+5U2+qFa/t67GXudzCMz
         ly/Us9RlBLH/YWRpgziYH+onbCeHqjhF+Jsx8f+BdbQnJpk0sZsc1lMdFG2vqOxBUmi3
         zREazE8Zg6hRzYOeK/wcN6BSghqPHghcuZXM/aLU82P664LzADeiNUaoRo96TUXapNFl
         VMQxHdl/BOL+DLppX1ABrQiPd4KpJ6Qar4Ka5KVHxxtBxrd0PruJ1D9m2pAFFESgzNds
         V19Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KMNCKIxUd7C3QCEkBdcu4g6ofRmUIVRG/BHPe4FFBiI=;
        b=T3LRONcddq5FYPLtvwQLApURaiguPuBowGSFl2dgVmnxcCwvT44VxM+oHZb9pUYVKt
         wd+mvxW8A9e91ecPpFyBygXZxbVx8w9dfTAmGknctLxsQ9H5wT8yJNEyzZiZvSUJmJz4
         prTFlOl/kSNFGczsEsNWgVfv9z2n/91It1OJrWVLmfIuvNH36gF78/wB5012sgAHdqOa
         MyD6S/84q9kb4dkM7lv2TSNWqAbYEnCSZt2/h1pot1Ur6rwSCUqlZB2xIt/FNhToVAv/
         TZNikutlWu/sNAnLYpMxOrUGZ0JXmm/4Rt3qj8vsV153WyeRBIQS8l1Iql2GYE8EDTGt
         xElA==
X-Gm-Message-State: APjAAAVBzDy6XLDPKFEU5Q544cFy2KKhu6n/J/tRzHwVV0Q++MzSEt6A
        LbH18aI/VtH0AFrYgUzZbM+aUA==
X-Google-Smtp-Source: APXvYqwRW1eo9HwE7l93QclNUXgFCxIkpcB0HGbeFgij2hTMSad7SU3toR850JGxhkFCj/Cfl4JFQA==
X-Received: by 2002:a9d:6ac9:: with SMTP id m9mr19994522otq.242.1562063701875;
        Tue, 02 Jul 2019 03:35:01 -0700 (PDT)
Received: from localhost.localdomain (li964-79.members.linode.com. [45.33.10.79])
        by smtp.gmail.com with ESMTPSA id 61sm5139805otx.8.2019.07.02.03.34.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 03:35:01 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Andi Kleen <ak@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jin Yao <yao.jin@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Changbin Du <changbin.du@intel.com>,
        Eric Saint-Etienne <eric.saint.etienne@oracle.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 02/11] perf stat: Smatch: Fix use-after-freed pointer
Date:   Tue,  2 Jul 2019 18:34:11 +0800
Message-Id: <20190702103420.27540-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190702103420.27540-1-leo.yan@linaro.org>
References: <20190702103420.27540-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on the following report from Smatch, fix the use-after-freed
pointer.

  tools/perf/builtin-stat.c:1353
  add_default_attributes() warn: passing freed memory 'str'.

The pointer 'str' has been freed but later it is still passed into the
function parse_events_print_error().  This patch fixes this
use-after-freed issue.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-stat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 8a35fc5a7281..de0f6d0e96a2 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1349,8 +1349,8 @@ static int add_default_attributes(void)
 				fprintf(stderr,
 					"Cannot set up top down events %s: %d\n",
 					str, err);
-				free(str);
 				parse_events_print_error(&errinfo, str);
+				free(str);
 				return -1;
 			}
 		} else {
-- 
2.17.1

