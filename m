Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A3E8C76188
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 06:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24EC1223A1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 06:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AS7dyrHG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730101AbfGWGOe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 02:14:34 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40403 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388096AbfGWGOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 02:14:31 -0400
Received: by mail-pg1-f195.google.com with SMTP id w10so18867824pgj.7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 23:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SWb56XEnAkwuUUTQuv4g9CftmyTnuWFI0OcyOh8bV4E=;
        b=AS7dyrHGVRmWsssELTaKoX/PZHEcnPqpDyuzYRx6yaWF7GV4TKl3wEsZLCqK09+afF
         UKPtHWleI0QB5Zu+zLqZNjhxvZgS1rWrGvzeol0aIejROxSkP10NjaNGLT9TtV4w4lTW
         9Ts6P/HxToNpQDWru2fZuBq1sLHJFfgeXg6uLZz6K18KDfsWBt3WvVSSgCAc46a8uYMh
         SmC/72s3aW8jIJj9hT0a9/XIgifFfWhoAOjRGbzvD9UVyZPoczLs2O0lZfsyOWbuV1LB
         ieQ/b25D/HHynbfdTLTG6pT9Zlj8Y50YrcCoIMfmMka93RWyu3U789hVkhtj1fOM6LFV
         XQAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SWb56XEnAkwuUUTQuv4g9CftmyTnuWFI0OcyOh8bV4E=;
        b=LXQjN3QJYUCdglvbCmWyRapr6n2EkDD0O2bCflmjzB9dZXqYIo9/TxxjyGCoTFz+6T
         hZtg+mOQwuYtFFJnMNx3KFWhsGipSVtRMuNBeGZmEgsPgR6dE+eF7nUwpFudb4/iatKT
         iDH8zEuhknI8htfx+az3L24uShLSzsrJPjYBnJ+6v2Lq1u9qqvHoKU0KRdQ8ctFNkSiW
         L+dFc5h+BLXlH0hpPdRL98gBIY9CqhKK0VI/zfxGyiOKCySJuQYGxrGlcfzv2YHq4Xi1
         FORZSu/ZIkLXsUd4frSDRQ7et+kvxEpCk1c/t+VvxOGBOPzeSpG4PmCuwepWDBS+z5Jh
         zTqA==
X-Gm-Message-State: APjAAAX3/ntmgMznvu8kMBtDdciqrHiOd39up8rn0RHT087yUWSaaYYy
        wjH1PVe5xd4fqsSGmWc77FwIOw==
X-Google-Smtp-Source: APXvYqyq06GLrfwvz+SL3YblFkBvCGjEzZkE9WnMZ0S1XzqjTWZU7vBi+IBQSh3jl76Zezux9RP3Ug==
X-Received: by 2002:a62:2f04:: with SMTP id v4mr3966722pfv.14.1563862470362;
        Mon, 22 Jul 2019 23:14:30 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id c69sm50590753pje.6.2019.07.22.23.14.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 23:14:29 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 03/10] powerpc: macintosh: Switch to QoS requests instead of cpufreq notifier
Date:   Tue, 23 Jul 2019 11:44:03 +0530
Message-Id: <8fab346b73991afcc6bc602253c973e5d4ecde95.1563862014.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
In-Reply-To: <cover.1563862014.git.viresh.kumar@linaro.org>
References: <cover.1563862014.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cpufreq core now takes the min/max frequency constraints via QoS
requests and the CPUFREQ_ADJUST notifier shall get removed later on.

Switch over to using the QoS request for maximum frequency constraint
for windfarm_cpufreq_clamp driver.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/macintosh/windfarm_cpufreq_clamp.c | 77 ++++++++++++++--------
 1 file changed, 50 insertions(+), 27 deletions(-)

diff --git a/drivers/macintosh/windfarm_cpufreq_clamp.c b/drivers/macintosh/windfarm_cpufreq_clamp.c
index 52fd5fca89a0..705c6200814b 100644
--- a/drivers/macintosh/windfarm_cpufreq_clamp.c
+++ b/drivers/macintosh/windfarm_cpufreq_clamp.c
@@ -3,9 +3,11 @@
 #include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/delay.h>
+#include <linux/pm_qos.h>
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/wait.h>
+#include <linux/cpu.h>
 #include <linux/cpufreq.h>
 
 #include <asm/prom.h>
@@ -16,36 +18,24 @@
 
 static int clamped;
 static struct wf_control *clamp_control;
-
-static int clamp_notifier_call(struct notifier_block *self,
-			       unsigned long event, void *data)
-{
-	struct cpufreq_policy *p = data;
-	unsigned long max_freq;
-
-	if (event != CPUFREQ_ADJUST)
-		return 0;
-
-	max_freq = clamped ? (p->cpuinfo.min_freq) : (p->cpuinfo.max_freq);
-	cpufreq_verify_within_limits(p, 0, max_freq);
-
-	return 0;
-}
-
-static struct notifier_block clamp_notifier = {
-	.notifier_call = clamp_notifier_call,
-};
+static struct dev_pm_qos_request qos_req;
+static unsigned int min_freq, max_freq;
 
 static int clamp_set(struct wf_control *ct, s32 value)
 {
-	if (value)
+	unsigned int freq;
+
+	if (value) {
+		freq = min_freq;
 		printk(KERN_INFO "windfarm: Clamping CPU frequency to "
 		       "minimum !\n");
-	else
+	} else {
+		freq = max_freq;
 		printk(KERN_INFO "windfarm: CPU frequency unclamped !\n");
+	}
 	clamped = value;
-	cpufreq_update_policy(0);
-	return 0;
+
+	return dev_pm_qos_update_request(&qos_req, freq);
 }
 
 static int clamp_get(struct wf_control *ct, s32 *value)
@@ -74,27 +64,60 @@ static const struct wf_control_ops clamp_ops = {
 
 static int __init wf_cpufreq_clamp_init(void)
 {
+	struct cpufreq_policy *policy;
 	struct wf_control *clamp;
+	struct device *dev;
+	int ret;
+
+	policy = cpufreq_cpu_get(0);
+	if (!policy) {
+		pr_warn("%s: cpufreq policy not found cpu0\n", __func__);
+		return -EPROBE_DEFER;
+	}
+
+	min_freq = policy->cpuinfo.min_freq;
+	max_freq = policy->cpuinfo.max_freq;
+	cpufreq_cpu_put(policy);
+
+	dev = get_cpu_device(0);
+	if (unlikely(!dev)) {
+		pr_warn("%s: No cpu device for cpu0\n", __func__);
+		return -ENODEV;
+	}
 
 	clamp = kmalloc(sizeof(struct wf_control), GFP_KERNEL);
 	if (clamp == NULL)
 		return -ENOMEM;
-	cpufreq_register_notifier(&clamp_notifier, CPUFREQ_POLICY_NOTIFIER);
+
+	ret = dev_pm_qos_add_request(dev, &qos_req, DEV_PM_QOS_MAX_FREQUENCY,
+				     max_freq);
+	if (ret < 0) {
+		pr_err("%s: Failed to add freq constraint (%d)\n", __func__,
+		       ret);
+		goto free;
+	}
+
 	clamp->ops = &clamp_ops;
 	clamp->name = "cpufreq-clamp";
-	if (wf_register_control(clamp))
+	ret = wf_register_control(clamp);
+	if (ret)
 		goto fail;
 	clamp_control = clamp;
 	return 0;
  fail:
+	dev_pm_qos_remove_request(&qos_req);
+
+ free:
 	kfree(clamp);
-	return -ENODEV;
+	return ret;
 }
 
 static void __exit wf_cpufreq_clamp_exit(void)
 {
-	if (clamp_control)
+	if (clamp_control) {
 		wf_unregister_control(clamp_control);
+		dev_pm_qos_remove_request(&qos_req);
+	}
 }
 
 
-- 
2.21.0.rc0.269.g1a574e7a288b

