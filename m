Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E94DC32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7654D2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="MLb+AaSc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbfGaPJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 11:09:05 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33641 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388614AbfGaPIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 11:08:32 -0400
Received: by mail-ed1-f65.google.com with SMTP id i11so2524968edq.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 08:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zVlcJDBaDTqmSz97nQxl4DvHh1B1aL9m42IztWqYpgk=;
        b=MLb+AaScf0hGsrpPSDd87+yWF18Ne5YphyrJDosl5qgEGBpjx5dqprcz8D6TDurakx
         v7dksS8vdyH98KwRfDrtg/ZbAe6E5vhUhxog7UiBo5/z7ZxDluJryzZrq7ii40mFem3i
         jMx9cmbPY8ZVw9geHuaHGUyOzRRTLmVrMwDlEzypgFsoq1OKR/Xmb+uMJ6IghodwNO1n
         RZiP1ftmR0Lj/uf8ewWim1E6GUd1B5u7cpUbveVRjMCNi8uIaEVIr/L9O6TQUka6NeYB
         zDwBJBoONjQlX/jht6jQVRNO6og/Cy7j8akyt5hXZpmDzorFoOnlfMMXa/CagiuWGoH+
         adxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zVlcJDBaDTqmSz97nQxl4DvHh1B1aL9m42IztWqYpgk=;
        b=O9PYY0aUhDPKAWYPoC+iYTjNIzI7yaNjWqHoRViOt8EY7Yb5z+yQaXxgdidSt7MjUE
         23q9baJseTJUBBTm0E07VhdzYYPFVZ6oUKOhnLMTi5s6Q/RYtTm6LRqtVbU1vz70nWC2
         jLuuRdcKE7GvUgwjUcvjawbiYd83ogDQg7Rr63/+YSPfDHDGZxcBvBPe+khBkRW9h0qc
         MvKB47Y8Xc6cCtMzPyIcWPSqpX6K0duGRAkN7CSjngPa7JGCBecvCFncmoTDHM4qt0TC
         nobAZt1LLaj3he6bDo9PGmJaSQbfyN41TZrfC/qyzECpsEWVIdRCo5elHn7cI702p/m4
         1aCw==
X-Gm-Message-State: APjAAAUSn1qH6+EgmmLUqjF5pjQL2QsLcZRrrzIJ9j4m5irsjibJQrDT
        Dujb5mMCszPDp3U+NM1GqmMC5plb
X-Google-Smtp-Source: APXvYqyr56BhZiXrSd8f2fq+Z375JbAoHMRws8MKCqxmheMr9Uoh5vHG5eCnsq/pE6efizao1axriw==
X-Received: by 2002:a05:6402:3d5:: with SMTP id t21mr107048118edw.13.1564585710210;
        Wed, 31 Jul 2019 08:08:30 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id s2sm5403001ejf.11.2019.07.31.08.08.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 08:08:28 -0700 (PDT)
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
X-Google-Original-From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Received: by box.localdomain (Postfix, from userid 1000)
        id E8A5B1045FA; Wed, 31 Jul 2019 18:08:16 +0300 (+03)
To:     Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@amacapital.net>,
        David Howells <dhowells@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Kai Huang <kai.huang@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        linux-mm@kvack.org, kvm@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv2 36/59] keys/mktme: Require ACPI HMAT to register the MKTME Key Service
Date:   Wed, 31 Jul 2019 18:07:50 +0300
Message-Id: <20190731150813.26289-37-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190731150813.26289-1-kirill.shutemov@linux.intel.com>
References: <20190731150813.26289-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

The ACPI HMAT will be used by the MKTME key service to identify
topologies that support the safe programming of encryption keys.
Those decisions will happen at key creation time and during
hotplug events.

To enable this, we at least need to have the ACPI HMAT present
at init time. If it's not present, do not register the type.

If the HMAT is not present, failure looks like this:
[ ] MKTME: Registration failed. ACPI HMAT not present.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 security/keys/mktme_keys.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/security/keys/mktme_keys.c b/security/keys/mktme_keys.c
index 2d90cc83e5ce..6265b62801e9 100644
--- a/security/keys/mktme_keys.c
+++ b/security/keys/mktme_keys.c
@@ -2,6 +2,7 @@
 
 /* Documentation/x86/mktme/ */
 
+#include <linux/acpi.h>
 #include <linux/cred.h>
 #include <linux/cpu.h>
 #include <linux/init.h>
@@ -445,6 +446,12 @@ static int __init init_mktme(void)
 
 	mktme_available_keyids = mktme_nr_keyids();
 
+	/* Require an ACPI HMAT to identify MKTME safe topologies */
+	if (!acpi_hmat_present()) {
+		pr_warn("MKTME: Registration failed. ACPI HMAT not present.\n");
+		return -EINVAL;
+	}
+
 	/* Mapping of Userspace Keys to Hardware KeyIDs */
 	mktme_map = kvzalloc((sizeof(*mktme_map) * (mktme_nr_keyids() + 1)),
 			     GFP_KERNEL);
-- 
2.21.0

