Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 686FAC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 21:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6266B206EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 21:45:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="fMdFyNK+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfKMVp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 16:45:28 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37305 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbfKMVp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 16:45:27 -0500
Received: by mail-wm1-f68.google.com with SMTP id b17so3687521wmj.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 13:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VCIGNym1KnSbrflz0aPgysV9g2CKRub3cea0GIpdFfg=;
        b=fMdFyNK+SymwdAECuwGh5bgHiLHM52dlM8jOA7UMmkyThGbzpgqWdiZvnbYfi7Q5X/
         j8rrzeyjUH4OHFGBfQVetXMSg4HnUM6L7SqEx7WB5Iq8rF/KmJ+WVTiCgnfWP0Sx2EOj
         omXRh2a572Q2dOE+jH/Z+H/Igd+HuEMtjmDQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VCIGNym1KnSbrflz0aPgysV9g2CKRub3cea0GIpdFfg=;
        b=SSfcgHqzTtDqR9ipj0N5BNbCBpVRGTWTvqUakVK/15XrzBYUSOwHd5bvvOkXLCtaWI
         CkkwTDywHAYJDLyNW+of9nuvSQBYkqNeC78sm8ZrElFjUHr4eSsvKTwphF5T6dEWakN6
         xiwOGPM0Wrz/6/OIyBJwivyrum+P1RRQbT8QJEh9YYTJMlAR+zZDEymbVzHDHkFWgLKi
         bW7RdutwbsRAuqwNwZuPB2h9hlVFtpsQAupbYKsAlc0KFT+5xy/1x0J5GPBHL0NH1d9+
         xg/IMpIR1PlkwTT7bWaSQ+KMfM3+on98QEkVIqXRwkt3Kac9byMz7zec4hjWcOsHnD1p
         zERw==
X-Gm-Message-State: APjAAAXloxS5+kfeXpocs6/N5tZ8H0/HS0iz4Vs4yXm8f4eKM7VITKKA
        4DrT9nL0RiPMjYnb/G9VT6m8aQ==
X-Google-Smtp-Source: APXvYqxfYNjJ9YUKGN42stJr40vzZ7uxffjOy9HavGJeFiHz5gHpLiX9J8pnt+qzLJb3/NNwObpklA==
X-Received: by 2002:a1c:41c2:: with SMTP id o185mr4419000wma.34.1573681524367;
        Wed, 13 Nov 2019 13:45:24 -0800 (PST)
Received: from prevas-ravi.prevas.se (ip-5-186-115-54.cgn.fibianet.dk. [5.186.115.54])
        by smtp.gmail.com with ESMTPSA id y78sm3997722wmd.32.2019.11.13.13.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 13:45:23 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs/namei.c: micro-optimize acl_permission_check
Date:   Wed, 13 Nov 2019 22:45:21 +0100
Message-Id: <20191113214521.20931-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

System-installed files are usually 0755 or 0644, so in most cases, we
can avoid the binary search and the cost of pulling the cred->groups
array and in_group_p() .text into the cpu cache.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
Ballpark numbers: For example, building a random package like
util-linux with "make -j8" causes about 300000 calls/s of
generic_permission, with root-owned files (binaries, shared libraries,
system headers, and walking the directories from / to those)
outnumbering the user-owned files about 10:1, so in that case one
avoids, say, 250000 calls/s of in_group_p(). Assuming that the net
saving is about 20 instructions, that's 5M insn/s, which is of course
too small to measure (it's in the .1% range), but might still be
enough to justify this.

 fs/namei.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/namei.c b/fs/namei.c
index 671c3c1a3425..c78757435317 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -303,7 +303,12 @@ static int acl_permission_check(struct inode *inode, int mask)
 				return error;
 		}
 
-		if (in_group_p(inode->i_gid))
+		/*
+		 * If the "group" and "other" permissions are the same,
+		 * there's no point calling in_group_p() to decide which
+		 * set to use.
+		 */
+		if ((((mode >> 3) ^ mode) & 7) && in_group_p(inode->i_gid))
 			mode >>= 3;
 	}
 
-- 
2.23.0

