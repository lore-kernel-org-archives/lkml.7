Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB47C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 14:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA225222C8
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 14:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jZ+YeB95";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Cz3JEDjr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbfCXO5M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 10:57:12 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36488 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbfCXO5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 10:57:12 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 642D1606AC; Sun, 24 Mar 2019 14:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553439431;
        bh=M2kgVvCxxFln7pcAf/y6C2AajYo0qfzCTQF0TEAPzww=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jZ+YeB95XSLtx+Nn3e6J7+Qp/87qd1ueySm1NF6nUenXITv8ciXw1u0WHtVjVAWwM
         XyHIWDtlnUd4hbqydl5GbEJyTopXqxRWozWklhz/eHIR2WZaBlFB4snDEKc8Ick6bd
         WfYFeT7bQvi2EV2yo9UYyeIPGewpQYa1zn7D0XT8=
Received: from psodagud-linux1.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: psodagud@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6B50C6083E;
        Sun, 24 Mar 2019 14:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553439430;
        bh=M2kgVvCxxFln7pcAf/y6C2AajYo0qfzCTQF0TEAPzww=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cz3JEDjr964JJBt6zervgw0ipCPMf+q0GbUeexiPH+MrLeuRH6WyH+lC7lu8drnhu
         aHgwB6ZOSkIpGZET/dJNNuVNhg2pMaEs6+1M1DOzeLpuVYX74l7XqtPvXya3TDRGQj
         Z1BedAkR7uvLc/AHAdc1G9zgcz/Y5aFsDaKq6Sb0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6B50C6083E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=psodagud@codeaurora.org
From:   Prasad Sodagudi <psodagud@codeaurora.org>
To:     tglx@linutronix.de, marc.zyngier@arm.com
Cc:     linux-kernel@vger.kernel.org, psodagud@codeaurora.org
Subject: [PATCH v2] genirq: Prevent use-after-free and work list corruption
Date:   Sun, 24 Mar 2019 07:57:04 -0700
Message-Id: <1553439424-6529-1-git-send-email-psodagud@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <fd8a18f33a3f385575048969482fd22f@codeaurora.org>
References: <fd8a18f33a3f385575048969482fd22f@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When irq_set_affinity_notifier() replaces the notifier, then the
reference count on the old notifier is dropped which causes it to be
freed. But nothing ensures that the old notifier is not longer queued
in the work list. If it is queued this results in a use after free and
possibly in work list corruption.

Ensure that the work is canceled before the reference is dropped.

Signed-off-by: Prasad Sodagudi <psodagud@codeaurora.org>
---
 kernel/irq/manage.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 9ec34a2..1a1ac84 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -356,8 +356,10 @@ static void irq_affinity_notify(struct work_struct *work)
 	desc->affinity_notify = notify;
 	raw_spin_unlock_irqrestore(&desc->lock, flags);
 
-	if (old_notify)
+	if (old_notify) {
+		cancel_work_sync(&old_notify->work);
 		kref_put(&old_notify->kref, old_notify->release);
+	}
 
 	return 0;
 }
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project

