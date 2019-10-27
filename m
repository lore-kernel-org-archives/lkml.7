Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16573CA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA738208C0
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572210720;
	bh=+ZsH7oQpipIz+45yrR434x2lkezrifEcknHQJqomgC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VSId2PRrjWimiBpg65EbpXZsybC0SUJsPM8vRpUSVIuXHaO5P1qP4UiJKRQmp2yTh
	 Uq9RNOWSccScTfy8/6qctZuBZdHzJwtu2PhcvWRnApLi+0NBhSDQLwl3NjnojCv0OU
	 sISGMYJSKKlU7UXrRXYXFj/sU093jyQxCrxNCuVg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729987AbfJ0VL7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 17:11:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:58550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729981AbfJ0VL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 17:11:56 -0400
Received: from localhost (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78F54205C9;
        Sun, 27 Oct 2019 21:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572210715;
        bh=+ZsH7oQpipIz+45yrR434x2lkezrifEcknHQJqomgC0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wXUA1rnzfJ5TH7RMF/V5IUvASrqpY50NcWfSuXlL19/ioJms0+luznUPAISeK5izy
         eatT4BEtSZffOum5tyg3OUqbOra/oGinuVMqzDArtrrx8fwBrgtSpSQrUOPe1j54wP
         CC/+gSSma+WbcHcmfbzROLiFMllwSf1dxGWgUBa0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 4.14 112/119] cpufreq: Avoid cpufreq_suspend() deadlock on system shutdown
Date:   Sun, 27 Oct 2019 22:01:29 +0100
Message-Id: <20191027203349.647955851@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191027203259.948006506@linuxfoundation.org>
References: <20191027203259.948006506@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

commit 65650b35133ff20f0c9ef0abd5c3c66dbce3ae57 upstream.

It is incorrect to set the cpufreq syscore shutdown callback pointer
to cpufreq_suspend(), because that function cannot be run in the
syscore stage of system shutdown for two reasons: (a) it may attempt
to carry out actions depending on devices that have already been shut
down at that point and (b) the RCU synchronization carried out by it
may not be able to make progress then.

The latter issue has been present since commit 45975c7d21a1 ("rcu:
Define RCU-sched API in terms of RCU for Tree RCU PREEMPT builds"),
but the former one has been there since commit 90de2a4aa9f3 ("cpufreq:
suspend cpufreq governors on shutdown") regardless.

Fix that by dropping cpufreq_syscore_ops altogether and making
device_shutdown() call cpufreq_suspend() directly before shutting
down devices, which is along the lines of what system-wide power
management does.

Fixes: 45975c7d21a1 ("rcu: Define RCU-sched API in terms of RCU for Tree RCU PREEMPT builds")
Fixes: 90de2a4aa9f3 ("cpufreq: suspend cpufreq governors on shutdown")
Reported-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Tested-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Cc: 4.0+ <stable@vger.kernel.org> # 4.0+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/base/core.c       |    3 +++
 drivers/cpufreq/cpufreq.c |   10 ----------
 2 files changed, 3 insertions(+), 10 deletions(-)

--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -10,6 +10,7 @@
  *
  */
 
+#include <linux/cpufreq.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/fwnode.h>
@@ -2845,6 +2846,8 @@ void device_shutdown(void)
 	wait_for_device_probe();
 	device_block_probing();
 
+	cpufreq_suspend();
+
 	spin_lock(&devices_kset->list_lock);
 	/*
 	 * Walk the devices list backward, shutting down each in turn.
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2570,14 +2570,6 @@ int cpufreq_unregister_driver(struct cpu
 }
 EXPORT_SYMBOL_GPL(cpufreq_unregister_driver);
 
-/*
- * Stop cpufreq at shutdown to make sure it isn't holding any locks
- * or mutexes when secondary CPUs are halted.
- */
-static struct syscore_ops cpufreq_syscore_ops = {
-	.shutdown = cpufreq_suspend,
-};
-
 struct kobject *cpufreq_global_kobject;
 EXPORT_SYMBOL(cpufreq_global_kobject);
 
@@ -2589,8 +2581,6 @@ static int __init cpufreq_core_init(void
 	cpufreq_global_kobject = kobject_create_and_add("cpufreq", &cpu_subsys.dev_root->kobj);
 	BUG_ON(!cpufreq_global_kobject);
 
-	register_syscore_ops(&cpufreq_syscore_ops);
-
 	return 0;
 }
 module_param(off, int, 0444);


