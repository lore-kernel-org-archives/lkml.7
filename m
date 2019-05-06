Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7769C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 17:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13426216B7
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 17:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ITgh7Mwr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbfEFRML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 13:12:11 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45149 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfEFRMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 13:12:10 -0400
Received: by mail-pg1-f193.google.com with SMTP id i21so6751784pgi.12;
        Mon, 06 May 2019 10:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PKBU7pt8rvrhzoOSyv05XPu1ZaQkpgjUMyroog+NNeg=;
        b=ITgh7Mwr9pGZpYyMMtoYh4n+BueIwFBdjvjXUODlhDAI+zm3BMmO6EzcXEIpfbaN6h
         3brgZ0s5do0pMq9xfGscsjzvZo+EDoFijRlpNH/0p3sGNxl54YPXL0uMySB+Q/ahMoif
         DQV/3bIZ2dJETyWFnlHLElF0V4P3ch7lILj+3I3GYY2zWo4sLhM9LdQKrR+UET/rmeOM
         SavEQKK0Jlwe4ug/YDvaN024/6CqN0fLQlqYjK9ZPqSBLQKXb5xWJGkI1IWernlj339P
         oyqvJDBVyemCBS2lqI5jxHoSJb8sEEs09DOtS9F4o2HDB6dgCfAJMn3uu5pF5pT7Fetk
         CM0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PKBU7pt8rvrhzoOSyv05XPu1ZaQkpgjUMyroog+NNeg=;
        b=JhHumbn8QqQmy+hG4QAhfIwc4HvwJeQvh1Ctrui6cPAJEKiFwsTjOZn2I2Qu0rfvze
         nuydaMitlKJHFGlko/yTHi5u/if9ar1CkX48x1hx8HBatBpGwLeA73vx5hl3SCjINbj8
         74B8YrGDvNHJyOEX930LkbiHu0cUrMAn3hxF0cPdClp/Exq2OgEtoF6Fa4NKUd8lTG00
         LcEiooiKXLiCEL0m+Jamj27ujjCmUgmUstNNCFl0W/GE1l7R8gQYRa84aKMu8UV3PU14
         lsrmwBKbad63uWPz2dJOAQyMhQAbA+Cg+O55Jox2mqpvMk9bfUo6tQnRrnKLDDJF/fK9
         d0cA==
X-Gm-Message-State: APjAAAWQ2JEjvNF3drSIhgStVIGl6AOWqe7dbv45q9BW4Pe+ZACBccIq
        WlF9h4TF2stB4pXa9hPbo3c=
X-Google-Smtp-Source: APXvYqyG++6WLiC9U2lF8C/tXqR24631BLq4q0E9sdXqKMO5143BXUm+ZxZlsFzqL6lM0SIW7HEWTg==
X-Received: by 2002:a63:a1a:: with SMTP id 26mr32690489pgk.11.1557162729247;
        Mon, 06 May 2019 10:12:09 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id h13sm11045680pgk.55.2019.05.06.10.12.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 06 May 2019 10:12:08 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH v3 26/27] Documentation: x86: convert x86_64/cpu-hotplug-spec to reST
Date:   Tue,  7 May 2019 01:09:22 +0800
Message-Id: <20190506170923.7117-27-changbin.du@gmail.com>
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

