Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7FEC31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 07:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 724B62084A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 07:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="KbEOrQLu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731185AbfFSHcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 03:32:47 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34479 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731065AbfFSHcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 03:32:46 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5J7Vx7R247900
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 19 Jun 2019 00:31:59 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5J7Vx7R247900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560929520;
        bh=fTdj1HYoz+Ag8ogsG0vZVQ/JAHq194S4qWCi25pJ6z4=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=KbEOrQLuGBFqF4PG3lASHevC0/oDvaPNZB78UJ+F1DZOxRnhUnfIp1icDGbj+NHVk
         rivrti5HDUZo4i8b/WDdFQEtioPCJg168RFC1htcEL9vaXf7OExh+uiXMSVQevs08S
         HMGzF2JJjVxnlAqKEDwrMp22tk3zKFTUOaeltsezFq731uLWrOtoV1N7NvniUQwx3n
         bh9zUsgzVVajbP6OpMP9N7AJhc1+3d1+7l98Y4fY3BlPkAgmibNxO722R3tPv7/c2F
         fIJxAgtcT8B5A53L2lwEV5ycjim/c/2W2cmoZ3112FVH7UShuZoZFks8XuVMk5xLaH
         HNV3n04QkUpPQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5J7Vx0r247897;
        Wed, 19 Jun 2019 00:31:59 -0700
Date:   Wed, 19 Jun 2019 00:31:59 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-5423f5ce5ca410b3646f355279e4e937d452e622@git.kernel.org>
Cc:     tglx@linutronix.de, x86@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, mingo@kernel.org, hpa@zytor.com, bp@suse.de
Reply-To: mingo@kernel.org, hpa@zytor.com, bp@suse.de, tglx@linutronix.de,
          x86@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <alpine.DEB.2.21.1906182228350.1766@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1906182228350.1766@nanos.tec.linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/microcode: Fix the microcode load on CPU
 hotplug for real
Git-Commit-ID: 5423f5ce5ca410b3646f355279e4e937d452e622
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  5423f5ce5ca410b3646f355279e4e937d452e622
Gitweb:     https://git.kernel.org/tip/5423f5ce5ca410b3646f355279e4e937d452e622
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Tue, 18 Jun 2019 22:31:40 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Wed, 19 Jun 2019 09:16:35 +0200

x86/microcode: Fix the microcode load on CPU hotplug for real

A recent change moved the microcode loader hotplug callback into the early
startup phase which is running with interrupts disabled. It missed that
the callbacks invoke sysfs functions which might sleep causing nice 'might
sleep' splats with proper debugging enabled.

Split the callbacks and only load the microcode in the early startup phase
and move the sysfs handling back into the later threaded and preemptible
bringup phase where it was before.

Fixes: 78f4e932f776 ("x86/microcode, cpuhotplug: Add a microcode loader CPU hotplug callback")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: stable@vger.kernel.org
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/alpine.DEB.2.21.1906182228350.1766@nanos.tec.linutronix.de
---
 arch/x86/kernel/cpu/microcode/core.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index a813987b5552..cb0fdcaf1415 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -789,13 +789,16 @@ static struct syscore_ops mc_syscore_ops = {
 	.resume			= mc_bp_resume,
 };
 
-static int mc_cpu_online(unsigned int cpu)
+static int mc_cpu_starting(unsigned int cpu)
 {
-	struct device *dev;
-
-	dev = get_cpu_device(cpu);
 	microcode_update_cpu(cpu);
 	pr_debug("CPU%d added\n", cpu);
+	return 0;
+}
+
+static int mc_cpu_online(unsigned int cpu)
+{
+	struct device *dev = get_cpu_device(cpu);
 
 	if (sysfs_create_group(&dev->kobj, &mc_attr_group))
 		pr_err("Failed to create group for CPU%d\n", cpu);
@@ -872,7 +875,9 @@ int __init microcode_init(void)
 		goto out_ucode_group;
 
 	register_syscore_ops(&mc_syscore_ops);
-	cpuhp_setup_state_nocalls(CPUHP_AP_MICROCODE_LOADER, "x86/microcode:online",
+	cpuhp_setup_state_nocalls(CPUHP_AP_MICROCODE_LOADER, "x86/microcode:starting",
+				  mc_cpu_starting, NULL);
+	cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "x86/microcode:online",
 				  mc_cpu_online, mc_cpu_down_prep);
 
 	pr_info("Microcode Update Driver: v%s.", DRIVER_VERSION);
