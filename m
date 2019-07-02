Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9061BC5B57D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 697832183F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562054818;
	bh=UGiJQGJTx3wkmG+1excLzEVoivEDKBu/VMBZYlSklB8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OOszEZa7kRpJQnSED38npA+BaAVzgPX0X/pWg1nJXbJhr0xkICz3vef9Kj9Mi3AFp
	 4QIJLGxhihN6UjE8JEuFKk419nHttJs60/Ba30h//r1lH/Jq/W+UWzcBduwIcICGAg
	 mLxkAqYf6RdxQPvG3JznN4FOzcKFohFtUQosj+RM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbfGBIGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 04:06:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:53788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728157AbfGBIGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 04:06:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 720312183F;
        Tue,  2 Jul 2019 08:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562054809;
        bh=UGiJQGJTx3wkmG+1excLzEVoivEDKBu/VMBZYlSklB8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T/LLFqowIX0jxbGpmIoz0QFGxfvrYtMuGLl/pweN9xWkP5td0+3MAEXV79gDeMsji
         3t6WWgR7NBuDCP3z2nC2vgCyS8oo6lJttntPfGrsutJejG58OwLp//gwFxB0//3Fsa
         Szm2jOMPua3Ja2GMvKw/cVVyHXxIr5SbblOAgvCk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>, x86-ml <x86@kernel.org>
Subject: [PATCH 4.19 42/72] x86/microcode: Fix the microcode load on CPU hotplug for real
Date:   Tue,  2 Jul 2019 10:01:43 +0200
Message-Id: <20190702080126.819431850@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190702080124.564652899@linuxfoundation.org>
References: <20190702080124.564652899@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

commit 5423f5ce5ca410b3646f355279e4e937d452e622 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/cpu/microcode/core.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -790,13 +790,16 @@ static struct syscore_ops mc_syscore_ops
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
@@ -873,7 +876,9 @@ int __init microcode_init(void)
 		goto out_ucode_group;
 
 	register_syscore_ops(&mc_syscore_ops);
-	cpuhp_setup_state_nocalls(CPUHP_AP_MICROCODE_LOADER, "x86/microcode:online",
+	cpuhp_setup_state_nocalls(CPUHP_AP_MICROCODE_LOADER, "x86/microcode:starting",
+				  mc_cpu_starting, NULL);
+	cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "x86/microcode:online",
 				  mc_cpu_online, mc_cpu_down_prep);
 
 	pr_info("Microcode Update Driver: v%s.", DRIVER_VERSION);


