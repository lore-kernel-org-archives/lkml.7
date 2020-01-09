Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 247E0C32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 06:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB62620721
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 06:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bImzlfp3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbgAIGgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 01:36:33 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40645 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728032AbgAIGgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 01:36:33 -0500
Received: by mail-pg1-f194.google.com with SMTP id k25so2715072pgt.7;
        Wed, 08 Jan 2020 22:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Gc8W5S1Ur3wJ9TCtlMqhIuhs+JTASQlzSkw6Uribzpo=;
        b=bImzlfp3uh2oGPQGEvh42E1XqJgVewlMDLfL2Z9c0q/7G493Sf9BoVogyHFhFJRdMU
         ssZuB7u4QL4qr1vFuqWxZxghCcaIxnCwyq2tn0V00VHTe8GmBkchdqmnGcT6Du93IRX/
         DaaIFrFQks3f60CbgxSb7CybOKL7nueECfEsXZSJynniaDhmbbf/klQjcrluTRgAkFpg
         GqgwWqEyEWr6JKl4FeA40f+MB746uE00l5Va42HXVCzfWLuhtN06QBCJJhKoTsjMWOww
         r/ammwiKSEyL5mhtN+qWXz+AyJT21dZwZXT5ZveZ7Ru1rkg7vfePhBX1FPb8zcwg9iko
         W7fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Gc8W5S1Ur3wJ9TCtlMqhIuhs+JTASQlzSkw6Uribzpo=;
        b=tsLwqEsND5xrA37yn27IeynTSBn8kFxadQXxXupp3+ODXo3kScKtSVxGMPYl3yCrHX
         nVnIHPMhbxHc+cwaY67xlua9BUTunqI/iJ/7c8cHdli455MinN7OpH24bzkHJksMlIb4
         2C/xmCeUEq4ZYf1ohBgM9DFqJGfD27DdcmCjdwEXo987T0GU5wo2+EJ2msZvRDUxu9Ku
         ySwQ1pCuQJfg3+ltUW73NvqMJm3ZKbLaatCDH6xF63qwxKcshiDhnV/J1vDMf9d+/9wX
         OyHmO4mcXbyXTA0exMQTXGytOkpxe3p/NLxzySX50qS65G05t/+HSX9/xBt8kpvePr8u
         GDFA==
X-Gm-Message-State: APjAAAW6TfebahgxkrL3lkZXTwftKN2gMgEyliaQaSeTfHQ0OBLaoPQ4
        4kndxOXV/crFMQJqXYKy8h8=
X-Google-Smtp-Source: APXvYqxYe0iv7Ehxk//Vc86TGJ/zKBeixPPVxjeaczSSXJySWXAXnp+NpESZeD13tzUoWciyuq0Bww==
X-Received: by 2002:a63:e84d:: with SMTP id a13mr9970394pgk.274.1578551792132;
        Wed, 08 Jan 2020 22:36:32 -0800 (PST)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id d26sm5727483pgv.66.2020.01.08.22.36.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jan 2020 22:36:31 -0800 (PST)
From:   liuyang34 <yangliuxm34@gmail.com>
X-Google-Original-From: liuyang34 <liuyang34@xiaomi.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Richard Fontana <rfontana@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc:     liuyang34 <liuyang34@xiaomi.com>
Subject: [PATCH] x86: event, use scnprintf instead of snprintf
Date:   Thu,  9 Jan 2020 14:36:26 +0800
Message-Id: <5fc0611a37b6c73fb524b8469cced8fd4cefc6a1.1578550730.git.liuyang34@xiaomi.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1578550730.git.liuyang34@xiaomi.com>
References: <cover.1578550730.git.liuyang34@xiaomi.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

the return size will low than PAGE_SIZE but maybe over 40 in show_sysctl_tfa,
so use scnprintf instead of snprintf to get real size

Signed-off-by: liuyang34 <liuyang34@xiaomi.com>
---
 arch/x86/events/intel/core.c    | 6 +++---
 arch/x86/events/intel/pt.c      | 2 +-
 arch/x86/platform/uv/uv_sysfs.c | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 3be51aa..bf287b4 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4372,7 +4372,7 @@ static ssize_t show_sysctl_tfa(struct device *cdev,
 			      struct device_attribute *attr,
 			      char *buf)
 {
-	return snprintf(buf, 40, "%d\n", allow_tsx_force_abort);
+	return scnprintf(buf, 40, "%d\n", allow_tsx_force_abort);
 }
 
 static ssize_t set_sysctl_tfa(struct device *cdev,
@@ -4406,7 +4406,7 @@ static ssize_t branches_show(struct device *cdev,
 			     struct device_attribute *attr,
 			     char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%d\n", x86_pmu.lbr_nr);
+	return scnprintf(buf, PAGE_SIZE, "%d\n", x86_pmu.lbr_nr);
 }
 
 static DEVICE_ATTR_RO(branches);
@@ -4422,7 +4422,7 @@ static ssize_t pmu_name_show(struct device *cdev,
 			     struct device_attribute *attr,
 			     char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%s\n", pmu_name_str);
+	return scnprintf(buf, PAGE_SIZE, "%s\n", pmu_name_str);
 }
 
 static DEVICE_ATTR_RO(pmu_name);
diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 1db7a51..4ca7ed9 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -92,7 +92,7 @@ static ssize_t pt_cap_show(struct device *cdev,
 		container_of(attr, struct dev_ext_attribute, attr);
 	enum pt_capabilities cap = (long)ea->var;
 
-	return snprintf(buf, PAGE_SIZE, "%x\n", intel_pt_validate_hw_cap(cap));
+	return scnprintf(buf, PAGE_SIZE, "%x\n", intel_pt_validate_hw_cap(cap));
 }
 
 static struct attribute_group pt_cap_group __ro_after_init = {
diff --git a/arch/x86/platform/uv/uv_sysfs.c b/arch/x86/platform/uv/uv_sysfs.c
index 6221473..aa44c82 100644
--- a/arch/x86/platform/uv/uv_sysfs.c
+++ b/arch/x86/platform/uv/uv_sysfs.c
@@ -15,13 +15,13 @@ struct kobject *sgi_uv_kobj;
 static ssize_t partition_id_show(struct kobject *kobj,
 			struct kobj_attribute *attr, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%ld\n", sn_partition_id);
+	return scnprintf(buf, PAGE_SIZE, "%ld\n", sn_partition_id);
 }
 
 static ssize_t coherence_id_show(struct kobject *kobj,
 			struct kobj_attribute *attr, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%ld\n", uv_partition_coherence_id());
+	return scnprintf(buf, PAGE_SIZE, "%ld\n", uv_partition_coherence_id());
 }
 
 static struct kobj_attribute partition_id_attr =
-- 
2.7.4

