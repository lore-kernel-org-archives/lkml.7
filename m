Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37BBAC48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 11:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10F1D20656
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 11:33:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b8O+q8+p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730765AbfFYLdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 07:33:02 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34818 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728940AbfFYLdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 07:33:01 -0400
Received: by mail-wr1-f68.google.com with SMTP id f15so7577425wrp.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 04:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Jb+mp+rDj9DLSvOVTi217/rhPZn5ckg46P7fvQWw8bI=;
        b=b8O+q8+prWiPegbdgjjfIFOuD5BkeaA7JfC1MHz+Tc9x43b1tRTTjSTLnGoMlFQ6ul
         6aPkd4to4AnqNt1LUjRofjOUM3WGxDCGW6r/LDUCpIt71dR8i78wdpcep75jh7hjCjlI
         NOB//JopuNBp6KX8Nakjz+38eK4WMv6pIjMIUqWF8hSPUTD1zl9rREM4NNJ/IxniZN94
         n/GrA2nFH/lMlM8bACKhMEzqvlJT2YsaQ4Vog3WehS2DK6a/hp8sBQEf6hVbGRFkKtFd
         Ogqz5CUtiy2m8PfP5NtZ5/BgFkvchuk8P0m9F8fe/MyuaH58/HbhixDhKiZf83g5NjSJ
         4SXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Jb+mp+rDj9DLSvOVTi217/rhPZn5ckg46P7fvQWw8bI=;
        b=airkmmn+VBQhdc6FG6lDGpFzXbTjbjc/pgG6I4rFz4DbjXBxHo3kR6K614s9nrfXZK
         CvAa1gqNSo972W8Bp00xZT+9PK9HSZ1kJWbuGPrQdOEU3kI73XHtNsD8MldRlcbHUfS6
         66OS/QPV4jRZuJYBoHwXY9JuoxrrduUR2HLxHctlfTKGb1Ig9497THDkMxhrjiSyzylx
         6arWEdhmlkLA15OP8y/hPJ6jZ8LfTQZmTdsja6fAjiYDHUHulgwOL+h8Yds7hRXz3xAZ
         Mn5EH5VPWRPAuLnq9Oba07gFVyFDHIUvz9kpABJGOQCBDwCh38AOdnBS4m0xxSvp8FUx
         Cj2A==
X-Gm-Message-State: APjAAAUAhWrSvmLpdCG2/aD/TaDSg2yKyZdKE8Z5/vzwCxaLLJA/JYEK
        4x5Rmx+arGMlK9xF1+kjwqJ5RQ==
X-Google-Smtp-Source: APXvYqyDTRsg9JgGOVVsxssqrY+oHBPFPg8nvRzQM0sR5MIPPyTAr34aqUlQ3cxCDkSStjDs+UDDug==
X-Received: by 2002:adf:b78c:: with SMTP id s12mr49273824wre.264.1561462379160;
        Tue, 25 Jun 2019 04:32:59 -0700 (PDT)
Received: from clegane.local (191.184.66.86.rev.sfr.net. [86.66.184.191])
        by smtp.gmail.com with ESMTPSA id j7sm19254284wru.54.2019.06.25.04.32.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 04:32:58 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     viresh.kumar@linaro.org
Cc:     rjw@rjwysocki.net, edubezval@gmail.com,
        linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK)
Subject: [PATCH V3 1/3] cpufreq: Move the IS_ENABLED(CPU_THERMAL) macro in a stub
Date:   Tue, 25 Jun 2019 13:32:41 +0200
Message-Id: <20190625113244.18146-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cpufreq_online and the cpufreq_offline [un]register the driver as
a cooling device. This is done if the driver is flagged as a cooling
device in addition with a IS_ENABLED macro to compile out the branching
code.

Group this test in a stub function added in the cpufreq header instead
of having the IS_ENABLED in the code path.

Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 6 ++----
 include/linux/cpufreq.h   | 6 ++++++
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 85ff958e01f1..aee024e42618 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1378,8 +1378,7 @@ static int cpufreq_online(unsigned int cpu)
 	if (cpufreq_driver->ready)
 		cpufreq_driver->ready(policy);
 
-	if (IS_ENABLED(CONFIG_CPU_THERMAL) &&
-	    cpufreq_driver->flags & CPUFREQ_IS_COOLING_DEV)
+	if (cpufreq_thermal_control_enabled(cpufreq_driver))
 		policy->cdev = of_cpufreq_cooling_register(policy);
 
 	pr_debug("initialization complete\n");
@@ -1469,8 +1468,7 @@ static int cpufreq_offline(unsigned int cpu)
 		goto unlock;
 	}
 
-	if (IS_ENABLED(CONFIG_CPU_THERMAL) &&
-	    cpufreq_driver->flags & CPUFREQ_IS_COOLING_DEV) {
+	if (cpufreq_thermal_control_enabled(cpufreq_driver)) {
 		cpufreq_cooling_unregister(policy->cdev);
 		policy->cdev = NULL;
 	}
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index d01a74fbc4db..a1467aa7f58b 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -409,6 +409,12 @@ int cpufreq_unregister_driver(struct cpufreq_driver *driver_data);
 const char *cpufreq_get_current_driver(void);
 void *cpufreq_get_driver_data(void);
 
+static inline int cpufreq_thermal_control_enabled(struct cpufreq_driver *drv)
+{
+	return IS_ENABLED(CONFIG_CPU_THERMAL) &&
+		(drv->flags & CPUFREQ_IS_COOLING_DEV);
+}
+
 static inline void cpufreq_verify_within_limits(struct cpufreq_policy *policy,
 		unsigned int min, unsigned int max)
 {
-- 
2.17.1

