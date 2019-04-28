Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0DA1C43219
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 09:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AF70206BB
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 09:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lx+jPmcT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfD1Jvj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 05:51:39 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39277 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbfD1Jvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 05:51:38 -0400
Received: by mail-wr1-f65.google.com with SMTP id a9so11148126wrp.6
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2019 02:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=40vQhCWF25KCOygjTxWMwR00SFUppKuwSlIi4NPfG4I=;
        b=Lx+jPmcTYGJuK8G7wOr1Hg6U+yhw+gL4mmxquj/CLIDtsag/ZM0B3C1VqTJLYrIYXt
         0RK+cDTUhMBkv8aeQipfghWXbKa3fdVw4l3p3NcP3G80kQZKLf63CYq3SfrrfWvRytg9
         hqNeUDHK7FLELHlDvhi6iRH3j4t+4ZkM357v+0YTFf29/iocxTgacEXE7fLRrNFw0kMO
         e4+4j8GMpouzh1itkcOLsqvrT1VniJ3jM/+OD4H4tnZF8gHrwmS+uYKKe+IrsUNU5M0t
         05Uv2GcYR+tVjxpM8aBt98XkBFZB8C8BUSBnEb5lLazDfubqcXOAbjaGxF48WJz3WSUV
         8gEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=40vQhCWF25KCOygjTxWMwR00SFUppKuwSlIi4NPfG4I=;
        b=WrLc82u7kxgblA28/uYR27Ha1Pz/6+A4QS0cQqlFuFVjE09FGc67hdhm9uegGUsqEE
         QEkI+oCR078ZhTclb7IhhD46x9CWxf6jRm+iFqNRx+cMkGHuK+bGd5Nm28jcbyqtPMWG
         WuXV22WLBNfcdDBTl6L2JekqkmMN+glmRU/o/Z7efILJNGtyvopkWzOtysptVbWXijPR
         e9WpFtkas9/x3HbI0xv3d5IH6dVcCKis6w3wabeQLYVz70wPXYGS/0ephpfF/k6+zak2
         f0LVMFHisccZXcmEzhEljjHRgqG1vQknDKLIsfrtZsgZiyAtsX4Ixx2KaUE4o4aKGbSA
         9crg==
X-Gm-Message-State: APjAAAXoPC8PSAPVbFYfi9TEqw6npShzjspyOiMzjoR43Sv9eRc0uvrN
        uaMUG589lWURJ1v9Sdv8cwcEWLrtebw=
X-Google-Smtp-Source: APXvYqwInBZjS2ofuNIYsrUI0kvN/WOkPj4ELFPWfyez18CoVxYWPiMOJ5cqdfFcQ+cLjVaJFGrs2A==
X-Received: by 2002:a5d:6ac3:: with SMTP id u3mr3683132wrw.13.1556445096437;
        Sun, 28 Apr 2019 02:51:36 -0700 (PDT)
Received: from clegane.local (86.204.129.77.rev.sfr.net. [77.129.204.86])
        by smtp.gmail.com with ESMTPSA id e5sm1560675wrh.79.2019.04.28.02.51.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Apr 2019 02:51:35 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     edubezval@gmail.com, rui.zhang@intel.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>
Subject: [PATCH - resend 3/3] thermal/drivers/cpu_cooling: Remove pointless field
Date:   Sun, 28 Apr 2019 11:51:05 +0200
Message-Id: <20190428095106.5171-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190428095106.5171-1-daniel.lezcano@linaro.org>
References: <20190428095106.5171-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The structure cpufreq_cooling_device provides a backpointer to the thermal
device but this one is used for a trace and to unregister. For the trace,
we don't really need this field and the unregister function as the same
pointer passed as parameter. Remove it.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/cpu_cooling.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index b9d152a5f7ba..9b014d0e8e70 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -87,7 +87,6 @@ struct cpufreq_cooling_device {
 	unsigned int clipped_freq;
 	unsigned int max_level;
 	struct freq_table *freq_table;	/* In descending order */
-	struct thermal_cooling_device *cdev;
 	struct cpufreq_policy *policy;
 	struct list_head node;
 	struct time_in_idle *idle_time;
@@ -195,8 +194,7 @@ static int update_freq_table(struct cpufreq_cooling_device *cpufreq_cdev,
 
 	dev = get_cpu_device(cpu);
 	if (unlikely(!dev)) {
-		dev_warn(&cpufreq_cdev->cdev->device,
-			 "No cpu device for cpu %d\n", cpu);
+		pr_warn("No cpu device for cpu %d\n", cpu);
 		return -ENODEV;
 	}
 
@@ -679,7 +677,6 @@ __cpufreq_cooling_register(struct device_node *np,
 		goto remove_ida;
 
 	cpufreq_cdev->clipped_freq = cpufreq_cdev->freq_table[0].frequency;
-	cpufreq_cdev->cdev = cdev;
 
 	mutex_lock(&cooling_list_lock);
 	/* Register the notifier for first cpufreq cooling device */
@@ -797,7 +794,7 @@ void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
 		cpufreq_unregister_notifier(&thermal_cpufreq_notifier_block,
 					    CPUFREQ_POLICY_NOTIFIER);
 
-	thermal_cooling_device_unregister(cpufreq_cdev->cdev);
+	thermal_cooling_device_unregister(cdev);
 	ida_simple_remove(&cpufreq_ida, cpufreq_cdev->id);
 	kfree(cpufreq_cdev->idle_time);
 	kfree(cpufreq_cdev->freq_table);
-- 
2.17.1

