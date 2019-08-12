Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFBC5C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 09:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3A7A20820
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 09:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fossix-org.20150623.gappssmtp.com header.i=@fossix-org.20150623.gappssmtp.com header.b="qYKPu7dQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbfHLJW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 05:22:57 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34395 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727371AbfHLJW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 05:22:56 -0400
Received: by mail-pl1-f196.google.com with SMTP id i2so47676895plt.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 02:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xo5GxV2VUz5oUEAom/90QFb/1qeb/Ep256qNvcX0mNY=;
        b=qYKPu7dQnJ+efxNuKAgOhhGHbAtOXZiq6e8QCQ68gncmUnNmf7V9YNSsDwdaNeQBPE
         xJmNTmwZKEylqy/Ylcwjisr3ExW+75yriMU6j0SKUI30CDpDMfXvTU4qt7TR3cu//PiM
         K6CZg2/N7KBO7pr4kvvBdYbVgRldlXRmV3gu6BcETBXEu7crWdPdZoYoXEnLP/4w19TM
         oCXBVrbx+xktP79mC8nCIBoOwhvxzSAvNmcOjQP0BJm0ZwoPT/qCNb2dtN5+BGfGvyzi
         vgEzaXHDCNKV1eajtKIwM1yUdNMUemKkeGsqIj9djgeTOWYPPi5bc0e0fb10VWJXq6Fs
         1jKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xo5GxV2VUz5oUEAom/90QFb/1qeb/Ep256qNvcX0mNY=;
        b=DOUnP5zs3niL/+ZRT+d+ql4Z9SJpNeO9uyVQFgaUAU5GWljtU8a5+TpDmGqxNqkWPL
         W8I+HjZj7j/uaxnH6TusZMPxxbkBFffNUSVjXmEBvUgsRtkFM7CwzlUSbxDLspjPbYUm
         9RFOllUD68GYZ3PWsZ+lijLxhBE5eVSyvwG6zvSVuavawtu5Vs5MqqvRsI3WwM3KJVTy
         8j09C15Ds1/N1s+xrIntBNtPPLaV1QvHaEsA5+5sqy9Oyv4+o/cdq05B+YmJsmiDUP1m
         O2Vhbo3ZXp60OSlj1wRpun/54Bcl5zUC/SPGzm8zwFUOw7cCYylFKjslmeaMATmcZlw2
         HoPA==
X-Gm-Message-State: APjAAAWDDqkFz73oC6jqdzzgpqrjAywkmW2pgyhdA69ZOUtxo+YbCh8H
        sCOPJ2gUNX3rvM3DzzSar2YLYw==
X-Google-Smtp-Source: APXvYqwtw33Uv4tZNCnDJo6DvoapC5CmXz0Ep2dPuTnN0OYxub03wKeh9P4Gz/QX5Ibf+5KkSX/mqA==
X-Received: by 2002:a17:902:f81:: with SMTP id 1mr31777188plz.191.1565601775904;
        Mon, 12 Aug 2019 02:22:55 -0700 (PDT)
Received: from santosiv.in.ibm.com ([129.41.84.75])
        by smtp.gmail.com with ESMTPSA id y188sm10543517pfb.115.2019.08.12.02.22.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 02:22:55 -0700 (PDT)
From:   Santosh Sivaraj <santosh@fossix.org>
To:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Reza Arbab <arbab@linux.ibm.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        christophe leroy <christophe.leroy@c-s.fr>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        stable@vger.kernel.org
Subject: [PATCH v9 1/7] powerpc/mce: Schedule work from irq_work
Date:   Mon, 12 Aug 2019 14:52:30 +0530
Message-Id: <20190812092236.16648-2-santosh@fossix.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190812092236.16648-1-santosh@fossix.org>
References: <20190812092236.16648-1-santosh@fossix.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

schedule_work() cannot be called from MCE exception context as MCE can
interrupt even in interrupt disabled context.

fixes: 733e4a4c ("powerpc/mce: hookup memory_failure for UE errors")
Suggested-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
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

