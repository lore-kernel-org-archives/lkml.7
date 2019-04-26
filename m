Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06040C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9DB5208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ar+hnKRt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfDZPfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 11:35:00 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45459 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfDZPe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 11:34:58 -0400
Received: by mail-pg1-f193.google.com with SMTP id y27so1075334pgl.12;
        Fri, 26 Apr 2019 08:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6w+/ukhBs5A+/Cpc4cy3lRbWsMEd9es6i7ZvKVBddzs=;
        b=ar+hnKRt9xUnyGmefS2iMG5EjolPiFrDp9Nf+0rIIyPKhjJQaxNzloVnIzTDIwL7iA
         Yv0STlefWYMTZU9UH26Iiup2BtXIe/InVTAfqs9R9EdzY259S3IXxLIQQu9JlnQa4BZF
         CHk/e9HbyRyN3ga7ZWKCUhofgJNHR5WZcjF7XQ5TxFwenJI4onqp+A3Zx1B766gK36V1
         2RINT3Zpdr2u2SEhcsfuVVmTMg5Yq70uZQoMPrcGx+8iIi1GS8T00QLvwwz6H5MsC5G8
         m2atqbJfc//HZ9JFRR+6oAfCOAas6Jm95goa4oXiPl0xRMiAYSSdbAfQ0Ny9QR4LgTRB
         yc7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6w+/ukhBs5A+/Cpc4cy3lRbWsMEd9es6i7ZvKVBddzs=;
        b=WMHzWeW12U/zt978EBcyobguaRd48wanc6F8rTP4C8xSTkgpnZMjEwOGW7d2ks0uyR
         k+XIE3/Zp1//jefWRPdAz4cRmNuukwhn3G7Ke0s60W7IvMN5MUPlucGkdhBuWlG/DJz3
         zMcEdI1CBsIGBK6REq84VokEXUp1lB64smvt8PHVUo7grAF9Y3GayXTVQr5PudcuoeXG
         630deAFvp1l87cXxjuYgGI/tHBTMJacA7lTYtsWff5gEgK1YEjy2lN/GfI5KQvDvsz5t
         hwQ7vqn9pR2f8r05IVPjb++iWJQUaxliFvRi6mxyr1avqREBqSUq6n5XIHcy6HmhotTg
         zqLg==
X-Gm-Message-State: APjAAAVkWf+SeSFbzs6NLdkEiKAQmCqIx+Q9MTEOzDcSffpMfFU+PqeJ
        e/GWk3nn+Youdvm0qU1B81A=
X-Google-Smtp-Source: APXvYqyhOjXBIHrE1PLiNyUHrTuBtyaXSkQWw+LvT/V5jz/U6qA+dmw6b+LPNvu0NoqoIBqrpOpLpw==
X-Received: by 2002:a63:dc50:: with SMTP id f16mr44486519pgj.396.1556292897821;
        Fri, 26 Apr 2019 08:34:57 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id b1sm29024833pgq.15.2019.04.26.08.34.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 08:34:57 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab+samsung@kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 27/27] Documentation: x86: convert x86_64/machinecheck to reST
Date:   Fri, 26 Apr 2019 23:31:50 +0800
Message-Id: <20190426153150.21228-28-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190426153150.21228-1-changbin.du@gmail.com>
References: <20190426153150.21228-1-changbin.du@gmail.com>
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
 Documentation/x86/x86_64/index.rst                    |  1 +
 .../x86/x86_64/{machinecheck => machinecheck.rst}     | 11 ++++++-----
 2 files changed, 7 insertions(+), 5 deletions(-)
 rename Documentation/x86/x86_64/{machinecheck => machinecheck.rst} (92%)

diff --git a/Documentation/x86/x86_64/index.rst b/Documentation/x86/x86_64/index.rst
index c04b6eab3c76..d6eaaa5a35fc 100644
--- a/Documentation/x86/x86_64/index.rst
+++ b/Documentation/x86/x86_64/index.rst
@@ -13,3 +13,4 @@ x86_64 Support
    5level-paging
    fake-numa-for-cpusets
    cpu-hotplug-spec
+   machinecheck
diff --git a/Documentation/x86/x86_64/machinecheck b/Documentation/x86/x86_64/machinecheck.rst
similarity index 92%
rename from Documentation/x86/x86_64/machinecheck
rename to Documentation/x86/x86_64/machinecheck.rst
index d0648a74fceb..8e9d2d529a8d 100644
--- a/Documentation/x86/x86_64/machinecheck
+++ b/Documentation/x86/x86_64/machinecheck.rst
@@ -1,5 +1,8 @@
+.. SPDX-License-Identifier: GPL-2.0
 
-Configurable sysfs parameters for the x86-64 machine check code.
+===============================================================
+Configurable sysfs parameters for the x86-64 machine check code
+===============================================================
 
 Machine checks report internal hardware error conditions detected
 by the CPU. Uncorrected errors typically cause a machine check
@@ -16,14 +19,12 @@ log then mcelog should run to collect and decode machine check entries
 from /dev/mcelog. Normally mcelog should be run regularly from a cronjob.
 
 Each CPU has a directory in /sys/devices/system/machinecheck/machinecheckN
-(N = CPU number)
+(N = CPU number).
 
 The directory contains some configurable entries:
 
-Entries:
-
 bankNctl
-(N bank number)
+	(N bank number)
 	64bit Hex bitmask enabling/disabling specific subevents for bank N
 	When a bit in the bitmask is zero then the respective
 	subevent will not be reported.
-- 
2.20.1

