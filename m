Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A9FC76191
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 12:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40751229F3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 12:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Akqpe6Ca"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404554AbfGYMRJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 08:17:09 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:49436 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729579AbfGYMRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 08:17:08 -0400
Received: by mail-pf1-f201.google.com with SMTP id 145so30763401pfw.16
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 05:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:cc;
        bh=ljHSm6Zzu7WQyG9Dr0/JwBFIPwkJWPZ7lmDnCVtXIlE=;
        b=Akqpe6Ca2kvfIFTvnoJ+c5OIYtAWTfjYFlxZ91JhehPR4MBfJm9ywhoCD3lGefBXW0
         n7SlpQFWfYgG4Aeujtxv2t7rdZa2kXKrO9hHdeloLRjBRpBGpMGC+IgBRq2hYlz74cwT
         010HpW9jL8W5gbrRGoEO3Y5fFruckvISszQcCXS5Fakkmmuet7C21J+u8swlLNVNjOq5
         Y1f7sdvOFzNM443uu1ysPbXSRudZDiBnFMX+WjpLHVbB5ENiuVLz2sPMw8Llub0ae2DF
         odjWLHT2fIwPD/mrVsCYEKgBnlnMvrlYvMqvBgUUd2lfogU6I9BnZ/kduh+R4OJE/trK
         0jzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:cc;
        bh=ljHSm6Zzu7WQyG9Dr0/JwBFIPwkJWPZ7lmDnCVtXIlE=;
        b=gESRrLKTFH5HHuhGCyYh1JX0wbPNr/ntTyz/2gk3yodbJnoKSP+YUtPd0alCQnfTZE
         v9kGIhU8kPeIOzzLnm9cooqh4snFFq97KZOB89tDLUyK85tbvqGuiITXa+GZwv6edcMM
         QwhRJsIYh28a0an6wEq9/iEyNRAiZvbZdY3g99uShae4+TPcNOwBNGUU9vRL5EotOtCj
         Xyo8EK7BzkAirNRA2z8h4DBMKdOOXXBHPcm2w70vGNS/FixeQgp+5makxxEhngZuvcJ6
         04/Pad6VZ46mjoZ+miY0VENdu+dQvXaEPdMBNZh1QuGRUzxHJcbScAiGwPOVI66ylfk3
         Ts0w==
X-Gm-Message-State: APjAAAVXNM77BSbvJZY2oiBycFwuRGG+oRIJGFx9lSBr4Opp+1zywQlM
        dXIp3/5BfWp/zlrMdZbZQQQMUOBrZM8=
X-Google-Smtp-Source: APXvYqz7yDmnI8s4vZuY1Ns1rw5n80XNvB05UiBPhLd8LH+m+RekLRU9SaXAoHp8e/m+hAePiBCX3thvsdg=
X-Received: by 2002:a63:cb4f:: with SMTP id m15mr10449746pgi.100.1564057027478;
 Thu, 25 Jul 2019 05:17:07 -0700 (PDT)
Date:   Thu, 25 Jul 2019 14:17:03 +0200
Message-Id: <20190725121703.210874-1-glider@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
Subject: [PATCH] test_meminit: use GFP_ATOMIC in RCU critical section
From:   Alexander Potapenko <glider@google.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmalloc() shouldn't sleep while in RCU critical section, therefore
use GFP_ATOMIC instead of GFP_KERNEL.

The bug has been spotted by the 0day kernel testing robot.

Fixes: 7e659650cbda ("lib: introduce test_meminit module")
Signed-off-by: Alexander Potapenko <glider@google.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-security-module@vger.kernel.org
---
 lib/test_meminit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_meminit.c b/lib/test_meminit.c
index 62d19f270cad..9729f271d150 100644
--- a/lib/test_meminit.c
+++ b/lib/test_meminit.c
@@ -222,7 +222,7 @@ static int __init do_kmem_cache_size(size_t size, bool want_ctor,
 		 * Copy the buffer to check that it's not wiped on
 		 * free().
 		 */
-		buf_copy = kmalloc(size, GFP_KERNEL);
+		buf_copy = kmalloc(size, GFP_ATOMIC);
 		if (buf_copy)
 			memcpy(buf_copy, buf, size);
 
-- 
2.22.0.657.g960e92d24f-goog

