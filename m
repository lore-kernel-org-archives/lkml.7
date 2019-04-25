Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A5DC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60B322084F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jdEaSoZL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729237AbfDYPbm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 11:31:42 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46464 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbfDYPbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 11:31:41 -0400
Received: by mail-pg1-f193.google.com with SMTP id n2so10028pgg.13;
        Thu, 25 Apr 2019 08:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V9nzDmKVs6B2fvIsmgDPfkl3yh4fpAvQzb9wSqlneGU=;
        b=jdEaSoZLj73TAFcApF7rENFfh01EaZJ0MNw6sKz8qO15YAR2btCXKvoiH1ROxCGsmb
         LOjTQbz38X/Ftk6b4J/+ARuHkYBbKB5BnqRTU39PzG+B6msfh55wIGebHkA9y8pYfKu4
         72rC5xAyZd89c0tOIx+kSIt3oPYnMECIjaLg1n02H2oHHqb/NTUIybYqAQVNn1aqZ0GF
         BF6zEoDnbSA8lMewxePuT7QCf2njcJKBoj1YCO6yn9hb4T3nKoHtuCS0vuKkylh8B+uF
         vpwNnGtVMAww5FJ0RY3PEh83mNV4QKwPOVG4U5rHqDrPowmSWBIo/hH8b5WGpgryg2sa
         uzCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V9nzDmKVs6B2fvIsmgDPfkl3yh4fpAvQzb9wSqlneGU=;
        b=bQTqMJfSzI2EjffFz6/tby9Wk4vQ4Cyo2wudkYv8/yXNuOLyov4zYo3MLRw/IWfcFu
         ImYdRO18hXwIgN3+qcCXsPL0K8R+RMIGHtFrKvAqGJeGK53oIyaAEgBZHUeSee1bRfA5
         0qn9O8JUw1JvDV0F2TbAtYw99kdfKBIBFgLiB4LW6rTxtf4Nkn+I/OydaBkZ70VCZgKo
         vohsk6PH8tjhIG79QIrRWHs6B7LSW91l542iTBJ+U05GdVgB1hPsDrSjRr7ftKGHovm9
         Qc4rbjuaU6BPPcaqFqPBJ3sYtwvRtlbKvci+u8EneU0J1nb+PmJaXr5wdOGb+A0PojKS
         cEGA==
X-Gm-Message-State: APjAAAXJm/V6wQGrqI63Oy+Bwh2N0ycjupcahucMiOUljZBv0ROL8j6p
        0U5Zd7WJ3k/dgQ6Jt4MGUC4=
X-Google-Smtp-Source: APXvYqzFTgC2Jvs/yOKKDftQRRa8InUlkgNmWcPljHcVsijce2GVeWByOsQVXdkq/P8gVAE9yeSpqw==
X-Received: by 2002:a63:5d44:: with SMTP id o4mr37785200pgm.15.1556206300285;
        Thu, 25 Apr 2019 08:31:40 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id c14sm2643363pgj.94.2019.04.25.08.31.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 08:31:39 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     rjw@rjwysocki.net, Jonathan Corbet <corbet@lwn.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org, mchehab+samsung@kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v6 01/24] Documentation: add Linux ACPI to Sphinx TOC tree
Date:   Thu, 25 Apr 2019 23:30:54 +0800
Message-Id: <20190425153117.16057-2-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190425153117.16057-1-changbin.du@gmail.com>
References: <20190425153117.16057-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add below index.rst files for ACPI subsystem. More docs will be added later.
  o admin-guide/acpi/index.rst
  o driver-api/acpi/index.rst
  o firmware-guide/index.rst

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/admin-guide/acpi/index.rst    | 10 ++++++++++
 Documentation/admin-guide/index.rst         |  1 +
 Documentation/driver-api/acpi/index.rst     |  7 +++++++
 Documentation/driver-api/index.rst          |  1 +
 Documentation/firmware-guide/acpi/index.rst |  9 +++++++++
 Documentation/firmware-guide/index.rst      | 13 +++++++++++++
 Documentation/index.rst                     | 10 ++++++++++
 7 files changed, 51 insertions(+)
 create mode 100644 Documentation/admin-guide/acpi/index.rst
 create mode 100644 Documentation/driver-api/acpi/index.rst
 create mode 100644 Documentation/firmware-guide/acpi/index.rst
 create mode 100644 Documentation/firmware-guide/index.rst

diff --git a/Documentation/admin-guide/acpi/index.rst b/Documentation/admin-guide/acpi/index.rst
new file mode 100644
index 000000000000..3e041206089d
--- /dev/null
+++ b/Documentation/admin-guide/acpi/index.rst
@@ -0,0 +1,10 @@
+============
+ACPI Support
+============
+
+Here we document in detail how to interact with various mechanisms in
+the Linux ACPI support.
+
+.. toctree::
+   :maxdepth: 1
+
diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
index 0a491676685e..5b8286fdd91b 100644
--- a/Documentation/admin-guide/index.rst
+++ b/Documentation/admin-guide/index.rst
@@ -77,6 +77,7 @@ configure specific aspects of kernel behavior to your liking.
    LSM/index
    mm/index
    perf-security
+   acpi/index
 
 .. only::  subproject and html
 
diff --git a/Documentation/driver-api/acpi/index.rst b/Documentation/driver-api/acpi/index.rst
new file mode 100644
index 000000000000..898b0c60671a
--- /dev/null
+++ b/Documentation/driver-api/acpi/index.rst
@@ -0,0 +1,7 @@
+============
+ACPI Support
+============
+
+.. toctree::
+   :maxdepth: 2
+
diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index c0b600ed9961..aa87075c7846 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -56,6 +56,7 @@ available subsections can be seen below.
    slimbus
    soundwire/index
    fpga/index
+   acpi/index
 
 .. only::  subproject and html
 
diff --git a/Documentation/firmware-guide/acpi/index.rst b/Documentation/firmware-guide/acpi/index.rst
new file mode 100644
index 000000000000..0ec7d072ba22
--- /dev/null
+++ b/Documentation/firmware-guide/acpi/index.rst
@@ -0,0 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+============
+ACPI Support
+============
+
+.. toctree::
+   :maxdepth: 1
+
diff --git a/Documentation/firmware-guide/index.rst b/Documentation/firmware-guide/index.rst
new file mode 100644
index 000000000000..5355784ca0a2
--- /dev/null
+++ b/Documentation/firmware-guide/index.rst
@@ -0,0 +1,13 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===============================
+The Linux kernel firmware guide
+===============================
+
+This section describes the ACPI subsystem in Linux from firmware perspective.
+
+.. toctree::
+   :maxdepth: 1
+
+   acpi/index
+
diff --git a/Documentation/index.rst b/Documentation/index.rst
index 80a421cb935e..fdfa85c56a50 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -35,6 +35,16 @@ trying to get it to work optimally on a given system.
 
    admin-guide/index
 
+Firmware-related documentation
+------------------------------
+The following holds information on the kernel's expectations regarding the
+platform firmwares.
+
+.. toctree::
+   :maxdepth: 2
+
+   firmware-guide/index
+
 Application-developer documentation
 -----------------------------------
 
-- 
2.20.1

