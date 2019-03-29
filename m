Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D29E9C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 20:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 507BE204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 20:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="T5XH4UXx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730332AbfC2Ux7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 16:53:59 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34390 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730151AbfC2Ux6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 16:53:58 -0400
Received: by mail-ed1-f67.google.com with SMTP id x14so3194928eds.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 13:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1EdFJr1wqFodZvRBJe1lUJf8A8cE8w12Blsb/XkAOvk=;
        b=T5XH4UXx+82HvAjoLPk/gVafZHUuyM0GfCiicuqdJEVr8+iEmUuoNSGiQg9a0RLxPj
         JKZEQw0++ukSv7iQe/JqJD9yFU7WdjHg8tAnBzkjideHRPvvfbYXxyl52ewbsoDdm201
         0xtMgBNvyHhksi6A0wrqg9wNyyswdA5YIdGxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1EdFJr1wqFodZvRBJe1lUJf8A8cE8w12Blsb/XkAOvk=;
        b=bRBxMeqqzWMatPBis1rrJxAAVxkBY2Nin4P37LowqQYegwQwWKpIjgJsmMgu5beoFN
         NnEYUFqEbfQTioi5Bz7ZXAvjOc+4Tst2OxxSZTAPD06wH4MYq0PS3HWDI9jrdD75Dg9m
         iZlMcsgBjS4lnx2mFtugfCCbq8vJWnGiM8aQbffnkjXJgFowCfOghrrY24bKarhUdkPu
         dSvVMrwjp5sMMbreELSQSf8RM7mTYUhZXCgkIuFUtgtcKlujceAcNTKMBrRUqethwN7R
         +mIDDkukVFrQWOE29icq684iDuaJGPAJXgo+H5mh6WZxrb6RfDC1832nwqX0O9WOP37i
         lFjA==
X-Gm-Message-State: APjAAAXc3XUIt75tcjUvZ+ZqVgWzpo3u7plMB3+58IxDCVyxOd39Zkkc
        orKEH1SeFPLDOzGlArOh4HznIQ==
X-Google-Smtp-Source: APXvYqyStjGuth1FAQd8JN4AYOWXjjyM1PG3adp1ZRF1iivryVSNt2EDfCRhRazvcapAWfovZcG0lw==
X-Received: by 2002:a50:f9c1:: with SMTP id a1mr33223660edq.278.1553892836955;
        Fri, 29 Mar 2019 13:53:56 -0700 (PDT)
Received: from prevas-ravi.prevas.se (ip-5-186-118-63.cgn.fibianet.dk. [5.186.118.63])
        by smtp.gmail.com with ESMTPSA id 35sm902636edh.43.2019.03.29.13.53.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 13:53:56 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Yury Norov <ynorov@caviumnetworks.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] lib/bitmap.c: remove unused EXPORT_SYMBOLs
Date:   Fri, 29 Mar 2019 21:53:50 +0100
Message-Id: <20190329205353.6010-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AFAICT, there have never been any callers of these functions outside
mm/mempolicy.c (via their nodemask.h wrappers). In particular, no
modular code has ever used them, and given their somewhat exotic
semantics, I highly doubt they will ever find such a use. In any case,
no need to export them currently.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 lib/bitmap.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index 98872e9025da..66421f304f7d 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -757,7 +757,6 @@ void bitmap_remap(unsigned long *dst, const unsigned long *src,
 			set_bit(bitmap_ord_to_pos(new, n % w, nbits), dst);
 	}
 }
-EXPORT_SYMBOL(bitmap_remap);
 
 /**
  * bitmap_bitremap - Apply map defined by a pair of bitmaps to a single bit
@@ -795,7 +794,6 @@ int bitmap_bitremap(int oldbit, const unsigned long *old,
 	else
 		return bitmap_ord_to_pos(new, n % w, bits);
 }
-EXPORT_SYMBOL(bitmap_bitremap);
 
 /**
  * bitmap_onto - translate one bitmap relative to another
@@ -930,7 +928,6 @@ void bitmap_onto(unsigned long *dst, const unsigned long *orig,
 		m++;
 	}
 }
-EXPORT_SYMBOL(bitmap_onto);
 
 /**
  * bitmap_fold - fold larger bitmap into smaller, modulo specified size
@@ -955,7 +952,6 @@ void bitmap_fold(unsigned long *dst, const unsigned long *orig,
 	for_each_set_bit(oldbit, orig, nbits)
 		set_bit(oldbit % sz, dst);
 }
-EXPORT_SYMBOL(bitmap_fold);
 
 /*
  * Common code for bitmap_*_region() routines.
-- 
2.20.1

