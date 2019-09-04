Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A94A0C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 23:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E3F321726
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 23:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WCSe2dJR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730496AbfIDXwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 19:52:19 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:56095 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729635AbfIDXwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 19:52:19 -0400
Received: by mail-wm1-f65.google.com with SMTP id g207so580140wmg.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 16:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DP+w8Reea8xQqNhk6ytQ1Vf7IQB6w5cSP5pS7nk17P8=;
        b=WCSe2dJRpyLYEJzHzWzKX/M4KJRSygBcT4ixMiKvKETW56WKDxWi/Fnuzf8aetHjyk
         VXjHjNH0F849Mjub6NSNKSaTSUMgIMcR0pm8j4eRA3gITNNfxkqMWmRLyFLIAaf4r0Mb
         G6mBV7hpfPE3x5p4Q9S4fr36ZDVSIlMX495FEY8gk48PLSJQR68gqxgfJyAfA5wuXKk/
         W+fYylGYsUG0CXZqV0nf1eR30Y1nr/5hovISQRW4gRvRKu6GnocbF0bzQO10LwVm6+So
         l5XngKJFl+Gco+0m/s0zkjGZ4qzy/pBLNKFHj77xSnh/e1mEGiK+xiw+ExZg6xxBZzJV
         zoNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=DP+w8Reea8xQqNhk6ytQ1Vf7IQB6w5cSP5pS7nk17P8=;
        b=hc0AFHDS1kNBz+tYjSe1+Or29ypOE39ksgifVaooeNj/i4ZVopH7I6Nb78OGlGm4hR
         bM3TEMH+b1PRzezbnTS1zwyKeJth8fl9HJYR8+XiGeuTR4jIdsGw6y/aMWvilelY9nxM
         j8wQdahPRMj80rGPyfKAAsmjJFi4dKUf5Yey9UkCSV84g0WRY2cC11enHR/nUjQG4byl
         3WHzj26Y6RSZqUhYcF+YcuVPVLZBL68tJHU1iK+tLfwqLAA1EjR8FrP29vE+aCOFSdsi
         SjQcGrRIFGo9bP7pJQfGf5yRB2kyBAJx4vI27NgP4+xldhcwDNR3MkZA0mHplvD2meec
         yc+A==
X-Gm-Message-State: APjAAAVmtAMbXdQBKfldCJlwDRExuJN9ZzynN3t1wvCp6D5dJwd5TOMz
        C8o23LxYl/rM9kl9VgEOuJ8f9Ey7kSd/gg==
X-Google-Smtp-Source: APXvYqw2BzqDVKreHJEMnu8TmBg230mk+HWRgfFJig/5egwmGj4bXiiU9grBFrptR8uNqS7Ca6eXFQ==
X-Received: by 2002:a7b:c40f:: with SMTP id k15mr506756wmi.99.1567641138422;
        Wed, 04 Sep 2019 16:52:18 -0700 (PDT)
Received: from localhost.localdomain (ip5b4096c3.dynamic.kabel-deutschland.de. [91.64.150.195])
        by smtp.gmail.com with ESMTPSA id z17sm296949wrw.23.2019.09.04.16.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 16:52:17 -0700 (PDT)
From:   Krzysztof Wilczynski <kw@linux.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] nds32: Move static keyword to the front of declaration
Date:   Thu,  5 Sep 2019 01:52:16 +0200
Message-Id: <20190904235216.18510-1-kw@linux.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the static keyword to the front of declaration of
cpu_pmu_of_device_ids, and resolve the following compiler
warning that can be seen when building with warnings
enabled (W=1):

arch/nds32/kernel/perf_event_cpu.c:1122:1: warning:
  ‘static’ is not at beginning of declaration [-Wold-style-declaration]

Signed-off-by: Krzysztof Wilczynski <kw@linux.com>
---
Related: https://lore.kernel.org/r/20190827233017.GK9987@google.com

 arch/nds32/kernel/perf_event_cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/nds32/kernel/perf_event_cpu.c b/arch/nds32/kernel/perf_event_cpu.c
index 334c2a6cec23..0ce6f9f307e6 100644
--- a/arch/nds32/kernel/perf_event_cpu.c
+++ b/arch/nds32/kernel/perf_event_cpu.c
@@ -1119,7 +1119,7 @@ static void cpu_pmu_init(struct nds32_pmu *cpu_pmu)
 		on_each_cpu(cpu_pmu->reset, cpu_pmu, 1);
 }
 
-const static struct of_device_id cpu_pmu_of_device_ids[] = {
+static const struct of_device_id cpu_pmu_of_device_ids[] = {
 	{.compatible = "andestech,nds32v3-pmu",
 	 .data = device_pmu_init},
 	{},
-- 
2.22.1

