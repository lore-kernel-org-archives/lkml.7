Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AEBFC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 09:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B54920820
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 09:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fossix-org.20150623.gappssmtp.com header.i=@fossix-org.20150623.gappssmtp.com header.b="S4icX2XX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbfHLJXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 05:23:05 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44787 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727369AbfHLJXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 05:23:03 -0400
Received: by mail-pl1-f195.google.com with SMTP id t14so47616568plr.11
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 02:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YJYgBqte5Ii/VSliQ8oA8G2Ha5PCLW/st87+39mATT8=;
        b=S4icX2XXM6aIjRUdCAkkGKuWAlG5xkCElu+5yhd+i9XYs2hv+ypGPPVNmlizlHd8aS
         kXcJ6Wf+v9zz5MCleydykchsEAViVPb4zRVxyF+l2XG+3trA+2rE1Aw+8Y9/TPCZfobf
         bPqqWDvmeBP28baUu8om09wmBoeD1FzDQprayAHHjJcAxhv859rl8sn7uIC3hpffO6Dh
         arS1uY1FrlvK814Adh3FljnYif/ReiU3MKRxAMfM2TxgJD3kRxz+NiYEw+kJ43VhU3UM
         dL6x26v1zKNTqtLL40/gG2R/Ev8c9WzaOhcSdZn8M4KXUm1+eFsR4BoHcBwF6oPYh5YO
         hTbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YJYgBqte5Ii/VSliQ8oA8G2Ha5PCLW/st87+39mATT8=;
        b=iH1THrl8k9IspZqX5jNbIVFeaoDV39q1URiM01twt2Y10ttkZCTaGQ1287UDRvsMjP
         H35m5yax3m05ZaPZR8LMg/Ln4Et+4rVhprKs94gw7iZuA2XhEiD/twUFsh5aMetSiVrp
         4pbrFU6IYChh1YQjz/9MNI6AYWJCuO4639ZPtWqDxnMywAeACMf/Vs9gQWqIAe+/7wlb
         /mREbcmE6zj6mn4L6qD5OrVDy3fKlnZB5qNFP83m7EO4zLHgImzwSMtk5CSX0etFl4y+
         9d3NfI2mC5WiiPZnURZOJrNS3eWIGp51MMHDLbaUfllrHEgLKhOqBdSl9bpAtliBTiNS
         9ryw==
X-Gm-Message-State: APjAAAWn/bod8ebkozMmxYEeMWLSqLAFnf/+3R3Y6AHBuu4+6ici3UHM
        yclys4yl1ssIb2+B0uNBs2CL1w==
X-Google-Smtp-Source: APXvYqxjMi1RdbCw38eLMQP/8fgPlz8ypjbBhtn9w4gdYK0krPBKiebotVX2Lf+DSq11TIMl/TjBRw==
X-Received: by 2002:a17:902:a409:: with SMTP id p9mr32274336plq.218.1565601783051;
        Mon, 12 Aug 2019 02:23:03 -0700 (PDT)
Received: from santosiv.in.ibm.com ([129.41.84.75])
        by smtp.gmail.com with ESMTPSA id y188sm10543517pfb.115.2019.08.12.02.23.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 02:23:02 -0700 (PDT)
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
        christophe leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v9 3/7] powerpc/mce: Make machine_check_ue_event() static
Date:   Mon, 12 Aug 2019 14:52:32 +0530
Message-Id: <20190812092236.16648-4-santosh@fossix.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190812092236.16648-1-santosh@fossix.org>
References: <20190812092236.16648-1-santosh@fossix.org>
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

