Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E30C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 10:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3255E21850
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 10:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="auYaCEDA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfDKKas (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 06:30:48 -0400
Received: from mail.codeweavers.com ([173.240.25.211]:55688 "EHLO
        mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbfDKKas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 06:30:48 -0400
X-Greylist: delayed 1119 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Apr 2019 06:30:47 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codeweavers.com; s=6377696661; h=References:In-Reply-To:Message-Id:Date:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=O7DkCrlKyVT3KBZM0hsKhSeSuqezOiBoBXelFKeEJtw=; b=auYaCEDANdeUhA9vTduCWY5WY
        N7wWcbRUuLXskmxutGan44TBoS2IXAE8IbtcdPw6qrbbZiG9lay9xU7EYLV7gca3QagbGF1VCgdMj
        lGWEl9O4I9XI86QuGmTqCcLOrhbhiM1kGMXRO4y8qbMYVpSKzUUq6AzA6LcCQfS+VEJds=;
Received: from vpn42.vpn.mn.codeweavers.com ([10.69.139.42] helo=merlot)
        by mail.codeweavers.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <huw@codeweavers.com>)
        id 1hEWgi-0000my-TY; Thu, 11 Apr 2019 05:12:10 -0500
Received: from daviesh by merlot with local (Exim 4.90_1)
        (envelope-from <huw@codeweavers.com>)
        id 1hEWgf-0002cz-C4; Thu, 11 Apr 2019 11:12:05 +0100
From:   Huw Davies <huw@codeweavers.com>
To:     linux kernel <linux-kernel@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 3/3] x86/vdso: Add support for CLOCK_MONOTONIC_RAW in the vDSO
Date:   Thu, 11 Apr 2019 11:12:05 +0100
Message-Id: <20190411101205.10006-4-huw@codeweavers.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190411101205.10006-1-huw@codeweavers.com>
References: <20190411101205.10006-1-huw@codeweavers.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is particularly useful for Wine which needs to implement Win32
API clock functions whose values do not get adjusted by adjtimex().

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Huw Davies <huw@codeweavers.com>
---
 arch/x86/entry/vsyscall/vsyscall_gtod.c | 6 ++++++
 arch/x86/include/asm/vgtod.h            | 3 ++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/vsyscall/vsyscall_gtod.c b/arch/x86/entry/vsyscall/vsyscall_gtod.c
index ddc6a71df87c..fe3458caf301 100644
--- a/arch/x86/entry/vsyscall/vsyscall_gtod.c
+++ b/arch/x86/entry/vsyscall/vsyscall_gtod.c
@@ -68,6 +68,12 @@ void update_vsyscall(struct timekeeper *tk)
 	base->mult = tk->tkr_mono.mult;
 	base->shift = tk->tkr_mono.shift;
 
+	base = &vdata->basetime[CLOCK_MONOTONIC_RAW];
+	base->sec = tk->raw_sec;
+	base->nsec = tk->tkr_raw.xtime_nsec;
+	base->mult = tk->tkr_raw.mult;
+	base->shift = tk->tkr_raw.shift;
+
 	base = &vdata->basetime[CLOCK_REALTIME_COARSE];
 	base->sec = tk->xtime_sec;
 	base->nsec = tk->tkr_mono.xtime_nsec >> tk->tkr_mono.shift;
diff --git a/arch/x86/include/asm/vgtod.h b/arch/x86/include/asm/vgtod.h
index ae0d76491595..0b76ba884e25 100644
--- a/arch/x86/include/asm/vgtod.h
+++ b/arch/x86/include/asm/vgtod.h
@@ -30,7 +30,8 @@ struct vgtod_ts {
 };
 
 #define VGTOD_BASES	(CLOCK_TAI + 1)
-#define VGTOD_HRES	(BIT(CLOCK_REALTIME) | BIT(CLOCK_MONOTONIC) | BIT(CLOCK_TAI))
+#define VGTOD_HRES	(BIT(CLOCK_REALTIME) | BIT(CLOCK_MONOTONIC) | \
+			BIT(CLOCK_MONOTONIC_RAW) | BIT(CLOCK_TAI))
 #define VGTOD_COARSE	(BIT(CLOCK_REALTIME_COARSE) | BIT(CLOCK_MONOTONIC_COARSE))
 
 /*
-- 
2.17.1

