Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B9EFC0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 06:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1AC620B1F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 06:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fossix-org.20150623.gappssmtp.com header.i=@fossix-org.20150623.gappssmtp.com header.b="1Nse/dO2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbfHEGWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 02:22:44 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46525 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbfHEGWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 02:22:42 -0400
Received: by mail-pl1-f195.google.com with SMTP id c2so36021782plz.13
        for <linux-kernel@vger.kernel.org>; Sun, 04 Aug 2019 23:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H/M6TqzLiuanVCliBc3NhrwyBR/yMVzqsnz9WE14WyI=;
        b=1Nse/dO23Ys1MctZWr+L8K1WlGtDgARRZnoh5PGymw+9Eu9kdrsnfK4WmSY9X4jRsq
         5vcDPjPH6UM/qX6zRFpX8KjxaNGzTShw5Oqoq2H9q2WruYazsPSeUI8VNvmJs14chpEn
         umzFmf3dUagSdryUGeIIhY7BJLH6RU1uDuRKkDyjDhOePY5RwBKFZZFhqhjL3BCx9JLP
         d97OiAVZ+e413fgnUvzJH4H9ZwIxYEUGUXwhiTpjycjIOrWJaFHN408f/CP0F+0PFigj
         RZdeBbiXnLmUn+fCA+SstBfhlS6W1mJrEFJ0oPzbYPfDasGwlCUKmGb4HDCqX3zWdtfh
         b1xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H/M6TqzLiuanVCliBc3NhrwyBR/yMVzqsnz9WE14WyI=;
        b=j7HLhXiRwUSPjRmDGrL751D4T3VfixjmvtGt08dqPYlCrYbAuuAnLKEB4VDaeftJQa
         N8gMC6ABjNph+Rh8DTPVBNk/Nsrl/M/sxJkh3sav9jnDkQS0h7HrWu9hJTCIVkva/m3i
         mOZ0C1rRdv0ZsMvBSpe3th2fGHdpvgijz70SW+dwgosB7Of4fffEH8QW2/R7cv9trL95
         1RvxXIM5F4LFpfJYAsxxGZcqPvoTcROkeBBBrBgg9Mc9CEZ6NTm2fKSSr3fIDtj11YJq
         m88qZzUz4EfQ+Sa80KokzDkwPXFazVVM53xkxB6QPqq/KVcWl2fyZQLtvKBd07u3rgx4
         DOIQ==
X-Gm-Message-State: APjAAAVLvEeYWbaKRIOsGu/xL+rJLYOzh84eKKMVqqrT4JAEBKQglTIm
        bz4gk63isbggqg693lFPGiQ=
X-Google-Smtp-Source: APXvYqzExHvOBf8j3MhHZWTk+Z3VqVYZHgHGPaR9MQnzwDtZFXfB5bCcqDxIIAFdNRwOe2v+7v6ctw==
X-Received: by 2002:a17:902:9a07:: with SMTP id v7mr35731472plp.245.1564986161925;
        Sun, 04 Aug 2019 23:22:41 -0700 (PDT)
Received: from santosiv.in.ibm.com ([129.41.84.66])
        by smtp.gmail.com with ESMTPSA id i14sm124680082pfk.0.2019.08.04.23.22.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 04 Aug 2019 23:22:41 -0700 (PDT)
From:   Santosh Sivaraj <santosh@fossix.org>
To:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-kernel@vger.kernel.org
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Reza Arbab <arbab@linux.ibm.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        christophe leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v7 2/7] powerpc/mce: Make machine_check_ue_event() static
Date:   Mon,  5 Aug 2019 11:52:20 +0530
Message-Id: <20190805062225.4354-3-santosh@fossix.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190805062225.4354-1-santosh@fossix.org>
References: <20190805062225.4354-1-santosh@fossix.org>
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
index 0ab6fa7cbbbb..8c0b471658a7 100644
--- a/arch/powerpc/kernel/mce.c
+++ b/arch/powerpc/kernel/mce.c
@@ -33,7 +33,7 @@ static DEFINE_PER_CPU(struct machine_check_event[MAX_MC_EVT],
 					mce_ue_event_queue);
 
 static void machine_check_process_queued_event(struct irq_work *work);
-void machine_check_ue_event(struct machine_check_event *evt);
+static void machine_check_ue_event(struct machine_check_event *evt);
 static void machine_process_ue_event(struct work_struct *work);
 
 static struct irq_work mce_event_process_work = {
@@ -202,7 +202,7 @@ void release_mce_event(void)
 /*
  * Queue up the MCE event which then can be handled later.
  */
-void machine_check_ue_event(struct machine_check_event *evt)
+static void machine_check_ue_event(struct machine_check_event *evt)
 {
 	int index;
 
-- 
2.20.1

