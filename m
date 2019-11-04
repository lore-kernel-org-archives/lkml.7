Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46DD8CA9ED3
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19B7621D7F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572905963;
	bh=WEjXPYN/4z2tLd11WOkLYZH11e/S5V8qQlTCbEuf090=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Z8QvV3zUR7KpWxfqcz/umfnsNFVHFDxJAYZ6ZaDMbGZo4/Wvb/qCyaDIZ5pVYDTK3
	 JbU4Spx7aaOT++pl2ZSe6/vh5qDSJ8y6IPIrI8IYpAQoE3AvIWqf5AVzE/q/07/f6/
	 /z2kZeDwum00YpT3KhOKj4o8ChTRrZf35FounXz0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388619AbfKDWBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 17:01:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:58822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388502AbfKDWAy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 17:00:54 -0500
Received: from localhost (6.204-14-84.ripe.coltfrance.com [84.14.204.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7133D217F4;
        Mon,  4 Nov 2019 22:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572904854;
        bh=WEjXPYN/4z2tLd11WOkLYZH11e/S5V8qQlTCbEuf090=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LAS1UnvOZxKRkV+YeS0F+DeAQsdKNaD8KCgQns/qMW1Q1VDWevRGLlu4cs26YGZiT
         KKBHsZesVnIPqI2ei6VbeuCQQVwS8+KN5x8zYGdv5z6P3OBNWQCi0Ho+dYAMrbO2Lq
         IIkD9xAl5cjF3oGZT8KHXPncPJVSelq03xfYUsHY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Thomas Bogendoerfer <tbogendoerfer@suse.de>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 095/149] MIPS: include: Mark __xchg as __always_inline
Date:   Mon,  4 Nov 2019 22:44:48 +0100
Message-Id: <20191104212143.197542345@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104212126.090054740@linuxfoundation.org>
References: <20191104212126.090054740@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Bogendoerfer <tbogendoerfer@suse.de>

[ Upstream commit 46f1619500d022501a4f0389f9f4c349ab46bb86 ]

Commit ac7c3e4ff401 ("compiler: enable CONFIG_OPTIMIZE_INLINING
forcibly") allows compiler to uninline functions marked as 'inline'.
In cace of __xchg this would cause to reference function
__xchg_called_with_bad_pointer, which is an error case
for catching bugs and will not happen for correct code, if
__xchg is inlined.

Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/include/asm/cmpxchg.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/cmpxchg.h b/arch/mips/include/asm/cmpxchg.h
index 895f91b9e89c3..520ca166cbed5 100644
--- a/arch/mips/include/asm/cmpxchg.h
+++ b/arch/mips/include/asm/cmpxchg.h
@@ -73,8 +73,8 @@ extern unsigned long __xchg_called_with_bad_pointer(void)
 extern unsigned long __xchg_small(volatile void *ptr, unsigned long val,
 				  unsigned int size);
 
-static inline unsigned long __xchg(volatile void *ptr, unsigned long x,
-				   int size)
+static __always_inline
+unsigned long __xchg(volatile void *ptr, unsigned long x, int size)
 {
 	switch (size) {
 	case 1:
-- 
2.20.1



