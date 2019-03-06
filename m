Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8592C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 737DB20663
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RTrNjVLx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbfCGAAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 19:00:10 -0500
Received: from mail-oi1-f202.google.com ([209.85.167.202]:39911 "EHLO
        mail-oi1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbfCGAAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 19:00:08 -0500
Received: by mail-oi1-f202.google.com with SMTP id u132so7277951oif.6
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 16:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=VGdoKwvSOpDfBZXQlfYkzECG5jzVJCUvh3oP5CjQxIk=;
        b=RTrNjVLxRZTgAOBWsuKxkprHBBIqH7DjzBBpSZ7zQaQvDgTODrf7K0sFB9SUJRlT7e
         nrhZ2WsILQ0S8qG1E11K49GiC0Ap915AQ3z07gV7UXjsAVQsZQGCrnM/EauC6Kr9jLQm
         1jMsZ8KUgIipeXp3iPgZURAieKlLWPBY/rRglPTe5asNog9rVGmQpJZ9A+RiSfA5S4sH
         QmzdOSdUvGjhm+mK9M7CoaoT0v+Gixaz5/+r4AaO/ypu1URtdl2Bh09k+mVxnj8YFqoF
         XA3qj2pwgStFGwNo6JJx84TB9t/L1s4Wjjc+fs07jfWOK+UD2/JHe26Bzm+zQ2MwR6qO
         JT3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VGdoKwvSOpDfBZXQlfYkzECG5jzVJCUvh3oP5CjQxIk=;
        b=hzcr23FVdAQhY1VuNJhBRG8Dxj8VJD/dNjKxwF568UEnyyu8Kgh/pny6AzhnPPRCPe
         9uTY06l7C9zX/uMH2J+d5jbwUeVM7r+0negiCB85fRxnaF/9kNs0RLBWjmajNR2sEUhZ
         nLej8kRXn5wzfKCfePSnN4Wg4vJVkjqYjnb8HglkNJChoCKCCwkiQQ7woSKJtJPpwuNa
         GzsM+odCVUDOSIp9eUqR9m+TumEueIXCnQbhY273S6wBUXqd58ZBJTnuVvigLd6QdIus
         efg0l0valJxLF4v/H9qmnTfBHqdTIt5X49svGpCbUQDC22Q7e19MPCft0jtVntPKZCxI
         jrZQ==
X-Gm-Message-State: APjAAAXCvnP72QjSr6b7WCnL4IC9xvoHbwKxJqvBWDw7yCqSkeFfOuZJ
        b/KxcMRoK+fZaBKs7I+dgZ2eRR8UPOP0+FQPrp0Zhg==
X-Google-Smtp-Source: AHgI3IbIQfs+qlNy04rRIbGGwZDV+GAve/Dbcrar2+5Zcfjm3N+32fWe55odB5OSUTGnTk7bWqpelKzk1jsptguY8gxWHg==
X-Received: by 2002:aca:4e93:: with SMTP id c141mr18809217oib.27.1551916807574;
 Wed, 06 Mar 2019 16:00:07 -0800 (PST)
Date:   Wed,  6 Mar 2019 15:59:02 -0800
In-Reply-To: <20190306235913.6631-1-matthewgarrett@google.com>
Message-Id: <20190306235913.6631-17-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190306235913.6631-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
Subject: [PATCH 16/27] acpi: Disable ACPI table override if the kernel is
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linn Crosetto <linn@hpe.com>

From the kernel documentation (initrd_table_override.txt):

  If the ACPI_INITRD_TABLE_OVERRIDE compile option is true, it is possible
  to override nearly any ACPI table provided by the BIOS with an
  instrumented, modified one.

When securelevel is set, the kernel should disallow any unauthenticated
changes to kernel space.  ACPI tables contain code invoked by the kernel,
so do not allow ACPI tables to be overridden if the kernel is locked down.

Signed-off-by: Linn Crosetto <linn@hpe.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: "Lee, Chun-Yi" <jlee@suse.com>
cc: linux-acpi@vger.kernel.org
Signed-off-by: Matthew Garrett <matthewgarrett@google.com>
---
 drivers/acpi/tables.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 48eabb6c2d4f..f3b4117cd8f3 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -531,6 +531,11 @@ void __init acpi_table_upgrade(void)
 	if (table_nr == 0)
 		return;
 
+	if (kernel_is_locked_down("ACPI table override")) {
+		pr_notice("kernel is locked down, ignoring table override\n");
+		return;
+	}
+
 	acpi_tables_addr =
 		memblock_find_in_range(0, ACPI_TABLE_UPGRADE_MAX_PHYS,
 				       all_tables_size, PAGE_SIZE);
-- 
2.21.0.352.gf09ad66450-goog

