Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CFDBC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 22:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E187218AE
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 22:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GnQuZWVe";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RhIHNaSN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbfCTWAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 18:00:23 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60318 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727510AbfCTWAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 18:00:23 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 07CBA602A7; Wed, 20 Mar 2019 22:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553119222;
        bh=iGZ2ZcEvvos2NuXB+HS+6tPJr07c+N8IB05qgnVAIuI=;
        h=From:To:Cc:Subject:Date:From;
        b=GnQuZWVeFas8A/rXY10cHWcRJqPZGtTg57i2LkY9s9Tib9taQIlMP+Wiprs3KMpQc
         TPJ3LeNlUrueJqSxUX/BkyPmQvYnQZhcha1JPEVlCbx75PL5ejL180P5uiariqXWYA
         Ch/NzIblxR0d/cNTTfgufcpURzs1AFN2QZpB5DCc=
Received: from psodagud-linux1.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: psodagud@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3EB7F602A7;
        Wed, 20 Mar 2019 22:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553119221;
        bh=iGZ2ZcEvvos2NuXB+HS+6tPJr07c+N8IB05qgnVAIuI=;
        h=From:To:Cc:Subject:Date:From;
        b=RhIHNaSNNqBdEk7/7vITdcFvcrO6lKbI174SXqToxmis0iygFJ9ZdnFNmIsR3UvDa
         Agzj6d5cwtZcYZ1TEblRgd8nVbBr9J1gaAUMCOKQYR6xL5REQy6EcmOkT9qPeLyGPO
         7J5w1lj2R72e0noaFolnVm8m5b0i/pNPPbO66Yng=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3EB7F602A7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=psodagud@codeaurora.org
From:   Prasad Sodagudi <psodagud@codeaurora.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, psodagud@codeaurora.org
Subject: [PATCH] genirq: call cancel_work_sync from irq_set_affinity_notifier
Date:   Wed, 20 Mar 2019 15:00:11 -0700
Message-Id: <1553119211-29761-1-git-send-email-psodagud@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When ever notification of IRQ affinity changes, call
cancel_work_sync from irq_set_affinity_notifier to cancel
all pending works to avoid work list corruption.

Signed-off-by: Prasad Sodagudi <psodagud@codeaurora.org>
---
 kernel/irq/manage.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 9ec34a2..da8b2ee 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -356,6 +356,9 @@ static void irq_affinity_notify(struct work_struct *work)
 	desc->affinity_notify = notify;
 	raw_spin_unlock_irqrestore(&desc->lock, flags);
 
+	if (!notify && old_notify)
+		cancel_work_sync(&old_notify->work);
+
 	if (old_notify)
 		kref_put(&old_notify->kref, old_notify->release);
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project

