Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C5EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 10:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FA0620850
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 10:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ElTP5n1w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbfCVKeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 06:34:01 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44085 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727739AbfCVKeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 06:34:01 -0400
Received: by mail-pg1-f195.google.com with SMTP id i2so1223444pgj.11;
        Fri, 22 Mar 2019 03:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=dZhxDdC/Qe4tqiAOQJ+sInBhscxUK5dRSwY91CjQlSQ=;
        b=ElTP5n1wpgt0y5iAgi21gAuo0spGZDqhq68weaFLRtb/NTJpNuS/SmTJuodnaovfNb
         s8QfcHzkt0JFGkh3dWrXzyp9fvNSOvsFNBO6AU6KMU4iBwBZzBWvSVKZfdy5rlGa7w7y
         B+8iLCF5LgWAHKQ1K4RHmOMR+KONTWv9YpQbD94sWrs51PHlZS0PR1MSLxqEIWYUzfFS
         yk5losiWqVwmIfSEXhE8oh0ZOD2LbyZwSLsu3BteUR15Rcr416lbZYBELexaKKn0Ci1i
         Q0aKFXMWirJXl2YZp6qXEphFJuwkrWiVuUrFdPidx82fg2q8sUeaY98BvmB0vpb7Un8v
         OFFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dZhxDdC/Qe4tqiAOQJ+sInBhscxUK5dRSwY91CjQlSQ=;
        b=py4q7EGWJ2ZWWx+ckg1So/9l6rSIL9tE+yaHHIrdpuFJdOU4xaHW6r/5ax2VIPi+hp
         34E9XTh0jCTJHhokWMZaJwyOONg0VbAl6VaeITZ+Tz2wbwyFOvI2OYse7umB6qDLgp1c
         57aduKqX8qeY6sZCS6uD07FMhA58/an1cPEv5HTyfUjPNdkz4efejxjnoMUfG2z1NcxU
         4t5wHn2aJFGczZLS6drl1nGiYjKF/rGwlmWCsmUe2dKHfWyDoCk1J7RQt4q9ex2uS9lm
         KQFAFBokJNubDhaL6BH2/x9Cw5UazZo8YgHprKipS3+caX37FSrCLqVbrXkj+iEvXdGu
         mNRw==
X-Gm-Message-State: APjAAAVh0ULpej+4RRtZm7S4zcXA2H7mKFDc59eNBOPdtSz2Mo3b9hyX
        w/+5ztu5iLcjXvnLEjjNYoA=
X-Google-Smtp-Source: APXvYqzFJDtBWBT3GBBFqyLcyjpgdZ0DyM2Oh+tkI21b/hNCJ5Z10Wo4bnls5DBP/C+epVuShVOwvw==
X-Received: by 2002:aa7:8b93:: with SMTP id r19mr8223640pfd.163.1553250840143;
        Fri, 22 Mar 2019 03:34:00 -0700 (PDT)
Received: from linux-l9pv.suse ([202.47.205.198])
        by smtp.gmail.com with ESMTPSA id l7sm22276889pfj.162.2019.03.22.03.33.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 22 Mar 2019 03:33:59 -0700 (PDT)
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
Date:   Fri, 22 Mar 2019 18:33:49 +0800
Message-Id: <20190322103350.27764-1-jlee@suse.com>
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

