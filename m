Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B0DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 23:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7E312133D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 23:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d9mbo5KR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387887AbfB1XMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 18:12:44 -0500
Received: from mail-oi1-f201.google.com ([209.85.167.201]:50160 "EHLO
        mail-oi1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387413AbfB1XMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 18:12:42 -0500
Received: by mail-oi1-f201.google.com with SMTP id a6so9663114oib.16
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 15:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=mp70BzDzYljwrYd25Lt2UYdTDnlpZHVvwxSHppwzPMQ=;
        b=d9mbo5KRuX/RDzSfaF9z9U/JVALls/m/pz/TIR77Q8r3FIN9dJSFVDfe7as12j9CYg
         qdZsexqPqnAnxNUev6Df6+SU06uOFjwvNupM5qThkzxUC15WeMpr/ddVBIPpUk/sshgT
         Yi5w8NjP8cW20UyrwtFhz2TyseSwRojDZ/w/dlGj8GGMfifKP/4bOXm+K2rOU8mgi9Cq
         APHC6H3pa3BlkFIFnpQhlTRcgtn6Jp9jwLbfbnead8KChCcHOpGUiD4PlmqMesuMwi2j
         FXGWgUQvqdOBu7336UXlYA4jKK7YzGfa7nW2nwCbZbMRZw9MYFvHqpRhaK7UJesHPJJz
         QcdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mp70BzDzYljwrYd25Lt2UYdTDnlpZHVvwxSHppwzPMQ=;
        b=ruhMBnxv2K9d7tPBxdrE4c2UGpgjM8etwyhFbtSaOIBvae2Kj4UtgqxoY70PSX23QN
         GtYBuwiBP4scQE5owhkPxoA5SEDOhQe1loVq5nPaj+hIaSBL0fONFJyK5BuTQzaM9Tf7
         X5C+4grJkwY01iadlX4dZlneIZM3LsSxtIFHnGk4PrBiENe9PvT0QbOdvgBNi3Mv0Kxa
         j2LNJBrBhnzhBFhMZwKgj8kj0AbnlgIyKYshWFvmwhrAlsapEYmuebz+Ftt2/j0ULiUK
         JrqTH9lGVunKppLR4enC5r3Z8mJLC/BZNDTCH7FMiMwzuVej37EfLsBssLN02P33BASY
         Ia1A==
X-Gm-Message-State: AHQUAuYBPJWZo1Nqka6oMGjK5SYbzfUUu2OqT6H+/AaAzXKgFdXbIDMI
        0Y5IqJ5Czj99lwAcrJ4CHJVOn6YuVZP/90UM9r6Z+A==
X-Google-Smtp-Source: AHgI3Ia5usj8LcdFU5Loh4aKXUNg08MNR91CW+JW/r9yGIg2PlSZhi9WN17w46ruHiIg35AKXfCS9vIsXAqcsDrlO7E+sQ==
X-Received: by 2002:aca:4b97:: with SMTP id y145mr1322685oia.19.1551395561327;
 Thu, 28 Feb 2019 15:12:41 -0800 (PST)
Date:   Thu, 28 Feb 2019 15:11:50 -0800
In-Reply-To: <20190228231203.212359-1-matthewgarrett@google.com>
Message-Id: <20190228231203.212359-14-matthewgarrett@google.com>
Mime-Version: 1.0
References: <CACdnJuvW47m3JvEcuEX1bsr+L2Ht9LDn_iCuPbHLOoaohOFW4Q@mail.gmail.com>
 <20190228231203.212359-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
Subject: [PATCH 14/27] ACPI: Limit access to custom_method when the kernel is
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

From: Matthew Garrett <mjg59@srcf.ucam.org>

custom_method effectively allows arbitrary access to system memory, making
it possible for an attacker to circumvent restrictions on module loading.
Disable it if the kernel is locked down.

Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: "Lee, Chun-Yi" <jlee@suse.com>
cc: linux-acpi@vger.kernel.org
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
2.21.0.352.gf09ad66450-goog

