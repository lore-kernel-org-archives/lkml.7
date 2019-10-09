Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56308C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 21:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DBDE206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 21:45:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ny2mlXdy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732087AbfJIVp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 17:45:29 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39737 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729865AbfJIVp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 17:45:28 -0400
Received: by mail-lj1-f193.google.com with SMTP id y3so4021250ljj.6
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 14:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KG74i+Cm65AJ3tsZa8mB9CCPbfVwRwQgBzXmouWHx+E=;
        b=ny2mlXdyj5wLpNUzmWNkbxmNLI1cjZ9fcDYPoQ8S+IoUG7uozAZhbsYgUUGH58et7m
         Dco2WhKPAxodi/HNnTC3plrIlv2MKXK34oI3MY/R9GTO8xWLrLaxFVIngPqsaTcf2JIr
         pb+ce5AlcqiOrzN8ZbjIlIYcAt+fiGjoRCh8PLK+ktWmT6+9tk19i91IGHvkteCk+I+c
         abUWkAm/ydhiHqccLsPyCh+aNwOVS48ls/GWeFxMs3Wg3ZNT+8tP5mJ5Q3p9TKAz5pFL
         LCSFo3wdd0B+H7TGL/NSY+KfFQaLi+KVvw0gaqVjqW/WehxuoVRlqQyT+b2qM6hmi6Pt
         rpBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KG74i+Cm65AJ3tsZa8mB9CCPbfVwRwQgBzXmouWHx+E=;
        b=izaTF97/kGtpe9MHBBYrXL8qPs8w2Nk32kDoNlLjJSvfy1VRS1zFWcNxsuwo838kjI
         JmrJBzWHgpmdBfkHJaUYw+nexen8i+hBMxnsbdPX6qwhMxzRAMvNjQzOfKPNfkc5ib0M
         1gf/ZbBn0U4XXWNgCuYstDLerSRGJbbQv3X3wGN+tJHcEpxzcUXrCWg3M39FWfEg1iho
         6DiEaT7Uo97ISSSUIB3GGP36c8NcC8503a5FA8KtGt2xeoi26qAxrs3fF7PTXFNBF5Ks
         YT8cFIwLX+lKQ+37iMSv8HoqfFKCmAN69shh+7tkgENb+iemLD2OGHDjxvdpbRcyoLNP
         huTA==
X-Gm-Message-State: APjAAAUx33jEpoCUt7BrneNrg3/USVnACSj6jVEzNWEWvSXK9INB5MCF
        jpsyeni0z+b2CELScrOLocw=
X-Google-Smtp-Source: APXvYqyL2cRl/mypPhb587cMfNQ0/f7Jz5LZtUkG7u1kb6PnZSpPcBw2J9dU8CIu0N25usU0SOAdSA==
X-Received: by 2002:a2e:86cd:: with SMTP id n13mr3823199ljj.252.1570657526593;
        Wed, 09 Oct 2019 14:45:26 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-228-153.NA.cust.bahnhof.se. [98.128.228.153])
        by smtp.gmail.com with ESMTPSA id v22sm701503ljh.56.2019.10.09.14.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 14:45:25 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     rikard.falkeborn@gmail.com
Cc:     akpm@linux-foundation.org, bp@alien8.de, joe@perches.com,
        johannes@sipsolutions.net, keescook@chromium.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        yamada.masahiro@socionext.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [Patch v4 1/2] linux/build_bug.h: Change type to int
Date:   Wed,  9 Oct 2019 23:45:01 +0200
Message-Id: <20191009214502.637875-2-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191009214502.637875-1-rikard.falkeborn@gmail.com>
References: <20190811184938.1796-1-rikard.falkeborn@gmail.com>
 <20191009214502.637875-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having BUILD_BUG_ON_ZERO produce a value of type size_t leads to awkward
casts in cases where the result needs to be signed, or of smaller type
than size_t. To avoid this, cast the value to int instead and rely on
implicit type conversions when a larger or unsigned type is needed.

Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
Changes in v4:
  - Added Kees and Masahiros reviewed-by tags.
Changes in v3:
  - This patch is new in v3

 include/linux/build_bug.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/build_bug.h b/include/linux/build_bug.h
index 0fe5426f2bdc..e3a0be2c90ad 100644
--- a/include/linux/build_bug.h
+++ b/include/linux/build_bug.h
@@ -9,11 +9,11 @@
 #else /* __CHECKER__ */
 /*
  * Force a compilation error if condition is true, but also produce a
- * result (of value 0 and type size_t), so the expression can be used
+ * result (of value 0 and type int), so the expression can be used
  * e.g. in a structure initializer (or where-ever else comma expressions
  * aren't permitted).
  */
-#define BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:(-!!(e)); }))
+#define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
 #endif /* __CHECKER__ */
 
 /* Force a compilation error if a constant expression is not a power of 2 */
-- 
2.23.0

