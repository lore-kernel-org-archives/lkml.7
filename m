Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 187C5C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 17:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCE042053B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 17:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4dug0xH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbfEFRJq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 13:09:46 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41166 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbfEFRJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 13:09:46 -0400
Received: by mail-pl1-f195.google.com with SMTP id d9so6678961pls.8;
        Mon, 06 May 2019 10:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rQAGErRRsp1BGyaJxVL4RRJn7QR6RpeFY3r/P7e2cqs=;
        b=l4dug0xHkEdP2rrP675U6YOpbE7L8wXbXJ4TLo8d3MDvInhhL7FFHOnoBlMlt4EF8T
         FIyCJR+/h4xYhhIzfm4ktS4WHYtlQbM7z4dGR01sIoca32K+j8ci/7beJXz54bxNXG0c
         WDbS0w6caAiloipRuADy6OvSe5arr9PwN4EWj/hHYj/WUQ/+ACKdNWR2ImjsMW+R7Q9w
         WTSmHzIoybWKy/M95K9vpO2a07w0kXAlE6kBeXJ/7iYP01IWZesgFf87xjH2++hiCDn9
         gWw0PadhPTwT8pBL+3e+kGXT4LXotIKZbFE8y8E40/tTasoZhtwVMBf5/lb7rpWSsHlG
         9Mgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rQAGErRRsp1BGyaJxVL4RRJn7QR6RpeFY3r/P7e2cqs=;
        b=V9GQmHHcQaDJJpq/GqNRQeRoMdDZohoX3uqSo2D0fp68o8A4cONjey3GGEvbuGKt9x
         89xCx9e0iINIWukmki/NyUkxRCThg7hL+v7ETj6WJOVxGJDXpCPCZ/aDvFdOTb8IeRjQ
         oJMRKLcoUukeidRU1WWWOn0AMzzrHDi71AiD2JAD1bxx2MtQsQd/jkotUDGqMxTZD3tl
         NtNx8eu0ajdDFq8/kRel25YpsV6dibHt74Df4Lj3rDuGsCzmjc2hv+06uHwm17T9Hi3J
         /k2GwPmzFr0WnvCUxalK1CdYCvJyqUN2ysaqlvrefhzv/a4EqmzzDTLQgxmqEGMH+WN3
         qZFw==
X-Gm-Message-State: APjAAAX9drDu6rnRa6nDKs7My5nX0cX0GQVtkYg00j5akSMzi1XuYpfg
        m2AzY1NxV9M5IIQsZjOikRo=
X-Google-Smtp-Source: APXvYqy5Q+ATC4Wcm1BMUsggOzQ8J0jiRtVXBVp9EEd7PEgq33hqDSRHIOx0oQ8YW3b0VCjnA7jkxg==
X-Received: by 2002:a17:902:b489:: with SMTP id y9mr2895707plr.70.1557162585340;
        Mon, 06 May 2019 10:09:45 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id h13sm11045680pgk.55.2019.05.06.10.09.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 06 May 2019 10:09:44 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH v3 01/27] Documentation: add Linux x86 docs to Sphinx TOC tree
Date:   Tue,  7 May 2019 01:08:57 +0800
Message-Id: <20190506170923.7117-2-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190506170923.7117-1-changbin.du@gmail.com>
References: <20190506170923.7117-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a index.rst for x86 support. More docs will be added later.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/index.rst     | 1 +
 Documentation/x86/index.rst | 9 +++++++++
 2 files changed, 10 insertions(+)
 create mode 100644 Documentation/x86/index.rst

diff --git a/Documentation/index.rst b/Documentation/index.rst
index 80a421cb935e..d65dd4934a1a 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -101,6 +101,7 @@ implementation.
 .. toctree::
    :maxdepth: 2
 
+   x86/index
    sh/index
 
 Filesystem Documentation
diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
new file mode 100644
index 000000000000..9f34545a9c52
--- /dev/null
+++ b/Documentation/x86/index.rst
@@ -0,0 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==========================
+x86-specific Documentation
+==========================
+
+.. toctree::
+   :maxdepth: 2
+   :numbered:
-- 
2.20.1

