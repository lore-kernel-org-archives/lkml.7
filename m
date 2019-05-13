Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B4ABC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 19:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 536EE20989
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 19:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YrDb+TI/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfEMT3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 15:29:42 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34160 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbfEMT3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 15:29:41 -0400
Received: by mail-lj1-f196.google.com with SMTP id j24so11286745ljg.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 12:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x3HZaV7vcbo/XhlaM1d9i+kdcoQHiHqHOKB8XCuJnJg=;
        b=YrDb+TI/qptrO7/5RXe8SeC+HyCzsJJl8ml3Jr2kE2brTGKdFR7/IJ+N4lXVtKfgGo
         NAHroyR3jEv97wAFOv1N3DRBDosPKmtXcn1hEpIBtK5wsOrvMlCDRGJxZwA8Y/CGP+8R
         ab2aAEL3gSBOsIHFKZCpimEz0v0pvvsft17f2AvJ1ojeV6J8wLK4ixd+AfhWKPZ/c7ZC
         sQLCc6Vgosbnw6yG7ZCHQQ1u7R7deMgYPyyYMCopM3U1unF1AFl5Ap4t5OT1xuDe8t5f
         uoNBPb8pfj6ZvLWRNfIZPJf9225Y1ujm2szcS0/1CCTN+KdvBfR2+owHypKzCboaNJCY
         oIXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=x3HZaV7vcbo/XhlaM1d9i+kdcoQHiHqHOKB8XCuJnJg=;
        b=e/yHWV97zD5dCXBO4+XMaZ9zXZaGAbjHV7EzB7GqB2o+dF8HW8sN5W642fZ68Vwe30
         mcs4m4utEMd001MiKlaR3pRWVgyPkwTct0BFQXB7gOA9yptTHjsd/ZU6iMBEGnZwqiUP
         EavCYeKot3/eKKc03DjVrvCUbY0NLdbNWIgWcF7lzaSM8sgF8Zf2/8/Naux/wfjcWHjs
         y44CmHxfMck4MciA1+JCRqJ1oNGHA5OgPz5ie7Han/y9d6h4Kfgm0XWhh8Nd+/MvkglZ
         70mAcekQ960J3SKBdlL01CO+/eFELtDChYDMcCaoKqGyCbYLgnRW2f7Zn1bp+Sv2iXQU
         PjeA==
X-Gm-Message-State: APjAAAUEJiYZ6E2DJ0BBQ9sm7iwIlBS4fFDqQfwSjhFEq/XbZwi93gLP
        j98116K0h14cZMmsfazh4I+NZA==
X-Google-Smtp-Source: APXvYqxhImmrN+c//ITxcw8U+57BeFavH+R85RVOLDvIyx6W8pcBzSGLx1AMwoyfzWMRSAkXmhUcdQ==
X-Received: by 2002:a2e:206:: with SMTP id 6mr13170535ljc.59.1557775408048;
        Mon, 13 May 2019 12:23:28 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id q21sm3449365lfa.84.2019.05.13.12.23.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 12:23:27 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Souvik Chakravarty <souvik.chakravarty@arm.com>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 12/18] drivers: firmware: psci: Add a helper to attach a CPU to its PM domain
Date:   Mon, 13 May 2019 21:22:54 +0200
Message-Id: <20190513192300.653-13-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190513192300.653-1-ulf.hansson@linaro.org>
References: <20190513192300.653-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a new PSCI DT helper function, psci_dt_attach_cpu(), which takes
a CPU number as an in-parameter and tries to attach the CPU's struct device
to its corresponding PM domain. Let's use dev_pm_domain_attach_by_name(),
as to be able to specify "psci" as the required "power-domain-names".

Additionally, let the helper prepare the CPU to be power managed via
runtime PM.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes:
	- Take into account whether the CPU is online/offline.
	- Convert from dev_pm_domain_attach() into using the more future proof
	  dev_pm_domain_attach_by_name().

---
 drivers/firmware/psci/psci.h           |  3 +++
 drivers/firmware/psci/psci_pm_domain.c | 17 +++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/firmware/psci/psci.h b/drivers/firmware/psci/psci.h
index c36e0e6649e9..b4254405b8ef 100644
--- a/drivers/firmware/psci/psci.h
+++ b/drivers/firmware/psci/psci.h
@@ -4,6 +4,7 @@
 #define __PSCI_H
 
 struct cpuidle_driver;
+struct device;
 struct device_node;
 
 int psci_set_osi_mode(void);
@@ -16,10 +17,12 @@ int psci_dt_parse_state_node(struct device_node *np, u32 *state);
 int psci_dt_init_pm_domains(struct device_node *np);
 int psci_dt_pm_domains_parse_states(struct cpuidle_driver *drv,
 		struct device_node *cpu_node, u32 *psci_states);
+struct device *psci_dt_attach_cpu(int cpu);
 #else
 static inline int psci_dt_init_pm_domains(struct device_node *np) { return 0; }
 static inline int psci_dt_pm_domains_parse_states(struct cpuidle_driver *drv,
 		struct device_node *cpu_node, u32 *psci_states) { return 0; }
+static inline struct device *psci_dt_attach_cpu(int cpu) { return NULL; }
 #endif
 #endif
 
diff --git a/drivers/firmware/psci/psci_pm_domain.c b/drivers/firmware/psci/psci_pm_domain.c
index 3aa645dba81b..1cbe745ee001 100644
--- a/drivers/firmware/psci/psci_pm_domain.c
+++ b/drivers/firmware/psci/psci_pm_domain.c
@@ -12,8 +12,10 @@
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/pm_domain.h>
+#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/string.h>
+#include <linux/cpu.h>
 #include <linux/cpuidle.h>
 #include <linux/cpu_pm.h>
 
@@ -383,4 +385,19 @@ int psci_dt_pm_domains_parse_states(struct cpuidle_driver *drv,
 
 	return 0;
 }
+
+struct device *psci_dt_attach_cpu(int cpu)
+{
+	struct device *dev, *cpu_dev = get_cpu_device(cpu);
+
+	dev = dev_pm_domain_attach_by_name(cpu_dev, "psci");
+	if (IS_ERR_OR_NULL(dev))
+		return dev;
+
+	pm_runtime_irq_safe(dev);
+	if (cpu_online(cpu))
+		pm_runtime_get_sync(dev);
+
+	return dev;
+}
 #endif
-- 
2.17.1

