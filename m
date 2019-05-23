Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 244A3C282DE
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 11:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E603620856
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 11:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nikanor-nu.20150623.gappssmtp.com header.i=@nikanor-nu.20150623.gappssmtp.com header.b="tWULEpUp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730566AbfEWLgi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 07:36:38 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45722 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729698AbfEWLgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 07:36:33 -0400
Received: by mail-lj1-f196.google.com with SMTP id r76so5097462lja.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 04:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nikanor-nu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WaaInSZ/8FR2reHnDUn1kcD6WX/fXP/+clwh+fO1tAQ=;
        b=tWULEpUp22syghVEsmuUX65V+hWfLLf7PzNEOlkKZvDchIwKdsF9Vze+MNx08c05a6
         kGQjn8tnlKpiJb5r6nece4El4Sq4fzGjuqx8Phyfoet9heTj0qLCPYKTVZGnJlCWcib3
         JY9Lrly4Jm/MFRZahknWKMYzkSfEqcK5O2xrKw52qFZ8B3c33uj4Aeo6ModPtqxOEkP6
         D+/fHOlf/8nGsknQdLAmjBrasu8LP7B77lefqxHZksKPsgVQOSLEoURXh/ji8zOB8NAk
         uyg+Fx0z840PAqFqD4yUY5PMU9ykUFbbKXI6bAXHhCIoCliurJB9slyxkdObH6kzRMvI
         AS+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WaaInSZ/8FR2reHnDUn1kcD6WX/fXP/+clwh+fO1tAQ=;
        b=R5QsBhUTfwjB5oj6kdqkT6+BB5XppU6j5yIpTLKbp3zt2c35GbpzaUvdoO4AKnNAFJ
         UoWolAlGkWLZXwF5ASQv69ufRYCq50oZY1IO6E4KfaQciMWAF7nM0YA9Glq3G71hwmdv
         3DfnAVODNJCQjQef8ZkTjN3x2TTszsPJPphMmeCJkomA6l4S/W4H4gjn5p6diIvyuk89
         NjlpA1lqmXgw9n5Bzt1+73zoGifBp0kkm+UbGj0Lxj4tUinUoOVFcjzi9ux4RfC7SEIo
         C9gvuzQbtlxfGRq1YNtEO4cEGKcCNAGowyrcrljooI5HL1XBZrW3PhKqZkMmUadLEbxN
         5Q1A==
X-Gm-Message-State: APjAAAVywdEB8JEVP7Iy+lFOvu01nkYCOSmGAOL7r0vWrkut8tZOErQT
        1mfsqqu65eUcejP0+WuVJU7WYg==
X-Google-Smtp-Source: APXvYqwSdZHuTrXPNifNP0NqQUhzXvx0/MG209uslKt+iBQvs3Ie5wmetoDNk750YGBnpdfCf8jvVQ==
X-Received: by 2002:a2e:1284:: with SMTP id 4mr18439439ljs.138.1558611391276;
        Thu, 23 May 2019 04:36:31 -0700 (PDT)
Received: from dev.nikanor.nu (78-72-133-4-no161.tbcn.telia.com. [78.72.133.4])
        by smtp.gmail.com with ESMTPSA id d68sm5269287lfg.23.2019.05.23.04.36.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 04:36:30 -0700 (PDT)
From:   =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
To:     gregkh@linuxfoundation.org
Cc:     simon@nikanor.nu, jeremy@azazel.net, dan.carpenter@oracle.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] staging: kpc2000: add blank line after declarations
Date:   Thu, 23 May 2019 13:36:06 +0200
Message-Id: <20190523113613.28342-2-simon@nikanor.nu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523113613.28342-1-simon@nikanor.nu>
References: <20190523113613.28342-1-simon@nikanor.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes checkpatch.pl warning "Missing a blank line after declarations".

Signed-off-by: Simon Sandström <simon@nikanor.nu>
---
 drivers/staging/kpc2000/kpc2000/cell_probe.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/staging/kpc2000/kpc2000/cell_probe.c b/drivers/staging/kpc2000/kpc2000/cell_probe.c
index e5cddf0eeed3..95bfbe4aae4d 100644
--- a/drivers/staging/kpc2000/kpc2000/cell_probe.c
+++ b/drivers/staging/kpc2000/kpc2000/cell_probe.c
@@ -245,6 +245,7 @@ int  kp2000_check_uio_irq(struct kp2000_device *pcard, u32 irq_num)
 	u64 interrupt_active   =  readq(pcard->sysinfo_regs_base + REG_INTERRUPT_ACTIVE);
 	u64 interrupt_mask_inv = ~readq(pcard->sysinfo_regs_base + REG_INTERRUPT_MASK);
 	u64 irq_check_mask = (1 << irq_num);
+
 	if (interrupt_active & irq_check_mask) { // if it's active (interrupt pending)
 		if (interrupt_mask_inv & irq_check_mask) {    // and if it's not masked off
 			return 1;
@@ -257,6 +258,7 @@ static
 irqreturn_t  kuio_handler(int irq, struct uio_info *uioinfo)
 {
 	struct kpc_uio_device *kudev = uioinfo->priv;
+
 	if (irq != kudev->pcard->pdev->irq)
 		return IRQ_NONE;
 
@@ -506,8 +508,10 @@ void  kp2000_remove_cores(struct kp2000_device *pcard)
 {
 	struct list_head *ptr;
 	struct list_head *next;
+
 	list_for_each_safe(ptr, next, &pcard->uio_devices_list) {
 		struct kpc_uio_device *kudev = list_entry(ptr, struct kpc_uio_device, list);
+
 		uio_unregister_device(&kudev->uioinfo);
 		device_unregister(kudev->dev);
 		list_del(&kudev->list);
-- 
2.20.1

