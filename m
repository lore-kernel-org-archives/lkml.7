Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70FE6C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 05:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 421D3204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 05:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561528347;
	bh=2DCB47D8iuSCWkMu8d8a5UgYWyZlL0ucifFdec4hUUk=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=uFu5/kL1qQUyYZRWiwwQoFU8tYHAA6OldIKr9Or6QQzMn47uF1IGxsaqJInnc+cL8
	 H6xXb/x+g6dqeE89hfmH2MZGW8wQMZ5rtyzK5qpkR0NnHnqJMg2f3sbzLrj5sZKZgE
	 JLwkOeF/mwQgNNCuCItXVBRfWMz2OJpYS+Rz8lQQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbfFZFw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 01:52:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:38878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbfFZFw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 01:52:26 -0400
Received: from localhost.localdomain (unknown [223.93.147.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0CF9208CB;
        Wed, 26 Jun 2019 05:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561528345;
        bh=2DCB47D8iuSCWkMu8d8a5UgYWyZlL0ucifFdec4hUUk=;
        h=From:To:Cc:Subject:Date:From;
        b=R20RshivXgjWnOWHHBZfhveZTd1+unvGdZhWwqUUq+b83/5TKrgwWwGHBkKDJk6iv
         HFQqam0IbAkbSoetr1M4FdP8m3Vq7kpXtrfptNCfX9/jrEqWsZQJJVNXzuNHFxn5WN
         J6opDznUcMdWYwe/hpuJnMYUmM0rcwsTsiPlA1nE=
From:   guoren@kernel.org
To:     arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-csky@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>,
        Mao Han <han_mao@c-sky.com>
Subject: [PATCH] csky: Fixup libgcc unwind error
Date:   Wed, 26 Jun 2019 13:51:36 +0800
Message-Id: <1561528296-27444-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

The struct rt_sigframe is also defined in libgcc/config/csky/linux-unwind.h
of gcc. Although there is no use for the first three word space, we must
keep them the same with linux-unwind.h for member position.

The BUG is found in glibc test with the tst-cancel02.
The BUG is from commit:bf2416829362 of linux-5.2-rc1 merge window.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Signed-off-by: Mao Han <han_mao@c-sky.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/csky/kernel/signal.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/csky/kernel/signal.c b/arch/csky/kernel/signal.c
index 04a43cf..d47a338 100644
--- a/arch/csky/kernel/signal.c
+++ b/arch/csky/kernel/signal.c
@@ -39,6 +39,11 @@ static int save_fpu_state(struct sigcontext __user *sc)
 #endif
 
 struct rt_sigframe {
+	/*
+	 * pad[3] is compatible with the same struct defined in
+	 * gcc/libgcc/config/csky/linux-unwind.h
+	 */
+	int pad[3];
 	struct siginfo info;
 	struct ucontext uc;
 };
-- 
2.7.4

