Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA4FC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 21:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA25420679
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 21:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UJGeL4yD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbfGaVaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 17:30:02 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:38958 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbfGaVaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 17:30:02 -0400
Received: by mail-qt1-f201.google.com with SMTP id o16so62675079qtj.6
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 14:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=thyn0r1sTePT7dA1IEUgi4oBaDvhUuHSp3UeUg6AYFA=;
        b=UJGeL4yDuCd0G0L4ShisQDRQhS6hO47o5YBWvW59p2qos6bUGS/dOk1n4WJeHvuwVe
         /KUSe3fNcjnTE/VR7V8KD3PHohkkZ+IgrPDxf/7adf3AZwVtyXPkBAVGYAG4RoVHSqhl
         uPjTdGV5LCR4j6QzhOXzDINQUzjqWmX9/VE8ur8X7/MUcGty7uRUVLS62pC0T76fm9of
         sMzT7W6hfDi4Dwz/aljmCjwoNf8KkyW38ZuKbAxze69AvZjyDlb/PBv6VeEJZz0tFy15
         x17A879l39uQLS2KWoflgDch+TRrTkWqa4xfPHIS/0A4LqeRXMsEMuLX0onXUdN3b2MZ
         9PrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=thyn0r1sTePT7dA1IEUgi4oBaDvhUuHSp3UeUg6AYFA=;
        b=Zbn/UE9H0uy3VBISAEWpAJUWOU7u6JoNEnLLwRO8CTEDT7EJfozalTAoavR8+C5iQR
         A60HcC5UdHs8T/IUG4FVghdxhVgjZwA6G2VUTFVkR3NkE7mqNO7HCPaaErYjP1CRzecr
         d5o4km9d/wjPp4gwkcFqH/wVjlFrOXfPgv2X708HelZ8nZUQkF2h+KYqwxmJIFGoWub2
         9Z51pSxHBH3joCzsAnzNdPb6hvTiMFu7WSBjSqqw285gsbyRs6PimUAcE0UIc2knvkG6
         cnGS2yWHQxjZ3hK9fwJ0SpWIDYYheOfxpwJSHkeW0/kqFW1S9iIxvKEV5TeFpqqJ1njg
         lxvA==
X-Gm-Message-State: APjAAAUXyCrWDnos1b2v3GsGaC1YKwzsObdFfpPEZmORszT12EE0uEBb
        SKrAuAkvJ7meaMCrb7UGT4eKAJ6aD7AnCismPg==
X-Google-Smtp-Source: APXvYqyt2KCrM9NDHmkFPXiAxGvLhzqFG6G0FMz9uT0VqhvyB97MPVxlcAuOreiKXmUL4xd/ydFZC6K6aUO2ve2gYQ==
X-Received: by 2002:a37:a80d:: with SMTP id r13mr8700473qke.209.1564608601059;
 Wed, 31 Jul 2019 14:30:01 -0700 (PDT)
Date:   Wed, 31 Jul 2019 14:29:33 -0700
In-Reply-To: <20190731050549.GA20809@kroah.com>
Message-Id: <20190731212933.23673-1-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20190731050549.GA20809@kroah.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH v2] PM/sleep: Expose suspend stats in sysfs
From:   Kalesh Singh <kaleshsingh@google.com>
To:     rjw@rjwysocki.net, gregkh@linuxfoundation.org
Cc:     trong@google.com, trong@android.com, sspatil@google.com,
        hridya@google.com, kernel-team@android.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Kalesh Singh <kaleshsingh@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Userspace can get suspend stats from the suspend stats debugfs node.
Since debugfs doesn't have stable ABI, expose suspend stats in
sysfs under /sys/power/suspend_stats.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
Changes in v2:
  - Added separate show functions for last_failed_* stats, as per Greg
  - Updated ABI Documentation

 Documentation/ABI/testing/sysfs-power | 106 ++++++++++++++++++++++++++
 kernel/power/main.c                   |  97 ++++++++++++++++++++++-
 2 files changed, 201 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-power b/Documentation/ABI/testing/sysfs-power
index 3c5130355011..6f87b9dd384b 100644
--- a/Documentation/ABI/testing/sysfs-power
+++ b/Documentation/ABI/testing/sysfs-power
@@ -301,3 +301,109 @@ Description:
 
 		Using this sysfs file will override any values that were
 		set using the kernel command line for disk offset.
+
+What:		/sys/power/suspend_stats
+Date:		July 2019
+Contact:	Kalesh Singh <kaleshsingh96@gmail.com>
+Description:
+		The /sys/power/suspend_stats directory contains suspend related
+		statistics.
+
+What:		/sys/power/suspend_stats/success
+Date:		July 2019
+Contact:	Kalesh Singh <kaleshsingh96@gmail.com>
+Description:
+		The /sys/power/suspend_stats/success file contains the number
+		of times entering system sleep state succeeded.
+
+What:		/sys/power/suspend_stats/fail
+Date:		July 2019
+Contact:	Kalesh Singh <kaleshsingh96@gmail.com>
+Description:
+		The /sys/power/suspend_stats/fail file contains the number
+		of times entering system sleep state failed.
+
+What:		/sys/power/suspend_stats/failed_freeze
+Date:		July 2019
+Contact:	Kalesh Singh <kaleshsingh96@gmail.com>
+Description:
+		The /sys/power/suspend_stats/failed_freeze file contains the
+		number of times freezing processes failed.
+
+What:		/sys/power/suspend_stats/failed_prepare
+Date:		July 2019
+Contact:	Kalesh Singh <kaleshsingh96@gmail.com>
+Description:
+		The /sys/power/suspend_stats/failed_prepare file contains the
+		number of times preparing all non-sysdev devices for
+		a system PM transition failed.
+
+What:		/sys/power/suspend_stats/failed_resume
+Date:		July 2019
+Contact:	Kalesh Singh <kaleshsingh96@gmail.com>
+Description:
+		The /sys/power/suspend_stats/failed_resume file contains the
+		number of times executing "resume" callbacks of
+		non-sysdev devices failed.
+
+What:		/sys/power/suspend_stats/failed_resume_early
+Date:		July 2019
+Contact:	Kalesh Singh <kaleshsingh96@gmail.com>
+Description:
+		The /sys/power/suspend_stats/failed_resume_early file contains
+		the number of times executing "early resume" callbacks
+		of devices failed.
+
+What:		/sys/power/suspend_stats/failed_resume_noirq
+Date:		July 2019
+Contact:	Kalesh Singh <kaleshsingh96@gmail.com>
+Description:
+		The /sys/power/suspend_stats/failed_resume_noirq file contains
+		the number of times executing "noirq resume" callbacks
+		of devices failed.
+
+What:		/sys/power/suspend_stats/failed_suspend
+Date:		July 2019
+Contact:	Kalesh Singh <kaleshsingh96@gmail.com>
+Description:
+		The /sys/power/suspend_stats/failed_suspend file contains
+		the number of times executing "suspend" callbacks
+		of all non-sysdev devices failed.
+
+What:		/sys/power/suspend_stats/failed_suspend_late
+Date:		July 2019
+Contact:	Kalesh Singh <kaleshsingh96@gmail.com>
+Description:
+		The /sys/power/suspend_stats/failed_suspend_late file contains
+		the number of times executing "late suspend" callbacks
+		of all devices failed.
+
+What:		/sys/power/suspend_stats/failed_suspend_noirq
+Date:		July 2019
+Contact:	Kalesh Singh <kaleshsingh96@gmail.com>
+Description:
+		The /sys/power/suspend_stats/failed_suspend_noirq file contains
+		the number of times executing "noirq suspend" callbacks
+		of all devices failed.
+
+What:		/sys/power/suspend_stats/last_failed_dev
+Date:		July 2019
+Contact:	Kalesh Singh <kaleshsingh96@gmail.com>
+Description:
+		The /sys/power/suspend_stats/last_failed_dev file contains
+		the last device for which a suspend/resume callback failed.
+
+What:		/sys/power/suspend_stats/last_failed_errno
+Date:		July 2019
+Contact:	Kalesh Singh <kaleshsingh96@gmail.com>
+Description:
+		The /sys/power/suspend_stats/last_failed_errno file contains
+		the errno of the last failed attempt at entering
+		system sleep state.
+
+What:		/sys/power/suspend_stats/last_failed_step
+Date:		July 2019
+Contact:	Kalesh Singh <kaleshsingh96@gmail.com>
+Description:
+		The /sys/power/suspend_stats/last_failed_step file contains
+		the last failed step in the suspend/resume path.
diff --git a/kernel/power/main.c b/kernel/power/main.c
index bdbd605c4215..938dc53a8b94 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -254,7 +254,6 @@ static ssize_t pm_test_store(struct kobject *kobj, struct kobj_attribute *attr,
 power_attr(pm_test);
 #endif /* CONFIG_PM_SLEEP_DEBUG */
 
-#ifdef CONFIG_DEBUG_FS
 static char *suspend_step_name(enum suspend_stat_step step)
 {
 	switch (step) {
@@ -275,6 +274,92 @@ static char *suspend_step_name(enum suspend_stat_step step)
 	}
 }
 
+#define suspend_attr(_name)					\
+static ssize_t _name##_show(struct kobject *kobj,		\
+		struct kobj_attribute *attr, char *buf)		\
+{								\
+	return sprintf(buf, "%d\n", suspend_stats._name);	\
+}								\
+static struct kobj_attribute _name = __ATTR_RO(_name)
+
+suspend_attr(success);
+suspend_attr(fail);
+suspend_attr(failed_freeze);
+suspend_attr(failed_prepare);
+suspend_attr(failed_suspend);
+suspend_attr(failed_suspend_late);
+suspend_attr(failed_suspend_noirq);
+suspend_attr(failed_resume);
+suspend_attr(failed_resume_early);
+suspend_attr(failed_resume_noirq);
+
+static ssize_t last_failed_dev_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	int index;
+	char *last_failed_dev = NULL;
+
+	index = suspend_stats.last_failed_dev + REC_FAILED_NUM - 1;
+	index %= REC_FAILED_NUM;
+	last_failed_dev = suspend_stats.failed_devs[index];
+
+	return sprintf(buf, "%s\n", last_failed_dev);
+}
+static struct kobj_attribute last_failed_dev = __ATTR_RO(last_failed_dev);
+
+static ssize_t last_failed_errno_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	int index;
+	int last_failed_errno;
+
+	index = suspend_stats.last_failed_errno + REC_FAILED_NUM - 1;
+	index %= REC_FAILED_NUM;
+	last_failed_errno = suspend_stats.errno[index];
+
+	return sprintf(buf, "%d\n", last_failed_errno);
+}
+static struct kobj_attribute last_failed_errno = __ATTR_RO(last_failed_errno);
+
+static ssize_t last_failed_step_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	int index;
+	enum suspend_stat_step step;
+	char *last_failed_step = NULL;
+
+	index = suspend_stats.last_failed_step + REC_FAILED_NUM - 1;
+	index %= REC_FAILED_NUM;
+	step = suspend_stats.failed_steps[index];
+	last_failed_step = suspend_step_name(step);
+
+	return sprintf(buf, "%s\n", last_failed_step);
+}
+static struct kobj_attribute last_failed_step = __ATTR_RO(last_failed_step);
+
+static struct attribute *suspend_attrs[] = {
+	&success.attr,
+	&fail.attr,
+	&failed_freeze.attr,
+	&failed_prepare.attr,
+	&failed_suspend.attr,
+	&failed_suspend_late.attr,
+	&failed_suspend_noirq.attr,
+	&failed_resume.attr,
+	&failed_resume_early.attr,
+	&failed_resume_noirq.attr,
+	&last_failed_dev.attr,
+	&last_failed_errno.attr,
+	&last_failed_step.attr,
+	NULL,
+};
+
+static struct attribute_group suspend_attr_group = {
+	.name = "suspend_stats",
+	.attrs = suspend_attrs,
+};
+
+#ifdef CONFIG_DEBUG_FS
 static int suspend_stats_show(struct seq_file *s, void *unused)
 {
 	int i, index, last_dev, last_errno, last_step;
@@ -794,6 +879,14 @@ static const struct attribute_group attr_group = {
 	.attrs = g,
 };
 
+static const struct attribute_group *attr_groups[] = {
+	&attr_group,
+#ifdef CONFIG_PM_SLEEP
+	&suspend_attr_group,
+#endif
+	NULL,
+};
+
 struct workqueue_struct *pm_wq;
 EXPORT_SYMBOL_GPL(pm_wq);
 
@@ -815,7 +908,7 @@ static int __init pm_init(void)
 	power_kobj = kobject_create_and_add("power", NULL);
 	if (!power_kobj)
 		return -ENOMEM;
-	error = sysfs_create_group(power_kobj, &attr_group);
+	error = sysfs_create_groups(power_kobj, attr_groups);
 	if (error)
 		return error;
 	pm_print_times_init();
-- 
2.22.0.770.g0f2c4a37fd-goog

