Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B981C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 23:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B7E0206B8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 23:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559691042;
	bh=Qb7YbNznCW8kC+aVurRGbRKhb6EowYJJu3J1fO63EkM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=USn/FZpVa+0OUpc7kMDLrkDvykx3gZQcwFR0FJB3uh/0po2YEc0GW2G4po20CAlfi
	 YqzwAae0M1E9BUAVO6Ra9eFL0yfglwh1+YI1R5AXzDg/NGaF8QFIlPCeZa6si58eSb
	 I3WYGeJ+uTkOpwzSYs0l/z622VRzdzIwRdnK6fBs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbfFDXal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 19:30:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:34448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727350AbfFDXXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 19:23:48 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 021DB20859;
        Tue,  4 Jun 2019 23:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559690627;
        bh=Qb7YbNznCW8kC+aVurRGbRKhb6EowYJJu3J1fO63EkM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zXW8QS2thY2Lk9t9w9yY26Z8T0w1x2XvOvuyH/KSh/436mGa29yTgQkv2fd8ekaT7
         Ctu+yj1oPW7szd1iTyRmru4gYWBBsGZzGGHMgFSSaF4LYBcV53gxf4ci8kYnD4wokg
         n9ulL6jJL55s7EA1FVkaDEIX+YeVM1Wum+s+jisg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 06/36] s390/kasan: fix strncpy_from_user kasan checks
Date:   Tue,  4 Jun 2019 19:23:01 -0400
Message-Id: <20190604232333.7185-6-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190604232333.7185-1-sashal@kernel.org>
References: <20190604232333.7185-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasily Gorbik <gor@linux.ibm.com>

[ Upstream commit 01eb42afb45719cb41bb32c278e068073738899d ]

arch/s390/lib/uaccess.c is built without kasan instrumentation. Kasan
checks are performed explicitly in copy_from_user/copy_to_user
functions. But since those functions could be inlined, calls from
files like uaccess.c with instrumentation disabled won't generate
kasan reports. This is currently the case with strncpy_from_user
function which was revealed by newly added kasan test. Avoid inlining of
copy_from_user/copy_to_user when the kernel is built with kasan support
to make sure kasan checks are fully functional.

Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/include/asm/uaccess.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/s390/include/asm/uaccess.h b/arch/s390/include/asm/uaccess.h
index ad6b91013a05..5332f628c1ed 100644
--- a/arch/s390/include/asm/uaccess.h
+++ b/arch/s390/include/asm/uaccess.h
@@ -56,8 +56,10 @@ raw_copy_from_user(void *to, const void __user *from, unsigned long n);
 unsigned long __must_check
 raw_copy_to_user(void __user *to, const void *from, unsigned long n);
 
+#ifndef CONFIG_KASAN
 #define INLINE_COPY_FROM_USER
 #define INLINE_COPY_TO_USER
+#endif
 
 #ifdef CONFIG_HAVE_MARCH_Z10_FEATURES
 
-- 
2.20.1

