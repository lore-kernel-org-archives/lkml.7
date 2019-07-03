Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F2A7C5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 08:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C6A6218A3
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 08:16:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="gySw0h5U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbfGCIQ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 04:16:26 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33557 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbfGCIQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 04:16:26 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x638GCka3200308
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 3 Jul 2019 01:16:12 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x638GCka3200308
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562141772;
        bh=JvwUorxRtVl80sJ4aj46GHhHXIeGEW99nltdKviE6Jk=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=gySw0h5UFFbfS51k0NMHodbiCVSRMdiQFWsKaENJ/RV8VxWJO1lE/e0ITIWfs/Ew4
         4hVZ/GQIdNFW9SdH6GNI4GMKPCNQ5ljwCDIuMpNG9rY4MPTs7II7Ch0w3ttro0qo+E
         3EAn6urfPGz8aNuxhit5sd+sjDJKtDmoUTcqcBBXDhf8Iy4pPXouIoO5RFb9DucQYj
         1oYvCHx0suwjVfBte3Yn0He9SCxbq1D/im0aiNacgZX2ADFG64AtMVf5f7a0/G/XYU
         JQpIw/xIeo//Ch/ZZ0NdNZT8IrqlTTmdP44KclVesa2CBo/RjEEjv7795DJDAT1thn
         jBFb8afD04x4A==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x638GBwU3200305;
        Wed, 3 Jul 2019 01:16:11 -0700
Date:   Wed, 3 Jul 2019 01:16:11 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-4001d8e8762f57d418b66e4e668601791900a1dd@git.kernel.org>
Cc:     hpa@zytor.com, mingo@kernel.org, marc.zyngier@arm.com,
        linux-kernel@vger.kernel.org, Robert.Hodaszi@digi.com,
        tglx@linutronix.de
Reply-To: tglx@linutronix.de, Robert.Hodaszi@digi.com,
          linux-kernel@vger.kernel.org, marc.zyngier@arm.com,
          mingo@kernel.org, hpa@zytor.com
In-Reply-To: <20190628111440.098196390@linutronix.de>
References: <20190628111440.098196390@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/apic] genirq: Delay deactivation in free_irq()
Git-Commit-ID: 4001d8e8762f57d418b66e4e668601791900a1dd
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

Commit-ID:  4001d8e8762f57d418b66e4e668601791900a1dd
Gitweb:     https://git.kernel.org/tip/4001d8e8762f57d418b66e4e668601791900a1dd
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Fri, 28 Jun 2019 13:11:49 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 3 Jul 2019 10:12:28 +0200

genirq: Delay deactivation in free_irq()

When interrupts are shutdown, they are immediately deactivated in the
irqdomain hierarchy. While this looks obviously correct there is a subtle
issue:

There might be an interrupt in flight when free_irq() is invoking the
shutdown. This is properly handled at the irq descriptor / primary handler
level, but the deactivation might completely disable resources which are
required to acknowledge the interrupt.

Split the shutdown code and deactivate the interrupt after synchronization
in free_irq(). Fixup all other usage sites where this is not an issue to
invoke the combined shutdown_and_deactivate() function instead.

This still might be an issue if the interrupt in flight servicing is
delayed on a remote CPU beyond the invocation of synchronize_irq(), but
that cannot be handled at that level and needs to be handled in the
synchronize_irq() context.

Fixes: f8264e34965a ("irqdomain: Introduce new interfaces to support hierarchy irqdomains")
Reported-by: Robert Hodaszi <Robert.Hodaszi@digi.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
Link: https://lkml.kernel.org/r/20190628111440.098196390@linutronix.de

---
 kernel/irq/autoprobe.c  |  6 +++---
 kernel/irq/chip.c       |  6 ++++++
 kernel/irq/cpuhotplug.c |  2 +-
 kernel/irq/internals.h  |  1 +
 kernel/irq/manage.c     | 12 +++++++++++-
 5 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/kernel/irq/autoprobe.c b/kernel/irq/autoprobe.c
index 16cbf6beb276..ae60cae24e9a 100644
--- a/kernel/irq/autoprobe.c
+++ b/kernel/irq/autoprobe.c
@@ -90,7 +90,7 @@ unsigned long probe_irq_on(void)
 			/* It triggered already - consider it spurious. */
 			if (!(desc->istate & IRQS_WAITING)) {
 				desc->istate &= ~IRQS_AUTODETECT;
-				irq_shutdown(desc);
+				irq_shutdown_and_deactivate(desc);
 			} else
 				if (i < 32)
 					mask |= 1 << i;
@@ -127,7 +127,7 @@ unsigned int probe_irq_mask(unsigned long val)
 				mask |= 1 << i;
 
 			desc->istate &= ~IRQS_AUTODETECT;
-			irq_shutdown(desc);
+			irq_shutdown_and_deactivate(desc);
 		}
 		raw_spin_unlock_irq(&desc->lock);
 	}
@@ -169,7 +169,7 @@ int probe_irq_off(unsigned long val)
 				nr_of_irqs++;
 			}
 			desc->istate &= ~IRQS_AUTODETECT;
-			irq_shutdown(desc);
+			irq_shutdown_and_deactivate(desc);
 		}
 		raw_spin_unlock_irq(&desc->lock);
 	}
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 51128bea3846..04fe4f989bd8 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -314,6 +314,12 @@ void irq_shutdown(struct irq_desc *desc)
 		}
 		irq_state_clr_started(desc);
 	}
+}
+
+
+void irq_shutdown_and_deactivate(struct irq_desc *desc)
+{
+	irq_shutdown(desc);
 	/*
 	 * This must be called even if the interrupt was never started up,
 	 * because the activation can happen before the interrupt is
diff --git a/kernel/irq/cpuhotplug.c b/kernel/irq/cpuhotplug.c
index 5b1072e394b2..6c7ca2e983a5 100644
--- a/kernel/irq/cpuhotplug.c
+++ b/kernel/irq/cpuhotplug.c
@@ -116,7 +116,7 @@ static bool migrate_one_irq(struct irq_desc *desc)
 		 */
 		if (irqd_affinity_is_managed(d)) {
 			irqd_set_managed_shutdown(d);
-			irq_shutdown(desc);
+			irq_shutdown_and_deactivate(desc);
 			return false;
 		}
 		affinity = cpu_online_mask;
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index 70c3053bc1f6..9c957f8b1198 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -82,6 +82,7 @@ extern int irq_activate_and_startup(struct irq_desc *desc, bool resend);
 extern int irq_startup(struct irq_desc *desc, bool resend, bool force);
 
 extern void irq_shutdown(struct irq_desc *desc);
+extern void irq_shutdown_and_deactivate(struct irq_desc *desc);
 extern void irq_enable(struct irq_desc *desc);
 extern void irq_disable(struct irq_desc *desc);
 extern void irq_percpu_enable(struct irq_desc *desc, unsigned int cpu);
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 53a081392115..dc8b35f2d545 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/random.h>
 #include <linux/interrupt.h>
+#include <linux/irqdomain.h>
 #include <linux/slab.h>
 #include <linux/sched.h>
 #include <linux/sched/rt.h>
@@ -1699,6 +1700,7 @@ static struct irqaction *__free_irq(struct irq_desc *desc, void *dev_id)
 	/* If this was the last handler, shut down the IRQ line: */
 	if (!desc->action) {
 		irq_settings_clr_disable_unlazy(desc);
+		/* Only shutdown. Deactivate after synchronize_hardirq() */
 		irq_shutdown(desc);
 	}
 
@@ -1768,6 +1770,14 @@ static struct irqaction *__free_irq(struct irq_desc *desc, void *dev_id)
 		 * require it to deallocate resources over the slow bus.
 		 */
 		chip_bus_lock(desc);
+		/*
+		 * There is no interrupt on the fly anymore. Deactivate it
+		 * completely.
+		 */
+		raw_spin_lock_irqsave(&desc->lock, flags);
+		irq_domain_deactivate_irq(&desc->irq_data);
+		raw_spin_unlock_irqrestore(&desc->lock, flags);
+
 		irq_release_resources(desc);
 		chip_bus_sync_unlock(desc);
 		irq_remove_timings(desc);
@@ -1855,7 +1865,7 @@ static const void *__cleanup_nmi(unsigned int irq, struct irq_desc *desc)
 	}
 
 	irq_settings_clr_disable_unlazy(desc);
-	irq_shutdown(desc);
+	irq_shutdown_and_deactivate(desc);
 
 	irq_release_resources(desc);
 
