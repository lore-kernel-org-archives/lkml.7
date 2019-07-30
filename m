Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE67C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 06:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9946206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 06:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fossix-org.20150623.gappssmtp.com header.i=@fossix-org.20150623.gappssmtp.com header.b="xNCb+F5o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbfG3GP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 02:15:29 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33318 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfG3GP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 02:15:29 -0400
Received: by mail-pf1-f195.google.com with SMTP id g2so29268344pfq.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 23:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rNAxrgF/Fu2C1YjiAQFHjU/OuPjgdh3QklL9HCBzlDY=;
        b=xNCb+F5o5GHCQCrM8iOOY1BhPmfzlYKhXwLaVOogMTRTbqN9gxVZHQyulEnhhat4a4
         f47JE66kNAf/5kbl2NNf0hVXlLNeW0nZe1e+m9QsvVCCGLyLm+i6zyYBqmdO2sv7egkr
         vlWWpmNb75RZH+Adr1aXek/QkxusTn++zc0t2fY2O0oVz8wqg57r+PehmG9r9ue+vhBf
         ZGNIpm1ZNqB7NGqAXaqP/KsyVkV5GYLWB6Xem4/bZPuwqkm2b5zqhaQQlC31YcdDJoCg
         WcJYPYuEKJmpdgDYVz91m++XkmnHaeVOgHnJkukKkx9RopME4jnECIJZUsKZgcwadcRW
         5j8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rNAxrgF/Fu2C1YjiAQFHjU/OuPjgdh3QklL9HCBzlDY=;
        b=VAKLLffnGOgw0Zhvhtgwk/kAaJBnKLs0M+QNk75Ll9efuZeWXA1Fw4LiqlzcvYlrJ+
         Guo9f6qm0JBtVwG2NtVHqy6g8s0oKP9fZ3XFe9JtvOh2Y+tGmS+04EPnFwOpPKPKj4dQ
         uheBp+kFWFcptLX3R4fm+Bn7YBKfNpZzE+cVzlIqT/vqUwXku809JE33gojrO7RpJ5hB
         reY/LKTzVDm04Y9Ieets6ooAGuLhqjdDYFthJtVEW6aANqw0DYPnk6KflM7d/LCz6u4k
         +yNGbKhW5PAEda3QE2zCPk6pX1PyL4tRo/puqG2eJuz3EBq/yn/Qm/YV+9zYyDaHerJl
         64aQ==
X-Gm-Message-State: APjAAAV5ogtDJ5u+DXcQ7cYqDlM70iIGdlvTCdy1XG9rFwhZ3XRhvx1A
        U+zcrmzhEoMTRrWWB3ARo9A=
X-Google-Smtp-Source: APXvYqyoiWtADy9CcJl1VAChZXBghswzTu6lkR4mHm6guZDMcfVZvrxW0rb62/4LylUnq96aE3/6tA==
X-Received: by 2002:a17:90a:35e6:: with SMTP id r93mr116106529pjb.20.1564467328367;
        Mon, 29 Jul 2019 23:15:28 -0700 (PDT)
Received: from santosiv.in.ibm.com ([129.41.84.67])
        by smtp.gmail.com with ESMTPSA id z24sm111999393pfr.51.2019.07.29.23.15.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 23:15:27 -0700 (PDT)
From:   Santosh Sivaraj <santosh@fossix.org>
To:     x86@kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH] x86/mce: Remove redundant irq work
Date:   Tue, 30 Jul 2019 11:45:20 +0530
Message-Id: <20190730061520.19953-1-santosh@fossix.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IRQ work currently only does a schedule work to process the mce
events. Since irq work does no other function, remove it.

Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
---
 arch/x86/kernel/cpu/mce/core.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 743370ee4983..658da808c031 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -119,7 +119,7 @@ DEFINE_PER_CPU(mce_banks_t, mce_poll_banks) = {
 mce_banks_t mce_banks_ce_disabled;
 
 static struct work_struct mce_work;
-static struct irq_work mce_irq_work;
+static void mce_schedule_work(void);
 
 static void (*quirk_no_way_out)(int bank, struct mce *m, struct pt_regs *regs);
 
@@ -154,7 +154,7 @@ EXPORT_PER_CPU_SYMBOL_GPL(injectm);
 void mce_log(struct mce *m)
 {
 	if (!mce_gen_pool_add(m))
-		irq_work_queue(&mce_irq_work);
+		mce_schedule_work();
 }
 
 void mce_inject_log(struct mce *m)
@@ -472,11 +472,6 @@ static void mce_schedule_work(void)
 		schedule_work(&mce_work);
 }
 
-static void mce_irq_work_cb(struct irq_work *entry)
-{
-	mce_schedule_work();
-}
-
 /*
  * Check if the address reported by the CPU is in a format we can parse.
  * It would be possible to add code for most other cases, but all would
@@ -1333,7 +1328,7 @@ void do_machine_check(struct pt_regs *regs, long error_code)
 		mce_panic("Fatal machine check on current CPU", &m, msg);
 
 	if (worst > 0)
-		irq_work_queue(&mce_irq_work);
+		mce_schedule_work();
 
 	mce_wrmsrl(MSR_IA32_MCG_STATUS, 0);
 
@@ -1984,7 +1979,6 @@ int __init mcheck_init(void)
 	mcheck_vendor_init_severity();
 
 	INIT_WORK(&mce_work, mce_gen_pool_process);
-	init_irq_work(&mce_irq_work, mce_irq_work_cb);
 
 	return 0;
 }
-- 
2.20.1

