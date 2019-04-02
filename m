Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1811C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90A302064A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YbW8teMW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730966AbfDBQOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 12:14:01 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35895 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729838AbfDBQOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 12:14:00 -0400
Received: by mail-wr1-f67.google.com with SMTP id y13so17438213wrd.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 09:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EpsrhrXs+dD79SXvH2cccWShrAxB04KkiEvgDMTNnaM=;
        b=YbW8teMWpb+FulYDEnukOhdz1UoCdasokDj1SgxZCIQcM/hCEnYtCStgdbU3an5U7K
         BQzbS7TqfD5ocAviTskX5VKV/1feBeXCVtSv4B95u3qxmrPTZxTqdFApp7j9r/upZqDw
         +oUbWSiGXoWv8ro6teeu+eOH/nc+GFtSXLnF9dBTE6ChT6KjGqQ31IRrES2K96PvIFMG
         hwKp+Xs4E/rDFnbwyaxiF5NhTbznGWORtj8ILS2n368EUDP8lxYaYPsEHhwMvAith9F6
         J76Gdoau+5UYSoOYveapNBlyjciutzsI4wTfJgGUkQTLVbHqDbGxQEzZiC0GE/Mr5aGI
         7Xng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EpsrhrXs+dD79SXvH2cccWShrAxB04KkiEvgDMTNnaM=;
        b=EWswszp9JMKEBVecDiRp7n0PbFAgOH6nwaYqisK9PJf02p8jUbJKDXrm1yO6hEZ2yD
         h0GvG06SMNJVe0Jrw3vhqGD8OftCQN1sFMDxeAuhZ0vERCVT3PtJLKgl4LaOQyF/6wEg
         YQVrYkJu7sjKKMLWhWpvqvOXJ10z0+hKDag52crpC2+uJclAx41C93rL6vKHF3n56oGc
         hOsZgfIIAJrIw/Nzrmca0KgziQNR5Wm4jvXG10SFUCXbV+9oQTdPqykWbyhz/OCigMkn
         5/0yN9S8i/SOS6RXTuPp/O+fYuatt227Ihx4H/ApTw3pJoUQAdhkj8bn62h/mrNCSkJW
         kAqA==
X-Gm-Message-State: APjAAAWT1YOt0abMeGjM4bPRzXnylreUhftHwGwvf6/W60KrJ5GpxUB7
        VSSyW/mESCzYA5pYx5HQyWfGEQ==
X-Google-Smtp-Source: APXvYqwa+okwyNn30H0eeVeqUSSNdHQvMxlo3PRs0KPdwcniY4itLQSGXKGA4H/Bpl5KdeDqtVIizg==
X-Received: by 2002:a5d:43c9:: with SMTP id v9mr45200552wrr.269.1554221638711;
        Tue, 02 Apr 2019 09:13:58 -0700 (PDT)
Received: from mai.imgcgcw.net (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.gmail.com with ESMTPSA id a126sm17054999wmh.4.2019.04.02.09.13.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 09:13:58 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rui.zhang@intel.com, edubezval@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT)
Subject: [PATCH 5/7] thermal/drivers/core: Remove depends on THERMAL in Kconfig
Date:   Tue,  2 Apr 2019 18:12:48 +0200
Message-Id: <20190402161256.11044-5-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190402161256.11044-1-daniel.lezcano@linaro.org>
References: <20190402161256.11044-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dependency on the THERMAL option to be set is already there implicitly
by the "if THERMAL" conditionnal option. The sub Kconfigs do not have to
check against the THERMAL option as they are called from a Kconfig block
which is enabled by the conditionnal option.

Remove the useless "depends on THERMAL" in the Kconfigs.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/Kconfig       | 2 --
 drivers/thermal/intel/Kconfig | 1 -
 drivers/thermal/qcom/Kconfig  | 1 -
 3 files changed, 4 deletions(-)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index ccf5b9408d7a..d8aa7fac8c56 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -24,7 +24,6 @@ config THERMAL_STATISTICS
 
 config THERMAL_EMERGENCY_POWEROFF_DELAY_MS
 	int "Emergency poweroff delay in milli-seconds"
-	depends on THERMAL
 	default 0
 	help
 	  Thermal subsystem will issue a graceful shutdown when
@@ -152,7 +151,6 @@ config CPU_THERMAL
 	bool "generic cpu cooling support"
 	depends on CPU_FREQ
 	depends on THERMAL_OF
-	depends on THERMAL=y
 	help
 	  This implements the generic cpu cooling mechanism through frequency
 	  reduction. An ACPI version of this already exists
diff --git a/drivers/thermal/intel/Kconfig b/drivers/thermal/intel/Kconfig
index 2e013eeb4a1d..2c727a820759 100644
--- a/drivers/thermal/intel/Kconfig
+++ b/drivers/thermal/intel/Kconfig
@@ -1,6 +1,5 @@
 config INTEL_POWERCLAMP
 	tristate "Intel PowerClamp idle injection driver"
-	depends on THERMAL
 	depends on X86
 	depends on CPU_SUP_INTEL
 	help
diff --git a/drivers/thermal/qcom/Kconfig b/drivers/thermal/qcom/Kconfig
index cdb455ffd575..3ce20fec86a2 100644
--- a/drivers/thermal/qcom/Kconfig
+++ b/drivers/thermal/qcom/Kconfig
@@ -1,6 +1,5 @@
 config QCOM_TSENS
 	tristate "Qualcomm TSENS Temperature Alarm"
-	depends on THERMAL
 	depends on QCOM_QFPROM
 	depends on ARCH_QCOM || COMPILE_TEST
 	help
-- 
2.17.1

