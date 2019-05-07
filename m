Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0995C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 22:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CB5820825
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 22:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QpLCCGwM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbfEGWv1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 18:51:27 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33934 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfEGWv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 18:51:27 -0400
Received: by mail-pl1-f194.google.com with SMTP id ck18so8898077plb.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 15:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zqjU7Kqphpvey584m7PYkn4clDjLsGfPvcRFWol1jUw=;
        b=QpLCCGwMqhVERlHz2h8cPPE5/geeHbfdAPQfGoqNtq2z5wglciwshLpXhmAVsKaFSw
         lIMtHGDVZo7++JRdjrfCCst3KKZUEdp0aUfI8Z0cW25aLR/DBnVAxrtdOFjZCfu6XUJw
         sCgkEyvyXfqTq91STfwwu26tyeR8rna1xe4R7vLmzjTXFT2ycSJjs4KG5793YqS6ASMZ
         o5wS/YkLzgEZcFyyVMPC91mfWOIeBGa90Ts6FmpTf0X9c0wlwiGaqOdaH2uNOq8TcNWC
         ax6qRS+HBFzjcaH0ET9iVH1QZ3ldp+aUPMAj2FU3bXgoPmQkMNJ96CChuuCaKvA74wVX
         WQ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zqjU7Kqphpvey584m7PYkn4clDjLsGfPvcRFWol1jUw=;
        b=HeBF18aKcUnmxmeRf8gaykuLdCROIuX0bhftOwxWKF2u4zifb0suhY00BjHaGAAvoi
         tsTnTEox5HdcAvmahYYKWgjCwa01lx7iUmJ9Hw0VTssymOu0d6luzUeK3Wv/cLRIllHk
         a5L184oI4FaxNRfVw3AAnQcl5mNlz7PrhfUBXY+oRRUKhSI4DK/oDwRcCqkrM7iKrS6n
         Xulqq05BRQwRxf48bEmAl5hFSsQ0FPDeP/Z5N0wWzKrGhfi9qo0PFu3DX87mQZC3TA+K
         eBR/QBqe2PHKlaCxss1Y5S+7TuMAgh5y5AHUvrGkTyaZvrPojurvDvSywUKhvTbJM7FL
         I5TA==
X-Gm-Message-State: APjAAAWsT2SRUyJYZAdu2wjoMEGQ8hXXhiqfYlv7LVPcA1A4q55sXFuP
        DInMclxJY8u+ZF6tzZbI+/I=
X-Google-Smtp-Source: APXvYqxOHVoT3+eSkoT/sHSCD3EM9x42XnLI9W5qBxIp/iNIOiJsrzdiJ2SmN3NZi3fIiQPqv+GMVA==
X-Received: by 2002:a17:902:2bc5:: with SMTP id l63mr44418160plb.202.1557269486243;
        Tue, 07 May 2019 15:51:26 -0700 (PDT)
Received: from localhost ([2601:640:2:82fb:19d3:11c4:475e:3daa])
        by smtp.gmail.com with ESMTPSA id z124sm19980997pfz.116.2019.05.07.15.51.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 15:51:25 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
X-Google-Original-From: Yury Norov <ynorov@marvell.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Breno Leitao <leitao@debian.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Yury Norov <ynorov@marvell.com>, Yury Norov <yury.norov@gmail.com>
Subject: [PATCH] powerpc: restore current_thread_info()
Date:   Tue,  7 May 2019 15:51:21 -0700
Message-Id: <20190507225121.18676-1-ynorov@marvell.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit ed1cd6deb013 ("powerpc: Activate CONFIG_THREAD_INFO_IN_TASK")
removes the function current_thread_info(). It's wrong because the
function is used in non-arch code and is part of API.

For my series of arm64/ilp32, after applying the patch
https://github.com/norov/linux/commit/b269e51eee66ffec3008a3effb12363b91754e49
it causes build break.

This patch restores current_thread_info().

Signed-off-by: Yury Norov <ynorov@marvell.com>
---
 arch/powerpc/include/asm/thread_info.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
index 8e1d0195ac36..f700bc80a607 100644
--- a/arch/powerpc/include/asm/thread_info.h
+++ b/arch/powerpc/include/asm/thread_info.h
@@ -19,6 +19,7 @@
 
 #ifndef __ASSEMBLY__
 #include <linux/cache.h>
+#include <asm/current.h>
 #include <asm/processor.h>
 #include <asm/page.h>
 #include <asm/accounting.h>
@@ -57,6 +58,11 @@ struct thread_info {
 #define THREAD_SIZE_ORDER	(THREAD_SHIFT - PAGE_SHIFT)
 
 /* how to get the thread information struct from C */
+static inline struct thread_info *current_thread_info(void)
+{
+	return (struct thread_info *)current;
+}
+
 extern int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
 
 #ifdef CONFIG_PPC_BOOK3S_64
-- 
2.17.1

