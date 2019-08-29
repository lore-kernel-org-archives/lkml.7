Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F37D8C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C470F215EA
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="X0VNkjtT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbfH2IeP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 04:34:15 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44963 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbfH2Icx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 04:32:53 -0400
Received: by mail-lf1-f66.google.com with SMTP id v16so1799493lfg.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 01:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XkUWp3b3ycOUyoALBiZbxKCqXUbdVPy7VrhNLZLe71M=;
        b=X0VNkjtTYFpdhzRXW5Ikf4F64e7hLmV9geeqcqjmVbLli1ohj7crDdQpVTqziWFiek
         8yuqeH8nUEG5x2W9IgZOwy+eUO3oRgWgH3TQdFbfHa8T0uoxODaTDAxtqAtMboL05N7o
         5b+z+KQ3FDyeqcqXjT9QAVaizjqH8qfhDqeOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XkUWp3b3ycOUyoALBiZbxKCqXUbdVPy7VrhNLZLe71M=;
        b=A+szBUnttUMOxaJ17h8cWp1uRrkHI4S7iOh3fOGwDfI51xq8Qmpzg3blcf5auajp5f
         y7aZxHACnSre06p0y4kcgCm93Vw0K5IM5r44oi49HUkPi3qrfNl7kFBdg99NVX0G9tx9
         G6vBLAHP71RsJfhJmZmQ9UsmyIOsFZMH+34JGDte5q+x3DCOJgGKiq9kxK8NxEOeULRZ
         sOX+kND70jasJC817qSttF7Kc1tG48jVSu0lFWkeANguIPxq7miuJbVobmVvpPOPenZO
         VPbOpmvKgaxB73ugh6Nsa7AbpGulTNFqIIc40GnQitTvwdicURtGJTEnr6L47bp9c+JG
         tZ4Q==
X-Gm-Message-State: APjAAAULQU3J0gWb4OGonpDDodf2TD9j+/2wtp4EZJVxFBgI+QIdUhFB
        s29Mt9/wWsYFHmPD4XVyhZAHIA==
X-Google-Smtp-Source: APXvYqziDCjW82KRY3HmNyGsmWvb0YOERBJNUwhGClcxiRmgJYCU4R95yEOKmdgCTXRwBw/zzFg5yA==
X-Received: by 2002:a19:4b0d:: with SMTP id y13mr5481811lfa.128.1567067571941;
        Thu, 29 Aug 2019 01:32:51 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id o20sm248087ljg.31.2019.08.29.01.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 01:32:51 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Nadav Amit <namit@vmware.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        ndesaulniers@google.com,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [RFC PATCH 2/5] compiler_types.h: don't #define __inline__
Date:   Thu, 29 Aug 2019 10:32:30 +0200
Message-Id: <20190829083233.24162-3-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190829083233.24162-1-linux@rasmusvillemoes.dk>
References: <20190829083233.24162-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The spelling __inline__ should be reserved for uses where one really
wants to refer to the inline keyword, regardless of whether or not the
spelling "inline" has been #defined to something else. Most users of
__inline__ have been converted to inline, for the remaining, this
represents a small change of semantics.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/compiler_types.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 599c27b56c29..4a8b63e3a31d 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -150,7 +150,6 @@ struct ftrace_likely_data {
 	__maybe_unused notrace
 #endif
 
-#define __inline__ inline
 #define __inline   inline
 
 /*
-- 
2.20.1

