Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B0FAC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 15:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B587214AF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 15:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SjmyFUhL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbfEHPWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 11:22:07 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44102 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbfEHPWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 11:22:06 -0400
Received: by mail-pl1-f196.google.com with SMTP id d3so6064038plj.11;
        Wed, 08 May 2019 08:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rQAGErRRsp1BGyaJxVL4RRJn7QR6RpeFY3r/P7e2cqs=;
        b=SjmyFUhLRA1bjconSiw5JXAtfkct5FPvWg3deuIW2y/v+Xr4wQIFgCZyC+/Ly25Kt3
         ooV5sCbwWjrEoJjzTmdXm98Lmgi0Ka2um/orX5ZOFK71g1IkBap4P4CzCLQ2qyIKCmGY
         EunV7zWrpnZUIhAL6nwMUQ0iBwb6G0WjjdoMn5MSRcekRcrQPQEhjVTH+LwV+2lKVQMY
         7hsGAzuc7MjhSZLzScFXL/02zDcAebGSYXwAe6xN4LlDYApKNMLIEoVb0eshcQaH70PC
         HbAkP/1h+IgC+J3q09S1jP0+HIFallVmyzQuvPA5EgAKMBy8tJAIRYoqo6+46bXFBgN5
         iyVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rQAGErRRsp1BGyaJxVL4RRJn7QR6RpeFY3r/P7e2cqs=;
        b=haaw5qHG1UXK49Pwqbl4mGP3KRbpT+Qms7SOMzaqKuOWbJfgUBX1Fsjr0Py5ItFo3c
         OZN4zDihTllJ98r0AkvVlX/mvoMuW9tYJAZf5rEJPuVJbF+zC1VeK5DaGT3Z3wOTy2HB
         sBuxXUkf4e60En+E021X+AVBRRjYB7bKT+/tZZpbqawVzMbpQOikqugWa2jGqawwC8CQ
         ueyeFcbjD3S/i0XhO8LhNiEhIuk5H7S/Egj8CavvulCwdNy1iiHbXZFQXlwgkkIVrQLi
         ZRtBl1MLOCuctZadlR8IJB4qFGhYVzu6C+/CbMRs6OgeaaPoY0qOLvHxCFZ1LDDL3GtT
         4ELg==
X-Gm-Message-State: APjAAAWa5g7BhOSeN51EBlez0/Nd30BPr3OD0c5yuSeQ/fAjsWWjbCXF
        PHurQLzhGedTMC6uc2Az08A=
X-Google-Smtp-Source: APXvYqwYbXS2P4AaBePCrAe9XYT3/X7iIXjHQ5MMkSWj3kJOCv9b7rB5izOPgPjLxMb5yPBY9Y6cWw==
X-Received: by 2002:a17:902:5910:: with SMTP id o16mr47253075pli.289.1557328925638;
        Wed, 08 May 2019 08:22:05 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id o73sm7459360pfi.137.2019.05.08.08.22.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 08 May 2019 08:22:05 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH v4 01/27] Documentation: add Linux x86 docs to Sphinx TOC tree
Date:   Wed,  8 May 2019 23:21:15 +0800
Message-Id: <20190508152141.8740-2-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190508152141.8740-1-changbin.du@gmail.com>
References: <20190508152141.8740-1-changbin.du@gmail.com>
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

