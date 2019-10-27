Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BFDACA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11B942064A
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572210760;
	bh=GQCxfnCFNNCNX5PCNOhkenmDHt9pXVPSq4JZ8mAOQXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=c4XmP0hwCRsRwJl5h7AZ6kFejfG09/EMjdYJucHOUuhPQ1LXUy9Zrhq/1gMIvDUIF
	 2nbu5d8v98p95FRJmEypu+RKMiy9Z+w8tdghJGII7xExSbJJmRPmuQzrkzagnT4c/p
	 xEySnv1GaFj2YYZ8tcWXGwD5n4IaeegGWt//ot8k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729679AbfJ0VMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 17:12:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:59438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727786AbfJ0VMg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 17:12:36 -0400
Received: from localhost (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC87C214AF;
        Sun, 27 Oct 2019 21:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572210755;
        bh=GQCxfnCFNNCNX5PCNOhkenmDHt9pXVPSq4JZ8mAOQXI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qo9+o/JISNvOvoqrghRUIxtyuiqRd7Re7ZEiWucMbNJPvPKjxAkcdo9S8XtPbwYva
         JH25isIHG4f/JXgUZtO18ZtBpiUmQMKRWaWTn+pVw9fXNGrDQXeeBfHvi0r8OK73Kb
         OP78TbC2FMLbDE9E3QEb09Id8eKl484ewMiE9HIE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 4.14 104/119] xtensa: drop EXPORT_SYMBOL for outs*/ins*
Date:   Sun, 27 Oct 2019 22:01:21 +0100
Message-Id: <20191027203349.178270519@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191027203259.948006506@linuxfoundation.org>
References: <20191027203259.948006506@linuxfoundation.org>
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
@@ -114,13 +114,6 @@ EXPORT_SYMBOL(__invalidate_icache_range)
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
 


