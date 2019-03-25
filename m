Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D8FFC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE01C2177E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WlInIGo7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731038AbfCYWKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 18:10:37 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:49172 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731003AbfCYWKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 18:10:32 -0400
Received: by mail-pf1-f201.google.com with SMTP id y2so10572390pfl.16
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 15:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=JjClfNcwudfjVo/9wlvsMTmCzUCPUTa4DRML2JJ7YVY=;
        b=WlInIGo7E8Sg1V/FJrdy7246BJfv2IFZBnZYy6waTznK9n+caw2TjPOhGfPZ703SMU
         HsdZZBq/cfCb9aUasck8HT2YGLHxCNOEM9Dn8gFGDuQRppgl9963pB2bWUbB3OdW0afz
         R9HQ+dGBSgtqfa4Llibc6rDd6MCdkBpPk9PllURgbs7CB/aHBVoZoDL9rJ67wbDYeM2+
         nkvuRWNqfMG3FM8h9H3EFUVkL8vF8uCHI4XGBEht/JE3ERIQt2oTW06JFFUZIo/C2MeG
         Gup11dIXcq1FY5/CF5EJkioM9JR9kP5hnhmiHGiydSEU3zr+pQBPM+64rv1Ip3uSVYPi
         STGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JjClfNcwudfjVo/9wlvsMTmCzUCPUTa4DRML2JJ7YVY=;
        b=d4buJcswOKo0I34wYLLmII0QUA/UynabJN9oEw3RcYP6ZFKmAvwQev1UQK1e/I58KQ
         yqyyI76ne45DeJFa2+XPVaqbsjg+H7inVyne1hCBplczbmEEjzspSNOqWQls+VvBtFlg
         3xBJFuoFFqhe2WW9mZCpKQ/B7Kda1J9XbJFS7k/WuDHz6pyMdHm8VNMEv5EvhAu/zM7z
         oqBdv8maoDaxvbOfzMbzXynNZdqkkQBnkdDsTwz3slsWh+vEV1dy0yPvzsGJFipxLxdx
         ap5tD0/rSyNFQKKVZ2LRJ3wOFdtFE6IyMXpSsxXf+nBYVnTRbb0/3DmrxiQmxMknpQeQ
         DhFw==
X-Gm-Message-State: APjAAAWyJJjtzMmgIZLVqctz8xmhKAGpElflogPy1WPsMZm6pWAnnXWp
        Bxir909Ep13X7Si0l0XHIfMFfQMGYaNL488EIhuvPw==
X-Google-Smtp-Source: APXvYqy+/HPWSggooyPKfCP9rCJAS540SEUMOaDvUBcRppcKI7iz6oLk3Dau8NiT2sBTzaxyaianjTm+/T/hLkd14AF0/g==
X-Received: by 2002:a63:6a45:: with SMTP id f66mr6790296pgc.7.1553551831630;
 Mon, 25 Mar 2019 15:10:31 -0700 (PDT)
Date:   Mon, 25 Mar 2019 15:09:40 -0700
In-Reply-To: <20190325220954.29054-1-matthewgarrett@google.com>
Message-Id: <20190325220954.29054-14-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190325220954.29054-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH 13/27] ACPI: Limit access to custom_method when the kernel is
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        linux-acpi@vger.kernel.org,
        Matthew Garrett <matthewgarrett@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Garrett <mjg59@srcf.ucam.org>

custom_method effectively allows arbitrary access to system memory, making
it possible for an attacker to circumvent restrictions on module loading.
Disable it if the kernel is locked down.

Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-acpi@vger.kernel.org
Signed-off-by: Matthew Garrett <matthewgarrett@google.com>
---
 drivers/acpi/custom_method.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/custom_method.c b/drivers/acpi/custom_method.c
index 4451877f83b6..ac8a90dc7096 100644
--- a/drivers/acpi/custom_method.c
+++ b/drivers/acpi/custom_method.c
@@ -29,6 +29,9 @@ static ssize_t cm_write(struct file *file, const char __user * user_buf,
 	struct acpi_table_header table;
 	acpi_status status;
 
+	if (kernel_is_locked_down("ACPI custom methods"))
+		return -EPERM;
+
 	if (!(*ppos)) {
 		/* parse the table header to get the table length */
 		if (count <= sizeof(struct acpi_table_header))
-- 
2.21.0.392.gf8f6787159e-goog

