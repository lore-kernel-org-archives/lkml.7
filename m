Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D5E3CA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47040205C9
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572212282;
	bh=osvjggYOXfm6VYWKkXyKzvmRDORihsKLZU69VQwLwM4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qGegGH7iXIRK+oFW0FJuhNxnKqU4ucDiuKoLThzzPoag9topBecIn5xCjEGC/cjaU
	 cFgGSG3w7HtUpejfSYOld4sX2HccLBE/95QSmgYmRbzej9xAVHsizA5bZfsgDO0Lfs
	 xFVsKsv9YsUXkdjxHKZYkieTOkyBlRjAFwQdQItM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729646AbfJ0ViB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 17:38:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:50038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728581AbfJ0VEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 17:04:21 -0400
Received: from localhost (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CE95214E0;
        Sun, 27 Oct 2019 21:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572210260;
        bh=osvjggYOXfm6VYWKkXyKzvmRDORihsKLZU69VQwLwM4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2k5SsqnA7BC1MDPWP/Ty/gARaC5fCj3i5y8oubWQzTi92KzC+0fR7A8oD+wEDVVv7
         6MnzDVUxovO/KzmiTNnjRXkOQSiPd+kVJ52Xg/a41dWhTsP1vivf/pg2loxw+TfKcJ
         Oz2FfhrV+HSIMF/9rdb1aQRg8ToLH4+ZrblDCIyI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 4.4 32/41] xtensa: drop EXPORT_SYMBOL for outs*/ins*
Date:   Sun, 27 Oct 2019 22:01:10 +0100
Message-Id: <20191027203126.453980532@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191027203056.220821342@linuxfoundation.org>
References: <20191027203056.220821342@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Max Filippov <jcmvbkbc@gmail.com>

commit 8b39da985194aac2998dd9e3a22d00b596cebf1e upstream.

Custom outs*/ins* implementations are long gone from the xtensa port,
remove matching EXPORT_SYMBOLs.
This fixes the following build warnings issued by modpost since commit
15bfc2348d54 ("modpost: check for static EXPORT_SYMBOL* functions"):

  WARNING: "insb" [vmlinux] is a static EXPORT_SYMBOL
  WARNING: "insw" [vmlinux] is a static EXPORT_SYMBOL
  WARNING: "insl" [vmlinux] is a static EXPORT_SYMBOL
  WARNING: "outsb" [vmlinux] is a static EXPORT_SYMBOL
  WARNING: "outsw" [vmlinux] is a static EXPORT_SYMBOL
  WARNING: "outsl" [vmlinux] is a static EXPORT_SYMBOL

Cc: stable@vger.kernel.org
Fixes: d38efc1f150f ("xtensa: adopt generic io routines")
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/xtensa/kernel/xtensa_ksyms.c |    7 -------
 1 file changed, 7 deletions(-)

--- a/arch/xtensa/kernel/xtensa_ksyms.c
+++ b/arch/xtensa/kernel/xtensa_ksyms.c
@@ -116,13 +116,6 @@ EXPORT_SYMBOL(__invalidate_icache_range)
 // FIXME EXPORT_SYMBOL(screen_info);
 #endif
 
-EXPORT_SYMBOL(outsb);
-EXPORT_SYMBOL(outsw);
-EXPORT_SYMBOL(outsl);
-EXPORT_SYMBOL(insb);
-EXPORT_SYMBOL(insw);
-EXPORT_SYMBOL(insl);
-
 extern long common_exception_return;
 EXPORT_SYMBOL(common_exception_return);
 


