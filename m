Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA9DC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 20:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 951AA20862
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 20:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pqs2RSzE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfEMUZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 16:25:40 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45530 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfEMUZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 16:25:39 -0400
Received: by mail-ed1-f66.google.com with SMTP id g57so19366141edc.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 13:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uCn6Vke4138+U/7e0Ka6YzQApQ9tmuWJ2ESUL37eTFU=;
        b=pqs2RSzEhP5MBiCHoHgf+86ImGMZ3WraDlEInb+07mjAKyFHIzTkqxXTlob3Dd3D6I
         Nt49GRdfJSPTx1/nmcireXaAgmgM8lfVNJA8lVkhDnhk0qo0cGnNJRjVBRhBirxnH0V0
         +OfGMF/usK3qNjfKdDk93gN9EfM7+6yX8aANjsDSFAENGZ/y9/j3wQvxeBAhEHaG21FP
         /DXaXSOwIqJ6GyErL15Z6MILIIREE+0bNPDJWxmpm5p5Xzfn1eJsxh6XNPm57nNZLi05
         lCTGVM6N9WJyaRstesmOAIzoK7Qssyptvk5XsR65Cz16dyk5dqJU+qErNIm0PEfxedR3
         5ogw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uCn6Vke4138+U/7e0Ka6YzQApQ9tmuWJ2ESUL37eTFU=;
        b=pxXOhZrB2HTtQB/x7FE8eEzozD8UiM++lczpY5jW+TjdgE6QLjNSqyuUjjg9Xk3wWU
         5XsLCyeWUl7eM+dbXtaDlf2t1utpgt6IWQKj2UTvY4aOyne3XtCHrIXDNFYD3w0DaEYh
         zG/lf+XCSP0rLhe4ik4tqUUmDaDN1xW6BTcBB2bFJX2Xte1GO3TnctNprTKch9Do2o23
         FS3wGQks20P4cMMTAn1w/Jds4XcHHGt4bbiXhYRvsd9BNL8uuR+6jVmkU/o4y//eaifd
         DudDWV/Q3nkMfS9aY0ecwU2ikb5tJ6iqqE8Gw63UVKvtcHlxL0oSnxOAA9V5xTTyhG8x
         k7ZQ==
X-Gm-Message-State: APjAAAU+yY34R064FicFYStoVuXwiFCFV8BCyn6bIjUzYPPvJJiF2+pq
        1/hWmYENlRTUvpCwuQD8RM6ZwVUe
X-Google-Smtp-Source: APXvYqwrQW7c83VHP6phdIgpO5+USwxpcAIbC39zOef3nLeX0cdU8cbPKNu7dnwAqDNh919K8mmJUA==
X-Received: by 2002:a50:b4f7:: with SMTP id x52mr32788267edd.190.1557779137464;
        Mon, 13 May 2019 13:25:37 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id k37sm4036076edb.11.2019.05.13.13.25.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 13:25:36 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM PMU PROFILING
        AND DEBUGGING), John Garry <john.garry@huawei.com>,
        Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>,
        Sean V Kelley <seanvk.dev@oregontracks.org>
Subject: [PATCH v2 1/3] perf vendor events arm64: Remove [[:xdigit:]] wildcard
Date:   Mon, 13 May 2019 13:25:20 -0700
Message-Id: <20190513202522.9050-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190513202522.9050-1-f.fainelli@gmail.com>
References: <20190513202522.9050-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARM64's implementation of get_cpuidr_str() masks out the revision bits
[3:0] while reading the CPU identifier, there is no need for the
[[:xdigit:]] wildcard.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 tools/perf/pmu-events/arch/arm64/mapfile.csv | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pmu-events/arch/arm64/mapfile.csv
index 59cd8604b0bd..da5ff2204bf6 100644
--- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
+++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
@@ -12,7 +12,7 @@
 #
 #
 #Family-model,Version,Filename,EventType
-0x00000000410fd03[[:xdigit:]],v1,arm/cortex-a53,core
+0x00000000410fd030,v1,arm/cortex-a53,core
 0x00000000420f5160,v1,cavium/thunderx2,core
 0x00000000430f0af0,v1,cavium/thunderx2,core
 0x00000000480fd010,v1,hisilicon/hip08,core
-- 
2.17.1

