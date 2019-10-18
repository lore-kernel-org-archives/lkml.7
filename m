Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A49CA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C1F42245C
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571436486;
	bh=xXS8p/EblncHJQHEhAPsiIeE9RiB5ZxpflNfzXPTfaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2vfbixXsxZhKPZ0Uxkm2a/b7TGu3nNnOb8rBebd5zfFWGfCfUquPc1bKraGMXSn7F
	 mDjmmRkpCMrvTq9NdGMCRdq646aO2z0xloi6VH0IjfdZDsNOBnkDgv5+CHI7UPI0fj
	 UcOxQgtaKLL8RMzySh5WRyK3uDsgsnk6us4e8loM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387484AbfJRWIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 18:08:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:40256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733281AbfJRWHu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 18:07:50 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7859C222D4;
        Fri, 18 Oct 2019 22:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571436470;
        bh=xXS8p/EblncHJQHEhAPsiIeE9RiB5ZxpflNfzXPTfaQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=krHBCYfAoKl/7I6w37QsAmUlEvsQ4tFsLkZpX78updqCRPT25w6jG/p3Vl/BkuW89
         w6rFKpoV9+A2KI2xrUS2k+2WrXHCutrrPJNxNKjyVCMENQz+at+UlmtNpP/eEuQ7Wy
         Sf/taBhtmsKZoEQLavGGYLS3m+ABPxpldCWIBWII=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 099/100] s390/uaccess: avoid (false positive) compiler warnings
Date:   Fri, 18 Oct 2019 18:05:24 -0400
Message-Id: <20191018220525.9042-99-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191018220525.9042-1-sashal@kernel.org>
References: <20191018220525.9042-1-sashal@kernel.org>
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
index 5332f628c1edc..40194f8c772a0 100644
--- a/arch/s390/include/asm/uaccess.h
+++ b/arch/s390/include/asm/uaccess.h
@@ -84,7 +84,7 @@ raw_copy_to_user(void __user *to, const void *from, unsigned long n);
 	__rc;							\
 })
 
-static inline int __put_user_fn(void *x, void __user *ptr, unsigned long size)
+static __always_inline int __put_user_fn(void *x, void __user *ptr, unsigned long size)
 {
 	unsigned long spec = 0x010000UL;
 	int rc;
@@ -114,7 +114,7 @@ static inline int __put_user_fn(void *x, void __user *ptr, unsigned long size)
 	return rc;
 }
 
-static inline int __get_user_fn(void *x, const void __user *ptr, unsigned long size)
+static __always_inline int __get_user_fn(void *x, const void __user *ptr, unsigned long size)
 {
 	unsigned long spec = 0x01UL;
 	int rc;
-- 
2.20.1

