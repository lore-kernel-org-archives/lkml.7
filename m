Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B466C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFDB620693
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fwFSXJZr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbfC1Q33 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 12:29:29 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40180 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbfC1Q32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 12:29:28 -0400
Received: by mail-pg1-f196.google.com with SMTP id u9so11843063pgo.7;
        Thu, 28 Mar 2019 09:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7j0CiSU3Iuu2nN0PWJDCw89ZwjR8GQiGqeVIF9bFSKg=;
        b=fwFSXJZr8f7bHU/9p7lebyJalCRQAzDstMGdCX/r9kAn0MUuU5K/GtJh2FpO89gZ8U
         ju4Q1JRA3IZaO+jdgMddBWG7ngp88RdMorRhPeafjLPQGm2T+USEDubCpPydvRZJW67j
         R+R2a2EAY9DnYZk6bNyEdga2G8v+67lmk6H3eAboLGACXN+CXpnjIhFjgNYoaA0T6kIJ
         A/XCJ5075U5kT7mmW1joV2qS4PPiEPOC0lQLg2Jny8Lt1Iq2c3sdycBKHV6iNCuNzyD5
         T+Fs1R+X+ZRlcImmcUcTj45asLylgPv97kBq2QFW5ql67Pvu8R4aVZ2hDphIjbjSeL/j
         ZnFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7j0CiSU3Iuu2nN0PWJDCw89ZwjR8GQiGqeVIF9bFSKg=;
        b=k9FHspEAIvx+geKVl372WsiUoZjL5NzK2w6cNoW8F8xYSQZBaDwYvZCS/EdeBNdCDC
         6WCxDYlUuMOFvem0Fu4YwQIm1GU2P4R39ocaSSeNFy4+YS3PGfDZHrZpg/4vNm8MYOVV
         YsDRQmB2VydeeuD8AAnHMKr9+fujx7iiccbdXRVKf+ub+VoxlvEp3WEAczxTkRjLWJfJ
         XFbrjPS9K9q/78xSvFIBBtqGegV62AIKcnp+oHvGbbFHnHZTLdyAE8Rd3lLRPUH5oFus
         NbxBOegb+Ffjg+7ITsjsbIbK5ihYGcagQ/GHZH7P2pvjBdBra1NlAOn4eQZ4isgijoYF
         A/NQ==
X-Gm-Message-State: APjAAAU7nHgzFuvcrbPifl6zwRWcR8QAN5NlDVsyuZVM3+T0c4hhS9FU
        vdEPR6P29W47sHm5H2qN+zkwwcvjT6s=
X-Google-Smtp-Source: APXvYqzPibBfa2lMqnmo6Zpm1FV26jsw52DI5o4Y39OJ81eKEMexuHLQh9v3RkR5dk/EBRrp0sVzEg==
X-Received: by 2002:a63:8143:: with SMTP id t64mr41828739pgd.301.1553790567597;
        Thu, 28 Mar 2019 09:29:27 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id y12sm42748885pgq.64.2019.03.28.09.29.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 09:29:26 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 11/23] acpi doc: convert acpi/dsdt-override.txt to rst format
Date:   Fri, 29 Mar 2019 00:27:09 +0800
Message-Id: <20190328162721.26138-12-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190328162721.26138-1-changbin.du@gmail.com>
References: <20190328162721.26138-1-changbin.du@gmail.com>
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
 Documentation/acpi/{dsdt-override.txt => dsdt-override.rst} | 6 +++++-
 Documentation/acpi/index.rst                                | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)
 rename Documentation/acpi/{dsdt-override.txt => dsdt-override.rst} (63%)

diff --git a/Documentation/acpi/dsdt-override.txt b/Documentation/acpi/dsdt-override.rst
similarity index 63%
rename from Documentation/acpi/dsdt-override.txt
rename to Documentation/acpi/dsdt-override.rst
index 784841caa6e6..77ecdc44bb2c 100644
--- a/Documentation/acpi/dsdt-override.txt
+++ b/Documentation/acpi/dsdt-override.rst
@@ -1,6 +1,10 @@
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
index 5ab8bad833f6..7701d4df614e 100644
--- a/Documentation/acpi/index.rst
+++ b/Documentation/acpi/index.rst
@@ -14,3 +14,4 @@ Linux ACPI (Advanced Configuration and Power Interface)
    scan_handlers
    method-customizing
    initrd_table_override
+   dsdt-override
-- 
2.20.1

