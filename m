Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94080C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64307218A5
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDtbUxsn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbfC1Q2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 12:28:55 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46053 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfC1Q2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 12:28:52 -0400
Received: by mail-pg1-f195.google.com with SMTP id y3so11839645pgk.12;
        Thu, 28 Mar 2019 09:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P5xupUPJLrv+GmoW3fo/9frJKCPMIHgFRAxVHpdEE8g=;
        b=SDtbUxsnrm+jgfY5C7hk1myuhoea5zCdaust8l1VLjp9bm9Rj8EOUnCFmuckGYzcD8
         U33nuWCl/YPQpVqCDrYOc4WaV4lBrT8yav02Ayzf3bQmKxqm3SJ8OyBjFkInEzdHxbIc
         DXqhEnwvTS3VHNolaLLxoNGkLvUEbaGJDrMpDUa/kReiCBs6JsKQiRMgHOk0AIMmK5SE
         5QM4O/yUTz4UTnS4FdMlwgWtjFaCb+JtrgmGLO+twviKC9Zbt/8xPIlhR4kctNu4R85i
         ekZjHaVabRNB5aT4awaq69LJ2+Pkg6MTK280/q7qW3pn8Dz7TrTJmjtAZ2NRKjlaidLy
         6CQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P5xupUPJLrv+GmoW3fo/9frJKCPMIHgFRAxVHpdEE8g=;
        b=PSW2cRADwwvImIZAQALa5Tjn9AvZ3dl7OrgCQAHw12Z4U27Eka29bg4FxXqiUxdcDH
         KEJB7D9h76dyrMiF6ZWjXLPdJ2r9RKVFA/1S9YZc1G+j8VkgyX/o+mwRaJ4iPCIfDA+x
         4tDLcjI6+IHoRdq4AExoImDLqusBN8L5IHyiR/9bzVqzpo0P32gFJwgx0ta0GsrjZ2ya
         sd4s+h0zllFQOy+INny2CUxwSejX0VlBHuxp7dRi4QNIqMDxAO+v0iwbDUBhF7PsSTAj
         f0Go1haVQu714f1FMmFeld6eSnMFQIDOSR3ZOt5g0AyKZlyHNYkCr1tU778q3TiHVljR
         HcQA==
X-Gm-Message-State: APjAAAUINNJL0CknWO4kyX5DyNgG7wXbnyowNPN5kH5FE41tj8E+vNfd
        VJkpiHcikI925t1B2BauQuU=
X-Google-Smtp-Source: APXvYqxJaiDXAYVsSYAfRI/puRMfVBwP8yz8b8t2o/w46Xxkxx04SscbKJs+gI9xpvNePGJhoWPASQ==
X-Received: by 2002:a63:fc64:: with SMTP id r36mr41003841pgk.280.1553790531848;
        Thu, 28 Mar 2019 09:28:51 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id y12sm42748885pgq.64.2019.03.28.09.28.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 09:28:51 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 04/23] acpi doc: convert acpi/osi.txt to rst format
Date:   Fri, 29 Mar 2019 00:27:02 +0800
Message-Id: <20190328162721.26138-5-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190328162721.26138-1-changbin.du@gmail.com>
References: <20190328162721.26138-1-changbin.du@gmail.com>
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
 Documentation/acpi/index.rst            |  1 +
 Documentation/acpi/{osi.txt => osi.rst} | 13 +++++++------
 2 files changed, 8 insertions(+), 6 deletions(-)
 rename Documentation/acpi/{osi.txt => osi.rst} (97%)

diff --git a/Documentation/acpi/index.rst b/Documentation/acpi/index.rst
index 624eb95e982b..1b5459e46533 100644
--- a/Documentation/acpi/index.rst
+++ b/Documentation/acpi/index.rst
@@ -7,3 +7,4 @@ Linux ACPI (Advanced Configuration and Power Interface)
 
    namespace
    enumeration
+   osi
diff --git a/Documentation/acpi/osi.txt b/Documentation/acpi/osi.rst
similarity index 97%
rename from Documentation/acpi/osi.txt
rename to Documentation/acpi/osi.rst
index 50cde0ceb9b0..47aaedd1013a 100644
--- a/Documentation/acpi/osi.txt
+++ b/Documentation/acpi/osi.rst
@@ -1,5 +1,6 @@
+==========================
 ACPI _OSI and _REV methods
---------------------------
+==========================
 
 An ACPI BIOS can use the "Operating System Interfaces" method (_OSI)
 to find out what the operating system supports. Eg. If BIOS
@@ -14,7 +15,7 @@ This document explains how and why the BIOS and Linux should use these methods.
 It also explains how and why they are widely misused.
 
 How to use _OSI
----------------
+===============
 
 Linux runs on two groups of machines -- those that are tested by the OEM
 to be compatible with Linux, and those that were never tested with Linux,
@@ -62,7 +63,7 @@ the string when that support is added to the kernel.
 That was easy.  Read on, to find out how to do it wrong.
 
 Before _OSI, there was _OS
---------------------------
+==========================
 
 ACPI 1.0 specified "_OS" as an
 "object that evaluates to a string that identifies the operating system."
@@ -96,7 +97,7 @@ That is the *only* viable strategy, as that is what modern Windows does,
 and so doing otherwise could steer the BIOS down an untested path.
 
 _OSI is born, and immediately misused
---------------------------------------
+=====================================
 
 With _OSI, the *BIOS* provides the string describing an interface,
 and asks the OS: "YES/NO, are you compatible with this interface?"
@@ -144,7 +145,7 @@ catastrophic failure resulting from the BIOS taking paths that
 were never validated under *any* OS.
 
 Do not use _REV
----------------
+===============
 
 Since _OSI("Linux") went away, some BIOS writers used _REV
 to support Linux and Windows differences in the same BIOS.
@@ -164,7 +165,7 @@ from mid-2015 onward.  The ACPI specification will also be updated
 to reflect that _REV is deprecated, and always returns 2.
 
 Apple Mac and _OSI("Darwin")
-----------------------------
+============================
 
 On Apple's Mac platforms, the ACPI BIOS invokes _OSI("Darwin")
 to determine if the machine is running Apple OSX.
-- 
2.20.1

