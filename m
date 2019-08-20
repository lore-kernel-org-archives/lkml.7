Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B31AC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 08:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EB7B23A7A
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 08:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fossix-org.20150623.gappssmtp.com header.i=@fossix-org.20150623.gappssmtp.com header.b="o8PfGZiI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729433AbfHTIOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 04:14:12 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45471 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729395AbfHTIOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 04:14:10 -0400
Received: by mail-pl1-f196.google.com with SMTP id y8so2363683plr.12
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 01:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YJYgBqte5Ii/VSliQ8oA8G2Ha5PCLW/st87+39mATT8=;
        b=o8PfGZiIlB2TqYW1b3hM8z1019vtcXTc/m8pBj5F5FdYLJgcRYH7K88P2YJM1ibjj3
         8SsafjOOWlHk39uF6xHZ4rTpqPFu9WW5djBEn1+zZPk0aEnwF+rIAzWAuSx/Oj9JTdYi
         pNcFBy0MgtQZYmJZ+csCGzMpCAC0woTGkcuNQiYGAhJrI5f9Yyq3diOSx/nt9sNU1554
         9TlzNQCgpqvQhxxgGnGo3QZIjr33sCZETfocJwj8dWv4/R6QETvBgiZtlrZwSeGSvQ+U
         UsP0nSy6LLU+CqqkgD9U887l+2B5xk9xH/s3Sr2niAUh0rUkpxUaHXFa+wQZv8i9iW2v
         rcJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YJYgBqte5Ii/VSliQ8oA8G2Ha5PCLW/st87+39mATT8=;
        b=PJoMIifAgZY36DM9T6slyg58/V8sCQpcjLSnCHKuhciIN5+gg5nytp40gp7rrS6TwT
         5WY2XYVgIa/GTu4S6kuN+TSaqB8fP2/bdycEcVdlRtGrEIbT/dIFOo2914td5NfRDNSF
         9885cYgJJCvNlnTMLbFI0UjD9BB8vyt3R/HNV9JSm2j9+fxHkNAcs7dPj4jExgS7/C00
         88fgvYDLNDKeqZ9KT93zpEN6ObKtOIV4w1rs4n0JKY1hR0VA4NLSYnAnQZqiUHZJrxHu
         xk6IdpanN416qtWTXIwnKFHwvzJb/VyvQD/gUWMxcv5vYMMVNQ/7ZGD7P+aqj1Tj6KRk
         UGJA==
X-Gm-Message-State: APjAAAVRs3Ly5/kWho5HhOIIISvi/OoFT5ubk0RDnGrqseSP++nkuL86
        sQndOsjumGcobXnfWHriL/UE8Q==
X-Google-Smtp-Source: APXvYqzQm/aCpNRce4Y9mErF0e8Uju13vUdmSIZWfvkH8IIfs+311kArKxd4CLK9fTMu4ft13FN/bw==
X-Received: by 2002:a17:902:7442:: with SMTP id e2mr16414839plt.315.1566288850090;
        Tue, 20 Aug 2019 01:14:10 -0700 (PDT)
Received: from santosiv.in.ibm.com ([129.41.84.78])
        by smtp.gmail.com with ESMTPSA id b14sm18949265pfo.15.2019.08.20.01.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 01:14:09 -0700 (PDT)
From:   Santosh Sivaraj <santosh@fossix.org>
To:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Reza Arbab <arbab@linux.ibm.com>,
        Chandan Rajendra <chandan@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v11 3/7] powerpc/mce: Make machine_check_ue_event() static
Date:   Tue, 20 Aug 2019 13:43:48 +0530
Message-Id: <20190820081352.8641-4-santosh@fossix.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190820081352.8641-1-santosh@fossix.org>
References: <20190820081352.8641-1-santosh@fossix.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Reza Arbab <arbab@linux.ibm.com>

The function doesn't get used outside this file, so make it static.

Signed-off-by: Reza Arbab <arbab@linux.ibm.com>
Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/mce.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/mce.c b/arch/powerpc/kernel/mce.c
index cff31d4a501f..a3b122a685a5 100644
--- a/arch/powerpc/kernel/mce.c
+++ b/arch/powerpc/kernel/mce.c
@@ -34,7 +34,7 @@ static DEFINE_PER_CPU(struct machine_check_event[MAX_MC_EVT],
 
 static void machine_check_process_queued_event(struct irq_work *work);
 static void machine_check_ue_irq_work(struct irq_work *work);
-void machine_check_ue_event(struct machine_check_event *evt);
+static void machine_check_ue_event(struct machine_check_event *evt);
 static void machine_process_ue_event(struct work_struct *work);
 
 static struct irq_work mce_event_process_work = {
@@ -212,7 +212,7 @@ static void machine_check_ue_irq_work(struct irq_work *work)
 /*
  * Queue up the MCE event which then can be handled later.
  */
-void machine_check_ue_event(struct machine_check_event *evt)
+static void machine_check_ue_event(struct machine_check_event *evt)
 {
 	int index;
 
-- 
2.21.0

