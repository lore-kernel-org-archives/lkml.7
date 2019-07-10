Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9CA2C73C7C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 08:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBE2C20838
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 08:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8yKh+6C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbfGJIhZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 04:37:25 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42938 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfGJIhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 04:37:25 -0400
Received: by mail-pg1-f194.google.com with SMTP id t132so881812pgb.9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 01:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=uULVVNf+00uTXLBlTk+5ZpHg9JZ7/DLSlO8BujKHgOA=;
        b=Z8yKh+6C8SBN1Mos1npqTjLIAXadVhs0pYArp4XHXzVQcUhEq7SBlkne2dUIJUHFiZ
         aASwenuNR/xGEM3udLpaONc7GSg7Od+yKG8LRt3V+PnMvETokuduR4HeES3wVjGgRWPZ
         FB8hqs14ywgMeEek3j89BnPbCqDFBrvuA8Sz3xCIVnJ+ttc4aaOw86Q7BV8HhZhhWVeB
         RKcphfAn3OU3RN4FktbNxkMakv/6AMmtKRMJeWRxN09osj7npSeIsGGk3O6F8KO0K8IG
         Km4vEJDhKw91EBNsgUAxAy2fkBZIK+8VkMOWEsWlLsxgxBvOk/vVWkzXyG0F4sOAMU3v
         g2lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uULVVNf+00uTXLBlTk+5ZpHg9JZ7/DLSlO8BujKHgOA=;
        b=cDmJnbfQqbe+OwlrT/K79xtfXUbMfqx03Y9eT84n+yQaoGe0p2AweDBSbLHObon7Vf
         xoRxVBlYzcAti5E8Bdt/1xAEtX2zUD2bx6XmZoJQb5adoeD5OILSJXO2qQ6JkmQUdIVC
         Q71sNGxIQjRj8C6pwbGBXZ3tLTnCAMQ/S7MqCabFRsyvCZwBn2dN/tzfKqE2OGmhlUwW
         2n7rcvpXMLAHUIZL7gNTkGuQfJBYPYLM4056gcIL+anm9XhaMMjBycJ7owtFNYCQl5Bl
         p2kklctgJwAfXW0KYjGzjG1ROMIgh6NnVMh471/M4UfEoR8+8O8FSBYG9Fs07nL9Qvyp
         70GA==
X-Gm-Message-State: APjAAAWvBih+kRRVlokwH9plhv6G08nCe9mHyqX8cGnljWoMUdi1wlkx
        s/dH1nztt6ogcO6h9E6Zjg==
X-Google-Smtp-Source: APXvYqyV8BGGYxZMldErHuMZ25Le9QBc4K9Gg2WB0AjAq7NBLwrUpHgyb3ycy6oeRIf/7XcKncfnZg==
X-Received: by 2002:a65:5144:: with SMTP id g4mr1168743pgq.202.1562747844462;
        Wed, 10 Jul 2019 01:37:24 -0700 (PDT)
Received: from mylaptop.nay.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id r188sm3809271pfr.16.2019.07.10.01.37.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 01:37:23 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     x86@kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Jiri Kosina <jkosina@suse.cz>,
        Mukesh Ojha <mojha@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] smp: force all cpu to boot once under maxcpus option
Date:   Wed, 10 Jul 2019 16:37:03 +0800
Message-Id: <1562747823-16972-1-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On x86 it's required to boot all logical CPUs at least once so that the
init code can get a chance to set CR4.MCE on each CPU. Otherwise, a
broadacasted MCE observing CR4.MCE=0b on any core will shutdown the
machine.

The option 'nosmt' has already complied with the above rule. In the case of
maxcpus, the initialization of capped out cpus may be deferred indefinitely
until a user brings them up. This exposes the machine under the risk of
sudden shutdown indefinitely.

Minimize the risk window by initializing all cpus at boot time.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Mukesh Ojha <mojha@codeaurora.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: linux-kernel@vger.kernel.org
---
 include/linux/smp.h |  1 +
 kernel/cpu.c        | 20 ++++++++++++++++++--
 kernel/smp.c        |  4 ++++
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/include/linux/smp.h b/include/linux/smp.h
index a56f08f..9d2c692 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -130,6 +130,7 @@ extern void __init setup_nr_cpu_ids(void);
 extern void __init smp_init(void);
 
 extern int __boot_cpu_id;
+extern bool smp_boot_done;
 
 static inline int get_boot_cpu_id(void)
 {
diff --git a/kernel/cpu.c b/kernel/cpu.c
index ef1c565..ab19dc8 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -439,6 +439,21 @@ static inline bool cpu_smt_allowed(unsigned int cpu)
 static inline bool cpu_smt_allowed(unsigned int cpu) { return true; }
 #endif
 
+static inline bool maxcpus_allowed(unsigned int cpu)
+{
+	/* maxcpus only takes effect during system bootup */
+	if (smp_boot_done)
+		return true;
+	if (num_online_cpus() < setup_max_cpus)
+		return true;
+	/*
+	 * maxcpus should allow cpu to set CR4.MCE asap, otherwise the set may
+	 * be deferred indefinitely.
+	 */
+	if (!per_cpu(cpuhp_state, cpu).booted_once)
+		return true;
+}
+
 static inline enum cpuhp_state
 cpuhp_set_state(struct cpuhp_cpu_state *st, enum cpuhp_state target)
 {
@@ -525,8 +540,9 @@ static int bringup_wait_for_ap(unsigned int cpu)
 	 * CPU marked itself as booted_once in cpu_notify_starting() so the
 	 * cpu_smt_allowed() check will now return false if this is not the
 	 * primary sibling.
+	 * In case of maxcpus, the capped out cpus comply with the same rule.
 	 */
-	if (!cpu_smt_allowed(cpu))
+	if (!cpu_smt_allowed(cpu) || !maxcpus_allowed(cpu))
 		return -ECANCELED;
 
 	if (st->target <= CPUHP_AP_ONLINE_IDLE)
@@ -1177,7 +1193,7 @@ static int do_cpu_up(unsigned int cpu, enum cpuhp_state target)
 		err = -EBUSY;
 		goto out;
 	}
-	if (!cpu_smt_allowed(cpu)) {
+	if (!cpu_smt_allowed(cpu) || !maxcpus_allowed(cpu)) {
 		err = -EPERM;
 		goto out;
 	}
diff --git a/kernel/smp.c b/kernel/smp.c
index d155374..a5f82d53 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -560,6 +560,9 @@ void __init setup_nr_cpu_ids(void)
 	nr_cpu_ids = find_last_bit(cpumask_bits(cpu_possible_mask),NR_CPUS) + 1;
 }
 
+bool smp_boot_done __read_mostly;
+EXPORT_SYMBOL(smp_boot_done);
+
 /* Called by boot processor to activate the rest. */
 void __init smp_init(void)
 {
@@ -587,6 +590,7 @@ void __init smp_init(void)
 
 	/* Any cleanup work */
 	smp_cpus_done(setup_max_cpus);
+	smp_boot_done = true;
 }
 
 /*
-- 
2.7.5

