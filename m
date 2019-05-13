Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0DF0C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 20:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A53FA20862
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 20:25:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jXSMryiW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfEMUZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 16:25:43 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35902 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfEMUZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 16:25:43 -0400
Received: by mail-ed1-f68.google.com with SMTP id a8so19383448edx.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 13:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X21mAOGoYN+8cZIHmSdtLL/CvV/fwCagbBZkiJttwK4=;
        b=jXSMryiWqISxtsYFYby3XTlqJ6RmmCgpop+OScSEXitjK2TiTG8wx6Ex48F0kjFwDd
         aGGOex0N06MkzF9dOFthoEDGDYUcQH+uwUAD1fVK2yE0mYT3gwAzgKtEu7KRHaF+YqZV
         x/zCRrN6+u1FI/0gumcbtWFw0r3nGGcUijtQ5rr9rzNaVxJdPjd13AeQ7ynk5JsY0BbF
         48IbkbQZiuY2cNAEAQc8ZeyS4dEXj+8rB3DA/08HS4+L5yVaFk9beEmINKfBb3tJsHr2
         JN2ZBgWr0met4KEriZBr/9wVAtusCf2zASo3kPD5Y966xN6j01heBCifmyvKwGYJe67B
         WCLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=X21mAOGoYN+8cZIHmSdtLL/CvV/fwCagbBZkiJttwK4=;
        b=EKS1oD1r7sqiTixa3D08lOw98mxPMAb5jaL+KTKel1QMBobxYqJ5GAIN0tSGDLKSVO
         f1TiuK5qGst3qX7S93DoOUPiFTN17OeEz7PM54xOVDdjBNXqyAh/eOsqeyIi2LiPJ/H5
         F6TmeuGLkPMOHDUWoJmS/gVjUoco2g7kelaks2qOiPwb+C9skdyGRf95lY7hAHbg9wCI
         76aluiTkLBDAOSnr3DSG+gIYSbCNUU8COaciifu+5NZdYS9o9NGzpDf1sOPYy+ekdl4H
         l/7iTOwIXikDnIE396z649HeTLrA7u5eMEQovsH/60wCqCGhmHHEwt46cFxukA0uqPmp
         qw/A==
X-Gm-Message-State: APjAAAVHNJQLyHgEp+LDxSCbQ2ApkN36SU4sO8grHC6vnykwHF/OwVfE
        TAKWYGug24oJr5ySNmIEueg6e6zV
X-Google-Smtp-Source: APXvYqyscfrrLasllLlS5bmvhzQfm4OxU9p693gex+v0fgr9f3QGjsYr3ie/NAK81+XhNPGmOxkvBg==
X-Received: by 2002:a17:906:c50:: with SMTP id t16mr23848218ejf.296.1557779141252;
        Mon, 13 May 2019 13:25:41 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id k37sm4036076edb.11.2019.05.13.13.25.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 13:25:40 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        John Garry <john.garry@huawei.com>,
        Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>,
        Sean V Kelley <seanvk.dev@oregontracks.org>
Subject: [PATCH v2 2/3] perf vendor events arm64: Map Brahma-B53 CPUID to cortex-a53 events
Date:   Mon, 13 May 2019 13:25:21 -0700
Message-Id: <20190513202522.9050-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190513202522.9050-1-f.fainelli@gmail.com>
References: <20190513202522.9050-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Broadcom's Brahma-B53 CPUs support the same type of events that the
Cortex-A53 supports, recognize its CPUID and map it to the cortex-a53
events.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: bcm-kernel-feedback-list@broadcom.com
Cc: linux-arm-kernel@lists.infradead.org (moderated list:arm pmu profiling and debugging)
Link: http://lkml.kernel.org/r/20190405165047.15847-1-f.fainelli@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/pmu-events/arch/arm64/mapfile.csv | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pmu-events/arch/arm64/mapfile.csv
index da5ff2204bf6..013155f1eb58 100644
--- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
+++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
@@ -13,6 +13,7 @@
 #
 #Family-model,Version,Filename,EventType
 0x00000000410fd030,v1,arm/cortex-a53,core
+0x00000000420f1000,v1,arm/cortex-a53,core
 0x00000000420f5160,v1,cavium/thunderx2,core
 0x00000000430f0af0,v1,cavium/thunderx2,core
 0x00000000480fd010,v1,hisilicon/hip08,core
-- 
2.17.1

