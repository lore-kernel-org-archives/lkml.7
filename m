Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A23C41514
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 02:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0A18217D9
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 02:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="siHGvn1B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbfHGCqR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 22:46:17 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39401 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbfHGCqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 22:46:16 -0400
Received: by mail-pf1-f195.google.com with SMTP id f17so38599198pfn.6;
        Tue, 06 Aug 2019 19:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=PrH45PB9RsMA7pyDP1csKVYDAqtxvNcn8nWcn6FbNjc=;
        b=siHGvn1Bj4sIEYw5q5Gg20BGgu8x4a1UDeEVboEey9CPp5bwN7qRSX9PdbaORdYhKH
         YkFcM8TpUuQwt6hsamQhz5DuOUHd74woX/sCdc4OzwKeHi1BwamkrTwX4FC3mMx+K6I9
         GliEblk6tNZKXY+o7iNGHFMB3sd2XRWkiqmJ0SnmEyGAcqAvus0fi+m5oOCcpSOQ66N3
         dDkKgbCtk9CMy9Fjaw9c5bPyAztNXN3LxHZMZBCJh267HKxdXSUsjyFxJocebohzrZuV
         Xh2L7rAAuVYsLieEQNwEDnk/pHbhPGilXJtGs8lQwOV8Bav46NWW9TJnRpsWxVrpnF0t
         2xqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PrH45PB9RsMA7pyDP1csKVYDAqtxvNcn8nWcn6FbNjc=;
        b=EiKHvei5aAd4PhXThGlJZLcg3oR9jx4rl+7or2uE4dkNOLju7dI5JlGH0hINXoNXQP
         al+X9cxBMLDr2lSUUPHtcWB4zpyl/vM94XlP3aeoOPy2cEnUUasm4kAYwL4DmPM7X9a9
         ogl1KMC+u7u6D0EeMfsYS9B7VtXiJkkbQvaMGIIf7pxM4cAH6GOlWXWI/75UQrxHZUQ2
         EsLP24LinWjJelZOUVgmwu11pOF7E+SAeJEkXkdb+PLre7ELCEehv0bmghf2kTjz8EOh
         Ituf2s5IaTy7UGlmRJ5O234ncBMuuD7VumCRrVIbQghEtYAgZHMnq9u9R+J86lIE/RyF
         BpqQ==
X-Gm-Message-State: APjAAAXfNT65/t1EgFEsU8kT4S9QWzyBvHS1bSTnIIqEURNcrHcuLIjj
        4pS/4dXNHG4ylMBR1YUw4iY=
X-Google-Smtp-Source: APXvYqyzxmGpPw6yQPMJeAM+1VC/2whsZsEv9hdon9qas9R0gYs75IBP5NVy2m9R9E/19rHgJjBrwQ==
X-Received: by 2002:a63:2026:: with SMTP id g38mr5668729pgg.172.1565145975883;
        Tue, 06 Aug 2019 19:46:15 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id q1sm104267950pfg.84.2019.08.06.19.46.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 19:46:14 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH] libata-sff: use spin_lock_irqsave instead of spin_lock_irq in IRQ context.
Date:   Wed,  7 Aug 2019 10:45:55 +0800
Message-Id: <20190807024555.13770-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function ata_sff_flush_pio_task use spin_lock_irq/spin_unlock_irq
to protect shared data.
spin_unlock_irq will enable interrupts.

In the interrupt handler nv_swncq_interrupt (./drivers/ata/sata_nv.c),
when ap->link.sactive is true, nv_swncq_host_interrupt was called.
nv_swncq_hotplug is called when NV_SWNCQ_IRQ_HOTPLUG is set.
Then it will follow this chain:
nv_swncq_hotplug -> sata_scr_read (./dirvers/ata/libata-core.c)
 -> sata_pmp_scr_read (./drivers/ata/libata-pmp.c)
 -> sata_pmp_read -> ata_exec_internal 
 -> ata_exec_internal_sg -> ata_sff_flush_pio_task

Interrupts are enabled in interrupt handler.
Use spin_lock_irqsave instead of spin_lock_irq to avoid this.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/ata/libata-sff.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 10aa27882142..d3143e7e6ec0 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -1241,6 +1241,7 @@ EXPORT_SYMBOL_GPL(ata_sff_queue_pio_task);
 
 void ata_sff_flush_pio_task(struct ata_port *ap)
 {
+	unsigned long flags;
 	DPRINTK("ENTER\n");
 
 	cancel_delayed_work_sync(&ap->sff_pio_task);
@@ -1253,9 +1254,9 @@ void ata_sff_flush_pio_task(struct ata_port *ap)
 	 * __ata_sff_port_intr() checks for HSM_ST_IDLE and before it calls
 	 * ata_sff_hsm_move() causing ata_sff_hsm_move() to BUG().
 	 */
-	spin_lock_irq(ap->lock);
+	spin_lock_irqsave(ap->lock, flags);
 	ap->hsm_task_state = HSM_ST_IDLE;
-	spin_unlock_irq(ap->lock);
+	spin_unlock_irqrestore(ap->lock, flags);
 
 	ap->sff_pio_task_link = NULL;
 
-- 
2.11.0

