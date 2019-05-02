Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 050A1C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 07:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5B7D20873
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 07:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="leNUqZhQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfEBHL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 03:11:27 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35623 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbfEBHL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 03:11:26 -0400
Received: by mail-pg1-f194.google.com with SMTP id h1so655072pgs.2;
        Thu, 02 May 2019 00:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+ht7GrFTU79fToPKb9Iep8eH6HLgwHBDoqhSDEh8xGU=;
        b=leNUqZhQaIC2E++KYr7LBdudAD48gDl5Gwwv4xMk64LRBCZsGsncfyj+BD2zmsHvMK
         qO9w5KpQ/yKD/c/MYAkP7yb2AsoIdpb/5Qtefdsj676OQ/lS7FDh7P67+KTuOF0RB6qH
         LpINMiKF93ja6rHewQ7vL85KsEQqBwEfmyJyJObgVRY9nFA5Ju3MQzwPbng8N8Nr3LJO
         HKcEbok3fGIs0+lcwFvHR6tDoGT2o1rd9VpTBpB/PY+bpNWJlH7z/5c6M8C6/j4IBzUr
         Q/meT59LQ2ToE/cVDvcleIBwll5HcyamuOziFzNi3/9Xh9pRKnCwY79koZ05s4/p4VSz
         L4cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+ht7GrFTU79fToPKb9Iep8eH6HLgwHBDoqhSDEh8xGU=;
        b=TM+6E5KThPOUp11c1r4f66wyRga6MtRE4+qXQLodGKCjzqo33ldDRGVGmGmvx0OTs9
         SOdaEG498HXKB36d14WbSc40JRLZzvjoAa8q3eZCT+fYxTS0BM0FyvzoZykes5zCIZP3
         e6PQdcmwZ2ckIUHKIQa3i0Gp1LLpnkfvO8d1DF/RrRqtRDc7+KetcPHzT3Rkfl6HAPox
         AJFFG6XjE/pLl1sY+XoyPi3WNCdrvLge4doXRjKgIP9NPgHNeMYYeiqxjhSFErwNFWj9
         dYh1h5zJW7Qkjl2w1GyAcV/AbF4n9ao5XL3ZQHXBJZUYv7jGDQJG9Z0Z5ZZhKKihXQR1
         nQEQ==
X-Gm-Message-State: APjAAAVZ8139AjZWaPNJTpajwwBseoBBhA1GvkcVh10LJotINu0X+DSL
        ebnbLYyyqyEjaUGpKbcNSiw=
X-Google-Smtp-Source: APXvYqx4RDrqub0ciRxOeiw7+beyuzBKmwGhPd628qNerr+hZmAjKMRCpP/QvXKsErFf4tQGtPD9xQ==
X-Received: by 2002:a62:4e86:: with SMTP id c128mr2466915pfb.39.1556781085723;
        Thu, 02 May 2019 00:11:25 -0700 (PDT)
Received: from laptop.DHCP ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id u24sm4686976pfh.91.2019.05.02.00.11.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 00:11:24 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH v2 19/27] Documentation: x86: convert usb-legacy-support.txt to reST
Date:   Thu,  2 May 2019 15:06:25 +0800
Message-Id: <20190502070633.9809-20-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502070633.9809-1-changbin.du@gmail.com>
References: <20190502070633.9809-1-changbin.du@gmail.com>
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
 Documentation/x86/index.rst                   |  1 +
 ...acy-support.txt => usb-legacy-support.rst} | 40 +++++++++++--------
 2 files changed, 24 insertions(+), 17 deletions(-)
 rename Documentation/x86/{usb-legacy-support.txt => usb-legacy-support.rst} (53%)

diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index 453557097743..3eb0334ae2d4 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -25,3 +25,4 @@ x86-specific Documentation
    pti
    microcode
    resctrl_ui
+   usb-legacy-support
diff --git a/Documentation/x86/usb-legacy-support.txt b/Documentation/x86/usb-legacy-support.rst
similarity index 53%
rename from Documentation/x86/usb-legacy-support.txt
rename to Documentation/x86/usb-legacy-support.rst
index 1894cdfc69d9..e01c08b7c981 100644
--- a/Documentation/x86/usb-legacy-support.txt
+++ b/Documentation/x86/usb-legacy-support.rst
@@ -1,7 +1,11 @@
+
+.. SPDX-License-Identifier: GPL-2.0
+
+==================
 USB Legacy support
-~~~~~~~~~~~~~~~~~~
+==================
 
-Vojtech Pavlik <vojtech@suse.cz>, January 2004
+:Author: Vojtech Pavlik <vojtech@suse.cz>, January 2004
 
 
 Also known as "USB Keyboard" or "USB Mouse support" in the BIOS Setup is a
@@ -27,18 +31,20 @@ It has several drawbacks, though:
 
 Solutions:
 
-Problem 1) can be solved by loading the USB drivers prior to loading the
-PS/2 mouse driver. Since the PS/2 mouse driver is in 2.6 compiled into
-the kernel unconditionally, this means the USB drivers need to be
-compiled-in, too.
-
-Problem 2) can currently only be solved by either disabling HIGHMEM64G
-in the kernel config or USB Legacy support in the BIOS. A BIOS update
-could help, but so far no such update exists.
-
-Problem 3) is usually fixed by a BIOS update. Check the board
-manufacturers web site. If an update is not available, disable USB
-Legacy support in the BIOS. If this alone doesn't help, try also adding
-idle=poll on the kernel command line. The BIOS may be entering the SMM
-on the HLT instruction as well.
-
+Problem 1)
+  can be solved by loading the USB drivers prior to loading the
+  PS/2 mouse driver. Since the PS/2 mouse driver is in 2.6 compiled into
+  the kernel unconditionally, this means the USB drivers need to be
+  compiled-in, too.
+
+Problem 2)
+  can currently only be solved by either disabling HIGHMEM64G
+  in the kernel config or USB Legacy support in the BIOS. A BIOS update
+  could help, but so far no such update exists.
+
+Problem 3)
+  is usually fixed by a BIOS update. Check the board
+  manufacturers web site. If an update is not available, disable USB
+  Legacy support in the BIOS. If this alone doesn't help, try also adding
+  idle=poll on the kernel command line. The BIOS may be entering the SMM
+  on the HLT instruction as well.
-- 
2.20.1

