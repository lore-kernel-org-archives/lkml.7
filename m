Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A0EC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 645A02183F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jf5iZ6h/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbfC1QaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 12:30:20 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39802 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727565AbfC1QaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 12:30:18 -0400
Received: by mail-pl1-f196.google.com with SMTP id b65so5199649plb.6;
        Thu, 28 Mar 2019 09:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MJFVCivaioheelzD/fAPrmrwNOtb9+R5f31YaD06Bmw=;
        b=jf5iZ6h/V/CTzCkARBLOzmohp9gSzslJaCLca/4ZlacU7oPyiScyzv9ovR3dy9HuRZ
         ofbAAUZlnbzWht0s6o88Qp/+J9YougUYrhJlWD+VuNSWXuGpsPie7kgUoI4NwQSLPfTA
         Tgz8fRHd1t8ixz07VQll0ho6Z3faO2oumyWtOmOGNi7L2QEd3yJORJN4jMr/MbAxU0EC
         KviZuOMeBrVkLAJjiXg3thuNLwgP62uRcbXw8wfVl2XtRkNuIHl6C2MJXjigcGznVqI1
         DPXunCBPp2B6NPlfMuL2tnNIr4BaUiULFyvnDv2t5es0/uOp6QPXiLQLMMvkXW34w5i+
         G3Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MJFVCivaioheelzD/fAPrmrwNOtb9+R5f31YaD06Bmw=;
        b=ga33C8JrZQgQjDXQfCSQ8nzaSxUBynRlFWUeVQEoKhFcnuGrQag+kUX6AJ4asWOY/9
         X5Drrxfkicl3u53kRXc2C1lPZ28Un/v9I7NsBqTbjkaTenZZcMwO9GjSIqEnpLThd3gC
         v17GXQ4q8WPDNHYmmoQsyc4dUgVqPp4EJTIkrIOO/afmYCgn8OpJ6O6zLhkekIBJAnBE
         srebV98lA0Qc5FWKQfh3hApd79HoSuAAph4JwiE1JFCLPrxUnw32ZTF8Sm6y02X8PjCw
         dDgzb+5Uw14xYDi50+3VYqtCTXomlnwMuMkwoKSVz0kEM5RJTYHfRU4Ls1rnM6w1+kJv
         v1xA==
X-Gm-Message-State: APjAAAX/08vwhZluikkb/NZJqJ54tz1DtePRBixTlSsPo1z+FtxZvRuC
        tOItGyrj+7SLRnOYtmqpcNo=
X-Google-Smtp-Source: APXvYqwe+5okCbG7Scmhm0dKfXhrF1/KYTJz1eN26wvA927V+53uNCG0zQNf9s+yS8/v7Jjfx3TlWg==
X-Received: by 2002:a17:902:2e01:: with SMTP id q1mr44456018plb.253.1553790618219;
        Thu, 28 Mar 2019 09:30:18 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id y12sm42748885pgq.64.2019.03.28.09.30.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 09:30:17 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 21/23] acpi doc: convert acpi/lpit.txt to rst format
Date:   Fri, 29 Mar 2019 00:27:19 +0800
Message-Id: <20190328162721.26138-22-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190328162721.26138-1-changbin.du@gmail.com>
References: <20190328162721.26138-1-changbin.du@gmail.com>
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
 Documentation/acpi/{lpit.txt => lpit.rst} | 16 +++++++++++-----
 2 files changed, 12 insertions(+), 5 deletions(-)
 rename Documentation/acpi/{lpit.txt => lpit.rst} (70%)

diff --git a/Documentation/acpi/index.rst b/Documentation/acpi/index.rst
index f59e6ddb0f99..407b7e0aa54b 100644
--- a/Documentation/acpi/index.rst
+++ b/Documentation/acpi/index.rst
@@ -25,3 +25,4 @@ Linux ACPI (Advanced Configuration and Power Interface)
    apei/output_format
    apei/einj
    cppc_sysfs
+   lpit
diff --git a/Documentation/acpi/lpit.txt b/Documentation/acpi/lpit.rst
similarity index 70%
rename from Documentation/acpi/lpit.txt
rename to Documentation/acpi/lpit.rst
index b426398d2e97..f4e76b8519da 100644
--- a/Documentation/acpi/lpit.txt
+++ b/Documentation/acpi/lpit.rst
@@ -1,3 +1,7 @@
+===========================
+Low Power Idle Table (LPIT)
+===========================
+
 To enumerate platform Low Power Idle states, Intel platforms are using
 “Low Power Idle Table” (LPIT). More details about this table can be
 downloaded from:
@@ -8,13 +12,15 @@ Residencies for each low power state can be read via FFH
 
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

