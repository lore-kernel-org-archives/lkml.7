Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A06C282DD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 00:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5279A217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 00:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrMX1ev3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729003AbfDXAQD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 20:16:03 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37915 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728948AbfDXAP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 20:15:57 -0400
Received: by mail-pf1-f193.google.com with SMTP id 10so8312816pfo.5;
        Tue, 23 Apr 2019 17:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Pycg9+C9bswcmRyU8TzuQlgStI2j8eLUrkh/YIs9LC4=;
        b=jrMX1ev3szbH4DubtpUrkgvcYCNA/Rz6ct/zFlbS4zNaCpStXfXHZZKefr9YCOy5Ec
         okmVPjfjwSt4enrIurZpPP6VZjxU5kyJx1XgC/S92+//L6oN6JQzyUCCrxMs02zEQnx1
         u65Y2E3pFFVtWvRJHU0w6NCDq2orkmoVYUZBmXsxws2x0vXiWPUYVVNY5JyGZjVfm/KB
         2BAAqqIjodcAaXQg8ZtlB/c19p3FZx58vcfvq3w1l+e6z64E4JJtI8CKf5I0HuV6drVN
         hgH6xel4ey59yEZ2yXJ4GTR4xSCfmc/p/wZ/5IogdP/TOUqW0n4kHSCovo9T0HT1OQm7
         JMug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Pycg9+C9bswcmRyU8TzuQlgStI2j8eLUrkh/YIs9LC4=;
        b=PDakXGP/ewfnS1PPAUdvbGbS2YilUnUMxfWaJGdqgvmyG/0WumYE0wzIiSNicAXT16
         zMmJsMXhvWfXRCLPSS7KNCFff8QMovNJQ5kdrqUfytDWSf01xtlYygMGYplDdZHK3VXw
         NQdVw9pd46e1QuffT1tcrOaht+hsWVT89W+H4VD7C28Kd8wqrr4kcXzS28DLiv3y8ix8
         M4eHENUrUO/eifaKIbsnTchvfYELXxnFA7i+SB8z+gz5603kllrv/lC+auCX1SFB1uzl
         Gd1HoGjelapHtAyj2egBqUxU/LwSfiIaAb60A6X7dsmPN3aSwFG98R2b0aIBIedjb+Og
         jfaw==
X-Gm-Message-State: APjAAAUSaNg2CMfVrBELuscdKPK42wEGkNhFywkMWG5gvTc1UbGnyOl3
        sTsM9YhfC1FKkcz00aVWP7cYu/lJv6o=
X-Google-Smtp-Source: APXvYqyB5ey/k+LdWtgC5yc8pCGHy1vIKxeiDszzqdgVr8q7n9T6blBkrp4NPkL85O4v4QvhsgoOrA==
X-Received: by 2002:a62:6807:: with SMTP id d7mr29268317pfc.75.1556064956523;
        Tue, 23 Apr 2019 17:15:56 -0700 (PDT)
Received: from prsriva-linux.corp.microsoft.com ([2001:4898:80e8:1:d4f:4d24:45fa:d461])
        by smtp.gmail.com with ESMTPSA id n21sm58955712pfb.42.2019.04.23.17.15.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 17:15:55 -0700 (PDT)
From:   Prakhar Srivastava <prsriva02@gmail.com>
X-Google-Original-From: Prakhar Srivastava
To:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        inux-security-module@vger.kernel.org
Cc:     zohar@linux.ibm.com, ebiederm@xmission.com, vgoyal@redhat.com,
        Prakhar Srivastava <prsriva02@gmail.com>,
        Prakhar Srivastava <prsriva@microsoft.com>
Subject: [PATCH v2 5/5 RFC] add the buffer to the event data in ima free entry data if store_template failed added check in templates for buffer
Date:   Tue, 23 Apr 2019 17:15:44 -0700
Message-Id: <20190424001544.7188-5-prsriva02@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190424001544.7188-1-prsriva02@gmail.com>
References: <20190424001544.7188-1-prsriva02@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Prakhar Srivastava <prsriva02@gmail.com>

Signed-off-by: Prakhar Srivastava <prsriva@microsoft.com>
---
Currently for soft reboot(kexec_file_load) the kernel file and
signature is measured by IMA. The cmdline args used to load the kernel
is not measured.
The boot aggregate that gets calculated will have no change since the
EFI loader has not been triggered.
Adding the kexec cmdline args measure and kernel version will add some
attestable criteria.

This patch adds the buffer to be measured as the event data.
this also contains changes necessary for template

 security/integrity/ima/ima_main.c         | 36 +++++++++++++++++++++--
 security/integrity/ima/ima_template_lib.c |  3 +-
 security/integrity/integrity.h            |  1 +
 3 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index da82c705a5ed..204a7a1acb86 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -14,7 +14,7 @@
  *
  * File: ima_main.c
  *	implements the IMA hooks: ima_bprm_check, ima_file_mmap,
- *	and ima_file_check.
+ *	ima_file_check and ima_buffer_check.
  */
 #include <linux/module.h>
 #include <linux/file.h>
@@ -180,16 +180,37 @@ static int process_buffer_measurement(const void *buff, int size,
 		struct ima_digest_data hdr;
 		char digest[IMA_MAX_DIGEST_SIZE];
 	} hash;
+	struct buffer_xattr {
+		enum evm_ima_xattr_type type;
+		u16 buff_length;
+		unsigned char buff[0];
+	};
 	char *name = NULL;
 	int violation = 0;
 	int pcr = CONFIG_IMA_MEASURE_PCR_IDX;
+	struct buffer_xattr *buffer_event_data = NULL;
+	int alloc_length = 0;
+	int action  = 0;
 
 	if (!buff || size ==  0 || !eventname)
 		goto err_out;
 
-	if (ima_get_action(NULL, 0, BUFFER_CHECK, &pcr) != IMA_MEASURE)
+	action = ima_get_action(NULL, 0, BUFFER_CHECK, &pcr);
+	if (!(action & IMA_AUDIT) && !(action & IMA_MEASURE))
 		goto err_out;
 
+	alloc_length = sizeof(struct buffer_xattr) + size;
+	buffer_event_data = kzalloc(alloc_length, GFP_KERNEL);
+	if (!buffer_event_data)
+		goto err_out;
+
+	buffer_event_data->type = IMA_BUFFER_CHECK;
+	buffer_event_data->buff_length = size;
+	memcpy(buffer_event_data->buff, buff, size);
+
+	event_data.xattr_value = (struct evm_ima_xattr_data *)buffer_event_data;
+	event_data.xattr_len = alloc_length;
+
 	name = eventname;
 	memset(iint, 0, sizeof(*iint));
 	memset(&hash, 0, sizeof(hash));
@@ -208,16 +229,25 @@ static int process_buffer_measurement(const void *buff, int size,
 	if (ret < 0)
 		goto err_out;
 
-	ret = ima_store_template(entry, violation, NULL,
+	if (action & IMA_MEASURE)
+		ret = ima_store_template(entry, violation, NULL,
 					buff, pcr);
+
 	if (ret < 0) {
 		ima_free_template_entry(entry);
 		goto err_out;
 	}
 
+	if (action & IMA_AUDIT)
+		ima_audit_measurement(iint, event_data.filename);
+
+	kfree(buffer_event_data);
 	return 0;
 
 err_out:
+
+	kfree(buffer_event_data);
+
 	pr_err("Error in adding buffer measure: %d\n", ret);
 	return ret;
 }
diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
index f9ba37b3928d..6050ef774355 100644
--- a/security/integrity/ima/ima_template_lib.c
+++ b/security/integrity/ima/ima_template_lib.c
@@ -322,7 +322,8 @@ int ima_eventsig_init(struct ima_event_data *event_data,
 	int xattr_len = event_data->xattr_len;
 	int rc = 0;
 
-	if ((!xattr_value) || (xattr_value->type != EVM_IMA_XATTR_DIGSIG))
+	if ((!xattr_value) || !((xattr_value->type == EVM_IMA_XATTR_DIGSIG) ||
+		 (xattr_value->type == IMA_BUFFER_CHECK)))
 		goto out;
 
 	rc = ima_write_template_field_data(xattr_value, xattr_len, fmt,
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 24520b4ef3b0..a674ae5be231 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -58,6 +58,7 @@ enum evm_ima_xattr_type {
 	EVM_XATTR_HMAC,
 	EVM_IMA_XATTR_DIGSIG,
 	IMA_XATTR_DIGEST_NG,
+	IMA_BUFFER_CHECK,
 	IMA_XATTR_LAST
 };
 
-- 
2.17.1

