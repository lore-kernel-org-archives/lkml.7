Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67625C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2968A2133D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="hfqkhQtJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389252AbfEXIEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 04:04:22 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55033 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388959AbfEXIEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 04:04:22 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4O8475w117569
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 24 May 2019 01:04:07 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4O8475w117569
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1558685048;
        bh=gpAvCLFY8WATT/YNdMDzVEaap+bR2sycGhzeaXjx/ZU=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=hfqkhQtJDpHVYJKtGZAte4ZF52jeIeZyKfofkPQvMzuWZY6EmrguKMkI9z6oz5y8+
         KQIgdaO0z53KiK/0z4695xUkPT3M9Rhe9CRsvuN250nFH6s/6KeLZV8kZG7jpb9fBO
         wW1Y1I2GUdjmGJ6aa800bVPld+HAXlqTPjnLeEpG7MC3FUZWxBtbJ7fbIB5memzQZz
         Y/P1QX5FjhQlKfmiGZqJ0VnqEKllYpqUijaWhroAoYw98GKfmqiosmFqu1hc62MNXq
         6OASQMQGZIaXC8SNtQZGuwKvH5xAFNcahC2Kf631qrXp/f6Ol+CGt3ON1fUMTP1I6Y
         7tWj5ygZuFeBg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4O847Xs117566;
        Fri, 24 May 2019 01:04:07 -0700
Date:   Fri, 24 May 2019 01:04:07 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Masahiro Yamada <tipbot@zytor.com>
Message-ID: <tip-e62a4239c3dfd182a7e676cfe9efb1f4cec5ca25@git.kernel.org>
Cc:     torvalds@linux-foundation.org, peterz@infradead.org, hpa@zytor.com,
        mingo@kernel.org, bp@alien8.de, linux-kernel@vger.kernel.org,
        yamada.masahiro@socionext.com, tglx@linutronix.de
Reply-To: bp@alien8.de, linux-kernel@vger.kernel.org,
          yamada.masahiro@socionext.com, tglx@linutronix.de,
          mingo@kernel.org, peterz@infradead.org, hpa@zytor.com,
          torvalds@linux-foundation.org
In-Reply-To: <20190521072211.21014-1-yamada.masahiro@socionext.com>
References: <20190521072211.21014-1-yamada.masahiro@socionext.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cleanups] x86/io_delay: Break instead of fallthrough in
 switch statement
Git-Commit-ID: e62a4239c3dfd182a7e676cfe9efb1f4cec5ca25
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  e62a4239c3dfd182a7e676cfe9efb1f4cec5ca25
Gitweb:     https://git.kernel.org/tip/e62a4239c3dfd182a7e676cfe9efb1f4cec5ca25
Author:     Masahiro Yamada <yamada.masahiro@socionext.com>
AuthorDate: Tue, 21 May 2019 16:22:10 +0900
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 24 May 2019 08:46:06 +0200

x86/io_delay: Break instead of fallthrough in switch statement

The current code is fine since 'case CONFIG_IO_DELAY_TYPE_NONE'
does nothing, but scripts/checkpatch.pl complains about this:

  warning: Possible switch case/default not preceded by break or fallthrough comment

I like break statement better than a fallthrough comment here.
It avoids the warning and clarify the code.

No behavior change is intended.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20190521072211.21014-1-yamada.masahiro@socionext.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/io_delay.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/io_delay.c b/arch/x86/kernel/io_delay.c
index 805b7a341aca..3dc874d5d43b 100644
--- a/arch/x86/kernel/io_delay.c
+++ b/arch/x86/kernel/io_delay.c
@@ -39,6 +39,7 @@ void native_io_delay(void)
 		 * are shorter until calibrated):
 		 */
 		udelay(2);
+		break;
 	case CONFIG_IO_DELAY_TYPE_NONE:
 		break;
 	}
