Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEC6C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BE2D2075E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:12:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i0BmNXts"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728726AbfC2AMJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 20:12:09 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41411 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728012AbfC2AMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 20:12:09 -0400
Received: by mail-pf1-f194.google.com with SMTP id 188so142623pfd.8;
        Thu, 28 Mar 2019 17:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aAo9+PhggEqKTa2QGNVjx2tdaccaYLwfaBza4akOH08=;
        b=i0BmNXtsx4ZhNf/eGTAYFvDsFTZacbsF3YsEvInM9wMICwEJK8DwD+fgrfJ9ZL7d4X
         zO9JIpkHI1IX/tulSWP5I0OPgPmGGXd+vzRWBqzs7qCih+8H10NfmQlp9Uyb8hlNekO0
         xIYjQ0iCXm4+r8qi8tCJJ31CS/U51ZUrrQTm3rx2NyWUaPwEVpoPrA5bIHT7LUpi0QbB
         FnpHbzJnbqVLYDPCS4Rw7+VkypbyVlBmh8nXYlUZ4c7vl+ens1x/G4tqjRft+rHtfr1r
         NsIY5sPeyCjW/6PiZabKHVKYgCFbqPaYs32XCnIx8HS4DdHDFCIweWnCjvWn1CtbuW2+
         2d+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aAo9+PhggEqKTa2QGNVjx2tdaccaYLwfaBza4akOH08=;
        b=A5i96q/3YvoHBWLE2g7r2gym+8N4KkOnjsfDX0Yak34G7RopG+oY6GBWS/jzaCWccM
         98BIrASIIVi01NPcOtqOy4oTX9xeEtOpAWtk/Uil0gf1oEKLTn0Ph0u8ZezVwQ6CCczE
         wgdOh18BztRyCVujOUkSro7edfQUWDVVpEFEcRiGq8yTLrSwZ0I8fx1Ji69gLmacvYUQ
         bhaS8vgUfoSsZsAoLH4Vs9xy28Dp74duhdpFgWWTVVovc2UNvk8qCrOrTqnCzzXJSOUn
         yePxAdEQboVQ9FNsE75SXsJteCG0krmT1dwpL/ZL3pvRDDpcQ1uMaHi35nIaQKJ5ri3e
         xH0g==
X-Gm-Message-State: APjAAAUdKhOXVLeuccz3y9+8UiNKfUdtJHcDc1kM+Vo7PQWdCkrai5t/
        3+nDaByzmDuP9/mlh7E4j8g=
X-Google-Smtp-Source: APXvYqyAdxBTz9ZSkHJrWCpdObu034vYC1CV8lnD5b/B4TLehZcvZmWoZnYFFYLBvV+3R1HO2xTFXw==
X-Received: by 2002:a65:6546:: with SMTP id a6mr43106263pgw.296.1553818328569;
        Thu, 28 Mar 2019 17:12:08 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id f125sm432488pfc.91.2019.03.28.17.12.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 17:12:07 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v2 01/24] Documentation: add Linux ACPI to Sphinx TOC tree
Date:   Fri, 29 Mar 2019 08:11:12 +0800
Message-Id: <20190329001135.15847-2-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190329001135.15847-1-changbin.du@gmail.com>
References: <20190329001135.15847-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a index.rst for trace subsystem. More docs will be added later.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 Documentation/acpi/index.rst | 8 ++++++++
 Documentation/index.rst      | 1 +
 2 files changed, 9 insertions(+)
 create mode 100644 Documentation/acpi/index.rst

diff --git a/Documentation/acpi/index.rst b/Documentation/acpi/index.rst
new file mode 100644
index 000000000000..7241ceb1673c
--- /dev/null
+++ b/Documentation/acpi/index.rst
@@ -0,0 +1,8 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=======================================================
+Linux ACPI (Advanced Configuration and Power Interface) 
+=======================================================
+
+.. toctree::
+   :maxdepth: 2
diff --git a/Documentation/index.rst b/Documentation/index.rst
index 80a421cb935e..e3aa28275894 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -90,6 +90,7 @@ needed).
    filesystems/index
    vm/index
    bpf/index
+   acpi/index
    misc-devices/index
 
 Architecture-specific documentation
-- 
2.20.1

