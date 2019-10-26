Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E828CA9EB9
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 13:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FED52070B
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 13:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572096054;
	bh=5g2TKYepzOq12HGG1Rs9GxMzREQ/5Jbgm0/GRVwlPGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RKxr8rGTzktgTxR7OrH5Fe1+LLhqYNri5l+JAUx64fkhxjoxLiKMW9vv2GvB+Ppg+
	 F/jbh6/4hZ97IhKc4R1LmHFpP/ydbogQNANvZ2MRt3Znq60DEAbrfylUNOP2DxYejM
	 yo9CgK5ZXjIZuZSSWnhBjwyLVGelcOiuDe+U/+Xo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbfJZNUw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 09:20:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:42364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728657AbfJZNUg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 09:20:36 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E097821E6F;
        Sat, 26 Oct 2019 13:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572096035;
        bh=5g2TKYepzOq12HGG1Rs9GxMzREQ/5Jbgm0/GRVwlPGA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FmuGR+KOipW9rnm4/+Qrq3CjkJUl6lEW213N0WzXHTcwj2bndnB379KBXFhhCcTdO
         BCtr5pxpqMVDCh05mXiDNgJj8CQtMqlpbGBYghNjCdLiY2FQgo36lmZ4P+Lpyibyv2
         EEqZVxJ5pfHXwcLFa79iQlSmF+NUHFtsIkwyxaJk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-xtensa@linux-xtensa.org
Subject: [PATCH AUTOSEL 4.19 44/59] xtensa: fix {get,put}_user() for 64bit values
Date:   Sat, 26 Oct 2019 09:18:55 -0400
Message-Id: <20191026131910.3435-44-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191026131910.3435-1-sashal@kernel.org>
References: <20191026131910.3435-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit 6595d144decec396bf2e2efee27e50634a4b627f ]

First of all, on short copies __copy_{to,from}_user() return the amount
of bytes left uncopied, *not* -EFAULT.  get_user() and put_user() are
expected to return -EFAULT on failure.

Another problem is get_user(v32, (__u64 __user *)p); that should
fetch 64bit value and the assign it to v32, truncating it in process.
Current code, OTOH, reads 8 bytes of data and stores them at the
address of v32, stomping on the 4 bytes that follow v32 itself.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/xtensa/include/asm/uaccess.h | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/xtensa/include/asm/uaccess.h b/arch/xtensa/include/asm/uaccess.h
index f1158b4c629cf..b403885dd493a 100644
--- a/arch/xtensa/include/asm/uaccess.h
+++ b/arch/xtensa/include/asm/uaccess.h
@@ -101,7 +101,7 @@ do {									\
 	case 4: __put_user_asm(x, ptr, retval, 4, "s32i", __cb); break;	\
 	case 8: {							\
 		     __typeof__(*ptr) __v64 = x;			\
-		     retval = __copy_to_user(ptr, &__v64, 8);		\
+		     retval = __copy_to_user(ptr, &__v64, 8) ? -EFAULT : 0;	\
 		     break;						\
 	        }							\
 	default: __put_user_bad();					\
@@ -200,7 +200,16 @@ do {									\
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

