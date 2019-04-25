Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D71C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33BB1206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:32:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EoeLbePD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729855AbfDYPcl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 11:32:41 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36989 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729689AbfDYPcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 11:32:39 -0400
Received: by mail-pg1-f195.google.com with SMTP id e6so35375pgc.4;
        Thu, 25 Apr 2019 08:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CaQAymN7670xs/t0KNGu5btmxbdCn1nriXbjUUgfR7I=;
        b=EoeLbePDtb/Yr7j7aqcMDgSLyFG2JcA8uqLWiGExLunJmpV2qOxREsOZ9vM3/w1UnR
         Tz/RkIdPtCvhX4cQQ3yXJZbuOmolFOtacMAN6U1sbUf04z1g6irHZJbdwMLxIah1q8BG
         ldfYTY5vgQI7JD0h0J1kUo6up9aI6ktzMV+VwrdV6CnvB2Aar+SiA5++y/qKmwbW4khL
         6G4cs0pP/UMiydahDBTusIZa/nHIBnpJ9AlhfVOAwCBPo/XYB1YsPKGeavJ5Bg5oLOzm
         kim2O3FLLNbeBqeKFhLoBfOj3CvuHIvkRiQU4ZTP3HBNEz1nLWBZKuRTcbX/ZlXzkF+V
         g2Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CaQAymN7670xs/t0KNGu5btmxbdCn1nriXbjUUgfR7I=;
        b=CUeuVB8VJjcYHEzQzBT7bLXLXDw/EmqK8o6a7V9rq8AfQ/3EwxgmwTXqD69CZwlUDV
         flafqZ0FE+QpvSNOKxX18jeJz2/mIfSWJNXZybtKOtmZ1s9kXtG4f76s+HCDn3W22mdO
         aTULMaf1ighveEoSHvwBXwRVKHPJDo6NRXh2g/iz2ZiQzxfs8fq3RaD4IJVyd7f6CsKS
         ZujSVBYctbyhNYiA+P7qZPVbB6dzdRfnJpSBJbackpsBCyqn54v+u64PoKR+62KyIWMD
         mv6VWR7UdIiobbaig8rLQp6zpBupIQZfz9zt3V+EBJV8vEhNWwZfu9eTuJbwJfDZ85QG
         soOw==
X-Gm-Message-State: APjAAAXzOJm7oK51yJgxScg20OjxiJXL76NCHCptAyFApIOz5CegkVB3
        +Yb6buHQ0AXdmIBvc4y44xE=
X-Google-Smtp-Source: APXvYqwu8IO/JcftwC6o2OO6yOkDsJw7boJEkhDfJjmmT1Gcs9QRkUNd/O8RephW2yg3Vg4Hv5WB6A==
X-Received: by 2002:a65:6205:: with SMTP id d5mr2463274pgv.61.1556206358681;
        Thu, 25 Apr 2019 08:32:38 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id c14sm2643363pgj.94.2019.04.25.08.32.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 08:32:37 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     rjw@rjwysocki.net, Jonathan Corbet <corbet@lwn.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org, mchehab+samsung@kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v6 11/24] Documentation: ACPI: move dsdt-override.txt to admin-guide/acpi and convert to reST
Date:   Thu, 25 Apr 2019 23:31:04 +0800
Message-Id: <20190425153117.16057-12-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190425153117.16057-1-changbin.du@gmail.com>
References: <20190425153117.16057-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This converts the plain text documentation to reStructuredText format and
add it to Sphinx TOC tree. No essential content change.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 .../acpi/dsdt-override.rst}                               | 8 +++++++-
 Documentation/admin-guide/acpi/index.rst                  | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)
 rename Documentation/{acpi/dsdt-override.txt => admin-guide/acpi/dsdt-override.rst} (56%)

diff --git a/Documentation/acpi/dsdt-override.txt b/Documentation/admin-guide/acpi/dsdt-override.rst
similarity index 56%
rename from Documentation/acpi/dsdt-override.txt
rename to Documentation/admin-guide/acpi/dsdt-override.rst
index 784841caa6e6..50bd7f194bf4 100644
--- a/Documentation/acpi/dsdt-override.txt
+++ b/Documentation/admin-guide/acpi/dsdt-override.rst
@@ -1,6 +1,12 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===============
+Overriding DSDT
+===============
+
 Linux supports a method of overriding the BIOS DSDT:
 
-CONFIG_ACPI_CUSTOM_DSDT builds the image into the kernel.
+CONFIG_ACPI_CUSTOM_DSDT - builds the image into the kernel.
 
 When to use this method is described in detail on the
 Linux/ACPI home page:
diff --git a/Documentation/admin-guide/acpi/index.rst b/Documentation/admin-guide/acpi/index.rst
index 09e4e81e4fb7..d68e9914c5ff 100644
--- a/Documentation/admin-guide/acpi/index.rst
+++ b/Documentation/admin-guide/acpi/index.rst
@@ -9,3 +9,4 @@ the Linux ACPI support.
    :maxdepth: 1
 
    initrd_table_override
+   dsdt-override
-- 
2.20.1

