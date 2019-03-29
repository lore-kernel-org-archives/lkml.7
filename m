Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 589F6C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26FD821902
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:13:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RrxLTdJi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728999AbfC2AN5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 20:13:57 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33459 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728652AbfC2ANz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 20:13:55 -0400
Received: by mail-pf1-f196.google.com with SMTP id i19so162127pfd.0;
        Thu, 28 Mar 2019 17:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zB6SojoKvcF0XGfhTw87N13GXKVF4uALg0ozLKJBNP4=;
        b=RrxLTdJiYdPGKVBESnyYseh9KyIgpJ0HTOym4R1Qz8By+Oh+H3I5LXSxI3FiKCIABh
         sisL3DuhLSYUqxUBsXvJ8vSkUndcU8ZB/G8SHMQ231coT9KOYiXOBbrbdRpp7yhRsZsk
         BlPJR5P83LMLWeasX082EPlE6qVEGwB5TA53eQXaq+BawdjjUs02tO0k/TChueNtV9QT
         Sxt8yqKXQ4scTshd2Gw070GnX/XUKv2drydZlqFHr1DfL/V6G+5MgWycdyX3IiXdK75B
         huB+fV5tmz9O0t0xA7CQoSQpaOPCID6apsM3eC7U7OqKLuRgDPapidZ8PkJ3k0V5IJP6
         SJzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zB6SojoKvcF0XGfhTw87N13GXKVF4uALg0ozLKJBNP4=;
        b=FuZsh/G3sPfwVqgdbwzqNUwLfNxAhrzLYu4aUBH8c6JfCXsJ5dIXim1vDb2XK0cpel
         dcIeYkfWragYMp11JmsWnq365L2Ir+PjPoi8aAhKcZkwTMB9Zq36PWXTh5Y0yW1z8GFj
         YTaDMqelYDhHCt1OJAdPkk1hgv18o2CBAwg2OQ9qyzS4PdhCG9RPrjjk6HiBwCgF2tNO
         ENW/tJT187CN1Zp6El8sKToGfWczuPVwEJr3QVlbzJk448nKyp5UjiyM9BfRI59voDuN
         vawHBmBdRYJ683wbWE3TMt3vbF2tJjZKzf59TvzVp6yDpb8xCMqSOrUasj0TZumgiaeW
         9ooA==
X-Gm-Message-State: APjAAAU7+dmLPr+ahxBALG6Vk0SXfRKCq2d/4VBwgzyGKQZjxRp42CBa
        hPj1TWaPsH/2QmW3oBCu71Q=
X-Google-Smtp-Source: APXvYqw1Ze5vdrDUhxmMscPklSxS6cgVNFXpcpw7GWpL85OVcCP+RZBG7cMLxMbQGOODrO8bRNLGPg==
X-Received: by 2002:a62:209c:: with SMTP id m28mr4780452pfj.233.1553818435016;
        Thu, 28 Mar 2019 17:13:55 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id f125sm432488pfc.91.2019.03.28.17.13.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 17:13:54 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v2 22/24] acpi doc: convert acpi/lpit.txt to rst format
Date:   Fri, 29 Mar 2019 08:11:33 +0800
Message-Id: <20190329001135.15847-23-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190329001135.15847-1-changbin.du@gmail.com>
References: <20190329001135.15847-1-changbin.du@gmail.com>
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
---
 Documentation/acpi/index.rst              |  1 +
 Documentation/acpi/{lpit.txt => lpit.rst} | 18 +++++++++++++-----
 2 files changed, 14 insertions(+), 5 deletions(-)
 rename Documentation/acpi/{lpit.txt => lpit.rst} (68%)

diff --git a/Documentation/acpi/index.rst b/Documentation/acpi/index.rst
index 91aeed814ea9..664807949272 100644
--- a/Documentation/acpi/index.rst
+++ b/Documentation/acpi/index.rst
@@ -27,3 +27,4 @@ Linux ACPI (Advanced Configuration and Power Interface)
    apei/output_format
    apei/einj
    cppc_sysfs
+   lpit
diff --git a/Documentation/acpi/lpit.txt b/Documentation/acpi/lpit.rst
similarity index 68%
rename from Documentation/acpi/lpit.txt
rename to Documentation/acpi/lpit.rst
index b426398d2e97..aca928fab027 100644
--- a/Documentation/acpi/lpit.txt
+++ b/Documentation/acpi/lpit.rst
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

