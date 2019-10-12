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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8331C47404
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 00:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DA752089F
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 00:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cf06n0Hk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbfJLAHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 20:07:33 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45800 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbfJLAHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 20:07:33 -0400
Received: by mail-lf1-f65.google.com with SMTP id r134so8171302lff.12
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 17:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KOU51IFsj1iWUWTwrZgYX0bBua/cZqGBz0E2pjuMMik=;
        b=cf06n0Hkxhy7kOh2+h4NMzhGw1OlsYghnaOjmz20S8X3irPNDR5+EZx4sRFVuWWnsT
         GNk+GUokwj9gqRZX+BJC9/1P0GY5lr6aBN+zddHlXQpTYn2+LB6ob8rzC85D7BnLYxSN
         OcRui87Nstph8ts/eUe7VxYBYWTssr8iWekrJAdC2dr0CIWZg+2a8muhXUXjo/GC1QL6
         WKNkh+hnb2An7bkTB3QcuJXT03Q/SrrddBgU2yW59/ZBJJ6PSwC+SDcssMCmJqU4WWpZ
         6mSngT+q53l5xM7SCgIWriPoeO33E20DQAVSby3nZkxzkCQC7hKWtnx1Dm7cRZh3jehC
         jPtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KOU51IFsj1iWUWTwrZgYX0bBua/cZqGBz0E2pjuMMik=;
        b=nenQzUlVh9kvXWpCh1rYSoTgnieAFrsipeIFYrjB+T89H9lmQBaTP9AO6HyZqfu3NV
         /LFEfFxhTOhEWooguArOdJ5IrIt95CeLxjWfEJkmk6+yYT98RF86vmGz5VM+ErnbqG1D
         uu2M6Z+FchX9WmRc7r5aws4mhDsHfx/37c5pHiyxqjr3RZDX/iZgspHa6jYqYDuALRWO
         v3XahBg7rYKb+qLX9TrSOGivz7IxGrVk8mH0fM3XoqtywyqZDURb0jy6a1fmZdCc5rOC
         PkwGIlhNQygAW9UTNaF1JulzUBWqeS2qnpni9laHfsp/d50xQv4vPDms6zgE9V6f5l3N
         joMg==
X-Gm-Message-State: APjAAAVjhZeCw6kssccV97341qsl/eGHyDNQL5pVCGCR/J2YM1aXYSrq
        1Qu+x3Vufr94rYLfj12R1Ds=
X-Google-Smtp-Source: APXvYqwYdmZMj7678HK/tvZJ2dro1f5xYGc78HMplO3y9uphHeSRU8KsXptHwuptP2ocEcTM+3mCEQ==
X-Received: by 2002:a19:f813:: with SMTP id a19mr10378473lff.154.1570838851010;
        Fri, 11 Oct 2019 17:07:31 -0700 (PDT)
Received: from octofox.cadence.com (jcmvbkbc-1-pt.tunnel.tserv24.sto1.ipv6.he.net. [2001:470:27:1fa::2])
        by smtp.gmail.com with ESMTPSA id x17sm2215705lji.62.2019.10.11.17.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 17:07:29 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org, Al Viro <viro@zeniv.linux.org.uk>
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 1/3] xtensa: fix {get,put}_user() for 64bit values
Date:   Fri, 11 Oct 2019 17:07:09 -0700
Message-Id: <20191012000711.3775-2-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191012000711.3775-1-jcmvbkbc@gmail.com>
References: <20191012000711.3775-1-jcmvbkbc@gmail.com>
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

