Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE5AC432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 07:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C12B3222C3
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 07:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6Yje2WD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730538AbfIZHjo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 03:39:44 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33438 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728263AbfIZHjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 03:39:44 -0400
Received: by mail-pf1-f195.google.com with SMTP id q10so1355257pfl.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 00:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=HzGUkaoGcW3mdUmJnqxtLb5+t2i8FwmzFVNwvPd0PPg=;
        b=m6Yje2WDv15asqStTscydbt0qRWRZ6Bd7CHEuPniujA0FAiEHBYuYu1baqtdLuM52t
         Xcm1dzwW/CRhroaEjMApnsvEKgF9nvYLIStzepqWGa8miuWs6aqvwBRgXw1Tz9OSHY2z
         10tjXskx5HzSkIAz82Wh9E20UXjc1+6Lla+vN//8rTwtQlfKovJYgtfVOY6RKf7+PNSD
         +8x9OtXOK+8Kx/cUTzZa7Vz1jqNZRv8pTBE42UvVl11TImOC8+lkfMFP9Oyt89gnsVrn
         w+ojblxcInKrM7ZqMYpUIL5QJsjIwyGPHw7h3HfmlXO1/kd6t5xq1ezLCWUhjfKLsfGu
         qENg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HzGUkaoGcW3mdUmJnqxtLb5+t2i8FwmzFVNwvPd0PPg=;
        b=J4I3bdfbyKNQyz142JyL67xAApbnuqQqPtvy7VI1hHN/SXwu+wqL+NNwI+gXwgMiMA
         IPRy46NEoHwRek6zfcgcOeHY2CMgf02WLCa9XYrzeVVlDjLx3aPODBz0ft6KMkUxkhvZ
         dNeVdRxvTjo3/UvWtJTPdksZUxoBMveoD6YzfmE7qqYVTVbABGMf/Nn/C9NwpqqlTE46
         MF3A7qYgLqFK5kcv562iGnlrLVuZxmsVKL8vcblE7cLcwfq9ZGR8Ws22BiYAKTL4IpRQ
         WIw3uxUoSXVSvgtlnbEXf5Qxn+on38ekwdBk91+77HYx+BQIbFNT3NDPJujPh+MulGbF
         W6NA==
X-Gm-Message-State: APjAAAWusIpp15Bro22JIKnY6fryYSx+t2BhESchPrySwu+pmbGGoHst
        FxzAVt7awGP9xia6TpsjcqE=
X-Google-Smtp-Source: APXvYqxfyaPfSeYrkecMjySLxZ/eEs3VKQY0c+5Rbj9H35ViN9RC2gqgO5x/VsuVxvnW6VnFtFgMjw==
X-Received: by 2002:a65:6799:: with SMTP id e25mr2099914pgr.271.1569483583803;
        Thu, 26 Sep 2019 00:39:43 -0700 (PDT)
Received: from bj04616pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id a8sm2608699pfa.182.2019.09.26.00.39.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 26 Sep 2019 00:39:42 -0700 (PDT)
From:   Candle Sun <candlesea@gmail.com>
To:     will@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Candle Sun <candle.sun@unisoc.com>,
        Nianfu Bai <nianfu.bai@unisoc.com>
Subject: [RESEND PATCH] ARM/hw_breakpoint: add ARMv8.1/ARMv8.2 debug architecutre versions support in enable_monitor_mode()
Date:   Thu, 26 Sep 2019 15:38:28 +0800
Message-Id: <1569483508-18768-1-git-send-email-candlesea@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Candle Sun <candle.sun@unisoc.com>

When ARMv8.1/ARMv8.2 cores are used in AArch32 mode,
arch_hw_breakpoint_init() in arch/arm/kernel/hw_breakpoint.c will be used.

From ARMv8 specification, different debug architecture versions defined:
* 0110 ARMv8, v8 Debug architecture.
* 0111 ARMv8.1, v8 Debug architecture, with Virtualization Host Extensions.
* 1000 ARMv8.2, v8.2 Debug architecture.

So missing ARMv8.1/ARMv8.2 cases will cause enable_monitor_mode() function
returns -ENODEV, and arch_hw_breakpoint_init() will fail.

Signed-off-by: Candle Sun <candle.sun@unisoc.com>
Signed-off-by: Nianfu Bai <nianfu.bai@unisoc.com>
---
 arch/arm/include/asm/hw_breakpoint.h | 2 ++
 arch/arm/kernel/hw_breakpoint.c      | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm/include/asm/hw_breakpoint.h b/arch/arm/include/asm/hw_breakpoint.h
index ac54c06..9137ef6 100644
--- a/arch/arm/include/asm/hw_breakpoint.h
+++ b/arch/arm/include/asm/hw_breakpoint.h
@@ -53,6 +53,8 @@ static inline void decode_ctrl_reg(u32 reg,
 #define ARM_DEBUG_ARCH_V7_MM	4
 #define ARM_DEBUG_ARCH_V7_1	5
 #define ARM_DEBUG_ARCH_V8	6
+#define ARM_DEBUG_ARCH_V8_1	7
+#define ARM_DEBUG_ARCH_V8_2	8
 
 /* Breakpoint */
 #define ARM_BREAKPOINT_EXECUTE	0
diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
index b0c195e..cb99612 100644
--- a/arch/arm/kernel/hw_breakpoint.c
+++ b/arch/arm/kernel/hw_breakpoint.c
@@ -246,6 +246,8 @@ static int enable_monitor_mode(void)
 	case ARM_DEBUG_ARCH_V7_ECP14:
 	case ARM_DEBUG_ARCH_V7_1:
 	case ARM_DEBUG_ARCH_V8:
+	case ARM_DEBUG_ARCH_V8_1:
+	case ARM_DEBUG_ARCH_V8_2:
 		ARM_DBG_WRITE(c0, c2, 2, (dscr | ARM_DSCR_MDBGEN));
 		isb();
 		break;
-- 
2.7.4

