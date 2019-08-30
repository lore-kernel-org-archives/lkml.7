Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A78FC3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 23:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB5E023431
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 23:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="b+YA+3ES"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbfH3XPh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 19:15:37 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41843 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728420AbfH3XPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 19:15:36 -0400
Received: by mail-ed1-f68.google.com with SMTP id z9so4475171edq.8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 16:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EITwBjrLXSeaqco3tdwlSiFA9QTDrFXAMEenrsCPuR4=;
        b=b+YA+3ESUD4gokGRN7Fagcj+UBDU1kvNmUcWadmh//+/vY8g88S8BTsXZMKjqSp/rR
         QyahQsHohvDeg4kxFKNOHaAmqpMQaZ0RMNSaX5N2Xss5QQsAPIuxBDG+SsFHzscTh8j6
         G8b+lT0rxBOGKEGZ/99iHP7J4JlLDEKozoLdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EITwBjrLXSeaqco3tdwlSiFA9QTDrFXAMEenrsCPuR4=;
        b=C7eb1rYzdEl2lvz75HKqYX9gwoj1AoTZtJNpno6UZm9wfQ3VHomTOH5+Ha3mlKLAIe
         c3IUFOPrT100V3hB1xgfxTBJ/pxtxytKe4R7JYXPyuhWtSXXLsHZeGLIfw4RfT33RDkO
         bjs8jK3Qrpm3SA4jqJZBXuPGRk3eoyUW/fALWIs4vP/R/v7FTZHoQfSnD1wFH7Omg9ld
         3u8e6Rz0HlTTtKnfNEMvhqF8phZ5pDhMMR9Y+h4gS+0pAJRyjG8C3rHbhJcOM/PD8Og+
         estxWZuvbi5Xxpw7GPTei9pVbsmTE5ayMTXyDfmjodJ7bPdlsnwMk+A4zNGJ1el3BF15
         IjGw==
X-Gm-Message-State: APjAAAUuzHVZXaRlk/ewDz9N52Am78hMupkA4Ys0RsA6LFPSgOPUVm43
        GHYr5UbD2Oozis5ifP7F68S3ww==
X-Google-Smtp-Source: APXvYqyg+6eIrgyCSxWqsNHG0gEZMaJ5rB8dc63fcdCHD7EwqkkCgkUjLZOnf/obFUa7OZZKPR2VEQ==
X-Received: by 2002:a17:906:f145:: with SMTP id gw5mr15109316ejb.34.1567206935146;
        Fri, 30 Aug 2019 16:15:35 -0700 (PDT)
Received: from prevas-ravi.prevas.se (ip-5-186-115-35.cgn.fibianet.dk. [5.186.115.35])
        by smtp.gmail.com with ESMTPSA id s4sm875457ejx.33.2019.08.30.16.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 16:15:34 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Nadav Amit <namit@vmware.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        ndesaulniers@google.com,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v2 2/6] lib/zstd/mem.h: replace __inline by inline
Date:   Sat, 31 Aug 2019 01:15:23 +0200
Message-Id: <20190830231527.22304-3-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190830231527.22304-1-linux@rasmusvillemoes.dk>
References: <20190829083233.24162-1-linux@rasmusvillemoes.dk>
 <20190830231527.22304-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, compiler_types.h #defines __inline as inline (and further
#defines inline to automatically attach some attributes), so this does
not change functionality. It serves as preparation for removing the
#define of __inline.

(Note that if ZSTD_STATIC is expanded somewhere where compiler_types.h
has not yet been processed, both __inline and inline both refer to the
compiler keyword, so again this does not change anything.)

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 lib/zstd/mem.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/zstd/mem.h b/lib/zstd/mem.h
index 3a0f34c8706c..739837a59ad6 100644
--- a/lib/zstd/mem.h
+++ b/lib/zstd/mem.h
@@ -27,7 +27,7 @@
 /*-****************************************
 *  Compiler specifics
 ******************************************/
-#define ZSTD_STATIC static __inline __attribute__((unused))
+#define ZSTD_STATIC static inline __attribute__((unused))
 
 /*-**************************************************************
 *  Basic Types
-- 
2.20.1

