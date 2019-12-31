Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D746C2D0C2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 13:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D5B9206DA
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 13:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="izoC2nmZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfLaNfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 08:35:46 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:39401 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfLaNfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 08:35:45 -0500
Received: by mail-pj1-f66.google.com with SMTP id t101so1232277pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Dec 2019 05:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dEit719n2Ik36OhY/hE3/4A9AQeh6rXuvoLsvQp2DrE=;
        b=izoC2nmZ/zXLGi9aRbnLJsWJYaP4LeBp8QtAfnx+zUT2T8CxRnppRCRNji8J0K4CA8
         PYDe/gZSqieXnH4mEqfd+EFHUZ6Kq4fbED4NImWxh72N7GNwGIEB6txrOk291AT2g6cz
         OFzrRzn3wScUNxx9XFNXxCmt7firufX3/QJuw2CxiBGr/8OQDDM8I2mtqvMSlksTouzP
         pF9Duy1pjVCcqdOeRMjxITT98eDFT7/KjNiFwFgsF0R8ASfUSBjTI02CgoFygEv+s7xq
         IiI68FLkhCElwGaCQEwzog4T2MZaAfRyZe+ZDjkY6ZfTy+jRY2wDntV9cSo7ec5Wf6Kr
         Asdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dEit719n2Ik36OhY/hE3/4A9AQeh6rXuvoLsvQp2DrE=;
        b=VJYwjaIkXZKvY+TXNzV9Djp7PPYQ0uj8FFMirsdpiEHZXna697lwl2CSiDY8FTU6j6
         7/o29KCiITqOdW7AwvioQEVD9l9ie0/NsAR9Pmb7bVZAY+yuf7iEKsfqi215dKsJxYvA
         YAQ+D5fhYty2arlz2gtYD7wuENZUrCG80Q3RxRrT6bJkB8MUTGriOI7F9igGXcCOTiu7
         c6HA3EPiAy3CH7RVy9ujuTPlPF0EaLmbFIexPR+TjHC79jebVeaDS1Z5GuhmDVMc9Ju9
         5cpyiKr3m0Q8i3TasSZzn/3kkptwzybF7w5awYtubBFh99HtZK6eBs1sSMtCk8WUsR0u
         wTPw==
X-Gm-Message-State: APjAAAUMYVTFT//soIozOsT32NlsIR0fr/iyD2Ae37bswXM8QRf/VjxM
        KPQvvYUUHauZ+meNmvGkyus=
X-Google-Smtp-Source: APXvYqwzn5JhjM0MgDhpzTd9WBBz3GkKR/NF1IZ58WLZ9wuo9W9MtKDxIZhl5VIadzV54kOpQJ2SjA==
X-Received: by 2002:a17:90a:35e6:: with SMTP id r93mr6362250pjb.44.1577799345086;
        Tue, 31 Dec 2019 05:35:45 -0800 (PST)
Received: from localhost.localdomain ([2408:8025:ad:7e20:f8a1:4793:6c48:941])
        by smtp.gmail.com with ESMTPSA id e10sm57903910pfj.7.2019.12.31.05.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Dec 2019 05:35:44 -0800 (PST)
From:   chengkaitao <pilgrimtao@gmail.com>
To:     rostedt@goodmis.org
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org, smuchun@gmail.com,
        Kaitao Cheng <pilgrimtao@gmail.com>
Subject: [PATCH] kernel/trace: Fix do not unregister tracepoints when register sched_migrate_task fail
Date:   Tue, 31 Dec 2019 05:35:30 -0800
Message-Id: <20191231133530.2794-1-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kaitao Cheng <pilgrimtao@gmail.com>

In the function, if register_trace_sched_migrate_task() returns error,
sched_switch/sched_wakeup_new/sched_wakeup won't unregister. That is
why fail_deprobe_sched_switch was added.

Signed-off-by: Kaitao Cheng <pilgrimtao@gmail.com>
---
 kernel/trace/trace_sched_wakeup.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_wakeup.c
index 5e43b9664eca..617e297f46dc 100644
--- a/kernel/trace/trace_sched_wakeup.c
+++ b/kernel/trace/trace_sched_wakeup.c
@@ -630,7 +630,7 @@ static void start_wakeup_tracer(struct trace_array *tr)
 	if (ret) {
 		pr_info("wakeup trace: Couldn't activate tracepoint"
 			" probe to kernel_sched_migrate_task\n");
-		return;
+		goto fail_deprobe_sched_switch;
 	}
 
 	wakeup_reset(tr);
@@ -648,6 +648,8 @@ static void start_wakeup_tracer(struct trace_array *tr)
 		printk(KERN_ERR "failed to start wakeup tracer\n");
 
 	return;
+fail_deprobe_sched_switch:
+	unregister_trace_sched_switch(probe_wakeup_sched_switch, NULL);
 fail_deprobe_wake_new:
 	unregister_trace_sched_wakeup_new(probe_wakeup, NULL);
 fail_deprobe:
-- 
2.20.1

