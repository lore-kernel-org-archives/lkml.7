Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08CC3C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF50820830
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554140615;
	bh=sEcKuufavJxOnZcjjVjDWN2lkLleBMaAr17XnbTnOtA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VwdEocsO2B1xS/IKbCjArV7ou4twWxxZWgd3zMRIjEt4e906GdyzXaYZteGFNqpLQ
	 7h9IsZBCFS3GKuetBc+ANYCGzAP8JzNZ+FLQjPKueXdfJCk5kHMINUg0k3GkEFVEBm
	 ukZky1i+rUc7O323581WI8igoBp/+aRqR9g2oOC0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387970AbfDARgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:36:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:47202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729666AbfDARf7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:35:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADE6520896;
        Mon,  1 Apr 2019 17:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554140159;
        bh=sEcKuufavJxOnZcjjVjDWN2lkLleBMaAr17XnbTnOtA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tLB8t6AixRyNf3Kp6io+fhzFDfKit0VuPozFxgNR0i+gEGcrAK024o4fFHCF4VuB9
         GqCHa3VyEB+WUe1rI3GGmKFZdw/hsMJuCL2dGsZBBnbZs0n/hITI2tnvbNrf8Dzvph
         c7H14D4cg32/ox+1rswlkzTPirKVpA2d4QHRPuMA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lianwei Wang <lianwei.wang@gmail.com>,
        peterz@infradead.org, linux-pm@vger.kernel.org, oleg@redhat.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 084/131] cpu/hotplug: Handle unbalanced hotplug enable/disable
Date:   Mon,  1 Apr 2019 19:02:34 +0200
Message-Id: <20190401170059.116218209@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170051.645954551@linuxfoundation.org>
References: <20190401170051.645954551@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 01b41159066531cc8d664362ff0cd89dd137bbfa ]

When cpu_hotplug_enable() is called unbalanced w/o a preceeding
cpu_hotplug_disable() the code emits a warning, but happily decrements the
disabled counter. This causes the next operations to malfunction.

Prevent the decrement and just emit a warning.

Signed-off-by: Lianwei Wang <lianwei.wang@gmail.com>
Cc: peterz@infradead.org
Cc: linux-pm@vger.kernel.org
Cc: oleg@redhat.com
Link: http://lkml.kernel.org/r/1465541008-12476-1-git-send-email-lianwei.wang@gmail.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/cpu.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 40d20bf5de28..42ce0b0ae5c5 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -183,10 +183,17 @@ void cpu_hotplug_disable(void)
 }
 EXPORT_SYMBOL_GPL(cpu_hotplug_disable);
 
+static void __cpu_hotplug_enable(void)
+{
+	if (WARN_ONCE(!cpu_hotplug_disabled, "Unbalanced cpu hotplug enable\n"))
+		return;
+	cpu_hotplug_disabled--;
+}
+
 void cpu_hotplug_enable(void)
 {
 	cpu_maps_update_begin();
-	WARN_ON(--cpu_hotplug_disabled < 0);
+	__cpu_hotplug_enable();
 	cpu_maps_update_done();
 }
 EXPORT_SYMBOL_GPL(cpu_hotplug_enable);
@@ -626,7 +633,7 @@ void enable_nonboot_cpus(void)
 
 	/* Allow everyone to use the CPU hotplug again */
 	cpu_maps_update_begin();
-	WARN_ON(--cpu_hotplug_disabled < 0);
+	__cpu_hotplug_enable();
 	if (cpumask_empty(frozen_cpus))
 		goto out;
 
-- 
2.19.1



