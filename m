Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D01A8CA9EAE
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 02:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A42F620663
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 02:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U3BMhs20"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbfJ3CVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 22:21:41 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35010 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfJ3CVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 22:21:40 -0400
Received: by mail-pf1-f194.google.com with SMTP id d13so455791pfq.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 19:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qVD3J8XzUwcfeXNwdpWLpuVBq1SeYqO+/HWGUDDG45w=;
        b=U3BMhs20PpxQ3D2Nh3i3v8BQfGLEPy46WsjoaG6YpwygQ9h1E+1VeqxJx7/HqVhGCd
         2tDn7vxtA+k8CWvI4PLA9WBhp7mZ4wscC9sghjfURhBISc+5R9jbFlA36Eo1xwEOBcdN
         uSEDunpuJV4+wzidN4W23UVJ43HRo6/GBpJDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qVD3J8XzUwcfeXNwdpWLpuVBq1SeYqO+/HWGUDDG45w=;
        b=PTMusZkgdaOXOltTKk9mcopjnmnQlIJ3HPi+9RfoUr/ySKoPaajm5seuCuTpTywv6b
         QtRAuR3pnjRgKsGIMN/SLEUHo0QRXauUiJBxoV3+7eVGg9Su1WmUIhCLWh8CqGxHBc7d
         6FI+T7pd08Hx1TCyg30QsbKPpUE88EFfHLIapGGejRFWZu2lKt268wd6knyUU32r972e
         CAT9LOX8G+meIOfHN+Skg0Aq7kothB/vhOATyB7DG9viWA+IFtJfw0L+2lGQwnwXFhHT
         7UFD91++IBiPltF4GqO8SD9R0WJAYewghp3kwDAxpzcJujNG39G/63uugfXmi++GUjtN
         m+fg==
X-Gm-Message-State: APjAAAVWeVxOTdILLFokbTXGIXEhpswfYX+RNz4ss4hCwbntgPp7ZUXt
        qe2Tx9OCKhA5dwVqcH375QiE2Q==
X-Google-Smtp-Source: APXvYqwm1umW28orhgobh16jX1UxaO8pYMLi1pxSkbchnq4ODrgiZ5MoqHUm8UcNYSbAhTPS4+Smyw==
X-Received: by 2002:a63:d415:: with SMTP id a21mr29816934pgh.299.1572402099004;
        Tue, 29 Oct 2019 19:21:39 -0700 (PDT)
Received: from ikjn-p920.tpe.corp.google.com ([2401:fa00:1:10:254e:2b40:ef8:ee17])
        by smtp.gmail.com with ESMTPSA id m68sm416109pfb.122.2019.10.29.19.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 19:21:38 -0700 (PDT)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     linux-pm@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        "Pavel Machek )" <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Ikjoon Jang <ikjn@chromium.org>
Subject: [RFC PATCH RESEND] cpuidle: undelaying cpuidle in dpm_{suspend|resume}()
Date:   Wed, 30 Oct 2019 10:21:05 +0800
Message-Id: <20191030022105.223213-1-ikjn@chromium.org>
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

Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
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

