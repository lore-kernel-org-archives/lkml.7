Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A34C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 18:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E7DE2175B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 18:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h6yky17a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729083AbfCVSah (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 14:30:37 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:38060 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbfCVSah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 14:30:37 -0400
Received: by mail-vk1-f194.google.com with SMTP id h71so684097vkf.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 11:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=QHKLfg/vBhdXYRO4deWi+CYS6pkbDYiyKauNVBCvb4U=;
        b=h6yky17abN6hu/Ml+pfHNv0cEniO7kK55g7UrvUiKMfqE4AyQJOyWuGG9NUozW/bu9
         W4pOhJXuKOrzQM3VKZK50p1WMl8XOr5lOSHykUMXkvOGsmXUpTm77dP8/Cv4pfVHSzIz
         E/iO947QDWzRG1rt6zXzCR9J6YuAfYFhSiyxRq13+om+VkRy8ItdTxgzV/r+cQPD167f
         aSVw28zEdoVmsQM8Eo8LyDAWZ7pzOwqEQGbwuvK+dFjBsobjwpi0bu7KWOleLtQqR85K
         S4LL8cIEdmmRrqza5E+DNSDhmGxtN0EdtACjs6Mzc9FDYgYsM0UYAjDdyDVMSf5CGNSo
         SloQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QHKLfg/vBhdXYRO4deWi+CYS6pkbDYiyKauNVBCvb4U=;
        b=Ka7Yr+48WBGiieV8/F+owQmrePibLHEFGX63zKNp9KunBGmPS1PGj/0O2q7xkR1hZx
         fT8LoFv1Km1NzZNzMJLSm/Cr/P0HWMt+5xsmrLGot7j3qdz3Cp0jRM8gEN7qQY+9q35T
         mCFjcXySDk2l+IY2lZOnQTYFcXy8GQ4nRrP/0/oUtq9xxJqGXc6StnSqm+jCtQWMP885
         2vm4OwTXCiIrqc+ObKIZCS9haAFWPV3FaBDRytJHEtq0aPhzzsDHZuCXup2eX3mpzgrw
         QOl3I32llGNh98NTOw/jkyDo1F1bzlIuPsr3tGzguDyJXrHQW2VbuiPfQ5JhFFkN1Qe+
         k2kQ==
X-Gm-Message-State: APjAAAWqy1UcGOxsjCTuJ+RFuaGD1VavxwZl8nTvmnQI4lQLJWM08S3v
        R2aF39+0XAbhzpuvxELe5Hs=
X-Google-Smtp-Source: APXvYqzgey0cMVktXG7uQUh/M3P9IIJLfhBfDGMCim8jsFsVMUSWX1UjqJJOxGv6y0Y9o1NXg3J2ww==
X-Received: by 2002:a1f:2acb:: with SMTP id q194mr6691777vkq.92.1553279436098;
        Fri, 22 Mar 2019 11:30:36 -0700 (PDT)
Received: from centos-dev.localdomain (pool-173-66-89-81.washdc.fios.verizon.net. [173.66.89.81])
        by smtp.gmail.com with ESMTPSA id r185sm2768649vsr.29.2019.03.22.11.30.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 11:30:35 -0700 (PDT)
From:   thibodux@gmail.com
X-Google-Original-From: ryan.thibodeaux@starlab.io
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     boris.ostrovsky@oracle.com, oleksandr_andrushchenko@epam.com,
        tglx@linutronix.de, jgross@suse.com, thibodux@gmail.com,
        ryan.thibodeaux@starlab.io
Subject: [PATCH] x86/xen: Add "xen_timer_slop" command line option
Date:   Fri, 22 Mar 2019 14:29:57 -0400
Message-Id: <1553279397-130201-1-git-send-email-ryan.thibodeaux@starlab.io>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ryan Thibodeaux <ryan.thibodeaux@starlab.io>

Add a new command-line option "xen_timer_slop=<INT>" that sets the
minimum delta of virtual Xen timers. This commit does not change the
default timer slop value for virtual Xen timers.

Lowering the timer slop value should improve the accuracy of virtual
timers (e.g., better process dispatch latency), but it will likely
increase the number of virtual timer interrupts (relative to the
original slop setting).

The original timer slop value has not changed since the introduction
of the Xen-aware Linux kernel code. This commit provides users an
opportunity to tune timer performance given the refinements to
hardware and the Xen event channel processing. It also mirrors
a feature in the Xen hypervisor - the "timer_slop" Xen command line
option.

Signed-off-by: Ryan Thibodeaux <ryan.thibodeaux@starlab.io>
---
 Documentation/admin-guide/kernel-parameters.txt |  7 +++++++
 arch/x86/xen/time.c                             | 18 ++++++++++++++++--
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 858b6c0..fb58c84 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5129,6 +5129,13 @@
 			with /sys/devices/system/xen_memory/xen_memory0/scrub_pages.
 			Default value controlled with CONFIG_XEN_SCRUB_PAGES_DEFAULT.
 
+	xen_timer_slop=	[X86-64,XEN]
+			Set the timer slop (in nanoseconds) for the virtual Xen
+			timers (default is 100000). This adjusts the minimum
+			delta of virtualized Xen timers, where lower values
+			improve timer resolution at the expense of processing
+			more timer interrupts.
+
 	xirc2ps_cs=	[NET,PCMCIA]
 			Format:
 			<irq>,<irq_mask>,<io>,<full_duplex>,<do_sound>,<lockup_hack>[,<irq2>[,<irq3>[,<irq4>]]]
diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
index 6e29794..0393968 100644
--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -212,7 +212,7 @@ static int xen_timerop_set_next_event(unsigned long delta,
 	return 0;
 }
 
-static const struct clock_event_device xen_timerop_clockevent = {
+static struct clock_event_device xen_timerop_clockevent __ro_after_init = {
 	.name			= "xen",
 	.features		= CLOCK_EVT_FEAT_ONESHOT,
 
@@ -273,7 +273,7 @@ static int xen_vcpuop_set_next_event(unsigned long delta,
 	return ret;
 }
 
-static const struct clock_event_device xen_vcpuop_clockevent = {
+static struct clock_event_device xen_vcpuop_clockevent __ro_after_init = {
 	.name = "xen",
 	.features = CLOCK_EVT_FEAT_ONESHOT,
 
@@ -570,3 +570,17 @@ void __init xen_hvm_init_time_ops(void)
 	x86_platform.set_wallclock = xen_set_wallclock;
 }
 #endif
+
+/* Kernel parameter to specify Xen timer slop */
+static int __init parse_xen_timer_slop(char *ptr)
+{
+	unsigned long slop = memparse(ptr, NULL);
+
+	xen_timerop_clockevent.min_delta_ns = slop;
+	xen_timerop_clockevent.min_delta_ticks = slop;
+	xen_vcpuop_clockevent.min_delta_ns = slop;
+	xen_vcpuop_clockevent.min_delta_ticks = slop;
+
+	return 0;
+}
+early_param("xen_timer_slop", parse_xen_timer_slop);
-- 
1.8.3.1

