Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32BEFECE58D
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 00:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D10A20663
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 00:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UTJP5c51"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbfJLAhb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 20:37:31 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45065 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbfJLAha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 20:37:30 -0400
Received: by mail-lf1-f67.google.com with SMTP id r134so8197779lff.12
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 17:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KOU51IFsj1iWUWTwrZgYX0bBua/cZqGBz0E2pjuMMik=;
        b=UTJP5c51u97TZQgmSLoRxAc925Tkumx8EJcmpN2Qa463ReM1bWUp4aN9rj4Wo8FsfU
         19TbDGA3FzoulgBqb/PHvZtLhF0VqxWCVzjh+aju5wXruPSLQFPp8TKPQn2j3y43lLvR
         /ML1Y+T3xSkUA7U3uRn/a4eihlQ3sOFHA8kWUGTrMJIVVIszwHEx3VyMY71qjM/p4ggy
         ofLUpySc3mRtQYwcolnmzLyVEhvtu6n6vqUpfIuY/6zfiLtRZyHxIbrxLQqTf3E50p7a
         ce3FP1VdZICSAfhGh7+Cl3B0M7f6I5DKs8lNG574GxL+KO0twj3+ZjcjOb7C4khywNUR
         9IZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KOU51IFsj1iWUWTwrZgYX0bBua/cZqGBz0E2pjuMMik=;
        b=kNwN3ZtRsWNTtDqmhFWRN26F4uaJIzu5DNdnxLUJZix94qIZ9f9unfpynOWXQYddn4
         n1h3N/VhsOoOx1BP5PactCZMbrqfZGXSTXMoBzGhM4HhhVwG5nhgXh3twe0gJY/fzYzx
         YTW49V2upg0alvneT+/4xPVixMh/t0Ev3EKgRyAlwaqqFYseFv1BM0jxEsflZEfxeKMn
         R2NqRs4CN571+2eAC82YRJVtIXA97LPV0QHSkDI+8xZOHK6lS15fDnWotxKcy8tpxccv
         qeli35PAvZ4X18a5cYRei03AkXljpwfuyif3OlRfzGimP4972lGevxBuB6W3MqoizuLj
         W4Lg==
X-Gm-Message-State: APjAAAUjwcUls+dadpiqluoRrWaGQxKrQZMiODDQi/W+pWUkaDIXCzQ1
        eDY053j/Gcsvhz9gvJCxSUk=
X-Google-Smtp-Source: APXvYqyh7VUEelfBevfxp2ozULTq0Wc4+EN6WACxzJmxXe54N++ulhT3aTDtgkmJ0xTyoatL6FeAjw==
X-Received: by 2002:ac2:5bc1:: with SMTP id u1mr10487452lfn.182.1570840648861;
        Fri, 11 Oct 2019 17:37:28 -0700 (PDT)
Received: from octofox.cadence.com (jcmvbkbc-1-pt.tunnel.tserv24.sto1.ipv6.he.net. [2001:470:27:1fa::2])
        by smtp.gmail.com with ESMTPSA id f22sm2346620lfa.41.2019.10.11.17.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 17:37:28 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org, Al Viro <viro@zeniv.linux.org.uk>
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 1/4] xtensa: fix {get,put}_user() for 64bit values
Date:   Fri, 11 Oct 2019 17:37:05 -0700
Message-Id: <20191012003708.22182-2-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191012003708.22182-1-jcmvbkbc@gmail.com>
References: <20191012003708.22182-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

First of all, on short copies __copy_{to,from}_user() return the amount
of bytes left uncopied, *not* -EFAULT.  get_user() and put_user() are
expected to return -EFAULT on failure.

Another problem is get_user(v32, (__u64 __user *)p); that should
fetch 64bit value and the assign it to v32, truncating it in process.
Current code, OTOH, reads 8 bytes of data and stores them at the
address of v32, stomping on the 4 bytes that follow v32 itself.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/include/asm/uaccess.h | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/xtensa/include/asm/uaccess.h b/arch/xtensa/include/asm/uaccess.h
index 6792928ba84a..f568c00392ec 100644
--- a/arch/xtensa/include/asm/uaccess.h
+++ b/arch/xtensa/include/asm/uaccess.h
@@ -100,7 +100,7 @@ do {									\
 	case 4: __put_user_asm(x, ptr, retval, 4, "s32i", __cb); break;	\
 	case 8: {							\
 		     __typeof__(*ptr) __v64 = x;			\
-		     retval = __copy_to_user(ptr, &__v64, 8);		\
+		     retval = __copy_to_user(ptr, &__v64, 8) ? -EFAULT : 0;	\
 		     break;						\
 	        }							\
 	default: __put_user_bad();					\
@@ -198,7 +198,16 @@ do {									\
 	case 1: __get_user_asm(x, ptr, retval, 1, "l8ui", __cb);  break;\
 	case 2: __get_user_asm(x, ptr, retval, 2, "l16ui", __cb); break;\
 	case 4: __get_user_asm(x, ptr, retval, 4, "l32i", __cb);  break;\
-	case 8: retval = __copy_from_user(&x, ptr, 8);    break;	\
+	case 8: {							\
+		u64 __x;						\
+		if (unlikely(__copy_from_user(&__x, ptr, 8))) {		\
+			retval = -EFAULT;				\
+			(x) = 0;					\
+		} else {						\
+			(x) = *(__force __typeof__((ptr)))&__x;		\
+		}							\
+		break;							\
+	}								\
 	default: (x) = __get_user_bad();				\
 	}								\
 } while (0)
-- 
2.20.1

