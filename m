Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D491C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 525F72083B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:29:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfF1M3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 08:29:04 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33199 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbfF1M3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 08:29:04 -0400
Received: by mail-wr1-f67.google.com with SMTP id n9so6140989wru.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 05:29:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aG/OfFQqUs+39UCm0pAGeKeTGmu26+WZWtFUm3Tny98=;
        b=QavqLRiMffrc+JxePleJYOmtM0q5At4sLJ+FmrHuGv4mfagdpzMBw0I0XSHX3IlBxR
         qiqp6ynZ/nV9svxlFgNbmpYukpVtQdTrD+frIBEcClFghfhfrr8a6J5oKs6mA/+TM2nQ
         DIBEOph2O1v4MpIeWVIVRGvKJeuVYnl+qcxRy40zmh1E7GnEq6gjwGxfS1LHbZJh7s4I
         vSRh9eivcNNSRPUiwSL1UYou6x14NX+0V9XGg4DHAVzuu9ZKaVEyWgjm//K53ObgEUQO
         xD0iF6WLG3s737arsc0kIX03STEJARYpP7RiRG8y06W0CQ4W6clK7FlbAqL3GI4BNKBh
         r3sg==
X-Gm-Message-State: APjAAAVDRKKkijrJ7NgaON5bxE9zUwVPRuNb6h6XW+R/QoRz5B7Bxjpd
        THnhbgqpY8t1Z/4sr0NeFiu8jJEtbOtRtg==
X-Google-Smtp-Source: APXvYqwYNe0Yo5cDbRJ3pYz7dPo/PjBpERriYEki/0ce1JPSpBxRwrUrfr0hunfz/YfcG8Ttg9LdAA==
X-Received: by 2002:a05:6000:112:: with SMTP id o18mr8247045wrx.153.1561724941516;
        Fri, 28 Jun 2019 05:29:01 -0700 (PDT)
Received: from dhcp-1-158.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.googlemail.com with ESMTPSA id t1sm3241473wra.74.2019.06.28.05.29.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 28 Jun 2019 05:29:01 -0700 (PDT)
From:   Grzegorz Halat <ghalat@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Don Zickus <dzickus@redhat.com>,
        Oleksandr Natalenko <oleksandr@redhat.com>,
        Grzegorz Halat <ghalat@redhat.com>
Subject: [PATCH RFC] x86/reboot: Don't wait infinitely for IPI completion during reboot
Date:   Fri, 28 Jun 2019 14:28:13 +0200
Message-Id: <20190628122813.15500-1-ghalat@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
This patch is trying to address a deadlock that may happen during a
reboot.

CPU0 can stop a CPU which is holding a lock and there may be another CPU
with disabled interrupts waiting for the same lock. In this situation,
the CPU waiting for the lock can't be stopped and CPU0 will be
indefinitely waiting for IPI completion.

To avoid indefinitely looping kernel should send NMI after timeout.
It seems to me that this was the original intention of
commit 7d007d21e539 ("x86/reboot: Use NMI to assist in shutting down if
IRQ fails") but the removal of 'wait' in the first loop has been
forgotten.

I'm sending the patch as RFC, maybe there is a better way to handle this
situation. Another thing which wonders me is pr_emerg() after IPI.
Is this safe? I think that IPI can shut down a CPU that is holding a
lock used by pr_emerg(), so there may be a deadlock.

CPU0 is stuck in native_stop_other_cpus() waiting for shutdown of CPU2:

 #6 [ffffb1a7826b7dd0] delay_tsc at ffffffffb640f0b4
 #7 [ffffb1a7826b7dd0] native_stop_other_cpus at ffffffffb5c47ffa 
 #8 [ffffb1a7826b7df0] native_machine_shutdown at ffffffffb5c47132
 #9 [ffffb1a7826b7df8] native_machine_restart at ffffffffb5c47649
#10 [ffffb1a7826b7e00] __do_sys_reboot at ffffffffb5ccff62
#11 [ffffb1a7826b7f38] do_syscall_64 at ffffffffb5c0424b

The loop, in case of reboot() syscall wait==1:
File: linux/arch/x86/kernel/smp.c
218: 		timeout = USEC_PER_SEC;
219: 		while (num_online_cpus() > 1 && (wait || timeout--))
220: 			udelay(1);

CPU1 has been shutdown while holding tasklist_lock:

 #0 [ffff984418083fb8] stop_this_cpu at ffffffffb5c28495  << CPU stopped
 #1 [ffff984418083fc0] smp_reboot_interrupt at ffffffffb5c48169
 #2 [ffff984418083ff0] reboot_interrupt at ffffffffb6600bbf
--- <IRQ stack> ---
 #3 [ffffb1a782417be8] reboot_interrupt at ffffffffb6600bbf
    [exception RIP: delay_tsc+32]
 #4 [ffffb1a782417c98] probe_12098 at ffffffffc0813fab 
 #5 [ffffb1a782417cb0] do_wait at ffffffffb5cae5b4
 #6 [ffffb1a782417d08] optimized_callback at ffffffffb5c56be3
 #7 [ffffb1a782417d98] do_wait at ffffffffb5cae5b3 << read_lock() here
 #8 [ffffb1a782417df0] kernel_wait4 at ffffffffb5cafa4e
 #9 [ffffb1a782417e78] __do_sys_wait4 at ffffffffb5cafb73
#10 [ffffb1a782417f38] do_syscall_64 at ffffffffb5c0424b

Note: probe_12098 is SystemTap probe which injects delay.
I'm using SystemTap to reliably reproduce the issue 

CPU2 is trying to grab tasklist_lock with disabled interrupts:

RFLAGS: 00000006
 #5 [ffffb1a782397e78] queued_write_lock_slowpath at ffffffffb5d0052e
 #6 [ffffb1a782397e88] do_exit at ffffffffb5caf08e
 #7 [ffffb1a782397f08] do_group_exit at ffffffffb5caf8da
 #8 [ffffb1a782397f30] __x64_sys_exit_group at ffffffffb5caf954
 #9 [ffffb1a782397f38] do_syscall_64 at ffffffffb5c0424b

Signed-off-by: Grzegorz Halat <ghalat@redhat.com>
---
 arch/x86/kernel/smp.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/smp.c b/arch/x86/kernel/smp.c
index 4693e2f3a03e..9186e432b8d6 100644
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -211,30 +211,23 @@ static void native_stop_other_cpus(int wait)
 
 		apic->send_IPI_allbutself(REBOOT_VECTOR);
 
-		/*
-		 * Don't wait longer than a second if the caller
-		 * didn't ask us to wait.
-		 */
+		/* Don't wait longer than a second for IPI completion */
 		timeout = USEC_PER_SEC;
-		while (num_online_cpus() > 1 && (wait || timeout--))
+		while (num_online_cpus() > 1 && timeout--)
 			udelay(1);
 	}
 	
 	/* if the REBOOT_VECTOR didn't work, try with the NMI */
-	if ((num_online_cpus() > 1) && (!smp_no_nmi_ipi))  {
-		if (register_nmi_handler(NMI_LOCAL, smp_stop_nmi_callback,
-					 NMI_FLAG_FIRST, "smp_stop"))
-			/* Note: we ignore failures here */
-			/* Hope the REBOOT_IRQ is good enough */
-			goto finish;
-
-		/* sync above data before sending IRQ */
-		wmb();
-
-		pr_emerg("Shutting down cpus with NMI\n");
+	if (num_online_cpus() > 1) {
+		if (!smp_no_nmi_ipi && !register_nmi_handler(NMI_LOCAL,
+			smp_stop_nmi_callback, NMI_FLAG_FIRST, "smp_stop")){
+			/* sync above data before sending IRQ */
+			wmb();
 
-		apic->send_IPI_allbutself(NMI_VECTOR);
+			pr_emerg("Shutting down cpus with NMI\n");
 
+			apic->send_IPI_allbutself(NMI_VECTOR);
+		}
 		/*
 		 * Don't wait longer than a 10 ms if the caller
 		 * didn't ask us to wait.
@@ -244,7 +237,6 @@ static void native_stop_other_cpus(int wait)
 			udelay(1);
 	}
 
-finish:
 	local_irq_save(flags);
 	disable_local_APIC();
 	mcheck_cpu_clear(this_cpu_ptr(&cpu_info));
-- 
2.18.1

