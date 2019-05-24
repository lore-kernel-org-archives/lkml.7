Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8282EC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 572322184E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wYww6fnn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403860AbfEXRf1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 13:35:27 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38171 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391702AbfEXRfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 13:35:23 -0400
Received: by mail-pl1-f193.google.com with SMTP id f97so4446541plb.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 10:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lhIIAcqMYF91fEeMtO+5Bx5waRYhYv5nfW6t1irEE4g=;
        b=wYww6fnnhGNHiIplyjMggWqEHnKDZ+6g2AFzNWB7CAYKb806lbqsb66g3Q+Qj2l1CG
         lxE5Ksd6Y3XuyIUrUpdb55Kgd3V5G/aGpuK7YPCslS/ZdGzm4xYgJKSwpzOYdlTZDeSp
         k/LzzsHlxhqtfyofe6xlIefGjoStrQZWfDJAeW3BrTS6xz4H+J9bnGmfgSnqvjiIlIQP
         1ci587Bb+g/X7SOGH/zbxj0A3N8F86Bz/X/04Pt0HqFWHuIW2qCm1iRuEhks1DTZiZ5Z
         WO7+GylOXqZ/z2TnIzuyxqhOU57gRjrvXsacYHyxtOFpCT81KwmN2he9haaLsX3ighkx
         43mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lhIIAcqMYF91fEeMtO+5Bx5waRYhYv5nfW6t1irEE4g=;
        b=UPO/FIMa590cdyRwdg7ehCgpJD4j4RzPEfc0T0RRPB89WOhmw4gHXioX72h2hkSWaI
         LBt/X2KPZ8p+raNJtDxRNu+pFJFiL0BaOsBqaooaG+wb7qbCvStqP3EjQCVVxG68LmBe
         EEyWYcKAmWwjoi9AOqTz0vYCnN/m6QyiBCSQT8aYx0LF/pqCn6Fuh68efCOV3shqzkUS
         lr+l4fr3pkiDNEGiuIVCAXR3Jj6syNDVfzdXhNa9Dey6MgSQuWc+l/FkDOrYnlL6qt4v
         ipBMIv9K13LTj6+dLhCmd6Ga6bTGZ3+D4Z8S4yXrBrxjOn8vleLej+xTR9I0SuodI3Qm
         ZzCA==
X-Gm-Message-State: APjAAAVYMvKlC4E642bdrCLdST2kEmzqlx3OjOLKjyLxX7CGbTE/snYV
        CXcKi0xX54sP68UMquczqhOurw==
X-Google-Smtp-Source: APXvYqyJaO7Ehk/11VJkm7Wix7uH3ModKau5JGUwCUtFF5mM6tOmErjXDCFZY4kfx/RlT3+xst+M5g==
X-Received: by 2002:a17:902:ca:: with SMTP id a68mr83329085pla.7.1558719322941;
        Fri, 24 May 2019 10:35:22 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id k13sm2809575pgr.90.2019.05.24.10.35.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 10:35:22 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     acme@kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, suzuki.poulose@arm.com, leo.yan@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        coresight@lists.linaro.org
Subject: [PATCH v2 10/17] perf tools: Get rid of unused cpu in struct cs_etm_queue
Date:   Fri, 24 May 2019 11:35:01 -0600
Message-Id: <20190524173508.29044-11-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190524173508.29044-1-mathieu.poirier@linaro.org>
References: <20190524173508.29044-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nowadays the synthesize code is using the packet's cpu information, making
cs_etm_queue::cpu useless.  As such simply remove it.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 tools/perf/util/cs-etm.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 9e8212c74055..531bbb355ba4 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -79,7 +79,6 @@ struct cs_etm_queue {
 	struct auxtrace_buffer *buffer;
 	unsigned int queue_nr;
 	pid_t pid, tid;
-	int cpu;
 	u64 offset;
 	const unsigned char *buf;
 	size_t buf_len, buf_used;
@@ -599,7 +598,6 @@ static int cs_etm__setup_queue(struct cs_etm_auxtrace *etm,
 	queue->priv = etmq;
 	etmq->etm = etm;
 	etmq->queue_nr = queue_nr;
-	etmq->cpu = queue->cpu;
 	etmq->tid = queue->tid;
 	etmq->pid = -1;
 	etmq->offset = 0;
@@ -831,11 +829,8 @@ static void cs_etm__set_pid_tid_cpu(struct cs_etm_auxtrace *etm,
 		etmq->thread = machine__find_thread(etm->machine, -1,
 						    etmq->tid);
 
-	if (etmq->thread) {
+	if (etmq->thread)
 		etmq->pid = etmq->thread->pid_;
-		if (queue->cpu == -1)
-			etmq->cpu = etmq->thread->cpu;
-	}
 }
 
 static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
-- 
2.17.1

