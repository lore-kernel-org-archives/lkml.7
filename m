Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 902C9C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 11:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 687DA22BEF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 11:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aFmOhWcw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbfGZL1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 07:27:44 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43967 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbfGZL1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 07:27:43 -0400
Received: by mail-lj1-f193.google.com with SMTP id y17so26579660ljk.10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 04:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9OLH6fxuKgLOy3IQNpiLiTZEw036dSX/erXeaZiU+1g=;
        b=aFmOhWcwR9JZPomPlhuEjiQ+iDEneB3Fn7cOkOKbodtgm6JD4c5v+z03CMnc9Z1qxk
         N5BYlfwLuDrPYCgVEx3uT5AJu0lXJ0ERfEsfhZesnJczUQcmNVsgebr6Ip3WG9BeVgwT
         bhCer7qih/avaGN3NiV+P8ETiX3PBCjSocV402MD4r7vy4Mi73g9fagGvPdB2JtMOFEt
         WsTuzZ9t9fqOfCp5llHvN45J2SFvaESDfV1PoRj7h/LrkPxUJsgfIkZ+9b7g+XWoDhfn
         TL9as95m50nAnioG6EYMQZMj9cSITWohs2eXIEiiz2BGvN2Dj1b0Z16QjRT4Xo81Nrvz
         a45g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9OLH6fxuKgLOy3IQNpiLiTZEw036dSX/erXeaZiU+1g=;
        b=UG1T9fm+KiysndcX3cAdtXWHJWN1LrRKx6AnPSAffwsoRtEatg55kBRJ3Hh+vOgacf
         oWQkWOKnJhCQY+qES3Wh8ZLqPaj9kyj9TLrvOjGtw+gs9JdROYmZnzC1g0eyTEO6kL7K
         hkeYO2glOsp6vPK0C7oJNhoQoA3cASlGD8Wdt6oVUL+fWp3w3BtKAx+GZvBgw+p5MCiJ
         B1Cq+LzC+tBWcilT3FAeTFEYTKPgMDwCpEICPqQXwB+NEZsGDZWpH1rrlh8Hv1tJs+Z0
         GBjjs0EET4HNZcDuJ8+IxSwdRZmQY+kgnipO3420QWA0pUdErLmv/5kjjR9vpppdpMDZ
         VJcw==
X-Gm-Message-State: APjAAAUrDIgUfysLhugUT+bwwGEU9BnomEEMi2aukvyIZB55R1x60xfE
        OwDBA5YeOJAc6whC5zogHei1sA==
X-Google-Smtp-Source: APXvYqyLlEuVsq4S+ikz5rfIdN4QEBYo9a6hy0bII9lPMm8U6np7eGIUoQxz+vtDcvLauvKnwlRzhw==
X-Received: by 2002:a2e:9250:: with SMTP id v16mr48826921ljg.89.1564140461541;
        Fri, 26 Jul 2019 04:27:41 -0700 (PDT)
Received: from localhost (c-243c70d5.07-21-73746f28.bbcust.telenor.se. [213.112.60.36])
        by smtp.gmail.com with ESMTPSA id w6sm8239195lff.80.2019.07.26.04.27.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 04:27:40 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     will@kernel.org, mark.rutland@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] arm_pmu: Mark expected switch fall-through
Date:   Fri, 26 Jul 2019 13:27:37 +0200
Message-Id: <20190726112737.19309-1-anders.roxell@linaro.org>
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

../drivers/perf/arm_pmu.c: In function ‘cpu_pm_pmu_notify’:
../drivers/perf/arm_pmu.c:726:3: warning: this statement may fall
 through [-Wimplicit-fallthrough=]
   cpu_pm_pmu_setup(armpmu, cmd);
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/perf/arm_pmu.c:727:2: note: here
  case CPU_PM_ENTER_FAILED:
  ^~~~

Rework so that the compiler doesn't warn about fall-through.

Fixes: d93512ef0f0e ("Makefile: Globally enable fall-through warning")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---

I'm not convinced that this is the correct patch to fix this issue.
However, I can't see why we do 'armpmu->start(armpmu);' only in 'case
CPU_PM_ENTER_FAILED' and why we not call function cpu_pm_pmu_setup()
there also, since in cpu_pm_pmu_setup() has a case prepared for
CPU_PM_ENTER_FAILED.

 drivers/perf/arm_pmu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 2d06b8095a19..465a15705bab 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -724,6 +724,7 @@ static int cpu_pm_pmu_notify(struct notifier_block *b, unsigned long cmd,
 		break;
 	case CPU_PM_EXIT:
 		cpu_pm_pmu_setup(armpmu, cmd);
+		/* Fall through */
 	case CPU_PM_ENTER_FAILED:
 		armpmu->start(armpmu);
 		break;
-- 
2.20.1

