Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFDBC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC864206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g3oRH+Vq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730810AbfDBQNo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 12:13:44 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54079 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730293AbfDBQNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 12:13:39 -0400
Received: by mail-wm1-f67.google.com with SMTP id q16so4044025wmj.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 09:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5XdVUklbAk1BF8gxDGmA3aa53/CL+l4UqAw0sFP3uO4=;
        b=g3oRH+Vq/frBheTx1xc9MH7m0cQzUi96P2+u8jTFxAuuwEtbxJzdzCOYa8loyP6qwx
         i1+QiyTmOfy52e1YRRMx4vIEFacX/QHc+WZLsmxsmF5CEqQrRIajzCdAZGEAgOGTsEmU
         IDH+Z7w8bthdKw9JLgAnAmo2ZE7v9UniIwPTpBRZ6A8XYHwwu7uyyu7Dz6o8+DafQe5F
         eK80qoHRBMAhO7gJpd4n5DsA+KPa79cGdI1PIcVnt5tI3KdSVoacmhnuNiMpHn7f1yxY
         sKtX4nmxmqvF7fLH5PVMZRMvz+NaEdedWYqGyjIBqMhmT0jliqEk0m97xRjuqi6RRyLB
         ZKOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5XdVUklbAk1BF8gxDGmA3aa53/CL+l4UqAw0sFP3uO4=;
        b=VrUh+YAaT8Tw1/0ltKCVlj60LRTL1Ggm/wywpHvBOHepHx6UlJgYsPBZj38VIHEyOm
         vZBULUTccS6zW6MTQ6V3Zouqvp52IWyJsi4tJpRkL9UvkHexVmCh8QBmMpZgfW2hwIX0
         RvJk+WoQsrViOCtkQMEDVp6yaxitCWED1i1DAdC27GejFrzcaUWZU3L+6AufdT8uB0uk
         4LkecFbnB3Fvuvh3OIw5trZZmX11drzrIdMO8aEPI2GW6fmwByLsSRAZciMHwwR/zII9
         w1EDdSUcWgncaRE16jWNkz/bL1cUxvar9QQVlwOYlwWaw2rzSvpniIMDWuG3PWjIqQsB
         uUFQ==
X-Gm-Message-State: APjAAAUsRQJc6HH6IP7lS7GhLoXMv+p6m1X2kIbFMaMVl952WLbeHjPX
        WOlGr+/dANvvHK/pjFTX7BYXqIF5wucjKQ==
X-Google-Smtp-Source: APXvYqwQLa1V1vtFdnjqSFhPuHkACzje9KDz5B5Q4xhiBLqGrxAtmDXu4fxmbbCeVuGMYHBxmtjdeQ==
X-Received: by 2002:a1c:7008:: with SMTP id l8mr4147149wmc.49.1554221617399;
        Tue, 02 Apr 2019 09:13:37 -0700 (PDT)
Received: from mai.imgcgcw.net (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.gmail.com with ESMTPSA id a126sm17054999wmh.4.2019.04.02.09.13.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 09:13:36 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rui.zhang@intel.com, edubezval@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch@vger.kernel.org (open list:GENERIC INCLUDE/ASM HEADER FILES)
Subject: [PATCH 3/7] thermal/drivers/core: Add init section table for self-encapsulation
Date:   Tue,  2 Apr 2019 18:12:46 +0200
Message-Id: <20190402161256.11044-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190402161256.11044-1-daniel.lezcano@linaro.org>
References: <20190402161256.11044-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the governors are declared in their respective files but they
export their [un]register functions which in turn call the [un]register
the governors core's functions. That implies a cyclic dependency which is
not desirable. There is a way to self-encapsulate the governors by letting
them to declare themselves in a __init section table.

Define the table in the asm generic linker description like the other
tables and provide the specific macros to deal with.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.h    | 16 ++++++++++++++++
 include/asm-generic/vmlinux.lds.h | 11 +++++++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 0df190ed82a7..28d18083e969 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -15,6 +15,22 @@
 /* Initial state of a cooling device during binding */
 #define THERMAL_NO_TARGET -1UL
 
+/* Init section thermal table */
+extern struct thermal_governor * __governor_thermal_table[];
+extern struct thermal_governor * __governor_thermal_table_end[];
+
+#define THERMAL_TABLE_ENTRY(table, name)			\
+        static typeof(name) * __thermal_table_entry_##name	\
+	__used __section(__##table##_thermal_table)		\
+		= &name;
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
index f8f6f04c4453..9893a3ed242a 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -239,6 +239,16 @@
 #define ACPI_PROBE_TABLE(name)
 #endif
 
+#ifdef CONFIG_THERMAL
+#define THERMAL_TABLE(name)						\
+        . = ALIGN(8);							\
+        __##name##_thermal_table = .;					\
+        KEEP(*(__##name##_thermal_table))				\
+        __##name##_thermal_table_end = .;
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

