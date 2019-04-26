Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FECEC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11022212F5
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XgnXmWms"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfDZPeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 11:34:03 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39187 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbfDZPeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 11:34:02 -0400
Received: by mail-pg1-f196.google.com with SMTP id l18so1801699pgj.6;
        Fri, 26 Apr 2019 08:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M9skjzp96cygvVz+1JSKV6lvwc3vgk2hHizbPglWd7s=;
        b=XgnXmWmsR5i9Unlemb3afIH0vyh0dj1oJC/69msinEvlJzYemtF6fHVEPMiADZjYxI
         2Va2I7hSqmWLA7yJc6nWD5DbP/+WkbVpZC6FL+VuSOMxMIfJE61rDuawv+CaC64thleC
         MAwk3KqTTDS7ESBmdjMMqZkE50wSUx/7IRreuFUAg0FjCY7b4ZAcXHl9U+hy/T5W96ae
         fa4hMPKTfBvCsi5tlPfSU90xrmGuvhwV1TAtor1preXjj2OlnvLycUIdufz6ZMj+Dk0E
         TPUFBXkRQef9fuxreQ873aehO/2qTCoccDldAMOaFGydlzTvGiwW2/4Z29BPi2NW5yxT
         nfsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M9skjzp96cygvVz+1JSKV6lvwc3vgk2hHizbPglWd7s=;
        b=bcTb1lahtTZm1Otd6g6w6Wf31slveJcIuvIEuK49rna0213sk4L76Wk4KUwpLAttpD
         DMvcrZi0CPqRjxTvMI/UsWJ5W9LC9NwiQGbqBgVw1wmIJVxParilIaVsYFYcnhEQZt4t
         /baXKgDqiGjP85s3evwI4t2NIK1q4gCse/JUFk92ArKNbI9IEVtqJ/KqCWf5i9hAbI+z
         zJrLgbf70h8t4Ss4M8msAMOaBoNMAOxQRmwzzXCR79anOuRvQHP//fl3jvHnMND93Sfp
         BEqglpdGfUcaQoL5p8pzufz1zbzQaGvGqPeJt0p8IewjtS+ygTQAqjdL0pzFD++GELsn
         q5Bw==
X-Gm-Message-State: APjAAAVDQPgJLqNCz58GOxWMh6Sz3jH+xs+0aVYcemWOxnbPdnR4moey
        ItZNgcW+5lxWzcLaZ8m5R+Km0eZf
X-Google-Smtp-Source: APXvYqyBi2QKP1oH8KCdtEaCS4jjGubsemqve0PMdqzEsXaxMDkWV3SvGZm5EbaJ2n0sWFJPt5RhKw==
X-Received: by 2002:a63:de11:: with SMTP id f17mr34331696pgg.94.1556292842209;
        Fri, 26 Apr 2019 08:34:02 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id b1sm29024833pgq.15.2019.04.26.08.33.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 08:34:01 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab+samsung@kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 19/27] Documentation: x86: convert usb-legacy-support.txt to reST
Date:   Fri, 26 Apr 2019 23:31:42 +0800
Message-Id: <20190426153150.21228-20-changbin.du@gmail.com>
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
 Documentation/x86/index.rst                               | 1 +
 .../{usb-legacy-support.txt => usb-legacy-support.rst}    | 8 ++++++--
 2 files changed, 7 insertions(+), 2 deletions(-)
 rename Documentation/x86/{usb-legacy-support.txt => usb-legacy-support.rst} (92%)

diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index c41c17906b6d..526f7a008b8e 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -25,3 +25,4 @@ Linux x86 Support
    pti
    microcode
    resctrl_ui
+   usb-legacy-support
diff --git a/Documentation/x86/usb-legacy-support.txt b/Documentation/x86/usb-legacy-support.rst
similarity index 92%
rename from Documentation/x86/usb-legacy-support.txt
rename to Documentation/x86/usb-legacy-support.rst
index 1894cdfc69d9..19abead7f1a8 100644
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
-- 
2.20.1

