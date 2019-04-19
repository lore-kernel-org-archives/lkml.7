Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B71F4C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 807A820645
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="aIIOwZ1d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729560AbfDSTFl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:05:41 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42949 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729139AbfDSTDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:03:51 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3JFt4Gr333515
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 19 Apr 2019 08:55:04 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3JFt4Gr333515
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1555689304;
        bh=rmW1fMapbeh+/egqmaNym2ncZ1vdk8PouJZvXNlkQJ8=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=aIIOwZ1ddNHDQDYSmjsyuy8DCoj3zXPk3r+qQhrJUMAYG6LYt088Uk5PhttEKbBl+
         JKWxQSKH6yZmMNR1VNmkXXq207VspzWNF6NQlbM2ypBrF3uNKy3lDiDAXzrB0iSWXt
         5gGmSkg26VnI6UHSZisurnmgWqeb/IGec4Uqkd5Aojr3b8VuNBWTzsjzA/nBFUw1oN
         4lf5u3mTeuEGNes0M1ymiHUKwYA8b4Az7xFXysh+CNJ0QOAcUnsmd3PNXLWLO7nwB7
         2UB6TNLa/ZwFbFJpMsK4mrQx8Ae4uHZm0tWaeUlzzH5zZouqpg981sr/0GKjX0Y9jy
         k7YVs0RiVk+ug==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3JFt3ep333510;
        Fri, 19 Apr 2019 08:55:03 -0700
Date:   Fri, 19 Apr 2019 08:55:03 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andi Kleen <tipbot@zytor.com>
Message-ID: <tip-81423c37415fe45057d64196ae0ce8e17a9c7148@git.kernel.org>
Cc:     ak@linux.intel.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mingo@kernel.org
Reply-To: linux-kernel@vger.kernel.org, tglx@linutronix.de,
          mingo@kernel.org, ak@linux.intel.com, hpa@zytor.com
In-Reply-To: <20190330004743.29541-4-andi@firstfloor.org>
References: <20190330004743.29541-4-andi@firstfloor.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/timers] x86/timer: Don't inline __const_udelay()
Git-Commit-ID: 81423c37415fe45057d64196ae0ce8e17a9c7148
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

Commit-ID:  81423c37415fe45057d64196ae0ce8e17a9c7148
Gitweb:     https://git.kernel.org/tip/81423c37415fe45057d64196ae0ce8e17a9c7148
Author:     Andi Kleen <ak@linux.intel.com>
AuthorDate: Fri, 29 Mar 2019 17:47:38 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 19 Apr 2019 17:49:47 +0200

x86/timer: Don't inline __const_udelay()

LTO will happily inline __const_udelay() everywhere it is used.  Forcing it
noinline saves ~44k text in a LTO build.

13999560        1740864 1499136 17239560        1070e08 vmlinux-with-udelay-inline
13954764        1736768 1499136 17190668        1064f0c vmlinux-wo-udelay-inline

Even without LTO this function should never be inlined.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190330004743.29541-4-andi@firstfloor.org

---
 arch/x86/lib/delay.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/lib/delay.c b/arch/x86/lib/delay.c
index f5b7f1b3b6d7..b7375dc6898f 100644
--- a/arch/x86/lib/delay.c
+++ b/arch/x86/lib/delay.c
@@ -162,7 +162,7 @@ void __delay(unsigned long loops)
 }
 EXPORT_SYMBOL(__delay);
 
-void __const_udelay(unsigned long xloops)
+noinline void __const_udelay(unsigned long xloops)
 {
 	unsigned long lpj = this_cpu_read(cpu_info.loops_per_jiffy) ? : loops_per_jiffy;
 	int d0;
