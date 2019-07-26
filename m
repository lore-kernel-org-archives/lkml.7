Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F12C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 11:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A64222BEF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 11:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iZQOA7Vh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbfGZL1e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 07:27:34 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39421 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbfGZL1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 07:27:34 -0400
Received: by mail-lj1-f195.google.com with SMTP id v18so51101141ljh.6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 04:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VvJrkmi1Cwn8lyhtsQMDHS3PdPwEeGsIk+aMiHF32Hg=;
        b=iZQOA7Vh1AeiCmJRZYyWRcnNJw7mx3vuhfziN5xJyN0nCT7/YCjDyON4hFIJluzUUJ
         PBTIsl/eTYaLQkxKXopF6i/KGxtsqDXJcMB/A4YDGS1hE+Ki4Pr4zt6VHpzzflC6hsWp
         MISFZM1VeJsGmuRFCfMd+od6WxGiROAM528q+xZV79/evZBuTXs4Bs6m3pc8kaILzXkl
         Dd49j4aAP4LQVPeWFIsFLkYUEgriYpGKy0OLxZSgXv9oy5W5YMtOLGvb63AJ1gKU+swq
         iLHXB9AOquA7wCoGVyOLOjI/gWq4QRP24yyN1zU9HTy/B6iQs3Kc3OUWz7Y5syEkxwKc
         IXFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VvJrkmi1Cwn8lyhtsQMDHS3PdPwEeGsIk+aMiHF32Hg=;
        b=AvlXNAgqU0QwSDxa2iCVF9+v8cvK7SkYSzZYyY/Wps8Z2qg4NXbtHtciBBEtz3Y9RG
         EK0rhA+AhkKnhAH+UAdO4ZMKWBw3ph2B0Kz4Ipe8yoYTBrlqFJETjakI6NhmjVCtHHPO
         U//0LPEOxIYU5oZIM14kVRmkfeyOW1YJCfNF0X0oMly32ixQ8NlLfFN1NobEFF7OTVJv
         ovbCu12DzRaNBNZDF2jtY5Q7BLkt1vesmYVpTxYJC6PpWhmTC00GSK4aRJnTi2UgGOL9
         mqYBFcBh5nSLKPSSoJ/e7NYUf/PiaRhXz60BcXua0vsZ4HFoIpApdfPXsqKS2mVX8Yiq
         cwXA==
X-Gm-Message-State: APjAAAV3eYdsmJTvUHF4iG2o+qopdQMa+L7akZpOFqQ3nIGQy2MadtVx
        NC0k2uPA4sn1Q8N4lxERZ6on1w==
X-Google-Smtp-Source: APXvYqy2DiXWMGAc7lrhMJwuj/3I02AlVEVzIwxTmJTwoNODqG05gW6+VZKwf3/2vqK/EXuRJ4PyAg==
X-Received: by 2002:a2e:2b57:: with SMTP id q84mr49315455lje.105.1564140452344;
        Fri, 26 Jul 2019 04:27:32 -0700 (PDT)
Received: from localhost (c-243c70d5.07-21-73746f28.bbcust.telenor.se. [213.112.60.36])
        by smtp.gmail.com with ESMTPSA id i17sm8324734lfp.94.2019.07.26.04.27.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 04:27:31 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     catalin.marinas@arm.com, will@kernel.org
Cc:     mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH 3/3] arm64: smp: Mark expected switch fall-through
Date:   Fri, 26 Jul 2019 13:27:25 +0200
Message-Id: <20190726112725.19204-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When fall-through warnings was enabled by default the following warning
was starting to show up:

In file included from ../include/linux/kernel.h:15,
                 from ../include/linux/list.h:9,
                 from ../include/linux/kobject.h:19,
                 from ../include/linux/of.h:17,
                 from ../include/linux/irqdomain.h:35,
                 from ../include/linux/acpi.h:13,
                 from ../arch/arm64/kernel/smp.c:9:
../arch/arm64/kernel/smp.c: In function ‘__cpu_up’:
../include/linux/printk.h:302:2: warning: this statement may fall
 through [-Wimplicit-fallthrough=]
  printk(KERN_CRIT pr_fmt(fmt), ##__VA_ARGS__)
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../arch/arm64/kernel/smp.c:156:4: note: in expansion of macro ‘pr_crit’
    pr_crit("CPU%u: may not have shut down cleanly\n", cpu);
    ^~~~~~~
../arch/arm64/kernel/smp.c:157:3: note: here
   case CPU_STUCK_IN_KERNEL:
   ^~~~

Rework so that the compiler doesn't warn about fall-through.

Fixes: d93512ef0f0e ("Makefile: Globally enable fall-through warning")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 arch/arm64/kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index ea90d3bd9253..018a33e01b0e 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -152,8 +152,8 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
 				pr_crit("CPU%u: died during early boot\n", cpu);
 				break;
 			}
-			/* Fall through */
 			pr_crit("CPU%u: may not have shut down cleanly\n", cpu);
+			/* Fall through */
 		case CPU_STUCK_IN_KERNEL:
 			pr_crit("CPU%u: is stuck in kernel\n", cpu);
 			if (status & CPU_STUCK_REASON_52_BIT_VA)
-- 
2.20.1

