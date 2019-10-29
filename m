Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 147A3CA9EC4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 07:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF62520578
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 07:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IVuaIgCP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbfJ2Hbv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 03:31:51 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40695 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfJ2Hbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 03:31:51 -0400
Received: by mail-pg1-f194.google.com with SMTP id 15so8918506pgt.7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 00:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pcHTqmnnCL/NWw1R6J/1w2hmcyaktVbA1aDRoVWc/is=;
        b=IVuaIgCPZu9De21EzBOreBg3aTxziZOG+fuPnNADlZBgt6QVIoRuTI0aziDjm/WR0C
         5Evep3E6sG+j/ldomU0+cof21z+nhLFjg2IhMsRTCUpmMf0kXMAzRUdMnWsQ243ImYOM
         Mgr0uupo5clmKCVs/WwbmtD43orjyfkpw73Pk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pcHTqmnnCL/NWw1R6J/1w2hmcyaktVbA1aDRoVWc/is=;
        b=O7kNGjBVmR+yKhWjnE2yIzDO2+LApAtEhowbf8bcV1oCHHZYKkdL46bwE9WFLz/rA2
         zn6v3iktY2mjO+zAHlsqoVOko/fK6O40DY+2Fu+CkwqjN6nIhXViQVk40Igm52njr0Ng
         piKllMjBa9PY3pMVrJGgZBxztHnmW7iKlCm+cyQrSEUUDB2v/lhGZPG2z4I3p2aNymRS
         uCilyUduUxFG4MiPdDFjZwM0wicYc6MSMEYQNkXivLBSfWbJX3JE15F/r0tMCvbvuky7
         mNrqnCudVjPSFzb4CdYhWAakShKF9vEcOZGhdgYO3ygUIf6umZitM5Jv6TcBtEkuUL7z
         gHgQ==
X-Gm-Message-State: APjAAAWe5nUYNT94otYWi0Q1JbanvfMLhTUCPwWMQY5/6y4DbTpOKy6S
        3oT3SYsTF0oMczUDEIIFMHnc+g==
X-Google-Smtp-Source: APXvYqwf35aJKp32xWbepK70jpGUJiEK0cVshmX9rYiLnqh7a1/mBOk+sLo/xDDsfylN6916/n8uqQ==
X-Received: by 2002:a63:df11:: with SMTP id u17mr2028144pgg.27.1572334310304;
        Tue, 29 Oct 2019 00:31:50 -0700 (PDT)
Received: from ikjn-p920.tpe.corp.google.com ([2401:fa00:1:10:254e:2b40:ef8:ee17])
        by smtp.gmail.com with ESMTPSA id b23sm1563020pju.16.2019.10.29.00.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 00:31:49 -0700 (PDT)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     linux-pm@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        "Pavel Machek )" <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Ikjoon Jang <ikjn@chromium.org>
Subject: [PATCH] cpuidle: undelaying cpuidle in dpm_{suspend|resume}()
Date:   Tue, 29 Oct 2019 15:31:45 +0800
Message-Id: <20191029073145.154869-1-ikjn@chromium.org>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpuidle is paused only during dpm_suspend_noirq() ~ dpm_resume_noirq().
But some device drivers need random sized IOs in dpm_{suspend|resume}()
stage (e.g. re-downloading firmware in resume).
And with such a device, cpuidle's latencies could be critical to
response time of system suspend/resume.

To minimize those latencies, we could apply pm_qos to such device drivers,
but simply undelaying cpuidle from dpm_suspend_noirq() to dpm suspend()
seems no harm.
---
 drivers/base/power/main.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 134a8af51511..5928dd2139e8 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -773,8 +773,6 @@ void dpm_resume_noirq(pm_message_t state)
 
 	resume_device_irqs();
 	device_wakeup_disarm_wake_irqs();
-
-	cpuidle_resume();
 }
 
 static pm_callback_t dpm_subsys_resume_early_cb(struct device *dev,
@@ -1069,6 +1067,7 @@ void dpm_resume(pm_message_t state)
 
 	cpufreq_resume();
 	devfreq_resume();
+	cpuidle_resume();
 	trace_suspend_resume(TPS("dpm_resume"), state.event, false);
 }
 
@@ -1411,8 +1410,6 @@ int dpm_suspend_noirq(pm_message_t state)
 {
 	int ret;
 
-	cpuidle_pause();
-
 	device_wakeup_arm_wake_irqs();
 	suspend_device_irqs();
 
@@ -1830,6 +1827,7 @@ int dpm_suspend(pm_message_t state)
 	trace_suspend_resume(TPS("dpm_suspend"), state.event, true);
 	might_sleep();
 
+	cpuidle_pause();
 	devfreq_suspend();
 	cpufreq_suspend();
 
-- 
2.24.0.rc0.303.g954a862665-goog

