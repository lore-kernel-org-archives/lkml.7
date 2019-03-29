Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB5BC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 370C72075E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SXdZ/ZN0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbfC2ANC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 20:13:02 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37111 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728684AbfC2ANA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 20:13:00 -0400
Received: by mail-pf1-f195.google.com with SMTP id 8so153051pfr.4;
        Thu, 28 Mar 2019 17:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r4boFFMWy3Nm8uhZMBuL8bl1cmS3XYev1IbGdTJnkQA=;
        b=SXdZ/ZN0vkzGS0M63tx7hXiuXqwqJEqbTCYn4WvuYsU+uVgclS5ov+3WHBJfTkFFOS
         NwnQzrxdHTgqG/WFZqJX8lgKVQUAfunJoO04AJbIDVumXdqsuEi1cH3ez2X67ipk/Ofd
         Pw3pSuv6+tovhQVMQZz+xeLOCrF4NX8tOQ961rqbiSZ2zDJgMn0Mid0fN6KMKAuwzF39
         l5vct/2hhqjw6kNxpAJ3T9LI5tIO5hYHeWs1AEO8iXMKv/3YiAMT3XRIoYB5kOQMEENm
         f82OQu4PYE1VxICghFj7UWSAYaoajpzJG7F8/qG6nc5F8AQqsyKfJw42jD7+Zf5mu+rC
         B5AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r4boFFMWy3Nm8uhZMBuL8bl1cmS3XYev1IbGdTJnkQA=;
        b=cVDK+31rIT8Lk4f/O2n/JcFZT/BzfQZ9i2Bbf5agrNAo770uy+XCXDe9eMfaqrGbsr
         o+6eIdOWh0ecIhL4IsXMmY1edvP+P4rN9o5sC4dktXYym+IV+xdOLjRv7rmFmLYirK3a
         cwYnKWvgQ2he6S1Qxzs6Eoih0zgz151w5A0D0kbb2f3acuxzru/ocMi69VWNSufezVaB
         xoSP2gr4fkW8JwGq/D5FBHNB1pzJDNCJvI+ATafRbJAD2ijCXMhufem6yYiq35qfwhKj
         9V3CsgnxgBMYW+1wDjbF46FbncSFhCnIh7xlt3IE1tPUmULbRZQEeyeYQtQZCtZXsvFy
         Dg3Q==
X-Gm-Message-State: APjAAAVjOLV3NpF11w/4yNn2V468RiYba3nJZI/t6DoTuSs7mvTak+hX
        TqxslHHzOWEal7aOiuprpdg=
X-Google-Smtp-Source: APXvYqw7tSBDfXuv91Dnxu8Fsrpp0ahK0tytuuwZUnSZ0PtMWfNPwlQD2CvfyaYr1UkX7eqpC1Mc8g==
X-Received: by 2002:a65:6644:: with SMTP id z4mr42893157pgv.198.1553818379749;
        Thu, 28 Mar 2019 17:12:59 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id f125sm432488pfc.91.2019.03.28.17.12.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 17:12:59 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v2 11/24] acpi doc: convert acpi/dsdt-override.txt to rst format
Date:   Fri, 29 Mar 2019 08:11:22 +0800
Message-Id: <20190329001135.15847-12-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190329001135.15847-1-changbin.du@gmail.com>
References: <20190329001135.15847-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This converts the plain text documentation to reStructuredText format and
add it to Sphinx TOC tree. No essential content change.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 .../acpi/{dsdt-override.txt => dsdt-override.rst}         | 8 +++++++-
 Documentation/acpi/index.rst                              | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)
 rename Documentation/acpi/{dsdt-override.txt => dsdt-override.rst} (56%)

diff --git a/Documentation/acpi/dsdt-override.txt b/Documentation/acpi/dsdt-override.rst
similarity index 56%
rename from Documentation/acpi/dsdt-override.txt
rename to Documentation/acpi/dsdt-override.rst
index 784841caa6e6..50bd7f194bf4 100644
--- a/Documentation/acpi/dsdt-override.txt
+++ b/Documentation/acpi/dsdt-override.rst
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
diff --git a/Documentation/acpi/index.rst b/Documentation/acpi/index.rst
index 213c4601a42c..72fe855f567e 100644
--- a/Documentation/acpi/index.rst
+++ b/Documentation/acpi/index.rst
@@ -16,3 +16,4 @@ Linux ACPI (Advanced Configuration and Power Interface)
    scan_handlers
    method-customizing
    initrd_table_override
+   dsdt-override
-- 
2.20.1

