Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E9D1C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2623620885
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574142836;
	bh=yTksp1ZKXV82zjImAK+llrk3ZT07sr7e/NIZf/IX/ac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wN5hEciBC0HdCNpGk1a8NRp6aV4fUWjravX2DjKazimdBAOg9ThSvz9sZ0svnAuNC
	 wpx6Usiw/CpoGJDtajUX1WLmQ+d7k/Y3dOZZtiu0OaaquJOsBZx1qY8ms8ppUPhYhU
	 ApjvVrV8LM9NlsgfIFC/yqBGb0J9ZyzLPUcZdhWQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731492AbfKSFxz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:53:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:51864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732080AbfKSFxx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:53:53 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD5AB20721;
        Tue, 19 Nov 2019 05:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574142832;
        bh=yTksp1ZKXV82zjImAK+llrk3ZT07sr7e/NIZf/IX/ac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kVFW9LECNvk/2iWy/x8spzFEc6o7jtkgy9qo/YqjeEp8K1BM/ecbdIDzOPRLuIk0C
         pqkN1HoQLLHN1fa77gksK0mMRbitPwpsXalu13/HHuMSWSwGT7u68SFq/0IHEUfluF
         76LqgsS9z4SdZyv5ZJdK5wRsYBbj76iDSwy7sVEg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matthew Whitehead <tedheadster@gmail.com>,
        Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@amacapital.net>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
        Jia Zhang <qianyue.zj@alibaba-inc.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 175/239] x86/CPU: Use correct macros for Cyrix calls
Date:   Tue, 19 Nov 2019 06:19:35 +0100
Message-Id: <20191119051334.250360631@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051255.850204959@linuxfoundation.org>
References: <20191119051255.850204959@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Whitehead <tedheadster@gmail.com>

[ Upstream commit 03b099bdcdf7125d4a63dc9ddeefdd454e05123d ]

There are comments in processor-cyrix.h advising you to _not_ make calls
using the deprecated macros in this style:

  setCx86_old(CX86_CCR4, getCx86_old(CX86_CCR4) | 0x80);

This is because it expands the macro into a non-functioning calling
sequence. The calling order must be:

  outb(CX86_CCR2, 0x22);
  inb(0x23);

>From the comments:

 * When using the old macros a line like
 *   setCx86(CX86_CCR2, getCx86(CX86_CCR2) | 0x88);
 * gets expanded to:
 *  do {
 *    outb((CX86_CCR2), 0x22);
 *    outb((({
 *        outb((CX86_CCR2), 0x22);
 *        inb(0x23);
 *    }) | 0x88), 0x23);
 *  } while (0);

The new macros fix this problem, so use them instead.

Signed-off-by: Matthew Whitehead <tedheadster@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Andy Lutomirski <luto@amacapital.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Jia Zhang <qianyue.zj@alibaba-inc.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20180921212041.13096-2-tedheadster@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/cpu/cyrix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/cyrix.c b/arch/x86/kernel/cpu/cyrix.c
index fa61c870ada94..1d9b8aaea06c8 100644
--- a/arch/x86/kernel/cpu/cyrix.c
+++ b/arch/x86/kernel/cpu/cyrix.c
@@ -437,7 +437,7 @@ static void cyrix_identify(struct cpuinfo_x86 *c)
 			/* enable MAPEN  */
 			setCx86(CX86_CCR3, (ccr3 & 0x0f) | 0x10);
 			/* enable cpuid  */
-			setCx86_old(CX86_CCR4, getCx86_old(CX86_CCR4) | 0x80);
+			setCx86(CX86_CCR4, getCx86(CX86_CCR4) | 0x80);
 			/* disable MAPEN */
 			setCx86(CX86_CCR3, ccr3);
 			local_irq_restore(flags);
-- 
2.20.1



