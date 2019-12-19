Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21FCC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85D262465E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576781646;
	bh=uQRwI7gEVVVBcBGcIcDIIKDHTSgrdvlBCgzwcILLCxE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2GYUXhnX/NuSoPHkEOtyULvJnTMtbNzfbv9U9OIJV1Q0PESNe8Mjvmf5YeUn0Fmgg
	 Rrt3Bhy7WtwC9WgEmxxw/RHBQaV4C6b2mk358tqP+XlF63Dk9cvtRJMvkP7aZ+nEiY
	 ozSdcFLmesJf7Fdwz+6uHkEG+spuZ+wMLtKmc+rs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730450AbfLSSyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:54:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:49382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729824AbfLSSyC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:54:02 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59FD42465E;
        Thu, 19 Dec 2019 18:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576781641;
        bh=uQRwI7gEVVVBcBGcIcDIIKDHTSgrdvlBCgzwcILLCxE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SDVarrlPOdYKbXBfcQWzYauxhDlTwisTP7G7ahvsYK2jvvKEOCKnJ5C9CgmNkrROS
         jOVPyv69M2CkTbZDDvT6QVJNUDMi2+2UbS2FPleLl4yX6wmq9rmoYKNfmN2lZXAewk
         a4s3TtpIQb/60YfCkgwYoCBV12R+E7J7bskN+EYY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 5.4 20/80] xtensa: fix syscall_set_return_value
Date:   Thu, 19 Dec 2019 19:34:12 +0100
Message-Id: <20191219183100.383232228@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219183031.278083125@linuxfoundation.org>
References: <20191219183031.278083125@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Max Filippov <jcmvbkbc@gmail.com>

commit c2d9aa3b6e56de56c7f1ed9026ca6ec7cfbeef19 upstream.

syscall return value is in the register a2, not a0.

Cc: stable@vger.kernel.org # v5.0+
Fixes: 9f24f3c1067c ("xtensa: implement tracehook functions and enable HAVE_ARCH_TRACEHOOK")
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/xtensa/include/asm/syscall.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/xtensa/include/asm/syscall.h
+++ b/arch/xtensa/include/asm/syscall.h
@@ -51,7 +51,7 @@ static inline void syscall_set_return_va
 					    struct pt_regs *regs,
 					    int error, long val)
 {
-	regs->areg[0] = (long) error ? error : val;
+	regs->areg[2] = (long) error ? error : val;
 }
 
 #define SYSCALL_MAX_ARGS 6


