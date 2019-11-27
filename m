Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FBCFC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0ABB2080F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574889889;
	bh=mVdXT8KgpU+9tvB2z5w+5sXBmDF6P0AEXBz5zUQsBtY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QGaTpiPcwcLxZ6b+MO9obUlRUyFzaREZGuvmGojOefNYSIMqL+iFi9aVNidexbOX4
	 E6V5hYdTkiRbWtlVxe5gGUSMGya150h3zAjBQzRf+GkfwrAhbM0p6ZEqh8EoQoWepQ
	 MkOPHntkNFZF/FUnfBZgp1O6qxAH9g9UpRmZZe14=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731920AbfK0VCk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:02:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:55382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731916AbfK0VCi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 16:02:38 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0D7721771;
        Wed, 27 Nov 2019 21:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574888557;
        bh=mVdXT8KgpU+9tvB2z5w+5sXBmDF6P0AEXBz5zUQsBtY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pUT7eN8J4FZPR/CaIf2ZlX16SS+ki4DKC092wz18g8G9o/uvkUTQ1x6RMovWYCx1S
         NOlCFSjBg49bO3TACpHZM7cJVYuCnOXg6r4xOp5vlAr5CyxLYVxBWiocWyhdC7qIoj
         fowg20PkcXvv+TqiA2mh3LaagtragYV66Lz21KNg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 179/306] kernel/panic.c: do not append newline to the stack protector panic string
Date:   Wed, 27 Nov 2019 21:30:29 +0100
Message-Id: <20191127203128.406585408@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203114.766709977@linuxfoundation.org>
References: <20191127203114.766709977@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

[ Upstream commit 95c4fb78fb23081472465ca20d5d31c4b780ed82 ]

... because panic() itself already does this. Otherwise you have
line-broken trailer:

  [    1.836965] ---[ end Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: pgd_alloc+0x29e/0x2a0
  [    1.836965]  ]---

Link: http://lkml.kernel.org/r/20181008202901.7894-1-bp@alien8.de
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Kees Cook <keescook@chromium.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/panic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index 72e001e3753e3..8138a676fb7d1 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -636,7 +636,7 @@ device_initcall(register_warn_debugfs);
  */
 __visible void __stack_chk_fail(void)
 {
-	panic("stack-protector: Kernel stack is corrupted in: %pB\n",
+	panic("stack-protector: Kernel stack is corrupted in: %pB",
 		__builtin_return_address(0));
 }
 EXPORT_SYMBOL(__stack_chk_fail);
-- 
2.20.1



