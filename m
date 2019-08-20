Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A23B0C3A59D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 08:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FA7323A6B
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 08:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fossix-org.20150623.gappssmtp.com header.i=@fossix-org.20150623.gappssmtp.com header.b="tWa+y3xQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729394AbfHTIOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 04:14:05 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41703 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfHTIOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 04:14:04 -0400
Received: by mail-pg1-f195.google.com with SMTP id x15so2773479pgg.8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 01:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sloTW0YEU5DdpgVJy+78o9fe+CEqOumJXiAyJzqIzoM=;
        b=tWa+y3xQrmUbjXFYL9/i7bLqTFLvoEN/X+R6ZnOhKhuVLEoiBQdR99IKDZE7nd4U9z
         mwDWr5V7mJDqHVMmbEywkVVoXikNkaSC8llGubEvqqWHiTJZWFzXr+dOHbEzCcQ5JNYj
         Cm1qCn7nPrOEqKF7Nfx9klDoiq1xnYGRQwLKHeDD4Q1tfsjOnp0w+LoAhMSsBZbZ4Fh5
         hZCLQXKuXx0SKDC4zHqAEr9ZL3LVdDp2xI/dbTwt9kqna72QHEqZfM8oWHKbXl2KKm1U
         unN5Qfr1N61EOBswiTmG+LKB3RwmXmeZlKAE7lo6gJC6a9WyjKryuw+YJbBZt3qJgo8O
         j26g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sloTW0YEU5DdpgVJy+78o9fe+CEqOumJXiAyJzqIzoM=;
        b=o5GMa+IFZJyAZgf9FiKs5+lh9hm9XaZ0vaDKan5lAdgzf+P0t2roEp4VjFPzo9Ku7Y
         GMopQIrSTnIZ+ldmD/yz8cU/ajj1PgsuEpnZyNPALzeH2QjQWAsPjVsWSICUpNYO6eyL
         bP+8ZHhS4L6qKy4xrtUNdBQniq+6Gv5CmvqUcSDOqeaQiCsWVyHuw+m2wy8OE5FArI/T
         rqcxuivJy6iVP1yfWLN6To5D/+eUbVAvY1FmnoX8iw0C5oy0TbwO0jvFO+0Xk0EHuFoM
         mkS94AhnaueB/WaNwj6XyWnuMmzF4ukxVQC27woUxvNHfrN6m0kzs22WOnXSRflaHGqX
         4PHw==
X-Gm-Message-State: APjAAAUHFpuWTbkzm7fisgw6Sm+Vxk5oDoKHOtKR/fcKE+74tk0mp2a7
        Nl2daNRGBCtjn/s5v4LvzuH0vA==
X-Google-Smtp-Source: APXvYqxMP9x70oy7aMToUuCo9JKhJOhruFoPsMOCKCRG/kDeIMJQMt4VJJyz+BBRQxdGvLT9OdBbNg==
X-Received: by 2002:a63:947:: with SMTP id 68mr15413137pgj.212.1566288843562;
        Tue, 20 Aug 2019 01:14:03 -0700 (PDT)
Received: from santosiv.in.ibm.com ([129.41.84.78])
        by smtp.gmail.com with ESMTPSA id b14sm18949265pfo.15.2019.08.20.01.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 01:14:03 -0700 (PDT)
From:   Santosh Sivaraj <santosh@fossix.org>
To:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Reza Arbab <arbab@linux.ibm.com>,
        Chandan Rajendra <chandan@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Balbir Singh <bsingharora@gmail.com>, stable@vger.kernel.org
Subject: [PATCH v11 1/7] powerpc/mce: Schedule work from irq_work
Date:   Tue, 20 Aug 2019 13:43:46 +0530
Message-Id: <20190820081352.8641-2-santosh@fossix.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190820081352.8641-1-santosh@fossix.org>
References: <20190820081352.8641-1-santosh@fossix.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

schedule_work() cannot be called from MCE exception context as MCE can
interrupt even in interrupt disabled context.

fixes: 733e4a4c ("powerpc/mce: hookup memory_failure for UE errors")
Reviewed-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Acked-by: Balbir Singh <bsingharora@gmail.com>
Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
Cc: stable@vger.kernel.org # v4.15+
---
 arch/powerpc/kernel/mce.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/mce.c b/arch/powerpc/kernel/mce.c
index b18df633eae9..cff31d4a501f 100644
--- a/arch/powerpc/kernel/mce.c
+++ b/arch/powerpc/kernel/mce.c
@@ -33,6 +33,7 @@ static DEFINE_PER_CPU(struct machine_check_event[MAX_MC_EVT],
 					mce_ue_event_queue);
 
 static void machine_check_process_queued_event(struct irq_work *work);
+static void machine_check_ue_irq_work(struct irq_work *work);
 void machine_check_ue_event(struct machine_check_event *evt);
 static void machine_process_ue_event(struct work_struct *work);
 
@@ -40,6 +41,10 @@ static struct irq_work mce_event_process_work = {
         .func = machine_check_process_queued_event,
 };
 
+static struct irq_work mce_ue_event_irq_work = {
+	.func = machine_check_ue_irq_work,
+};
+
 DECLARE_WORK(mce_ue_event_work, machine_process_ue_event);
 
 static void mce_set_error_info(struct machine_check_event *mce,
@@ -199,6 +204,10 @@ void release_mce_event(void)
 	get_mce_event(NULL, true);
 }
 
+static void machine_check_ue_irq_work(struct irq_work *work)
+{
+	schedule_work(&mce_ue_event_work);
+}
 
 /*
  * Queue up the MCE event which then can be handled later.
@@ -216,7 +225,7 @@ void machine_check_ue_event(struct machine_check_event *evt)
 	memcpy(this_cpu_ptr(&mce_ue_event_queue[index]), evt, sizeof(*evt));
 
 	/* Queue work to process this event later. */
-	schedule_work(&mce_ue_event_work);
+	irq_work_queue(&mce_ue_event_irq_work);
 }
 
 /*
-- 
2.21.0

