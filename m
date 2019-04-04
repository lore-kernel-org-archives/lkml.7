Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521D7C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 12:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2027C2082E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 12:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UxhwuRPg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729378AbfDDMH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 08:07:27 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40032 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727341AbfDDMHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 08:07:19 -0400
Received: by mail-pf1-f195.google.com with SMTP id c207so1273483pfc.7
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 05:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QQXPqQpT2W1L+HjGubEtBhuTGho2R0gBiPb+a8ECXDc=;
        b=UxhwuRPgskknxttwmdMv5Nlfx2PyLJ31GntcMOB8CLaAJwYorS+24MI6SpIbzoWH82
         Y3sl4un/Qga9eC1px1Nyra/jqjDp1cFzxD1GNEMLFXNXF16Or2jER7VCOTogwN1bSmHZ
         ml7eTGjpcWvenAobBLHW/Wc3LfuSaXgBWXPypvKBQDyXSx2U9Hb7Mq4QBY71jNw1K28F
         wvHrzhJnicfEjG2P+WmiUAqKYwxSiEKCGH4O+IIYP26A4/u5ApGJ9iXXMOi7T4e9eJtn
         ylgftbdfCMqwWAw0pB/qpD0VmXoJ3JxEOKS3V6UKDSK0kY3B8ytgXx3u3KukKwL4DyRM
         ntNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QQXPqQpT2W1L+HjGubEtBhuTGho2R0gBiPb+a8ECXDc=;
        b=oMZkxHPmCYBPQQwdt7pNBeDuRKMHRiTBCht5/ldo7iK8UezJNSKinNVNgV+t9yWcfM
         KXwAjv0+duQrz7D2+BUKdTuIOvqzJ75qfVkynRG/vvm35DXVOAJlhtrYqVZhkLCvOa+Q
         z4zUECDS1xdUmW4ezzfJsxVHqUfH8Wjyz7CLjkF6T/H8EZVHNHTIQjHA5MQUEx8yhPe6
         P3U8CytWx74t6JM6WfosVEnKQ0WMw/kuNwhFJvrNyY577x+Op48nsn4bF1NK9jYU7b47
         2nJGgbRfP70Q2U4sEZLeah4WFXgTsbaX2Pw+ghXpLG5mB4PBnV4LF9sCaUOkqtdeD6Od
         RBGA==
X-Gm-Message-State: APjAAAWz2f2x83cwA8BTFOXAYV3Svv5IV5Xcv79wRLrt/7o/EZBDmUAU
        UlFb5mfpc58yDuDAiGt0pKM=
X-Google-Smtp-Source: APXvYqzKttk2jYrw6ZK7wQFp+nBUBemptYpS/SVCToLdaI+0TQHsvTXSVpP0XksRoUbgzpnVco/2VA==
X-Received: by 2002:a63:e845:: with SMTP id a5mr5633375pgk.246.1554379639035;
        Thu, 04 Apr 2019 05:07:19 -0700 (PDT)
Received: from bobo.local0.net (193-116-89-42.tpgi.com.au. [193.116.89.42])
        by smtp.gmail.com with ESMTPSA id j22sm24720668pfn.129.2019.04.04.05.07.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 05:07:18 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbec@gmail.com>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] sched/core: allow the remote scheduler tick to be started on CPU0
Date:   Thu,  4 Apr 2019 22:07:01 +1000
Message-Id: <20190404120704.18479-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190404120704.18479-1-npiggin@gmail.com>
References: <20190404120704.18479-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This has on effect yet because CPU0 will always be a housekeeping CPU
until a later change.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 4778c48a7fda..10e05ec049b6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5918,7 +5918,7 @@ void __init sched_init_smp(void)
 
 static int __init migration_init(void)
 {
-	sched_rq_cpu_starting(smp_processor_id());
+	sched_cpu_starting(smp_processor_id());
 	return 0;
 }
 early_initcall(migration_init);
-- 
2.20.1

