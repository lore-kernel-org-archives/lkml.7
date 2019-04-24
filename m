Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C12E3C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9335020685
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rjDLz9Sa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392106AbfDXRz0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:55:26 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42744 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390455AbfDXRzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:55:23 -0400
Received: by mail-pl1-f195.google.com with SMTP id x15so5293990pln.9;
        Wed, 24 Apr 2019 10:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CaQAymN7670xs/t0KNGu5btmxbdCn1nriXbjUUgfR7I=;
        b=rjDLz9SaSKV0ShBN8j5gnJGsloe3W61F1vCfHvg/oeNXhzOiyKWxDyjCfpN1YNU0s2
         nCOSAnR7/eVK1FaJu8oqElOsyyVjvvCI12Jq3BD37RCYV/meqim7pLD4qihd5ZP2Etd1
         VftIk3KV+GEKCwVBfX8vm+Pb0Uj37q7N4e+8lKee7MAjLJFf6GBxSPpRXrAg3fIW788E
         zotBcy2fZxk/MbEyYQ7npmf6M3S5OGSBOl8NLLgj738mW6TeiRnNKJzltX8zBo6V7j5a
         wciit0fHshuTHFuQjOXAI5e/5OoFoTmLYinDYqn9eiOwh/lCx96DTmHKwXEvUoPEgG/h
         mW9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CaQAymN7670xs/t0KNGu5btmxbdCn1nriXbjUUgfR7I=;
        b=ZHxpRTAMbBc5TSjm9znaAaEgUQGW8XJEwLXmP5FaloP6g0nA3O0zrlXXayBjLafLHH
         D1pVdQgL1F7HR605TFL5/dM7yUehZa48et0a7NVVHfk5w5kuxwAAfznNCfIFl421xc53
         DrZKAxmIlnbtNIhOTuFnC7mjWPbIgXx/Z6jeo04yuZZbtoegFjtw8TeNbiON7Z6cizTC
         T4M48cjo/Z/buIPUU+MMDcBH0RxYlvhz3jOLRSrwbDIohBJW6Jg/HTVMBPZ26NaMCqHS
         NOqG5UVh/OB2kkIngbBxyo3+S1q1DHjCgoTVzQ7EZRemnE06SyCzwGp+6RZ/xNh8YqB2
         yY+w==
X-Gm-Message-State: APjAAAXK3LZNA9NVB85m6cQg31t8ppHo6OHUvDUeSRoBVDYcJUuBZ6Zd
        V26mADmlCG5zE/eRtgiP+dY=
X-Google-Smtp-Source: APXvYqwp/3xOkC7K15I8gNCpycVbDjVWOEr7PvNCaNKJldNtuyXAkmwGSBgOaChAhsG1ZewEYrhx6g==
X-Received: by 2002:a17:902:be18:: with SMTP id r24mr32696902pls.69.1556128522749;
        Wed, 24 Apr 2019 10:55:22 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id 6sm29275630pfp.143.2019.04.24.10.55.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 10:55:22 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     rjw@rjwysocki.net, Jonathan Corbet <corbet@lwn.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org, mchehab+samsung@kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v5 10/23] Documentation: ACPI: move dsdt-override.txt to admin-guide/acpi and convert to reST
Date:   Thu, 25 Apr 2019 01:52:53 +0800
Message-Id: <20190424175306.25880-11-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190424175306.25880-1-changbin.du@gmail.com>
References: <20190424175306.25880-1-changbin.du@gmail.com>
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

