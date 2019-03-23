Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E97AC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 08:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33B9E218D4
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 08:37:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="giHPCxeZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbfCWIh5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 04:37:57 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44946 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfCWIh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 04:37:57 -0400
Received: by mail-pf1-f193.google.com with SMTP id a3so3063224pff.11;
        Sat, 23 Mar 2019 01:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=dZhxDdC/Qe4tqiAOQJ+sInBhscxUK5dRSwY91CjQlSQ=;
        b=giHPCxeZobgKq8aImQf0H999zM+IUZ+e+sCYOMolaoEfZIvgRNEKb4dRq2QFcBa4Al
         vOPmtZmbipjp4cpBkWh1pu5FVKAlaxr6KaCg0TJc9+8Sc9w1W7ZxSuOTJEYWHMyJrRo3
         Lqkl4dhFM7KX2G0UvlWdyMZYjlxWC86qebDdSd7ZkheVsIR6QdzbRuPgCS47f7+Cw0f1
         HbEhMACbyo6JKQ3RRl2Oza3NDgBTpdD/EqL7iiOYerdePrbyB0QRBXeC0fdUZHhB0Ek7
         ElIFnvHmNlv4soQZM21lwguj+LbhbpyB5beGeE+PcyCF9x/Kq7YZmJ3xNgzZ6wbbCN9x
         2d4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dZhxDdC/Qe4tqiAOQJ+sInBhscxUK5dRSwY91CjQlSQ=;
        b=D7JphqqmMuehmvat6imE+DuMpZrAv7VttJAiAh0TywSnBD65EdVoWX2duc1DPG3azE
         R+McJbCDho2ueWPSnWo6BXvxrOkNZ+BIffHAeJsTZGXegS3tEClfqcuhR+VqZ98PgT/Y
         tzcvnWcXwZZ90UhmCa5qmMeeuNtU3aHioE7CcnwysU+iW9ko55Jaig8KAWwLOaT4148z
         1jKsQJS4+13sa3rk0os2/HQS9bOEQbLGh6fFPiPRBYEW1/HxSLZjIAEpjGzGM/Yv1Be+
         EISD/IHMiEUzZfctnpmsdbptYb3F5dYqaObDxtyCKTBMtrq3TLnRAANWu7wdJM2+Z0/z
         /w9Q==
X-Gm-Message-State: APjAAAW0RWYePPGjUBLLwI6Bn5o+JWXszA+r6gMIoMmFXoWLj1S4IRJo
        3/cVc190jUYrnWlt288Qfhc=
X-Google-Smtp-Source: APXvYqyAzBIficAWjTJuMxs8R+Flw5qqBplDztRcErwNuAvXLQacZ7Anjg1FWVFYVhH0vNIz1YYa4g==
X-Received: by 2002:a63:f558:: with SMTP id e24mr12826488pgk.373.1553330276199;
        Sat, 23 Mar 2019 01:37:56 -0700 (PDT)
Received: from linux-l9pv.suse ([124.11.22.254])
        by smtp.gmail.com with ESMTPSA id i79sm21373563pfj.28.2019.03.23.01.37.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 23 Mar 2019 01:37:55 -0700 (PDT)
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
Date:   Sat, 23 Mar 2019 16:37:23 +0800
Message-Id: <20190323083724.1367-1-jlee@suse.com>
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

