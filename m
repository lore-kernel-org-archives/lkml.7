Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CDCC10F03
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7A1420830
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WJr9K5Ng"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731052AbfCYWKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 18:10:38 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:53746 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731033AbfCYWKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 18:10:37 -0400
Received: by mail-pf1-f201.google.com with SMTP id o67so10569400pfa.20
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 15:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hmYNaFdsLzMxO/YCEIEvJsYLVrtmlenBIeDGJtGu3OM=;
        b=WJr9K5NgaEvPnAiYcVXgNCci/FaQmP1mLDAruGRbuoJYCIIIAIHCe8AoJ7Kr/r7XTQ
         GQw08DDyEUVpKvHTAEIb+sEPYXaATnoEYcMU6RUM1j1Tho9BRATvED8dklQVfey1WoCS
         5Zw2P9yQRsZ3CfcPkjLEJGSVsIfKaucUb4rie3Em8mgNadzfJUISMHz/jGWDE1Fa8RBq
         AE2BTFqdLHnL2BpGCs/nUCP1iEIBaaePrRAiduat/JTEYNX3z9pzJ+ITXdHdNLZkF0N4
         S8pT0CxX6x4PrXc7LM2QN3tHBFsDnMAzcAJRZmMLq007lOBsanWryVyF2DgZD6WVGgwW
         Iyhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hmYNaFdsLzMxO/YCEIEvJsYLVrtmlenBIeDGJtGu3OM=;
        b=A0slRVDSmJxXhpvLLPXUziJ/LuYgwo+fQFwl1M8ujEYWt6fU+Yivrwi952uTgzAIR3
         a7FgyBnLOCK8f+cxWSVIyp+ke6dS7VFvq0pXnVNExNQjiLmn1RD7SH1A853k4UstEg1x
         zgu5q1sYWLv6y8QqOm4PeN6k24WIDE+eyU95y93jkS/QIIXTd3OSUifBhEO1wTaBiD0X
         rXtAbYvYwOPIwRmzujOLCe9FW57DHpxxibnbVckOZCGUC0HmD5Sy/b+fcxE1+ZBuXDmd
         X+d89cqg5eLX3C+/yY0HLhOUPKGVAYoBE//e+Fyz9pMwTUTt5KWoykYCr1ReQqlOEJeS
         9iVA==
X-Gm-Message-State: APjAAAUR+Syqyygv0dLwUtFHff3HnxGOSU6jwmEPaxcNhv/OgX0roV4n
        6HMrn070y0FajMFjExXd95fN6ErvuGLrGNRY27zbog==
X-Google-Smtp-Source: APXvYqzfY5QZCxd8HlRriXAgwGnuI2xGeE8bqzN/WGpaom6jdlIsf/syZMyYGJEMLS58QanuSd8SJG/TxwADifrWkLpwHg==
X-Received: by 2002:a63:4e10:: with SMTP id c16mr26146963pgb.302.1553551836682;
 Mon, 25 Mar 2019 15:10:36 -0700 (PDT)
Date:   Mon, 25 Mar 2019 15:09:42 -0700
In-Reply-To: <20190325220954.29054-1-matthewgarrett@google.com>
Message-Id: <20190325220954.29054-16-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190325220954.29054-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH 15/27] acpi: Disable ACPI table override if the kernel is
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        Linn Crosetto <linn@hpe.com>, linux-acpi@vger.kernel.org,
        Matthew Garrett <matthewgarrett@google.com>
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
2.21.0.392.gf8f6787159e-goog

