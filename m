Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C67C4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD66520B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D8dNqawa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730339AbfDYPdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 11:33:47 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34124 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730286AbfDYPdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 11:33:45 -0400
Received: by mail-pg1-f196.google.com with SMTP id v12so45382pgq.1;
        Thu, 25 Apr 2019 08:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2sbwg0L9RWIY1yx4og9yDX54LDcD6lm1qQ96G7LSClM=;
        b=D8dNqawaDr2iRAk6wUpl0siYfsyzK8XnZC9wZmD3cRqfcMxzxFxSL6Lf/+th9626cS
         Jun0eqT0cy3VU/MKwlLGmU7Fs3MSS70yroa4gKzqHf/MkLYcqXDQmHQWuhqAvTwM6Dtt
         fxf5+8WvG9xuS1D1NIFUuL6vXLJMa5aWhGWKFeeNJWVpslXimY1RWECdz1bVCvFkT4xK
         FDFp8NW2WccrcxfShPQshE9vqPvv8ukR2n/uj4npZW5Zigs0x1XUI4R+GxBa0GZXvC/j
         WdHJy5mVXHX9TEo2FQnscNXzauxlsOtdVsvTgdRHHIdHWZAmO3xxTMBvoutMiIrfO6O0
         QR6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2sbwg0L9RWIY1yx4og9yDX54LDcD6lm1qQ96G7LSClM=;
        b=Sgw9xtB4MDTAWjUlmU+bTD8GoDzzFExS2d67OZjVDgY2vM/Uh8Ikfnjr0VtSLvywOA
         VByU5VqC0sHrbsH1Ytuv6SnlQUjxhTmGmeAH6ECZRKvlcKpfRX4u3Cj/Kq8zZ7Nv39nN
         SAV40kktKf9yRLOw5D+B4FF5L+co05OyG0FKl3iQ7/Mn29XKzgtBUXCOgwtpzNoP04R8
         3OmQQKKTOvRX3gK9S9rRtiwqCIa2QlblSyTqWC6P2VN6cte14bbVcZpEUYREUue17wJR
         y5PK12sGpCm1u1HMKTper25iaEbDGqhmGwmxMXgoXBtGoWw3CsgMVVJJP8Cozdbeeii3
         QPjA==
X-Gm-Message-State: APjAAAVVrXQb3j4WwLtLcc5dCpOPG4IRt2Y2+G6FELRgC9hyCYxxs46G
        JFNIB6h90WKpKdGoQJnYNNM=
X-Google-Smtp-Source: APXvYqxLhr4gv2QXx7OUr6taBDWir9gqMUCQSLV5IcxxZUTXARIJJ13BV2DKYJJo+vGotX7f5fYVPA==
X-Received: by 2002:a63:4c26:: with SMTP id z38mr38632238pga.425.1556206424985;
        Thu, 25 Apr 2019 08:33:44 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id c14sm2643363pgj.94.2019.04.25.08.33.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 08:33:43 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     rjw@rjwysocki.net, Jonathan Corbet <corbet@lwn.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org, mchehab+samsung@kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v6 22/24] Documentation: ACPI: move lpit.txt to firmware-guide/acpi and convert to reST
Date:   Thu, 25 Apr 2019 23:31:15 +0800
Message-Id: <20190425153117.16057-23-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190425153117.16057-1-changbin.du@gmail.com>
References: <20190425153117.16057-1-changbin.du@gmail.com>
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

