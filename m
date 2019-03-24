Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98302C10F05
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 00:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60B89217D8
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 00:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Spyy5rGW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbfCXA0o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 20:26:44 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41393 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727319AbfCXA0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 20:26:44 -0400
Received: by mail-pg1-f195.google.com with SMTP id k11so3948990pgb.8;
        Sat, 23 Mar 2019 17:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=dZhxDdC/Qe4tqiAOQJ+sInBhscxUK5dRSwY91CjQlSQ=;
        b=Spyy5rGW+mybuiFbAZSI3utxWF/QbLOVK0U/rl6IYo3mkRjCowmXiJYqJCUnab4Uns
         8AKSCgHNnuiS0A01agvJmQYCKtX+QdlgjGCWkJVdsXd7xBS1P1hYqqv3abm7HzUyl8EZ
         RDu3lYmVAbYBAwcuumFxOoQqnDZ+CB9wm+gp3LVubEggi85oMaDPd3hfA9Lu5E+7ar59
         5sqCofMA2/V4+OztSXTkTpjBoP3ff1LDFYBjLkHesDLdabNveX03sOnMlVQPo22JcNCI
         /lqVJvuID0K5KpKAN0S0ECW/qbi2O/QuQjoseBPVwm3UGOTsPHwz8tWLIDytBKGBfE8T
         Fn3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dZhxDdC/Qe4tqiAOQJ+sInBhscxUK5dRSwY91CjQlSQ=;
        b=OTleZJ32DDVGcU39itjsIgB8YRvo9Twhnt/G2U1kx1hBgcQBHGMnL8kJ3SuCUKqmxf
         4uy2rWTlhB63Ji6O46UhE1wiArnrL6uFA/f/m6Nw7z1lUK7f/lJs86nsG2J1ZrYt6Nmj
         IjuSRilMl8KkX1cmtEueP30Ew+16Vpxyjxi58BuFc7Xzo4qJHlZaRBMmHnL7Vn+avSo2
         rHpIlatWwvQnd8F31+nCLRn7wPEkKfCVhyD1Ct6WuG60DZ+H1qGaThixJmGuTWZ6HGCL
         Pe1p1NIlxtXn/BWzjkMN2X/vSNhs6+75nvrOgYp03iHpscCw1vLyX3uRwrf7OS/xcFpd
         q3pA==
X-Gm-Message-State: APjAAAUPdx2R0hyEcvC1mIl2/ubWxTHHF/FxCpomrfKcyEiPIPw3oXZG
        njFlDeTkXQT9IY5nI07svBM=
X-Google-Smtp-Source: APXvYqxyrNhoqmRR2GtyxXyh4QHs1sQA01swBbH3fdhsIXVAgug9si2QT0NvHqrJ27GM4ugiyutOzQ==
X-Received: by 2002:a17:902:8ecc:: with SMTP id x12mr5278077plo.0.1553387202877;
        Sat, 23 Mar 2019 17:26:42 -0700 (PDT)
Received: from linux-l9pv.suse ([124.11.22.254])
        by smtp.gmail.com with ESMTPSA id r66sm13737687pfr.131.2019.03.23.17.26.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 23 Mar 2019 17:26:41 -0700 (PDT)
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
        linux-kernel@vger.kernel.org, "Lee, Chun-Yi" <jlee@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH 1/2] efi: add a function for transferring status to string
Date:   Sun, 24 Mar 2019 08:26:20 +0800
Message-Id: <20190324002621.3551-1-jlee@suse.com>
X-Mailer: git-send-email 2.12.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function can be used to transfer EFI status code to string
for printing out debug message. Using this function can improve
the readability of log.

Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Anton Vorontsov <anton@enomsg.org>
Cc: Colin Cross <ccross@android.com>
Cc: Tony Luck <tony.luck@intel.com>
Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
---
 include/linux/efi.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/include/linux/efi.h b/include/linux/efi.h
index 54357a258b35..a43cb0dc37af 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1768,4 +1768,32 @@ struct linux_efi_memreserve {
 #define EFI_MEMRESERVE_COUNT(size) (((size) - sizeof(struct linux_efi_memreserve)) \
 	/ sizeof(((struct linux_efi_memreserve *)0)->entry[0]))
 
+#define EFI_STATUS_STR(_status) \
+case EFI_##_status: \
+	return "EFI_" __stringify(_status);
+
+static inline char *
+efi_status_to_str(efi_status_t status)
+{
+	switch (status) {
+	EFI_STATUS_STR(SUCCESS)
+	EFI_STATUS_STR(LOAD_ERROR)
+	EFI_STATUS_STR(INVALID_PARAMETER)
+	EFI_STATUS_STR(UNSUPPORTED)
+	EFI_STATUS_STR(BAD_BUFFER_SIZE)
+	EFI_STATUS_STR(BUFFER_TOO_SMALL)
+	EFI_STATUS_STR(NOT_READY)
+	EFI_STATUS_STR(DEVICE_ERROR)
+	EFI_STATUS_STR(WRITE_PROTECTED)
+	EFI_STATUS_STR(OUT_OF_RESOURCES)
+	EFI_STATUS_STR(NOT_FOUND)
+	EFI_STATUS_STR(ABORTED)
+	EFI_STATUS_STR(SECURITY_VIOLATION)
+	default:
+		pr_warn("Unknown efi status: 0x%lx", status);
+	}
+
+	return "Unknown efi status";
+}
+
 #endif /* _LINUX_EFI_H */
-- 
2.16.4

