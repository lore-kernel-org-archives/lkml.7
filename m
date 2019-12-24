Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00ED5C2D0D2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 23:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB2E820663
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 23:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=generalsoftwareinc-com.20150623.gappssmtp.com header.i=@generalsoftwareinc-com.20150623.gappssmtp.com header.b="wAjz7cgz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbfLXXvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 18:51:16 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:36713 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbfLXXvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 18:51:16 -0500
Received: by mail-vs1-f68.google.com with SMTP id u14so13246148vsu.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Dec 2019 15:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=generalsoftwareinc-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6JkYU0nutAHI9fyqNTIL32WnpIq1wjmijBcPApKYOGg=;
        b=wAjz7cgzlGz0o31FJ6Vx7n5Ba/oOxKvrF7Srl0whxYZ6FhhfaX4I7psp34BLJgG4cx
         aFCHEUPK5An291BAIsIsuBoEKB/13f3d0wNHxVnJQcbXbTg0JurOs7xiXCr1IcWx1o+8
         cgEzDy5G1E5ideBv1ZhIrcYHz97Z4z94dUMMfYb7JfklJGvdeuTBuC4cCl2crBKwzxOp
         AsYC7mHUeaqbVsbAixvMC8y44W9w2EMON7TmltQccq/5IKqaFR5pxJ3DmAA0OGmZVZFV
         Kpr34ORmfmiSTW36BxKKKGD8NhsOM8zDf30pBKzSOP+5B0fJWJQZtTeCnXdYfAAyfcbc
         kpmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6JkYU0nutAHI9fyqNTIL32WnpIq1wjmijBcPApKYOGg=;
        b=cxS110hIorSB2wUSPXQYrgbCqsZDXuAs7/w8ijeVRmq++qH5NeiPAbOjhKdKLBEqKH
         9wLwJEg0FUVZYl+vXwDJSdsUjJUapxRxQoh88Z0Ppf8Piwv41E2uKoHqPhs5vwpTEqxB
         N3Zd3uQJlEjKzJoMbIaaxEomrHKkf5hp7srAZHQDIEj3nXJ1SwaAURg9OsTzuI6BCbmP
         Y0xolA/Af+9iI4Erm50RO17p5QEA2RbSi2H6zHz1mFG8zrFark8NOQf88qzj1AblOEns
         L6vFj92uKJxjS5yjryKUSPbusiLamYfWUujBL6tIHkjLgDEsV+II3y7EEOBBAWyE8WiI
         2caw==
X-Gm-Message-State: APjAAAVdhGtl9lJJG0yTNy0Y4V7meo5rDIL1aUGzY8giZngwgFliXgeS
        158Z8jxUtUy4NRCE8cKh9w8P3RSzzpb+RQ==
X-Google-Smtp-Source: APXvYqzPvCHvEG/Y8jIr0SbNCu4DTRUyZvK/m55ySu73VoP7xw1w3PpS1SIAdEknpbK+UKNaDyai5A==
X-Received: by 2002:a05:6102:52e:: with SMTP id m14mr21120368vsa.25.1577231475315;
        Tue, 24 Dec 2019 15:51:15 -0800 (PST)
Received: from frank-laptop ([172.97.41.74])
        by smtp.gmail.com with ESMTPSA id 111sm6290812uae.17.2019.12.24.15.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2019 15:51:14 -0800 (PST)
Date:   Tue, 24 Dec 2019 18:51:14 -0500
From:   "Frank A. Cancio Bello" <frank@generalsoftwareinc.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     joel@joelfernandes.org, saiprakash.ranjan@codeaurora.org,
        nachukannan@gmail.com, rdunlap@infradead.org
Subject: [PATCH 1/3] docs: ftrace: Clarify the RAM impact of buffer_size_kb
Message-ID: <6f33be5f3d60e5ffc061d8d2b329d3d3ccf22a8c.1577230982.git.frank@generalsoftwareinc.com>
References: <cover.1577230982.git.frank@generalsoftwareinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1577230982.git.frank@generalsoftwareinc.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current text could mislead the user into believing that the number
of pages allocated by each CPU ring buffer is calculated by the round
up of the division: buffer_size_kb / PAGE_SIZE.

Clarifies that a few extra pages may be allocated to accommodate buffer
management meta-data.

Suggested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Suggested-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Frank A. Cancio Bello <frank@generalsoftwareinc.com>
---
 Documentation/trace/ftrace.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index d2b5657ed33e..5a037bedbf6a 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -185,7 +185,8 @@ of ftrace. Here is a list of some of the key files:
 	CPU buffer and not total size of all buffers. The
 	trace buffers are allocated in pages (blocks of memory
 	that the kernel uses for allocation, usually 4 KB in size).
-	If the last page allocated has room for more bytes
+	A few extra pages may be allocated to accommodate buffer management
+	meta-data. If the last page allocated has room for more bytes
 	than requested, the rest of the page will be used,
 	making the actual allocation bigger than requested or shown.
 	( Note, the size may not be a multiple of the page size
-- 
2.17.1

