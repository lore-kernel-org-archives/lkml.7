Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23BE7C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 21:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBFB624672
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 21:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P8jFen51"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbfLPVbf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 16:31:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56035 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727110AbfLPVbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 16:31:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576531892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RH1+AViO4EoL9+jCeRxJJWq+wAQu3tyekrBf+r+c33M=;
        b=P8jFen51V+FCK97fQEEo/eU+U4/YgGB81BpnRVcRljIbHZJKoTVOARnd0aRXeX2aqMCb3Q
        wN/bYSWs1bPFLqMu3sk3sDcPW13Etoa4Vjfp3dZ8eHPB6hSrJ3/3B+GYmhP+rMpXAOzuKS
        DF9hP406aj2b2BDaW/4nkXUlTTr2H5E=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-r-1ApwKBPMGdmo2Ya6bEFQ-1; Mon, 16 Dec 2019 16:31:31 -0500
X-MC-Unique: r-1ApwKBPMGdmo2Ya6bEFQ-1
Received: by mail-qk1-f200.google.com with SMTP id g28so5531058qkl.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 13:31:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RH1+AViO4EoL9+jCeRxJJWq+wAQu3tyekrBf+r+c33M=;
        b=dJ17QBiczF3qAwOFyw6AK6JFlgQeFK99YAXUHAXCBW93LA6sdpFH/xE7CGfIW+jBSA
         14twEnf0Luynl8YEUVqh8rBWbN25PDHLgmYwbA18rmLFjghXJMAJQMkCseHq5D3QKEYL
         DqinOU7YR6/LhXyKtAsa35y4Nvl7OdNCr5Ao3J3ZEhzpDyObQ/17c0GoOHC5EXoSl22q
         41BzLrl25AXkpTNHS64Lf8byaFD7Y3T3EPfT7t6qMgYG1VlGc1JWMF0Qjbkw1K6WLcFY
         9qejqYO4q7X8vIpHFAnccQZ3Q8wMujNGnuUOnSKJToBfsaNAb0cWQk6g6BSvDg0qHgyK
         SFgA==
X-Gm-Message-State: APjAAAWPoLmDurfWB2x2PQqBLPY1DfwOM4+ABPBeZwer5gRSr5LVZKSt
        PQb80EwBMspuFKwwXE/XFbxvpAKDRHqmG9ARbCO++DlelUjQ4zU74nOCcwKyuGkic7bj6dlgHoo
        IcXoAN2ZJppnwwL4aAdgdBTRe
X-Received: by 2002:aed:30e2:: with SMTP id 89mr1467484qtf.355.1576531890419;
        Mon, 16 Dec 2019 13:31:30 -0800 (PST)
X-Google-Smtp-Source: APXvYqzs/VMYgoqhoiLGAmOXY5S9INg3jdWsZ9ngLkLfrfQtS12COJC294q65nOffgqO/bYEKrj+aQ==
X-Received: by 2002:aed:30e2:: with SMTP id 89mr1467475qtf.355.1576531890253;
        Mon, 16 Dec 2019 13:31:30 -0800 (PST)
Received: from xz-x1.yyz.redhat.com ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id y184sm6321943qkd.128.2019.12.16.13.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 13:31:29 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>, peterx@redhat.com,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 2/3] MIPS: smp: Remove tick_broadcast_count
Date:   Mon, 16 Dec 2019 16:31:24 -0500
Message-Id: <20191216213125.9536-3-peterx@redhat.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191216213125.9536-1-peterx@redhat.com>
References: <20191216213125.9536-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now smp_call_function_single_async() provides the protection that
we'll return with -EBUSY if the csd object is still pending, then we
don't need the tick_broadcast_count counter any more.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/mips/kernel/smp.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index f510c00bda88..0678901c214d 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -696,21 +696,16 @@ EXPORT_SYMBOL(flush_tlb_one);
 
 #ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
 
-static DEFINE_PER_CPU(atomic_t, tick_broadcast_count);
 static DEFINE_PER_CPU(call_single_data_t, tick_broadcast_csd);
 
 void tick_broadcast(const struct cpumask *mask)
 {
-	atomic_t *count;
 	call_single_data_t *csd;
 	int cpu;
 
 	for_each_cpu(cpu, mask) {
-		count = &per_cpu(tick_broadcast_count, cpu);
 		csd = &per_cpu(tick_broadcast_csd, cpu);
-
-		if (atomic_inc_return(count) == 1)
-			smp_call_function_single_async(cpu, csd);
+		smp_call_function_single_async(cpu, csd);
 	}
 }
 
@@ -718,7 +713,6 @@ static void tick_broadcast_callee(void *info)
 {
 	int cpu = smp_processor_id();
 	tick_receive_broadcast();
-	atomic_set(&per_cpu(tick_broadcast_count, cpu), 0);
 }
 
 static int __init tick_broadcast_init(void)
-- 
2.23.0

