Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A96C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 11:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27D4B20656
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 11:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="abYjQy+Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfFZLEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 07:04:44 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46538 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbfFZLEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 07:04:44 -0400
Received: by mail-pf1-f193.google.com with SMTP id 81so1154618pfy.13
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 04:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hhLrQG1zgstVzaP+j4YvOii01awCi0Ljywn5lL6XyNY=;
        b=abYjQy+Yy2hdpbQ/ekkhMyklBouHvv+xVOa4xpzHSE4levl250bYC6q2xkytFNofTt
         NDacNWtvsv3kpXGqaBMycevJLLUDHfu39gD6WkjPc1Yu9uzCPISJtLdkGPQRVfMoRBzF
         LVzNauontq537aVfBgqmvxRYdgpxE/+vddjZusvMEYNeCLImVm+eGYvGVBYolZvqMGMr
         F4Gbu0iPvACxqeukA2i0zgweYZFG93EibJPHBkYcUhbrjyEFRUOAu7fS5pQm+/ogXIZB
         Uyn+NoEhrcQSonApFIcxNjkU4jeTORDeEg/c1mXPr70AUEbY+hhqlHBzJ4kKzlw9nmuX
         nzyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hhLrQG1zgstVzaP+j4YvOii01awCi0Ljywn5lL6XyNY=;
        b=imEQVQUQw1PmrmcToeEbvgQXGUAkpS8nKSYhWrmpZ3OAUXqnw9/9jeT5BD9w6MvEVq
         FPMmsv6EHSGlJPb1JfQWpXRPIKqqRit10AbQKxC9+3xRS1GOSKH2Nlv6mHifyi8v5HkM
         QTnhKFmXuusoMe7ZK/RLAGGOYvG34JfmbNgW1cJnOR4t08Y/onQIQZAq/74EKK/0Pf+O
         DqdHc6YjLQPK491wx0UXxdo4s2lPIQ7yEtIROt01b4AWlqQJNvZsOYtcSn6gYiDt+aAG
         tyz+1P0OlPWVYbprqgoeSEwqoBtHHZI+uwOc5AtHeni0djaBORrdR5R9nFiPmnDn8eIq
         fpow==
X-Gm-Message-State: APjAAAW4E46efkYdYzF1KnhDEYb5h3eY8kq4+zH6T0Q5VFpGDSzusMoj
        wuZ9kpt5x8VArp0oxxaXdpQ=
X-Google-Smtp-Source: APXvYqwLOkuynMb7QGr5fBBIx794XKVKm8jEWI70uhArjlW3hRDq2b1xB/5g09w5s80mNhjaXN4Wzw==
X-Received: by 2002:a17:90a:d681:: with SMTP id x1mr3972928pju.13.1561547083567;
        Wed, 26 Jun 2019 04:04:43 -0700 (PDT)
Received: from masabert (150-66-94-139m5.mineo.jp. [150.66.94.139])
        by smtp.gmail.com with ESMTPSA id l44sm1727061pje.29.2019.06.26.04.04.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 04:04:42 -0700 (PDT)
Received: by masabert (Postfix, from userid 1000)
        id 73B4B20119C; Wed, 26 Jun 2019 20:04:38 +0900 (JST)
From:   Masanari Iida <standby24x7@gmail.com>
To:     ak@linux.intel.com, kan.liang@intel.com, acme@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH] perf vendor events intel: Fix typos in floating-point.json
Date:   Wed, 26 Jun 2019 20:04:36 +0900
Message-Id: <20190626110436.22563-1-standby24x7@gmail.com>
X-Mailer: git-send-email 2.22.0.214.g8dca754b1e87
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fix some spelling typo in x86/*/floating-point.json

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 tools/perf/pmu-events/arch/x86/nehalemep/floating-point.json    | 2 +-
 tools/perf/pmu-events/arch/x86/nehalemex/floating-point.json    | 2 +-
 .../perf/pmu-events/arch/x86/westmereep-dp/floating-point.json  | 2 +-
 .../perf/pmu-events/arch/x86/westmereep-sp/floating-point.json  | 2 +-
 tools/perf/pmu-events/arch/x86/westmereex/floating-point.json   | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/nehalemep/floating-point.json b/tools/perf/pmu-events/arch/x86/nehalemep/floating-point.json
index 7d2f71a9dee3..6b9b9fe74f3b 100644
--- a/tools/perf/pmu-events/arch/x86/nehalemep/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/nehalemep/floating-point.json
@@ -15,7 +15,7 @@
         "UMask": "0x4",
         "EventName": "FP_ASSIST.INPUT",
         "SampleAfterValue": "20000",
-        "BriefDescription": "X87 Floating poiint assists for invalid input value (Precise Event)"
+        "BriefDescription": "X87 Floating point assists for invalid input value (Precise Event)"
     },
     {
         "PEBS": "1",
diff --git a/tools/perf/pmu-events/arch/x86/nehalemex/floating-point.json b/tools/perf/pmu-events/arch/x86/nehalemex/floating-point.json
index 7d2f71a9dee3..6b9b9fe74f3b 100644
--- a/tools/perf/pmu-events/arch/x86/nehalemex/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/nehalemex/floating-point.json
@@ -15,7 +15,7 @@
         "UMask": "0x4",
         "EventName": "FP_ASSIST.INPUT",
         "SampleAfterValue": "20000",
-        "BriefDescription": "X87 Floating poiint assists for invalid input value (Precise Event)"
+        "BriefDescription": "X87 Floating point assists for invalid input value (Precise Event)"
     },
     {
         "PEBS": "1",
diff --git a/tools/perf/pmu-events/arch/x86/westmereep-dp/floating-point.json b/tools/perf/pmu-events/arch/x86/westmereep-dp/floating-point.json
index 7d2f71a9dee3..6b9b9fe74f3b 100644
--- a/tools/perf/pmu-events/arch/x86/westmereep-dp/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/westmereep-dp/floating-point.json
@@ -15,7 +15,7 @@
         "UMask": "0x4",
         "EventName": "FP_ASSIST.INPUT",
         "SampleAfterValue": "20000",
-        "BriefDescription": "X87 Floating poiint assists for invalid input value (Precise Event)"
+        "BriefDescription": "X87 Floating point assists for invalid input value (Precise Event)"
     },
     {
         "PEBS": "1",
diff --git a/tools/perf/pmu-events/arch/x86/westmereep-sp/floating-point.json b/tools/perf/pmu-events/arch/x86/westmereep-sp/floating-point.json
index 7d2f71a9dee3..6b9b9fe74f3b 100644
--- a/tools/perf/pmu-events/arch/x86/westmereep-sp/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/westmereep-sp/floating-point.json
@@ -15,7 +15,7 @@
         "UMask": "0x4",
         "EventName": "FP_ASSIST.INPUT",
         "SampleAfterValue": "20000",
-        "BriefDescription": "X87 Floating poiint assists for invalid input value (Precise Event)"
+        "BriefDescription": "X87 Floating point assists for invalid input value (Precise Event)"
     },
     {
         "PEBS": "1",
diff --git a/tools/perf/pmu-events/arch/x86/westmereex/floating-point.json b/tools/perf/pmu-events/arch/x86/westmereex/floating-point.json
index 7d2f71a9dee3..6b9b9fe74f3b 100644
--- a/tools/perf/pmu-events/arch/x86/westmereex/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/westmereex/floating-point.json
@@ -15,7 +15,7 @@
         "UMask": "0x4",
         "EventName": "FP_ASSIST.INPUT",
         "SampleAfterValue": "20000",
-        "BriefDescription": "X87 Floating poiint assists for invalid input value (Precise Event)"
+        "BriefDescription": "X87 Floating point assists for invalid input value (Precise Event)"
     },
     {
         "PEBS": "1",
-- 
2.22.0.214.g8dca754b1e87

