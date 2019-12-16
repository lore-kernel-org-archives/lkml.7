Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41AF0C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 21:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 084C524673
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 21:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W7TtsBOL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbfLPVbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 16:31:39 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51226 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727119AbfLPVbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 16:31:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576531893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1ZtgwiIEnYHkVgKhW+bFBM9sQF2o/xuVG7THWYjKZrk=;
        b=W7TtsBOLvNkNRqlLI3Ojf3HZCzo10qSopWI1lrJHWdqFkwo5/WUr9dRZii1MMXI5LMdSWQ
        N9utVad88HHM3W4UdbuWjfCkb6jpcWbLq593amXY/H2v805KQuQ3LdojWDt2RUMmjsLPzg
        fXJuSHbDJsMkkVm3CA49Xl2F0PEPl9c=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-9hRP_qjBPFSUkqo97SvDFA-1; Mon, 16 Dec 2019 16:31:32 -0500
X-MC-Unique: 9hRP_qjBPFSUkqo97SvDFA-1
Received: by mail-qk1-f197.google.com with SMTP id a200so3118299qkc.18
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 13:31:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1ZtgwiIEnYHkVgKhW+bFBM9sQF2o/xuVG7THWYjKZrk=;
        b=FsJYEUoGOsUXSreG2u92LvSRf4M52N/kQL2fn5ZUpNvs38DxTCFPBlGzngoqqaA0l7
         U0gGN6N6Bse/HUAohOgMvP0lKLOrwfD5OuKCJCIXL+KL9bRr8715Jm3JUhrqAeD5q73d
         wuKFzFLIEhe1k/RDfoJpPJZ/VhPEE+gDkmjACuoYdkkU7YXa4PGcyW0HdybkNNmkHftP
         NBH1JizY/P+cnF4JVbEfl5EMXke0dqhfPCXnNUJMnAFdnEuCw/2vmlv3+s4Ubi3gxwrz
         FDh++yV1l3Azjz1Vc6TOV0FQbVRjwm9+txFTIH87brw3dGs/Dt/nBLCBTHHlI4GC4n96
         ta3Q==
X-Gm-Message-State: APjAAAVFrrOG8RR6cIljXPwmmIzWY5+kQwAvx9IjFsvvpRRF8DJdUmDs
        5mlwLqYNxOGJphfyH6T4wckZWsx2s1d7BRE9LvhRx02Z9jJhVMtFX/wrz1Tceo8SpDiOHP3zDMh
        mboAY24tVL+bDEfWaqmz3GXkT
X-Received: by 2002:a05:6214:c3:: with SMTP id f3mr1526184qvs.226.1576531891718;
        Mon, 16 Dec 2019 13:31:31 -0800 (PST)
X-Google-Smtp-Source: APXvYqy7JOk4JZqvdtLrTTs09SUilPx8nuBzD2xep57Bdm4Wdal8sROqtqboNHGhYmEGHkIAOCtS7Q==
X-Received: by 2002:a05:6214:c3:: with SMTP id f3mr1526160qvs.226.1576531891545;
        Mon, 16 Dec 2019 13:31:31 -0800 (PST)
Received: from xz-x1.yyz.redhat.com ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id y184sm6321943qkd.128.2019.12.16.13.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 13:31:30 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>, peterx@redhat.com,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 3/3] sched: Remove rq.hrtick_csd_pending
Date:   Mon, 16 Dec 2019 16:31:25 -0500
Message-Id: <20191216213125.9536-4-peterx@redhat.com>
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
don't need the rq.hrtick_csd_pending any more.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 kernel/sched/core.c  | 9 ++-------
 kernel/sched/sched.h | 1 -
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 44123b4d14e8..ef527545d349 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -268,7 +268,6 @@ static void __hrtick_start(void *arg)
 
 	rq_lock(rq, &rf);
 	__hrtick_restart(rq);
-	rq->hrtick_csd_pending = 0;
 	rq_unlock(rq, &rf);
 }
 
@@ -292,12 +291,10 @@ void hrtick_start(struct rq *rq, u64 delay)
 
 	hrtimer_set_expires(timer, time);
 
-	if (rq == this_rq()) {
+	if (rq == this_rq())
 		__hrtick_restart(rq);
-	} else if (!rq->hrtick_csd_pending) {
+	else
 		smp_call_function_single_async(cpu_of(rq), &rq->hrtick_csd);
-		rq->hrtick_csd_pending = 1;
-	}
 }
 
 #else
@@ -321,8 +318,6 @@ void hrtick_start(struct rq *rq, u64 delay)
 static void hrtick_rq_init(struct rq *rq)
 {
 #ifdef CONFIG_SMP
-	rq->hrtick_csd_pending = 0;
-
 	rq->hrtick_csd.flags = 0;
 	rq->hrtick_csd.func = __hrtick_start;
 	rq->hrtick_csd.info = rq;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index c8870c5bd7df..79b435bbe129 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -967,7 +967,6 @@ struct rq {
 
 #ifdef CONFIG_SCHED_HRTICK
 #ifdef CONFIG_SMP
-	int			hrtick_csd_pending;
 	call_single_data_t	hrtick_csd;
 #endif
 	struct hrtimer		hrtick_timer;
-- 
2.23.0

