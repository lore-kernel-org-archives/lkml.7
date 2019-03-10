Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF62C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 18:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E311206DF
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 18:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DA9QbhuH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfCJSMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 14:12:38 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39524 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbfCJSMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 14:12:30 -0400
Received: by mail-wr1-f66.google.com with SMTP id p8so1037006wrq.6
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2019 11:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aRWEDuQLWzp3URwu3pEoQcxfbAgAvx//BghTXCmLhvY=;
        b=DA9QbhuHoXNY65XygCjZRskU4pHXsZRtYwhMZ/ppKrLRY/cZUw5C4SP4NKHgtrnia7
         L43N9yaqpHuWrBzOBfWEMHKaUwscw6PAOBAYRF4798nsZUPm8hoPSOZOES6zrjRFsWEZ
         GoM2YLMmYNNXIfu5pDkAR1BuFNWOpqwyL7E+AcVpqEmFCOcBNgfi2cbmn1eKhQM0HcT4
         E1NSIMlbtPfDZrYq5fmyB6e7IvD+LnKiLIhX0PE3l6lZcAD5Nqnfe/KC0ysd22m0LNGG
         rSvxvu+j84rLlnC5+sRmeq/gu5qweWtxUiqQ71Q67WsH3+qPUEV/jysG1IoYUoXS4got
         VOYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aRWEDuQLWzp3URwu3pEoQcxfbAgAvx//BghTXCmLhvY=;
        b=C+PriE/6kfpXzp/D/nUhFehiVJcWFrBxxqvpY9NlWlnRRvmxKXBFDcCPGeku86UMAC
         US90l1TcYQ4pNLd0IgmI3+PdzdsvWSu1A14S5WCn18+cVZubGNAJkW/rOCZNwh7CzanZ
         3MPHup/xSEIplgo4m9YeLV2IzG4P/kFVHGKfVKNsFsAKyqamgp7Rw8binrCyFTZNg0g2
         ykG0NWpx2vdNFYk95e9uClNT7MWQy4ei6WlSlkqr7SgJOeUICdxAXY9+wICfmLWFysuF
         88cBoZIiDtXdvzx3aGt3OzIDdUtaJWFVge7XETt8PS6LT8zvQZPPOsSDQjPQ0fwnj2Bw
         8QvA==
X-Gm-Message-State: APjAAAXGlfeWV7LmjgWo41SVbr9Jhaa1c3NDOgsL85Sh5sylcRF5gAnZ
        Mg5aT3pN5e5RUWbphlQS/1bHXw==
X-Google-Smtp-Source: APXvYqy9qSAWj5geYhYSuTpKq9v7xcBzqj7QNytr/wz1ED2B0/Q87fRBvZqbGtfzRvTb5TzPMrmudg==
X-Received: by 2002:adf:d84c:: with SMTP id k12mr8880621wrl.58.1552241548497;
        Sun, 10 Mar 2019 11:12:28 -0700 (PDT)
Received: from localhost.localdomain (146-241-67-113.dyn.eolo.it. [146.241.67.113])
        by smtp.gmail.com with ESMTPSA id d206sm24906368wmc.11.2019.03.10.11.12.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 11:12:28 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, fra.fra.800@gmail.com,
        alessio.masola@gmail.com, Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX IMPROVEMENT V2 9/9] doc, block, bfq: add information on bfq execution time
Date:   Sun, 10 Mar 2019 19:11:37 +0100
Message-Id: <20190310181137.2604-10-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190310181137.2604-1-paolo.valente@linaro.org>
References: <20190310181137.2604-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The execution time of BFQ has been slightly lowered. Report the new
execution time in BFQ documentation.

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 Documentation/block/bfq-iosched.txt | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/Documentation/block/bfq-iosched.txt b/Documentation/block/bfq-iosched.txt
index 98a8dd5ee385..1a0f2ac02eb6 100644
--- a/Documentation/block/bfq-iosched.txt
+++ b/Documentation/block/bfq-iosched.txt
@@ -20,13 +20,26 @@ for that device, by setting low_latency to 0. See Section 3 for
 details on how to configure BFQ for the desired tradeoff between
 latency and throughput, or on how to maximize throughput.
 
-BFQ has a non-null overhead, which limits the maximum IOPS that a CPU
-can process for a device scheduled with BFQ. To give an idea of the
-limits on slow or average CPUs, here are, first, the limits of BFQ for
-three different CPUs, on, respectively, an average laptop, an old
-desktop, and a cheap embedded system, in case full hierarchical
-support is enabled (i.e., CONFIG_BFQ_GROUP_IOSCHED is set), but
-CONFIG_DEBUG_BLK_CGROUP is not set (Section 4-2):
+As every I/O scheduler, BFQ adds some overhead to per-I/O-request
+processing. To give an idea of this overhead, the total,
+single-lock-protected, per-request processing time of BFQ---i.e., the
+sum of the execution times of the request insertion, dispatch and
+completion hooks---is, e.g., 1.9 us on an Intel Core i7-2760QM@2.40GHz
+(dated CPU for notebooks; time measured with simple code
+instrumentation, and using the throughput-sync.sh script of the S
+suite [1], in performance-profiling mode). To put this result into
+context, the total, single-lock-protected, per-request execution time
+of the lightest I/O scheduler available in blk-mq, mq-deadline, is 0.7
+us (mq-deadline is ~800 LOC, against ~10500 LOC for BFQ).
+
+Scheduling overhead further limits the maximum IOPS that a CPU can
+process (already limited by the execution of the rest of the I/O
+stack). To give an idea of the limits with BFQ, on slow or average
+CPUs, here are, first, the limits of BFQ for three different CPUs, on,
+respectively, an average laptop, an old desktop, and a cheap embedded
+system, in case full hierarchical support is enabled (i.e.,
+CONFIG_BFQ_GROUP_IOSCHED is set), but CONFIG_DEBUG_BLK_CGROUP is not
+set (Section 4-2):
 - Intel i7-4850HQ: 400 KIOPS
 - AMD A8-3850: 250 KIOPS
 - ARM CortexTM-A53 Octa-core: 80 KIOPS
@@ -566,3 +579,5 @@ applications. Unset this tunable if you need/want to control weights.
     Slightly extended version:
     http://algogroup.unimore.it/people/paolo/disk_sched/bfq-v1-suite-
 							results.pdf
+
+[3] https://github.com/Algodev-github/S
-- 
2.20.1

