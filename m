Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA6A1CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB54821852
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571436886;
	bh=vo9KI/6ReG4GAX0/NrUSIFMAlhImi0q1vwrXi1egK4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sBxh4qthfaoOR5EB3RuDd2N+LputOU2skML+5UcIpAwHGN9eQZArnge6izVlJoi6o
	 y+wlyWpHaLVcWq/rPCk2Qabmkyf+dnt6yxAq1QZh5ylny6g3FXB7LDbOlINeq+0pvG
	 dXyDohGnBy9T+6XQ2Kmc+3BdPvUEmC03fIVaEVn0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392355AbfJRWOp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 18:14:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:41990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388761AbfJRWJS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 18:09:18 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75069222C2;
        Fri, 18 Oct 2019 22:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571436558;
        bh=vo9KI/6ReG4GAX0/NrUSIFMAlhImi0q1vwrXi1egK4s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fyCLyGGjcUQkafh3wy6ZLXiwbqOdDP3hf8hsFTwmvl9NAWRg3sdrYszbLNkEZUUzX
         RYNWwuaZ/8B8d6/1nnQchDpVW5ImZnGBDIP3UMYzhk0tEO1M55hSPU32KWWdqnzg78
         J6UV7rR+42tuernckzfPuk2L4mB90JCeP5rUpkLY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 55/56] s390/uaccess: avoid (false positive) compiler warnings
Date:   Fri, 18 Oct 2019 18:07:52 -0400
Message-Id: <20191018220753.10002-55-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191018220753.10002-1-sashal@kernel.org>
References: <20191018220753.10002-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Borntraeger <borntraeger@de.ibm.com>

[ Upstream commit 062795fcdcb2d22822fb42644b1d76a8ad8439b3 ]

Depending on inlining decisions by the compiler, __get/put_user_fn
might become out of line. Then the compiler is no longer able to tell
that size can only be 1,2,4 or 8 due to the check in __get/put_user
resulting in false positives like

./arch/s390/include/asm/uaccess.h: In function ‘__put_user_fn’:
./arch/s390/include/asm/uaccess.h:113:9: warning: ‘rc’ may be used uninitialized in this function [-Wmaybe-uninitialized]
  113 |  return rc;
      |         ^~
./arch/s390/include/asm/uaccess.h: In function ‘__get_user_fn’:
./arch/s390/include/asm/uaccess.h:143:9: warning: ‘rc’ may be used uninitialized in this function [-Wmaybe-uninitialized]
  143 |  return rc;
      |         ^~

These functions are supposed to be always inlined. Mark it as such.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/include/asm/uaccess.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/uaccess.h b/arch/s390/include/asm/uaccess.h
index 689eae8d38591..bd7a19a0aecf7 100644
--- a/arch/s390/include/asm/uaccess.h
+++ b/arch/s390/include/asm/uaccess.h
@@ -95,7 +95,7 @@ raw_copy_to_user(void __user *to, const void *from, unsigned long n);
 	__rc;							\
 })
 
-static inline int __put_user_fn(void *x, void __user *ptr, unsigned long size)
+static __always_inline int __put_user_fn(void *x, void __user *ptr, unsigned long size)
 {
 	unsigned long spec = 0x810000UL;
 	int rc;
@@ -125,7 +125,7 @@ static inline int __put_user_fn(void *x, void __user *ptr, unsigned long size)
 	return rc;
 }
 
-static inline int __get_user_fn(void *x, const void __user *ptr, unsigned long size)
+static __always_inline int __get_user_fn(void *x, const void __user *ptr, unsigned long size)
 {
 	unsigned long spec = 0x81UL;
 	int rc;
-- 
2.20.1

