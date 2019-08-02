Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3524C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FC3521726
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564739613;
	bh=Sus13iWclroigCwhhejUjmR7RmySRV/rrlISLxwdSts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=B/eJ8B76o8973CmSlZzgpe7JN0hJqKuwwGjBcis4T5Ii0bcNXMXL5K59mJdG9N/QI
	 1SAfCobGYNHg4dQ+6Q+/Bsu5zAmSGKMN3mIY+IyA0Rnzx/cOQ9IyRdjVfTZrssmjXe
	 LHAeaeW+A0qpUaDYzZprHikb+kNxaYE6wAAli1Wo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406276AbfHBJxc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 05:53:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:59488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406262AbfHBJxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 05:53:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF663206A2;
        Fri,  2 Aug 2019 09:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564739603;
        bh=Sus13iWclroigCwhhejUjmR7RmySRV/rrlISLxwdSts=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=slAYXma5KMizcHS5AqtgeQ79+XeZ5vNin0103H28nijp+mspC2ssj/72KgoMx0sxX
         J5xGz1TkjSQgzuy2aycN9K3ST7wXncIseyg5RKbzkHnBM+9dDaoi0Xk2oBuh0kKdCf
         7xIqwWLCXXDEr5zSo7YKSX0K6Iy5uvtp15tK3hz8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Oleg Nesterov <oleg@redhat.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Steve McIntyre <steve.mcintyre@arm.com>,
        Steve McIntyre <93sam@debian.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 4.9 215/223] arm64: compat: Provide definition for COMPAT_SIGMINSTKSZ
Date:   Fri,  2 Aug 2019 11:37:20 +0200
Message-Id: <20190802092250.685349111@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190802092238.692035242@linuxfoundation.org>
References: <20190802092238.692035242@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Will Deacon <will.deacon@arm.com>

commit 24951465cbd279f60b1fdc2421b3694405bcff42 upstream.

arch/arm/ defines a SIGMINSTKSZ of 2k, so we should use the same value
for compat tasks.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Oleg Nesterov <oleg@redhat.com>
Reviewed-by: Dave Martin <Dave.Martin@arm.com>
Reported-by: Steve McIntyre <steve.mcintyre@arm.com>
Tested-by: Steve McIntyre <93sam@debian.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/include/asm/compat.h |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/arm64/include/asm/compat.h
+++ b/arch/arm64/include/asm/compat.h
@@ -234,6 +234,7 @@ static inline compat_uptr_t ptr_to_compa
 }
 
 #define compat_user_stack_pointer() (user_stack_pointer(task_pt_regs(current)))
+#define COMPAT_MINSIGSTKSZ	2048
 
 static inline void __user *arch_compat_alloc_user_space(long len)
 {


