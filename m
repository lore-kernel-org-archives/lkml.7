Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42290C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 17:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08CD021873
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 17:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xd4Mwmvb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbfEFRL7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 13:11:59 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39414 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727176AbfEFRL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 13:11:58 -0400
Received: by mail-pg1-f196.google.com with SMTP id w22so5451713pgi.6;
        Mon, 06 May 2019 10:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b71hcILz1f2BsDF7VpHynv0OFLT/ZIfiSJGLjPU43yY=;
        b=Xd4MwmvbSHgKuosIubkv08NyZ7ZYojZ/G1E+7J6rDtWPZe00ZvW8MJmnCMuouTCjF1
         f/r8jZejNLsHPQ2ppL+5nWLsDWfIjALXzILSsO1b8kYNK2s7TiYr6TJN9FgVJNdTmZ7i
         gaIts7klQhEcFz/l9iFPTRKHR32Nhf6YNUWNh7SQE1I6ltM230rZE0aMNaILElGUXWM8
         wTVEWNL0fHczNPElZ3IJ4Ne6BidkmFAn/WP7qnFZyMMNWZwVTfkkGgXE0DKhGjAsOICv
         /+o6ASoqzxu6puiQV5oUCpAJ07u5zEMfABmYGxbz7kxZepYaYGxKL212OHXEOrDrCnWR
         CT3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b71hcILz1f2BsDF7VpHynv0OFLT/ZIfiSJGLjPU43yY=;
        b=LnsXzbfdFTt1HyjVJqRsAwB/nGGovHc39AWl1aYcRg4stdvoVeRCltE+MWYDbbVGls
         2xCfaCA/L+tILQE4gdn2W3Eatn+Lwc1Uay3IfkYPJM2e6/VcdlwF3g86miyNVvVw2EQx
         3m8kHKAKRGxtmQxniXylkZEpixJcLZViPZtLAaQPMGUivyj7y4UpsOXWJyisylhbC2sY
         +np82xNXSSDVIGITBBE1excumZ9rRCvqhyWmZsAWlzGlcPgdC4I1qIOeHzdy6ByX/1mE
         nbahsN+a2IyzJdlu3lOq5D7AAK2knN4iZZSdbP/DdMSkvzFF4xg5oU4ke22vg7GXtZ6t
         zNfw==
X-Gm-Message-State: APjAAAWxMqg4KLfrwgFAdChGtFycS1KuKoHdGQsyu+eSkPXJ3lR8rATl
        eBt9ohg5aBu5fGYCUARgi7EtBprg
X-Google-Smtp-Source: APXvYqz8N3yovrPt9411l2qLyGetrPzgGYyUtUtsdsis69pOTlOOcBtzPC8m2/wNr/SeTJcGbyWxmw==
X-Received: by 2002:a63:f813:: with SMTP id n19mr5312648pgh.273.1557162717457;
        Mon, 06 May 2019 10:11:57 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id h13sm11045680pgk.55.2019.05.06.10.11.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 06 May 2019 10:11:56 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH v3 24/27] Documentation: x86: convert x86_64/5level-paging.txt to reST
Date:   Tue,  7 May 2019 01:09:20 +0800
Message-Id: <20190506170923.7117-25-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190506170923.7117-1-changbin.du@gmail.com>
References: <20190506170923.7117-1-changbin.du@gmail.com>
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
 .../{5level-paging.txt => 5level-paging.rst}     | 16 +++++++++++-----
 Documentation/x86/x86_64/index.rst               |  1 +
 2 files changed, 12 insertions(+), 5 deletions(-)
 rename Documentation/x86/x86_64/{5level-paging.txt => 5level-paging.rst} (91%)

diff --git a/Documentation/x86/x86_64/5level-paging.txt b/Documentation/x86/x86_64/5level-paging.rst
similarity index 91%
rename from Documentation/x86/x86_64/5level-paging.txt
rename to Documentation/x86/x86_64/5level-paging.rst
index 2432a5ef86d9..ab88a4514163 100644
--- a/Documentation/x86/x86_64/5level-paging.txt
+++ b/Documentation/x86/x86_64/5level-paging.rst
@@ -1,5 +1,11 @@
-== Overview ==
+.. SPDX-License-Identifier: GPL-2.0
 
+==============
+5-level paging
+==============
+
+Overview
+========
 Original x86-64 was limited by 4-level paing to 256 TiB of virtual address
 space and 64 TiB of physical address space. We are already bumping into
 this limit: some vendors offers servers with 64 TiB of memory today.
@@ -16,16 +22,17 @@ QEMU 2.9 and later support 5-level paging.
 Virtual memory layout for 5-level paging is described in
 Documentation/x86/x86_64/mm.txt
 
-== Enabling 5-level paging ==
 
+Enabling 5-level paging
+=======================
 CONFIG_X86_5LEVEL=y enables the feature.
 
 Kernel with CONFIG_X86_5LEVEL=y still able to boot on 4-level hardware.
 In this case additional page table level -- p4d -- will be folded at
 runtime.
 
-== User-space and large virtual address space ==
-
+User-space and large virtual address space
+==========================================
 On x86, 5-level paging enables 56-bit userspace virtual address space.
 Not all user space is ready to handle wide addresses. It's known that
 at least some JIT compilers use higher bits in pointers to encode their
@@ -58,4 +65,3 @@ One important case we need to handle here is interaction with MPX.
 MPX (without MAWA extension) cannot handle addresses above 47-bit, so we
 need to make sure that MPX cannot be enabled we already have VMA above
 the boundary and forbid creating such VMAs once MPX is enabled.
-
diff --git a/Documentation/x86/x86_64/index.rst b/Documentation/x86/x86_64/index.rst
index 4b65d29ef459..7b8c82151358 100644
--- a/Documentation/x86/x86_64/index.rst
+++ b/Documentation/x86/x86_64/index.rst
@@ -10,3 +10,4 @@ x86_64 Support
    boot-options
    uefi
    mm
+   5level-paging
-- 
2.20.1

