Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B1B6C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 04:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E84A4222C4
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 04:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e3SCyNmm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbfLLEMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 23:12:22 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36372 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727900AbfLLELz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 23:11:55 -0500
Received: by mail-qk1-f194.google.com with SMTP id a203so539599qkc.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 20:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7l5JKLqHdHgruudTWmIyB43cagXE9G3mjJRNavUYrx4=;
        b=e3SCyNmm8WdEkCQ7f3y2JoLiUnEkvMrrU/TuSfpi+kkupGJr28+LC5r5TA0lQcSeIR
         vvBy19qWpacP2+4UZTKfaFcgRe8r7P1Wfcq3xidv9Hf43Mq3Cvt8TvxmiTXfn3N/Xsvh
         Apr44+/tMBHFY6K27rPCm9SiRomjBs/sNiM3GDLBtohddXnL6BcV0q4+mMU+HkXsnzAC
         /EdpT3yUbUdm/3Ib5DgDGRuiIV2g1jbbDKPN6TtSstSp4SVzX0aydgoGdgd+INdWmFB9
         3dIjeKF+X+Ig3QzTtNaP7/pEhOU80TuR1vsNrqwGQiNR5uaY+iYmySn639nxva/hL8CW
         RiWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7l5JKLqHdHgruudTWmIyB43cagXE9G3mjJRNavUYrx4=;
        b=PNaDAP8eoHgZnk9rFbVNJfUsuC0oNe5KWSIBSpOIdroWWxVdCSBhqo3zwoy2lxwGqr
         a+podJzhTt4uF5QIgdNK5khbXnkOGPh670iRdvWy+R733fjbj9Y+Fis3oT2OSaMYILpk
         ZCoFUQpeigE41onca2WcDKyEdR2mRvTylfNXdP08Mb6eTScIPlP6wSHPQjYiQO82R/HH
         nJ0e3UckOV8QwrlfNgcn/UjiBbiMsE3CyUMONuWAcnlUwRHVNiTAFzgo/Tjp9Vx/KqbA
         51xg4CXWMitV6JbjSxs9syb5SSLj4p7BUVaOqKAFV1HVAOxC86qk8DZBOdxWcHe9bkBA
         Rt/Q==
X-Gm-Message-State: APjAAAUYiCgji/1zAN5TcN3SbOEJpdofxchREApRAK+taiZh1FpSK2tL
        n4MafJEpFIUhYe/hmNlzUzAP/Q==
X-Google-Smtp-Source: APXvYqx6nLAvmXFo0EYR5d9XGwePPiY2grZzGrICF+/4YsX4sqK6wuoDqbQGdnQRwlh2YeQdOZqKyQ==
X-Received: by 2002:a37:b601:: with SMTP id g1mr6388350qkf.114.1576123914207;
        Wed, 11 Dec 2019 20:11:54 -0800 (PST)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id s11sm1364126qkg.99.2019.12.11.20.11.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Dec 2019 20:11:53 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, rui.zhang@intel.com,
        qperret@google.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, amit.kucheria@verdurent.com
Subject: [Patch v6 3/7] Add infrastructure to store and update instantaneous thermal pressure
Date:   Wed, 11 Dec 2019 23:11:44 -0500
Message-Id: <1576123908-12105-4-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1576123908-12105-1-git-send-email-thara.gopinath@linaro.org>
References: <1576123908-12105-1-git-send-email-thara.gopinath@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add architecture specific APIs to update and track thermal pressure on a
per cpu basis. A per cpu variable thermal_pressure is introduced to keep
track of instantaneous per cpu thermal pressure. Thermal pressure is the
delta between maximum capacity and capped capacity due to a thermal event.
capacity and capped capacity due to a thermal event.

topology_get_thermal_pressure can be hooked into the scheduler specified
arch_scale_thermal_capacity to retrieve instantaneius thermal pressure of
a cpu.

arch_set_thermal_presure can be used to update the thermal pressure by
providing a capped maximum capacity.

Considering topology_get_thermal_pressure reads thermal_pressure and
arch_set_thermal_pressure writes into thermal_pressure, one can argue for
some sort of locking mechanism to avoid a stale value.  But considering
topology_get_thermal_pressure_average can be called from a system critical
path like scheduler tick function, a locking mechanism is not ideal. This
means that it is possible the thermal_pressure value used to calculate
average thermal pressure for a cpu can be stale for upto 1 tick period.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---

v3->v4:
        - Dropped per cpu max_capacity_info struct and instead added a per
          delta_capacity variable to store the delta between maximum
          capacity and capped capacity. The delta is now calculated when
          thermal pressure is updated and not every tick.
        - Dropped populate_max_capacity_info api as only per cpu delta
          capacity is stored.
        - Renamed update_periodic_maxcap to
          trigger_thermal_pressure_average and update_maxcap_capacity to
          update_thermal_pressure.
v4->v5:
	- As per Peter's review comments folded thermal.c into fair.c.
	- As per Ionela's review comments revamped update_thermal_pressure
	  to take maximum available capacity as input instead of maximum
	  capped frequency ration.
v5->v6:
	- As per review comments moved all the infrastructure to track
	  and retrieve instantaneous thermal pressure out of scheduler
	  to topology files.

 arch/arm/include/asm/topology.h   |  3 +++
 arch/arm64/include/asm/topology.h |  3 +++
 drivers/base/arch_topology.c      | 13 +++++++++++++
 include/linux/arch_topology.h     | 11 +++++++++++
 4 files changed, 30 insertions(+)

diff --git a/arch/arm/include/asm/topology.h b/arch/arm/include/asm/topology.h
index 8a0fae9..90b18c3 100644
--- a/arch/arm/include/asm/topology.h
+++ b/arch/arm/include/asm/topology.h
@@ -16,6 +16,9 @@
 /* Enable topology flag updates */
 #define arch_update_cpu_topology topology_update_cpu_topology
 
+/* Replace task scheduler's defalut thermal pressure retrieve API */
+#define arch_scale_thermal_capacity topology_get_thermal_pressure
+
 #else
 
 static inline void init_cpu_topology(void) { }
diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
index a4d945d..ccb277b 100644
--- a/arch/arm64/include/asm/topology.h
+++ b/arch/arm64/include/asm/topology.h
@@ -25,6 +25,9 @@ int pcibus_to_node(struct pci_bus *bus);
 /* Enable topology flag updates */
 #define arch_update_cpu_topology topology_update_cpu_topology
 
+/* Replace task scheduler's defalut thermal pressure retrieve API */
+#define arch_scale_thermal_capacity topology_get_thermal_pressure
+
 #include <asm-generic/topology.h>
 
 #endif /* _ASM_ARM_TOPOLOGY_H */
diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 1eb81f11..3a91379 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -42,6 +42,19 @@ void topology_set_cpu_scale(unsigned int cpu, unsigned long capacity)
 	per_cpu(cpu_scale, cpu) = capacity;
 }
 
+DEFINE_PER_CPU(unsigned long, thermal_pressure);
+
+void arch_set_thermal_pressure(struct cpumask *cpus,
+			       unsigned long capped_capacity)
+{
+	int cpu;
+	unsigned long delta = arch_scale_cpu_capacity(cpumask_first(cpus)) -
+					capped_capacity;
+
+	for_each_cpu(cpu, cpus)
+		WRITE_ONCE(per_cpu(thermal_pressure, cpu), delta);
+}
+
 static ssize_t cpu_capacity_show(struct device *dev,
 				 struct device_attribute *attr,
 				 char *buf)
diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
index 3015ecb..7a04364 100644
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -33,6 +33,17 @@ unsigned long topology_get_freq_scale(int cpu)
 	return per_cpu(freq_scale, cpu);
 }
 
+DECLARE_PER_CPU(unsigned long, thermal_pressure);
+
+static inline
+unsigned long topology_get_thermal_pressure(int cpu)
+{
+	return per_cpu(thermal_pressure, cpu);
+}
+
+void arch_set_thermal_pressure(struct cpumask *cpus,
+			       unsigned long capped_capacity);
+
 struct cpu_topology {
 	int thread_id;
 	int core_id;
-- 
2.1.4

