Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B6ECC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 17:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFA57217D4
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 17:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vAQ3/bTO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbfEFRL3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 13:11:29 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35649 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbfEFRL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 13:11:28 -0400
Received: by mail-pg1-f195.google.com with SMTP id h1so6773026pgs.2;
        Mon, 06 May 2019 10:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+ht7GrFTU79fToPKb9Iep8eH6HLgwHBDoqhSDEh8xGU=;
        b=vAQ3/bTOSAbsplQIPlQIHiYkgNFlxeLDhh2FnX+zeqEBYRw7vU3bvDlvORvUSkd46s
         lsydlhmzub3IVp+irWB0WCHJgXSRPhZk12ey3yNnO0POBpWYUAlArxfVC/+MHLyrOzyS
         hIotLj4PTSqnYI7lOd1AGsK/b3uUx+OCX7vVq82a7wpkjeVCS9t42gFxTq0S3VDQO/8w
         49+psbGoBrdMNekzrM0mplmIjs2csG1MSGy6niA1hbVwOjOE8LbT+dmrwCIFtdt/KSxV
         OqFRkheMsU0CQlIMbNGvQQ3wJdbVtQ9fuKDGWWrqQhRHFwbhsYI0oYQdTQg8vB6IfVes
         UT0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+ht7GrFTU79fToPKb9Iep8eH6HLgwHBDoqhSDEh8xGU=;
        b=KoFNZtx1NFyPXnzjx5icAINUWP1tqlWCJ8zcswIzbpW9z7rWzSQ9bYtiqb2YtEbaMu
         V/turzjKh7JeSnWvuH6q7jZiLhH8stT0wqqOlmChtNlihRRe0SO9TK/ow99mJiNgrxSu
         HvVjp1WVe0dL+nluip2Xs/6pkthZRmRaxyw0yr7XU22dKDhgoChIqfuijLreFA8oXQH8
         uuSoDT8KWCvIZsgbcnsZJCeyrmGnTIdjrfXVbLIrbDPoGQI92UsjV0P/EAb7iMociCzX
         PlZVHA972YyTglnV6EtW53+c7FQMrtqzkTNL3d9CCqgf5jRHzNmgKsz5OHe9lCntl+vt
         bgPw==
X-Gm-Message-State: APjAAAVjwpDkzQSNP51WOhbEAy2gRRDyWcfI2sNvdHnXEvCFaPhmsAB5
        IApjQvodKmbWDdbAm2Ch+f8=
X-Google-Smtp-Source: APXvYqwEtcC3mzmvAMOma3+8EgDHUQOJBE8d23RnrDMGcmVycMNK8f0mHO/xpSyl6JJTAdCnynvuQg==
X-Received: by 2002:a63:d756:: with SMTP id w22mr5417799pgi.382.1557162687844;
        Mon, 06 May 2019 10:11:27 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id h13sm11045680pgk.55.2019.05.06.10.11.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 06 May 2019 10:11:27 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH v3 19/27] Documentation: x86: convert usb-legacy-support.txt to reST
Date:   Tue,  7 May 2019 01:09:15 +0800
Message-Id: <20190506170923.7117-20-changbin.du@gmail.com>
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

