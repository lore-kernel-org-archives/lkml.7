Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3767EC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0216C20685
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rC7PI+Um"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392487AbfDXR6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:58:40 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42645 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392551AbfDXR4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:56:41 -0400
Received: by mail-pg1-f194.google.com with SMTP id p6so9740367pgh.9;
        Wed, 24 Apr 2019 10:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2sbwg0L9RWIY1yx4og9yDX54LDcD6lm1qQ96G7LSClM=;
        b=rC7PI+Umnb6CVvmFeTKMN7ISacQYIp5JWx7K4j+/MoThvTNXN7DKRPDYZuFRkx+xej
         i0m/SbyBO9wpeuFH4CZdqx+d1RsRX5A3vKccF2xgH0FzdffvCXrm3/kABVs47nkmtaln
         EcKhcVUokYPdQZoTiF9Gg3+or+ZiiYZAh2+HFADT9Qgb+JtdjJV/7YZxzfvBkInJerJh
         rNInXK1LJnOkyWXRdP7XJc6/mONGEuE6LWnaVJNcHp4cuZYpPiSVfBLNQzSruieHcGnT
         mCOAjxpnEUDx49BadZbt5sGCu5y66Jol1LNsT2o/ll4OQb9ja496PorsMm8XSlXZ7FpO
         9gCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2sbwg0L9RWIY1yx4og9yDX54LDcD6lm1qQ96G7LSClM=;
        b=ku3rjnuEOJBnf8NxDBwW+HC5ZmEqxhbd+CpCCrhCqo+Qt7L+S5VUWrnwZra1HyT8YY
         4hf5nZSd9RhKB1s7U3BFjoyZijv/w3ELrpJf0umyPE0cLThaUkrG8l4I5GVHnhpjyrKg
         Bw9j040z+2lr6E1eboLXRQfvjVl/KOJc4RDVpMsEByYo/oNWnuh7N0ZlQUldvfAiaR1H
         2MY369UPPIQbm2nbveRZp9ymoZ2dmYKU2h3jcdnmIEmF1TDGRiKFghTF9grxtCTJiPR6
         6+KojlunYUnIa2rgDXLg1AWWHsA0JImvIJfTaXrXH4poLekiEHNwinFyBqAf2KcRaK52
         MqGw==
X-Gm-Message-State: APjAAAV2SBG4tmVrOQq67u6xKWKuW7RJhofB7T6F4tZRPdwOlQLeRonV
        jlrt+7PhGM3DjRnetoHFxrE=
X-Google-Smtp-Source: APXvYqywpPJKgOpReGTP1RB2uUK+F9Ux/BhvqcLVN+Jg1BljPXHsv5ehNjMc0Jn3B4Fqjhdhhl/qhw==
X-Received: by 2002:a63:d10:: with SMTP id c16mr19643000pgl.156.1556128600687;
        Wed, 24 Apr 2019 10:56:40 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id 6sm29275630pfp.143.2019.04.24.10.56.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 10:56:39 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     rjw@rjwysocki.net, Jonathan Corbet <corbet@lwn.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org, mchehab+samsung@kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v5 21/23] Documentation: ACPI: move lpit.txt to firmware-guide/acpi and convert to reST
Date:   Thu, 25 Apr 2019 01:53:04 +0800
Message-Id: <20190424175306.25880-22-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190424175306.25880-1-changbin.du@gmail.com>
References: <20190424175306.25880-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
 Documentation/firmware-guide/acpi/index.rst    |  1 +
 .../lpit.txt => firmware-guide/acpi/lpit.rst}  | 18 +++++++++++++-----
 2 files changed, 14 insertions(+), 5 deletions(-)
 rename Documentation/{acpi/lpit.txt => firmware-guide/acpi/lpit.rst} (68%)

diff --git a/Documentation/firmware-guide/acpi/index.rst b/Documentation/firmware-guide/acpi/index.rst
index fca854f017d8..0e60f4b7129a 100644
--- a/Documentation/firmware-guide/acpi/index.rst
+++ b/Documentation/firmware-guide/acpi/index.rst
@@ -22,3 +22,4 @@ ACPI Support
    gpio-properties
    i2c-muxes
    acpi-lid
+   lpit
diff --git a/Documentation/acpi/lpit.txt b/Documentation/firmware-guide/acpi/lpit.rst
similarity index 68%
rename from Documentation/acpi/lpit.txt
rename to Documentation/firmware-guide/acpi/lpit.rst
index b426398d2e97..aca928fab027 100644
--- a/Documentation/acpi/lpit.txt
+++ b/Documentation/firmware-guide/acpi/lpit.rst
@@ -1,3 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===========================
+Low Power Idle Table (LPIT)
+===========================
+
 To enumerate platform Low Power Idle states, Intel platforms are using
 “Low Power Idle Table” (LPIT). More details about this table can be
 downloaded from:
@@ -8,13 +14,15 @@ Residencies for each low power state can be read via FFH
 
 On platforms supporting S0ix sleep states, there can be two types of
 residencies:
-- CPU PKG C10 (Read via FFH interface)
-- Platform Controller Hub (PCH) SLP_S0 (Read via memory mapped interface)
+
+  - CPU PKG C10 (Read via FFH interface)
+  - Platform Controller Hub (PCH) SLP_S0 (Read via memory mapped interface)
 
 The following attributes are added dynamically to the cpuidle
-sysfs attribute group:
-	/sys/devices/system/cpu/cpuidle/low_power_idle_cpu_residency_us
-	/sys/devices/system/cpu/cpuidle/low_power_idle_system_residency_us
+sysfs attribute group::
+
+  /sys/devices/system/cpu/cpuidle/low_power_idle_cpu_residency_us
+  /sys/devices/system/cpu/cpuidle/low_power_idle_system_residency_us
 
 The "low_power_idle_cpu_residency_us" attribute shows time spent
 by the CPU package in PKG C10
-- 
2.20.1

