Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2EC3C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 00:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F0BE217D8
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 00:26:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVUnQxOS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbfCXA0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 20:26:49 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37019 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727319AbfCXA0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 20:26:47 -0400
Received: by mail-pf1-f196.google.com with SMTP id 8so3930250pfr.4;
        Sat, 23 Mar 2019 17:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2i6I3aOV8fq5o+Rl5JqFM+suB9/ZJPZk88xNYv5hrs0=;
        b=MVUnQxOSAGdr6Jh3vFcFahSWploXSNtQn1jJwNS9KO8IghIuUB/6YvZTseAbfJQBVf
         oIkGh3xMnu3MBie7cErZ8l6zaX8Ml7fDBhpIlj1ZMCWEsfExrSEBt3grFWuC2Lxadlhp
         bgCf2kpB/M9t95GwL0vZi1mVfiwu/3z3xlS2xrkfBQkJ/Ylbm32BqVT31AZXEXjlpeKi
         f6jGmkEec4ZNfQZhNdbigZurQu3HwK4IE99LrD3VAjETfg4ayZIgvz9yKuJBhfWi9rwT
         WFZHCMLvdYr+keYhh98OHHY2eYQjCcxaYUgqb6e9ryOrh+kIwJxAy54PG7cn7ZPCG5Wj
         OzZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2i6I3aOV8fq5o+Rl5JqFM+suB9/ZJPZk88xNYv5hrs0=;
        b=GafPzLC6Wm2El2zGPPHDtX9Cpuon3VCGyOpdpFnP3QTdm5HWRkZ2g1d/bGCynQsfU5
         Cj4ErVBKEOiQ0oP94FgTdUJrh8hZNL5+fnaRyD3ixJcJX95Ka4Jj7tT+Z5IzK47pc6Nd
         hwngLTQ2FOQJiIaAKpgdPP3iKCcWTq/KseZkjZtqp0kHuf2+nDgTU8rckdDhiA8Qiq8I
         fZhtXcdKM/uV7rc/M2USwAxT6HiJU0u4WGfwKtS5pIkkXpaadqgEO3d021GR6C/HA6WP
         /lyQbbyx4Bad0d2oAOnD6eXJC18aIsiZ/OvGwIXU8xXgBFQdFVCOOxFcvv9dduPUPUsN
         st/A==
X-Gm-Message-State: APjAAAUTEDOvtRh7Zkj7PwfGxXSDSguZ+ah6leAdm3/Re4atJjuIv+Uw
        rsaktkxSHNWKmOs51FnRgsI=
X-Google-Smtp-Source: APXvYqzTXIOsMmnnHX4DZ63AVrE0memn6apWOPYHFHdHR8Lpj7T5zrGK1FrBVCQjV5naRmc3x0NJyA==
X-Received: by 2002:aa7:8144:: with SMTP id d4mr14647388pfn.88.1553387206789;
        Sat, 23 Mar 2019 17:26:46 -0700 (PDT)
Received: from linux-l9pv.suse ([124.11.22.254])
        by smtp.gmail.com with ESMTPSA id r66sm13737687pfr.131.2019.03.23.17.26.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 23 Mar 2019 17:26:46 -0700 (PDT)
From:   "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
X-Google-Original-From: "Lee, Chun-Yi" <jlee@suse.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        David Howells <dhowells@redhat.com>,
        Josh Boyer <jwboyer@fedoraproject.org>,
        Nayna Jain <nayna@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-efi@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Lee, Chun-Yi" <jlee@suse.com>
Subject: [PATCH 2/2 v2] efi: print appropriate status message when loading certificates
Date:   Sun, 24 Mar 2019 08:26:21 +0800
Message-Id: <20190324002621.3551-2-jlee@suse.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20190324002621.3551-1-jlee@suse.com>
References: <20190324002621.3551-1-jlee@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When loading certificates list from UEFI variable, the original error
message direct shows the efi status code from UEFI firmware. It looks
ugly:

[    2.335031] Couldn't get size: 0x800000000000000e
[    2.335032] Couldn't get UEFI MokListRT
[    2.339985] Couldn't get size: 0x800000000000000e
[    2.339987] Couldn't get UEFI dbx list

So, this patch shows the status string instead of status code.

On the other hand, the "Couldn't get UEFI" message doesn't need
to be exposed when db/dbx/mok variable do not exist. So, this
patch set the message level to debug.

v2.
Setting the MODSIGN messagse level to debug.

Link: https://forums.opensuse.org/showthread.php/535324-MODSIGN-Couldn-t-get-UEFI-db-list?p=2897516#post2897516
Cc: James Morris <jmorris@namei.org>
Cc: Serge E. Hallyn" <serge@hallyn.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Nayna Jain <nayna@linux.ibm.com>
Cc: Josh Boyer <jwboyer@fedoraproject.org>
Cc: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
---
 security/integrity/platform_certs/load_uefi.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/security/integrity/platform_certs/load_uefi.c b/security/integrity/platform_certs/load_uefi.c
index 81b19c52832b..e65244b31f04 100644
--- a/security/integrity/platform_certs/load_uefi.c
+++ b/security/integrity/platform_certs/load_uefi.c
@@ -48,7 +48,9 @@ static __init void *get_cert_list(efi_char16_t *name, efi_guid_t *guid,
 
 	status = efi.get_variable(name, guid, NULL, &lsize, &tmpdb);
 	if (status != EFI_BUFFER_TOO_SMALL) {
-		pr_err("Couldn't get size: 0x%lx\n", status);
+		if (status != EFI_NOT_FOUND)
+			pr_err("Couldn't get size: %s\n",
+				efi_status_to_str(status));
 		return NULL;
 	}
 
@@ -59,7 +61,8 @@ static __init void *get_cert_list(efi_char16_t *name, efi_guid_t *guid,
 	status = efi.get_variable(name, guid, NULL, &lsize, db);
 	if (status != EFI_SUCCESS) {
 		kfree(db);
-		pr_err("Error reading db var: 0x%lx\n", status);
+		pr_err("Error reading db var: %s\n",
+			efi_status_to_str(status));
 		return NULL;
 	}
 
@@ -155,7 +158,7 @@ static int __init load_uefi_certs(void)
 	if (!uefi_check_ignore_db()) {
 		db = get_cert_list(L"db", &secure_var, &dbsize);
 		if (!db) {
-			pr_err("MODSIGN: Couldn't get UEFI db list\n");
+			pr_debug("MODSIGN: Couldn't get UEFI db list\n");
 		} else {
 			rc = parse_efi_signature_list("UEFI:db",
 					db, dbsize, get_handler_for_db);
@@ -168,7 +171,7 @@ static int __init load_uefi_certs(void)
 
 	mok = get_cert_list(L"MokListRT", &mok_var, &moksize);
 	if (!mok) {
-		pr_info("Couldn't get UEFI MokListRT\n");
+		pr_debug("Couldn't get UEFI MokListRT\n");
 	} else {
 		rc = parse_efi_signature_list("UEFI:MokListRT",
 					      mok, moksize, get_handler_for_db);
@@ -179,7 +182,7 @@ static int __init load_uefi_certs(void)
 
 	dbx = get_cert_list(L"dbx", &secure_var, &dbxsize);
 	if (!dbx) {
-		pr_info("Couldn't get UEFI dbx list\n");
+		pr_debug("Couldn't get UEFI dbx list\n");
 	} else {
 		rc = parse_efi_signature_list("UEFI:dbx",
 					      dbx, dbxsize,
-- 
2.16.4

