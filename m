Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A4E5C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB0B4208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hy7Zx1Xk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfDZPez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 11:34:55 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35301 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfDZPew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 11:34:52 -0400
Received: by mail-pl1-f195.google.com with SMTP id w24so1760133plp.2;
        Fri, 26 Apr 2019 08:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/yvtB3uaTRGxnRgaWP7FcK1I6Vvjpy6XLjw84eVyA1w=;
        b=Hy7Zx1XkVkUjOYrBhQUrGQH6vA7nf1W1eDK0gCjj/dn5gdcK6I/Asx8LQ/TLeqv2nV
         oxeteOlgOBjTHqsx94I1+vshwMJ0cRnFZSN/4R2/SLqSXeyRi2MAWBUguv0/KJFxBu+b
         ZXz4imGMQJ3yMsYgnyYqUUt5W/RJB8Uvba2pi+lECjDymDg//8zbwxbONIgwO5cSr1T1
         5rQb/x+Eq84OV07HmWKVbM1390/7wSoUO+dnZBYbMxHb5IN0jVyY1f3gol9+ctItwaBb
         sz4acryjRWrtuSyXYg4F6GdHrnU9xVXFHMAEiffD8PuMCb6OK0e7/s+2CxYn/cIgjlIx
         gmKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/yvtB3uaTRGxnRgaWP7FcK1I6Vvjpy6XLjw84eVyA1w=;
        b=n+4m8/0FzAIHudk3ckU3EKaZsmPLZvdtuG7ImeXHKjPdqBHeQwcPoLKTdWNwxlQvb2
         bZQKXgwGD9xn2nsDTx/EyJIvnr/aZGl8zkbftTq7ZDv0JFViIJMADcW8Ms7MgMZVTdF/
         dSfmwpzcLGl9ae6OiAD5jdGLdSbH/eJ4tIfTi8DrvHEHmcBZksqXLrn33xojy5k1fCjP
         6nPMXTug822+Ewv8zDutx4rC6F1ryg26MWQ95jUYH7+Eu2VDmUET/qOuZqtiv0B6i7iD
         8hPHYuCd3cmzonLqXXlvt/u9NCGUsZQZulirZFSeSRNbqglWjB1tQeM/v9YV1vH9YCkj
         fhBA==
X-Gm-Message-State: APjAAAXyiBbzsYXTAeDjKn/DKr/HEchChW5H7gqgnS8dMpy/Y7pboxuL
        eYukgPbSF7aTk2LLVB3CGXU=
X-Google-Smtp-Source: APXvYqx+XFFSNMdyptPC6bheylkNX1OLLKht4m00w1EqHUFBc4bD1V3kgftEmEFOOeYx/JRxMZkSKQ==
X-Received: by 2002:a17:902:8a4:: with SMTP id 33mr46785950pll.7.1556292892025;
        Fri, 26 Apr 2019 08:34:52 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id b1sm29024833pgq.15.2019.04.26.08.34.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 08:34:51 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab+samsung@kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 26/27] Documentation: x86: convert x86_64/cpu-hotplug-spec to reST
Date:   Fri, 26 Apr 2019 23:31:49 +0800
Message-Id: <20190426153150.21228-27-changbin.du@gmail.com>
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
 .../x86/x86_64/{cpu-hotplug-spec => cpu-hotplug-spec.rst}    | 5 ++++-
 Documentation/x86/x86_64/index.rst                           | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)
 rename Documentation/x86/x86_64/{cpu-hotplug-spec => cpu-hotplug-spec.rst} (88%)

diff --git a/Documentation/x86/x86_64/cpu-hotplug-spec b/Documentation/x86/x86_64/cpu-hotplug-spec.rst
similarity index 88%
rename from Documentation/x86/x86_64/cpu-hotplug-spec
rename to Documentation/x86/x86_64/cpu-hotplug-spec.rst
index 3c23e0587db3..8d1c91f0c880 100644
--- a/Documentation/x86/x86_64/cpu-hotplug-spec
+++ b/Documentation/x86/x86_64/cpu-hotplug-spec.rst
@@ -1,5 +1,8 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===================================================
 Firmware support for CPU hotplug under Linux/x86-64
----------------------------------------------------
+===================================================
 
 Linux/x86-64 supports CPU hotplug now. For various reasons Linux wants to
 know in advance of boot time the maximum number of CPUs that could be plugged
diff --git a/Documentation/x86/x86_64/index.rst b/Documentation/x86/x86_64/index.rst
index e2a324cde671..c04b6eab3c76 100644
--- a/Documentation/x86/x86_64/index.rst
+++ b/Documentation/x86/x86_64/index.rst
@@ -12,3 +12,4 @@ x86_64 Support
    mm
    5level-paging
    fake-numa-for-cpusets
+   cpu-hotplug-spec
-- 
2.20.1

