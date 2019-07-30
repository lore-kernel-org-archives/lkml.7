Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53770C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 22:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 286612087F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 22:54:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cyFn2M0U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbfG3WyE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 18:54:04 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:57000 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbfG3WyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 18:54:03 -0400
Received: by mail-qk1-f202.google.com with SMTP id j81so56100100qke.23
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 15:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=R0JVGOkQwLlFihmKcCgicUJ0hNgc0t9L8L2hrWLxGhI=;
        b=cyFn2M0UOi/5de2AIh7Z0rxfDIaF65v/DKUYrGKgZahY0nh0GxlpgMLhIRLn37FkG9
         mlphLss5qJzjnE9eW25MnJTDN54hmf6ky8a6e2/62mAcyNRNiXfOBZFJsn+z5duIghCJ
         iOpuLRxoSWD8Oept37t/FEECF3xV6GoX3iYi7AVMRPXil1lpmMB9ETR5fa/iqK0csaAl
         0tEnsy4DqZ7RXltAY9x/AvGm9sLowVERoIH+VYbY0O8FY3YmlEbVxMo14bV2WcY39b+2
         QmT2f/Asklv3fdDAGMZrdrZs9mpHYwni8t7cLkCR6a3ogyHhF8/xHLLV2lOkbeR7SV5z
         w2Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=R0JVGOkQwLlFihmKcCgicUJ0hNgc0t9L8L2hrWLxGhI=;
        b=uIKMIV2CK0hFyyPECPcTa6bbUtEqxG5G1TlBCd8sZOTkozdP9SLzD7q4+3hQvRu0n5
         Z5o+toXab3i7K3vY6U2VRkxQx3CVqktXtLpfCOylXxb/Q3FOAZeaVLYN3aWYKmcXq8O4
         08tQnirypAd2//szrelHefukBa0m5AhhSMHqrACQVsOk0b8+MBHys7y4Kj/MojwCdPyl
         UPXEEmEgHRx+sbDyXpPjTXJGJ/fcs8qt3OlCEwhM8kR89X+lGZj8z86ZTbKMjiD+aTF/
         qtmuOABfJHE/Rb4sQo90DeUR+c7GqgkXFQgF8pmXf0R3KwEAjYWpiaxmJPOMhiX1hmLs
         Wn9Q==
X-Gm-Message-State: APjAAAUo/uA+zUFpQN+9YCu+szVgFbnqkuACFmnwZHmdS3cjiTIJfBkf
        scjMKMZYBkfoFSY5uzpTiuG/1ptDcEhfMhneYg==
X-Google-Smtp-Source: APXvYqxWqVNHp1EVqXYHvG4vL2AyDQ+o5xOQUG6C1tZwNnMOYl6ICpAa1caoZqDprfudm3UIFGBxlIXvMTbYp0N3lQ==
X-Received: by 2002:a0c:9890:: with SMTP id f16mr85244695qvd.165.1564527242501;
 Tue, 30 Jul 2019 15:54:02 -0700 (PDT)
Date:   Tue, 30 Jul 2019 15:52:28 -0700
Message-Id: <20190730225228.126044-1-kaleshsingh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH] PM/sleep: Expose suspend stats in sysfs
From:   Kalesh Singh <kaleshsingh@google.com>
To:     rjw@rjwysocki.net, gregkh@linuxfoundation.org
Cc:     trong@google.com, trong@android.com, sspatil@google.com,
        hridya@google.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Kalesh Singh <kaleshsingh@google.com>
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
 kernel/power/main.c | 77 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 75 insertions(+), 2 deletions(-)

diff --git a/kernel/power/main.c b/kernel/power/main.c
index bdbd605c4215..2a0edfcd50dc 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -254,7 +254,6 @@ static ssize_t pm_test_store(struct kobject *kobj, struct kobj_attribute *attr,
 power_attr(pm_test);
 #endif /* CONFIG_PM_SLEEP_DEBUG */
 
-#ifdef CONFIG_DEBUG_FS
 static char *suspend_step_name(enum suspend_stat_step step)
 {
 	switch (step) {
@@ -275,6 +274,72 @@ static char *suspend_step_name(enum suspend_stat_step step)
 	}
 }
 
+#define suspend_attr(_name)						\
+static ssize_t _name##_show(struct kobject *kobj,			\
+		struct kobj_attribute *attr, char *buf)			\
+{									\
+	int index;							\
+	enum suspend_stat_step step;					\
+	char *last_failed_stat = NULL;					\
+									\
+	if (strcmp(attr->attr.name, "last_failed_dev") == 0) {		\
+		index = suspend_stats._name + REC_FAILED_NUM - 1;	\
+		index %= REC_FAILED_NUM;				\
+		last_failed_stat = suspend_stats.failed_devs[index];	\
+		return sprintf(buf, "%s\n", last_failed_stat);		\
+	} else if (strcmp(attr->attr.name, "last_failed_step") == 0) {	\
+		index = suspend_stats._name + REC_FAILED_NUM - 1;	\
+		index %= REC_FAILED_NUM;				\
+		step = suspend_stats.failed_steps[index];		\
+		last_failed_stat = suspend_step_name(step);		\
+		return sprintf(buf, "%s\n", last_failed_stat);		\
+	} else if (strcmp(attr->attr.name, "last_failed_errno") == 0) {	\
+		index = suspend_stats._name + REC_FAILED_NUM - 1;	\
+		index %= REC_FAILED_NUM;				\
+		return sprintf(buf, "%d\n", suspend_stats.errno[index]);\
+	}								\
+									\
+	return sprintf(buf, "%d\n", suspend_stats._name);		\
+}									\
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
+suspend_attr(last_failed_dev);
+suspend_attr(last_failed_errno);
+suspend_attr(last_failed_step);
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
@@ -794,6 +859,14 @@ static const struct attribute_group attr_group = {
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
 
@@ -815,7 +888,7 @@ static int __init pm_init(void)
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

