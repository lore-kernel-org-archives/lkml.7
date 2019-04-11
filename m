Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C9CC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 10:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 404802084D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 10:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="cyk1gKwo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbfDKKbA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 06:31:00 -0400
Received: from mail.codeweavers.com ([173.240.25.211]:55698 "EHLO
        mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbfDKKau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 06:30:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codeweavers.com; s=6377696661; h=References:In-Reply-To:Message-Id:Date:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XbUcWh1uuDNPxQAfg4+iv2XRcqP/X0fXbj2X8IVZYNo=; b=cyk1gKwogwUPAO/KxbHz4A9uK
        GIlBdkwVRzjBHL272ZvQZaLvcd2scmFc2UYVEr1y/VTSvETzsd6n3g+qA2RWeI0s7Gnwffry+SCgj
        C8lSeKhAGJrdYVL7ZJDTsLroVypw5qXgrH2rOcl4txEpxlQ1ObUeKIf91LnsaV1xddCFg=;
Received: from vpn42.vpn.mn.codeweavers.com ([10.69.139.42] helo=merlot)
        by mail.codeweavers.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <huw@codeweavers.com>)
        id 1hEWgg-0000my-7i; Thu, 11 Apr 2019 05:12:07 -0500
Received: from daviesh by merlot with local (Exim 4.90_1)
        (envelope-from <huw@codeweavers.com>)
        id 1hEWgf-0002cp-7P; Thu, 11 Apr 2019 11:12:05 +0100
From:   Huw Davies <huw@codeweavers.com>
To:     linux kernel <linux-kernel@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 1/3] x86/vdso: Remove unused 'mask' member
Date:   Thu, 11 Apr 2019 11:12:03 +0100
Message-Id: <20190411101205.10006-2-huw@codeweavers.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190411101205.10006-1-huw@codeweavers.com>
References: <20190411101205.10006-1-huw@codeweavers.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'mask' member of struct vsyscall_gtod_data is unused, so remove
it.  Its use was removed in commit a51e996d48ac (x86/vdso: Enforce
64bit clocksource).

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Huw Davies <huw@codeweavers.com>
---
 arch/x86/entry/vsyscall/vsyscall_gtod.c | 1 -
 arch/x86/include/asm/vgtod.h            | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/x86/entry/vsyscall/vsyscall_gtod.c b/arch/x86/entry/vsyscall/vsyscall_gtod.c
index cfcdba082feb..e4ee83018279 100644
--- a/arch/x86/entry/vsyscall/vsyscall_gtod.c
+++ b/arch/x86/entry/vsyscall/vsyscall_gtod.c
@@ -43,7 +43,6 @@ void update_vsyscall(struct timekeeper *tk)
 	/* copy vsyscall data */
 	vdata->vclock_mode	= vclock_mode;
 	vdata->cycle_last	= tk->tkr_mono.cycle_last;
-	vdata->mask		= tk->tkr_mono.mask;
 	vdata->mult		= tk->tkr_mono.mult;
 	vdata->shift		= tk->tkr_mono.shift;
 
diff --git a/arch/x86/include/asm/vgtod.h b/arch/x86/include/asm/vgtod.h
index 913a133f8e6f..daf69a25e46b 100644
--- a/arch/x86/include/asm/vgtod.h
+++ b/arch/x86/include/asm/vgtod.h
@@ -40,7 +40,6 @@ struct vsyscall_gtod_data {
 
 	int		vclock_mode;
 	u64		cycle_last;
-	u64		mask;
 	u32		mult;
 	u32		shift;
 
-- 
2.17.1

