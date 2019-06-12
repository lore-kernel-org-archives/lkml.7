Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D71C31E48
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 20:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E049320652
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 20:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pJZ/5d5b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbfFLUNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 16:13:45 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40030 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727321AbfFLUNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 16:13:44 -0400
Received: by mail-wm1-f68.google.com with SMTP id v19so7791444wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 13:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=A36/iHVaO3uEyS+d/EzeUq+RkDaMz832JoNltOURTBo=;
        b=pJZ/5d5bOCs+D/TMQ5HtKnIIGvOiYfkzCi/ZdmCXPovFoxtFlNW+znmeVJoNQ24uOO
         SP6bNoCNILq9tzyaj/oXNFP72q58wVj6ldVo7xeSZ179In8KmiNQUIL8XU2paluGue7x
         Q66eCs7deVGb04ErpjQlM4ZSoVDTf9QDkETW+J/XJ7bkdpTWNXfPsnhf0UC4pQJnbIuO
         bkXgtexgQBm6pOpdRJsuutM7+EQydWCkL8IjcPlTk8hjbUceGQMlIgamepIbUVHaQ0g5
         D1A9v2CpVNgp625F4yhbrH8LLw1kmqnefVhKPIN1l+ZwyYO5XiCJRPfsm6HCNkXLTRmZ
         df0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=A36/iHVaO3uEyS+d/EzeUq+RkDaMz832JoNltOURTBo=;
        b=lJ9p4uYFQ5sTgKbqSL6LfOKgN5/fhzrfeGYp9JA9VvFa4u5G6UGV0ScBy3iskBuvXf
         aPwWOYIyr6fEwCUaW8NnKOWM4KuPJlp9GzUba4kEMYipFsprt3loGd9/VsrS5lAt51DM
         G2PmEKZDybuBss06yXhoXQuh+aXUNzJPn8a27pDCewhOQDYvoqQddCtdYYQxiw4axq6L
         RwEXpVHSdgdjXZOHlF8Om2APdhBo+Ojo43bG2QcDeHXyKCWqXSrEbs8Ml1JQ9Tw1oc5Q
         ZV4D7NwZnauEtK6UNkJGh1Omav6epr8oLqESI6QWWKQ84KfKRedzBf4dYZQ0t+ytGNHB
         CQ7Q==
X-Gm-Message-State: APjAAAX80gMwiGwTo/d5PPmCZXjtMkWTBboGR81lPYkuEUduqn5ifPiu
        vwKSYoKYFvO9Uu19Tj8LMWvwxsgJ04g=
X-Google-Smtp-Source: APXvYqy97vxFMTVImWGLO4fTpqCWE48n7WZKaiHLH+Xz2zXVaLq3FZO40hl85YzJRhdjmrVU4HFB7A==
X-Received: by 2002:a1c:343:: with SMTP id 64mr704892wmd.116.1560370422201;
        Wed, 12 Jun 2019 13:13:42 -0700 (PDT)
Received: from mai.imgcgcw.net (237.65.130.77.rev.sfr.net. [77.130.65.237])
        by smtp.gmail.com with ESMTPSA id l8sm1119566wrg.40.2019.06.12.13.13.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 13:13:41 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rui.zhang@intel.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        amit.kucheria@linaro.org
Subject: [PATCH 1/2] thermal/drivers/core: Add init section table for self-encapsulation
Date:   Wed, 12 Jun 2019 22:13:24 +0200
Message-Id: <20190612201325.1150-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the governors are declared in their respective files but they
export their [un]register functions which in turn call the [un]register
governors core's functions. That implies a cyclic dependency which is
not desirable. There is a way to self-encapsulate the governors by letting
them to declare themselves in a __init section table.

Define the table in the asm generic linker description like the other
tables and provide the specific macros to deal with.

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.h    | 15 +++++++++++++++
 include/asm-generic/vmlinux.lds.h | 11 +++++++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 0df190ed82a7..be901e84aa65 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -15,6 +15,21 @@
 /* Initial state of a cooling device during binding */
 #define THERMAL_NO_TARGET -1UL
 
+/* Init section thermal table */
+extern struct thermal_governor *__governor_thermal_table[];
+extern struct thermal_governor *__governor_thermal_table_end[];
+
+#define THERMAL_TABLE_ENTRY(table, name)			\
+	(static typeof(name) *__thermal_table_entry_##name	\
+	__used __section(__##table##_thermal_table) = &name)
+
+#define THERMAL_GOVERNOR_DECLARE(name)	THERMAL_TABLE_ENTRY(governor, name)
+
+#define for_each_governor_table(__governor)		\
+	for (__governor = __governor_thermal_table;	\
+	     __governor < __governor_thermal_table_end;	\
+	     __governor++)
+
 /*
  * This structure is used to describe the behavior of
  * a certain cooling device on a certain trip point
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index f8f6f04c4453..8312fdc2b2fa 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -239,6 +239,16 @@
 #define ACPI_PROBE_TABLE(name)
 #endif
 
+#ifdef CONFIG_THERMAL
+#define THERMAL_TABLE(name)						\
+	. = ALIGN(8);							\
+	__##name##_thermal_table = .;					\
+	KEEP(*(__##name##_thermal_table))				\
+	__##name##_thermal_table_end = .;
+#else
+#define THERMAL_TABLE(name)
+#endif
+
 #define KERNEL_DTB()							\
 	STRUCT_ALIGN();							\
 	__dtb_start = .;						\
@@ -609,6 +619,7 @@
 	IRQCHIP_OF_MATCH_TABLE()					\
 	ACPI_PROBE_TABLE(irqchip)					\
 	ACPI_PROBE_TABLE(timer)						\
+	THERMAL_TABLE(governor)						\
 	EARLYCON_TABLE()						\
 	LSM_TABLE()
 
-- 
2.17.1

