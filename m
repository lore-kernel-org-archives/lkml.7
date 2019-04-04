Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948B1C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 00:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6212020820
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 00:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HrnnfxtE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbfDDAdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 20:33:31 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:46943 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726966AbfDDAd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 20:33:28 -0400
Received: by mail-vk1-f202.google.com with SMTP id v82so435158vkd.13
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 17:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=aQw0KGeWmvPzPQJC9aCiMXHo5RCdIiAFpbvhdBtqfOA=;
        b=HrnnfxtEOmZgJzYuk+1NGAEVH3FcUFjd6/CBWrK13gcpvb388nqYaCopTOLyHeiL1d
         BKx8619edH1V2dmHSMJXG+k3mIUlblQzV2u/zO0e4fFTXaPhYH3qkk2oBZtOPkDf/pMH
         c54kprWqcu9bnxwX2huhYfWI0NK19dx+cOTVdTShh6O9RpDn5d1CRWLTj74UYSVkLfjk
         m9UNjHC3gaOX9OtPbO5zNNbbdyPtrCAFi3EKo2W41SCPOU88rp2S8NL6uCUmQdKvJubH
         3qMyUCCEogMiavG6CtQUFSXB3/s/iNE8LHMbqsYvZCIifSgPCsE7EMCoYzlvMPlip49W
         ZGow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=aQw0KGeWmvPzPQJC9aCiMXHo5RCdIiAFpbvhdBtqfOA=;
        b=PkMuZl5gMk3ScBORff2GjRQ5OfG6n432Yc3r8hwWwbtwPVxdnXH1ufWByZE7Rn36cq
         f6Qh3IUz2U7SgIJaCaGXnZIQwfu1a3snOp13yyLT1tRqgNOzpXyHzEcuFI9MPA+peGGl
         MK4kZYkzyEHjxBUpazhyh8rOZtuy2pr65GtowDQ5JgJx7HWET50rObOtfO/avTdg7ab/
         VrwGSNf17N8zVTZKO0bM2bWCGRWYdLO7ZkAsHX89vFB59R07x7EOfQeXM0Qgd0rmetTy
         1T0z/OPcRL0JGiSDIZXOsd/twHKHFkC6JAMgWJbEtRteaE5tLQe3ULLAk9wqkjsYXLYR
         DhPg==
X-Gm-Message-State: APjAAAXYtsKQHpousQFIiaqvh4I0RHNYhjSxmD6mDfO9dVDYph9KTbzS
        i6y15NuHfV9brvd0SVd+UA62vRoFLh1PyGmKbXY7pw==
X-Google-Smtp-Source: APXvYqwn9uDV4QCW3Ysw0OeGe8fuj1O+mbnQ+p5+YyWGjXPdgos0oC1yx4GJVCZSHMnrpHBueWMml8CLMI4YTuAGQGSUpA==
X-Received: by 2002:a1f:9010:: with SMTP id s16mr372950vkd.12.1554338007705;
 Wed, 03 Apr 2019 17:33:27 -0700 (PDT)
Date:   Wed,  3 Apr 2019 17:32:35 -0700
In-Reply-To: <20190404003249.14356-1-matthewgarrett@google.com>
Message-Id: <20190404003249.14356-14-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190404003249.14356-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH V32 13/27] ACPI: Limit access to custom_method when the kernel
 is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        linux-api@vger.kernel.org, luto@kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Matthew Garrett <mjg59@google.com>, linux-acpi@vger.kernel.org
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
cc: linux-acpi@vger.kernel.org
---
 drivers/acpi/custom_method.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/custom_method.c b/drivers/acpi/custom_method.c
index 4451877f83b6..37de3cd84493 100644
--- a/drivers/acpi/custom_method.c
+++ b/drivers/acpi/custom_method.c
@@ -29,6 +29,9 @@ static ssize_t cm_write(struct file *file, const char __user * user_buf,
 	struct acpi_table_header table;
 	acpi_status status;
 
+	if (kernel_is_locked_down("ACPI custom methods", LOCKDOWN_INTEGRITY))
+		return -EPERM;
+
 	if (!(*ppos)) {
 		/* parse the table header to get the table length */
 		if (count <= sizeof(struct acpi_table_header))
-- 
2.21.0.392.gf8f6787159e-goog

