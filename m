Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE601C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 23:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEA4820859
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 23:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559690677;
	bh=P0Fx1LFVw40DO3B5elgZ8KOSxtnwXqvfk80TEOPqYPg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SEGg+BiHQzAGbEOHRyaUYzDYtOTAN3IB1DUeRG1Xi/4ti+qO7pyhG6o1ltY1UbmBG
	 Vlm2UB04mN9G3OZ+SY8soWzzIZkXt0acDLXWheAE4wevyz8BE/6QRKfxehEzWZUKmd
	 tBIDwRv+3KB2Nx0D+qdgFdlH/eaParr0Lt/QFXJQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbfFDXYh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 19:24:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:35602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727613AbfFDXYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 19:24:32 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74B1620883;
        Tue,  4 Jun 2019 23:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559690672;
        bh=P0Fx1LFVw40DO3B5elgZ8KOSxtnwXqvfk80TEOPqYPg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hZa690EBFA6CGqi3yEX7NPPIfc5+iUtbbIsC//FEou/T/gDguXxA1HCe4SFSQIywV
         EWb4f2H09QxBKxT3WjZrVQJQhAmGBADFTK5Z136bxHS6qrCQxniB3MaOrJkNmd/48U
         NzdoTKU2zr4A2/L4sZDITjozYjzH1D1cSNYkyxe8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 06/24] s390/kasan: fix strncpy_from_user kasan checks
Date:   Tue,  4 Jun 2019 19:23:57 -0400
Message-Id: <20190604232416.7479-6-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190604232416.7479-1-sashal@kernel.org>
References: <20190604232416.7479-1-sashal@kernel.org>
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
index cdd0f0d999e2..689eae8d3859 100644
--- a/arch/s390/include/asm/uaccess.h
+++ b/arch/s390/include/asm/uaccess.h
@@ -67,8 +67,10 @@ raw_copy_from_user(void *to, const void __user *from, unsigned long n);
 unsigned long __must_check
 raw_copy_to_user(void __user *to, const void *from, unsigned long n);
 
+#ifndef CONFIG_KASAN
 #define INLINE_COPY_FROM_USER
 #define INLINE_COPY_TO_USER
+#endif
 
 #ifdef CONFIG_HAVE_MARCH_Z10_FEATURES
 
-- 
2.20.1

