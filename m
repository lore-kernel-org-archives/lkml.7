Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6165C76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 20:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA9082173B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 20:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zfkc7JwT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732892AbfGOUCQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 16:02:16 -0400
Received: from mail-yw1-f74.google.com ([209.85.161.74]:39282 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732443AbfGOUAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 16:00:31 -0400
Received: by mail-yw1-f74.google.com with SMTP id e12so14354888ywe.6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 13:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ZEWny5IFVoAY7+7cwG/iN1wA0h299zlUxTBItvDj0ts=;
        b=Zfkc7JwT5DU9z/o6qruZxUvtSG5dHseEY5MyWv9EfNowXWpECqNH74HmrCMpY6Lsun
         3lxELHqfkmTXqStjmCVEcrC3IDwxUkHckii/7WySAhjlykpTyjBF/liwYjw9UnL/kVae
         6ClWIRuDpOr2LvVMtLUJHKoWljg+4Ia5S3WKrOGk7PtbLhtvrFnyIgSOjTwxG00RrlCb
         3oWH8ea4VF9Ft1q0IQz4DKN+4VMPrFH5nCiC93O9QyydA33KSjv/A+IzI++Hmng0T7tw
         9HMZSl3RRI4QVLFy5s5SjteInYvM820efwrlprc802kSCOH8bjGGcPa4+zTPM19yVLAS
         8Lwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZEWny5IFVoAY7+7cwG/iN1wA0h299zlUxTBItvDj0ts=;
        b=b4bExlVb1kj9Hf1nlcLvftKFwVCYOMXA/gonUStGNrRLlvVWhPnEI8gYDquVD386s0
         PQlZqy6YB2/sJLEjqTjl0dXX9O/vQnBqDHvfgs5ff59UP4F+oTo7WL4DpYz/aXkaKk6k
         Ovalq4vqLaYg3CxwXOwu6Cm0uOfSWi1G/oDJI8dUPNRF1oUqcU8NlCCv9VpN/H5nNdcS
         Jvh1yoHXYTGlC4EjbpaIi1q87Kn7umJMm2dqp4gt1eVlVXx8QEbg5+gUG4h+cSEhgPhZ
         HCEkh345cqrDReIz6bJ/xphW04lqBAfyN/bC0mQWYfY00geFomXSJcruWezrNEO2wxnE
         qinw==
X-Gm-Message-State: APjAAAW/TWNjBptZMzCRocV2o6Fb5+JRZhjT5dJzExhj8pMC//HfEk6k
        6VNI5SAAL9dA3Ehz1+mVxlj0eV9g1bJj6FNx1wdRlQ==
X-Google-Smtp-Source: APXvYqyzP/ucQqITruoZ0U+xlf6n9TF8TcpzkJcXEBuAaYKylOcVnzZ/5O1mjzra9mVwgBw/6PyLE7/KRPqtyFMjsNtNrA==
X-Received: by 2002:a81:1d05:: with SMTP id d5mr15971402ywd.299.1563220830741;
 Mon, 15 Jul 2019 13:00:30 -0700 (PDT)
Date:   Mon, 15 Jul 2019 12:59:31 -0700
In-Reply-To: <20190715195946.223443-1-matthewgarrett@google.com>
Message-Id: <20190715195946.223443-15-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190715195946.223443-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH V35 14/29] ACPI: Limit access to custom_method when the kernel
 is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Matthew Garrett <mjg59@google.com>,
        David Howells <dhowells@redhat.com>,
        Kees Cook <keescook@chromium.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Garrett <mjg59@srcf.ucam.org>

custom_method effectively allows arbitrary access to system memory, making
it possible for an attacker to circumvent restrictions on module loading.
Disable it if the kernel is locked down.

Signed-off-by: Matthew Garrett <mjg59@google.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
cc: linux-acpi@vger.kernel.org
---
 drivers/acpi/custom_method.c | 6 ++++++
 include/linux/security.h     | 1 +
 security/lockdown/lockdown.c | 1 +
 3 files changed, 8 insertions(+)

diff --git a/drivers/acpi/custom_method.c b/drivers/acpi/custom_method.c
index b2ef4c2ec955..7031307becd7 100644
--- a/drivers/acpi/custom_method.c
+++ b/drivers/acpi/custom_method.c
@@ -9,6 +9,7 @@
 #include <linux/uaccess.h>
 #include <linux/debugfs.h>
 #include <linux/acpi.h>
+#include <linux/security.h>
 
 #include "internal.h"
 
@@ -29,6 +30,11 @@ static ssize_t cm_write(struct file *file, const char __user * user_buf,
 
 	struct acpi_table_header table;
 	acpi_status status;
+	int ret;
+
+	ret = security_locked_down(LOCKDOWN_ACPI_TABLES);
+	if (ret)
+		return ret;
 
 	if (!(*ppos)) {
 		/* parse the table header to get the table length */
diff --git a/include/linux/security.h b/include/linux/security.h
index 155ff026eca4..1c32522b3c5a 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -110,6 +110,7 @@ enum lockdown_reason {
 	LOCKDOWN_PCI_ACCESS,
 	LOCKDOWN_IOPORT,
 	LOCKDOWN_MSR,
+	LOCKDOWN_ACPI_TABLES,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index d99c0bee739d..67dbc5c70ea0 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -25,6 +25,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_PCI_ACCESS] = "direct PCI access",
 	[LOCKDOWN_IOPORT] = "raw io port access",
 	[LOCKDOWN_MSR] = "raw MSR access",
+	[LOCKDOWN_ACPI_TABLES] = "modified ACPI tables",
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
-- 
2.22.0.510.g264f2c817a-goog

