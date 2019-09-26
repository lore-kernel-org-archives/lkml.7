Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CFF6C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 17:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63A1E222CD
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 17:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Kt0MPBp1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbfIZR5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 13:57:30 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41731 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728081AbfIZR41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 13:56:27 -0400
Received: by mail-pf1-f194.google.com with SMTP id q7so2246436pfh.8
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 10:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4OoO9/kqQZ9xXFd9jmzh+sji+0+urCkP2+LVDe5fGPM=;
        b=Kt0MPBp1vWYay/J6CTJNxtKhAw6G5wCCoEhbJ7e0+7qQp53wQoH32XMsB7VcjjW8cx
         4n5ei4jcLt5cOlGxwseK9CUNEa1PwMGgojB41dyPkTZ+0nnKv4yyR9ehnWwAElksl0oo
         UL/EWa4ETLAK1IJlRMikbUdclaao+PPrUmFXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4OoO9/kqQZ9xXFd9jmzh+sji+0+urCkP2+LVDe5fGPM=;
        b=lBaBQlECjaebVmA8ZCrwzycXPh09ZMwTsNlEhU6ng6X6u8TsHYjfQH3+m+O7gO0VNM
         JaNJm3mdAIP6gQpC7YdE4q4ihdVZSRRtO1qK6fUgbTVKcjp36MqtqiiKaAfx6t/O0nFr
         JE0BlP2I0V0a0QQF4XzundUqfKynLh16R6IPmwlsV2jC7Yo4/UanmxqI/Z86eh6s0l8I
         V/XrA5R7gUpLDXkIbXSfz92XsV45b+Rkem5Lu3Z02Fnh4SJF/tSEQe90MhDEV7J6hZzu
         pUdJbXYt+J+OutWtyM9vo57WVJIiwkVDvrb66Hrvu1dCAOAHOQdDTbG0s19LZ/0wSvc0
         I3hQ==
X-Gm-Message-State: APjAAAWZ+6AiI5kTvKE4QjnxbgZ+5X0KsWXqJXtzxylYxu6mcImJFmN8
        JgJX0FeDGMq8Io7bJYdDdtyOPQ==
X-Google-Smtp-Source: APXvYqxweRYyy+FuCakseDUP9otT1JrAAZ6K77sV80DCrLZqyiEF0oUZBPpm9+PnY/7XVYYbKaiWnA==
X-Received: by 2002:a63:e514:: with SMTP id r20mr4651534pgh.275.1569520586692;
        Thu, 26 Sep 2019 10:56:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d10sm1358129pgm.4.2019.09.26.10.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 10:56:26 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-c6x-dev@linux-c6x.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michal Simek <monstr@monstr.eu>, linux-parisc@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 14/29] vmlinux.lds.h: Allow EXCEPTION_TABLE to live in RO_DATA
Date:   Thu, 26 Sep 2019 10:55:47 -0700
Message-Id: <20190926175602.33098-15-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190926175602.33098-1-keescook@chromium.org>
References: <20190926175602.33098-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many architectures have an EXCEPTION_TABLE that needs only to be
read-only. As such, it should live in RO_DATA. This creates a macro to
identify this case for the architectures that can move EXCEPTION_TABLE
into RO_DATA.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/asm-generic/vmlinux.lds.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index d57a28786bb8..35a6cba39d9f 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -69,6 +69,17 @@
 #define NOTES_HEADERS_RESTORE
 #endif
 
+/*
+ * Some architectures have non-executable read-only exception tables.
+ * They can be added to the RO_DATA segment by specifying their desired
+ * alignment.
+ */
+#ifdef RO_DATA_EXCEPTION_TABLE_ALIGN
+#define RO_DATA_EXCEPTION_TABLE	EXCEPTION_TABLE(RO_DATA_EXCEPTION_TABLE_ALIGN)
+#else
+#define RO_DATA_EXCEPTION_TABLE
+#endif
+
 /* Align . to a 8 byte boundary equals to maximum function alignment. */
 #define ALIGN_FUNCTION()  . = ALIGN(8)
 
@@ -508,6 +519,7 @@
 		__stop___modver = .;					\
 	}								\
 									\
+	RO_DATA_EXCEPTION_TABLE						\
 	NOTES								\
 									\
 	. = ALIGN((align));						\
-- 
2.17.1

