Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E75C433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 23:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E21482070D
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 23:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbfG1XxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 19:53:25 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:32857 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbfG1XxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 19:53:25 -0400
Received: by mail-wm1-f67.google.com with SMTP id h19so41793502wme.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 16:53:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tvo/EwR/TGSGrQyzo/cMXEKKXBvLMa9Iahv6vvH3r34=;
        b=P2qP8PxUKwvDuhQpbDXmKVDOUh97k9xw1pctNB4qwCydm0dejcS6zKLgm7yQq6V3RN
         3XOYmF4zaIYvQAQg8VI97Wq+vBJHa0UlNDhWv3cpgWu5P2O2MiDvyRQzJUkP94tcYXN3
         GxwmRFITYy3XT6inYdB1O7cKMhSuGEVy3Ud7RJILIvbUYcvLgpBRZDHlC9u7WteKY901
         B7Mh8bot+a4TXrDkg/VZkjo7MA7tjugObdNaYlc0SR/K8yC/OOR3GxTv+njeNNbLouAV
         9BvxiCuuQ7Sk4IPi2YiifOm535eaKMF0umY/MSPN4y5ZmZtGKYFdcPRItMPSYV+nn/hz
         EApQ==
X-Gm-Message-State: APjAAAVD5LLKQ7/MDb5/l2RVbR7NaCO7w9LX0qVEdbcU6XEgzcngkLp4
        HfX20lufMmEs1YRdET2F9WjffQ==
X-Google-Smtp-Source: APXvYqyrf0yR/xR9XDHVAOLqyW+RE3cSUi27Kfx+HycDIwlyHe4GqDgHnO+RWx5o6/Hn29vCCquabw==
X-Received: by 2002:a05:600c:34d:: with SMTP id u13mr69665580wmd.48.1564358003263;
        Sun, 28 Jul 2019 16:53:23 -0700 (PDT)
Received: from mcroce-redhat.homenet.telecomitalia.it (host221-208-dynamic.27-79-r.retail.telecomitalia.it. [79.27.208.221])
        by smtp.gmail.com with ESMTPSA id h16sm63516938wrv.88.2019.07.28.16.53.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 28 Jul 2019 16:53:22 -0700 (PDT)
From:   Matteo Croce <mcroce@redhat.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm_pmu: mark expected switch fall-through
Date:   Mon, 29 Jul 2019 01:53:20 +0200
Message-Id: <20190728235320.8600-1-mcroce@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark switch cases where we are expecting to fall through,
fixes the following warning:

drivers/perf/arm_pmu.c: In function ‘cpu_pm_pmu_notify’:
drivers/perf/arm_pmu.c:726:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
   cpu_pm_pmu_setup(armpmu, cmd);
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/perf/arm_pmu.c:727:2: note: here
  case CPU_PM_ENTER_FAILED:
  ^~~~

Signed-off-by: Matteo Croce <mcroce@redhat.com>
---
 drivers/perf/arm_pmu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 2d06b8095a19..3eb711066a22 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -724,6 +724,7 @@ static int cpu_pm_pmu_notify(struct notifier_block *b, unsigned long cmd,
 		break;
 	case CPU_PM_EXIT:
 		cpu_pm_pmu_setup(armpmu, cmd);
+		/* fallthrough */
 	case CPU_PM_ENTER_FAILED:
 		armpmu->start(armpmu);
 		break;
-- 
2.21.0

