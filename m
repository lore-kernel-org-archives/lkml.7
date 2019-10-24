Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 968D8CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 08:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AC6321872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 08:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pIb7uaZb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437977AbfJXIGL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 04:06:11 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42648 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfJXIGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 04:06:11 -0400
Received: by mail-pf1-f193.google.com with SMTP id 21so3370998pfj.9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 01:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=NFoNoda1L6TcjGEZkH600gLw7do0fH+cm0nMeiwx1No=;
        b=pIb7uaZbCqnCujproV7m9tVwv0YdwyYx1TFg7DVfK66jZ9OYBo/jGT0v/rEFbtiqxC
         9QhGcprVfN7oqUdF1Lb6oy5u9yeLb0XqfNzFBPguhnGo13YyMCFvmvmpWbcK733KMzHS
         hRql/h3l82wAwKR2UDCvTVdUzZi1YBi26EZpePSYfbEC1MpVTvQJxQeyrBCLCTLswfXz
         PQwZV+6EgX5NkqmAjLGidZOBYGWVGLtfnXKjfeyizGeamapHVSt/n2QQb6uAJ7KX67Ic
         uRwfcdgQmsHK7DXE2zQPN33XTjBL+vQjYZLTzkZe1sdjLB3buRZmH8Qm5l03J/bDUmcD
         P4xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NFoNoda1L6TcjGEZkH600gLw7do0fH+cm0nMeiwx1No=;
        b=lqAuAaUhnuQhEXVWHF2OJi91BT8zgDyTp2PAf2Fu3kLzhPE0vZnegu0pRe24O6PBHa
         6b5fw7DTqQlP27TzbhIMYBjohNXbA5Zck/VN9PBhEzND+1oxVPZbipsCAQ+FI+fDpzTL
         8zI0YdUY+cy8lKhHIWEILHcacNIX//+0xmQTBx15l3N2+g3pl8jg+uOiS6kRiXsrhpk9
         vhxWaZe3GGxFE4Hno+5jxfI1cJVwVfpZpDjGffMlQ3VevgoEWfrPMxQDHZCfSEREtxB4
         470DQJhfibMPOrqpm4jqaXU2tA1Br9YV1p6qlbC5/aIO+6Qh2xkWon25z+2x+IPcEodu
         ZArA==
X-Gm-Message-State: APjAAAXYcqr1GCkxnVV7EwtsmfZP/0jGMyV+4hBNCDlQ5xW82F7HOKP3
        oGSDRfMG5h7fWKKEk7KcLuk=
X-Google-Smtp-Source: APXvYqw7UO8GUnj1b4b6XfcSX4TDykES9o8aKOfMTBGvKR2D5ewQd2I6zEpaFZqx9OkuUskfTsrGCA==
X-Received: by 2002:a63:3104:: with SMTP id x4mr14846008pgx.135.1571904370642;
        Thu, 24 Oct 2019 01:06:10 -0700 (PDT)
Received: from bj04616pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id m22sm25659959pgj.29.2019.10.24.01.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 01:06:09 -0700 (PDT)
From:   Candle Sun <candlesea@gmail.com>
To:     will@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk
Cc:     orson.zhai@unisoc.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Candle Sun <candle.sun@unisoc.com>,
        Nianfu Bai <nianfu.bai@unisoc.com>
Subject: [PATCH v2] ARM/hw_breakpoint: add more ARMv8 debug architecture versions support
Date:   Thu, 24 Oct 2019 16:05:39 +0800
Message-Id: <20191024080539.9187-1-candlesea@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Candle Sun <candle.sun@unisoc.com>

When ARMv8 cores are used in AArch32 mode, arch_hw_breakpoint_init()
in arch/arm/kernel/hw_breakpoint.c will be used.

From ARMv8 specification, v8 debug architecture versions defined:
* 0110 ARMv8, v8 Debug architecture.
* 0111 ARMv8.1, v8 Debug architecture, with Virtualization Host
  Extensions.
* 1000 ARMv8.2, v8.2 Debug architecture.
* 1001 ARMv8.4, v8.4 Debug architecture.

So missing ARMv8.1/ARMv8.2/ARMv8.4 cases will cause
enable_monitor_mode() returns -ENODEV,and eventually
arch_hw_breakpoint_init() will fail.

Signed-off-by: Candle Sun <candle.sun@unisoc.com>
Signed-off-by: Nianfu Bai <nianfu.bai@unisoc.com>
---
Changes in v2:
- Add ARMv8.4 debug architecture case
- Update patch description
---
 arch/arm/include/asm/hw_breakpoint.h | 3 +++
 arch/arm/kernel/hw_breakpoint.c      | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm/include/asm/hw_breakpoint.h b/arch/arm/include/asm/hw_breakpoint.h
index ac54c06764e6..62358d3ca0a8 100644
--- a/arch/arm/include/asm/hw_breakpoint.h
+++ b/arch/arm/include/asm/hw_breakpoint.h
@@ -53,6 +53,9 @@ static inline void decode_ctrl_reg(u32 reg,
 #define ARM_DEBUG_ARCH_V7_MM	4
 #define ARM_DEBUG_ARCH_V7_1	5
 #define ARM_DEBUG_ARCH_V8	6
+#define ARM_DEBUG_ARCH_V8_1	7
+#define ARM_DEBUG_ARCH_V8_2	8
+#define ARM_DEBUG_ARCH_V8_4	9
 
 /* Breakpoint */
 #define ARM_BREAKPOINT_EXECUTE	0
diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
index b0c195e3a06d..02ca7adf5375 100644
--- a/arch/arm/kernel/hw_breakpoint.c
+++ b/arch/arm/kernel/hw_breakpoint.c
@@ -246,6 +246,9 @@ static int enable_monitor_mode(void)
 	case ARM_DEBUG_ARCH_V7_ECP14:
 	case ARM_DEBUG_ARCH_V7_1:
 	case ARM_DEBUG_ARCH_V8:
+	case ARM_DEBUG_ARCH_V8_1:
+	case ARM_DEBUG_ARCH_V8_2:
+	case ARM_DEBUG_ARCH_V8_4:
 		ARM_DBG_WRITE(c0, c2, 2, (dscr | ARM_DSCR_MDBGEN));
 		isb();
 		break;
-- 
2.17.1

