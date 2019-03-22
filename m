Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76000C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 10:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46B1620850
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 10:34:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sdemoHNJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbfCVKeG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 06:34:06 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42819 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727985AbfCVKeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 06:34:05 -0400
Received: by mail-pg1-f194.google.com with SMTP id p6so1230077pgh.9;
        Fri, 22 Mar 2019 03:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XTYPASRGMg0q/uWZzsJSXvakCs0yqwCjmkSLykQSBrU=;
        b=sdemoHNJefqNMY39D7WWWxEJsg1U6wNnj5Cq/fU7JOZCKqJOtoia/qVwWjtz2SQPBt
         Mjv3qMaSiLjR5fyEtuyuJFrMggTGei9r1kmqGGy9EEZAuEXOfDjxAI9Bd+lmic8G8Diy
         U/u47rlm/5cOemYDNQpakBdsfhiEx0jh4wVJjdLIQKncGB6oMO8qGqhYBjMBw0nJMfAy
         G5+yAzEeSZ51U+fKlylDV85JjEa4C1CrVPaTuTJyiwflFBv2VRcYNGIWjGGaa7hrxc99
         LTB/AvWXPDSldI+djBDChTLnTsrRKJ7Y60cEk0CmRnO5FEtIqyJNbUm0RFeZ5oWGa9b+
         BzAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XTYPASRGMg0q/uWZzsJSXvakCs0yqwCjmkSLykQSBrU=;
        b=gpEVvBWRn3ofubF+Xhp46esHC5WNVfONJi5iGTZkDjeNroyZNmotRrTHfT5NQFSDt4
         1SDssRVcLB/aWjaw7SSBcBb2D9UKHqH3pKwyRkj8W9po/s8QWYfbbyyzh7eALWhU/hBg
         /ihi8ATx/XDAqbCmU5Z3bcoFRnTTcG4eGH+6jBYYF88TYtv1Z2S0q9AQ9Kp4WesaGAk8
         +9+4D8M0LJvqgEtSp8zWRThfiSCa50unsXKqivK/mL8efUsVSmroT5JWLtMA8nQ/vE7E
         TwnWtmkxv/JEg/3wRTAyFNcCAV/yw8gwnZDISLleJ9s9UBfJxbYhbT+RTg90F25ZjoxY
         VIeg==
X-Gm-Message-State: APjAAAXj5LV3PT/+GxTxw5VQxDohh25FigAqajOpFMDdO6jupJpb8cum
        QsqcrWLpIfJ81JN9X8i/7OU=
X-Google-Smtp-Source: APXvYqzPUdfWgIIlAW0XqLkR5mcW0Pb4CmOX0wux8eNkSVHoC6lUGnsTGnOTdO1nX26LI6GtHxdCNw==
X-Received: by 2002:aa7:92c1:: with SMTP id k1mr8443187pfa.246.1553250844332;
        Fri, 22 Mar 2019 03:34:04 -0700 (PDT)
Received: from linux-l9pv.suse ([202.47.205.198])
        by smtp.gmail.com with ESMTPSA id l7sm22276889pfj.162.2019.03.22.03.34.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 22 Mar 2019 03:34:03 -0700 (PDT)
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
Subject: [PATCH 2/2] efi: print appropriate status message when loading certificates
Date:   Fri, 22 Mar 2019 18:33:50 +0800
Message-Id: <20190322103350.27764-2-jlee@suse.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20190322103350.27764-1-jlee@suse.com>
References: <20190322103350.27764-1-jlee@suse.com>
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

On the other hand, the error message of EFI_NOT_FOUND
(0x800000000000000e) doesn't need to be exposed because kernel
already prints "Couldn't get UEFI..." message. This patch also
filtered out it.

Link: https://forums.opensuse.org/showthread.php/535324-MODSIGN-Couldn-t-get-UEFI-db-list?p=2897516#post2897516
Cc: James Morris <jmorris@namei.org>
Cc: Serge E. Hallyn" <serge@hallyn.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Nayna Jain <nayna@linux.ibm.com>
Cc: Josh Boyer <jwboyer@fedoraproject.org>
Cc: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
---
 security/integrity/platform_certs/load_uefi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/security/integrity/platform_certs/load_uefi.c b/security/integrity/platform_certs/load_uefi.c
index 81b19c52832b..fe261166621f 100644
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
 
-- 
2.16.4

