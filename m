Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 137AFC73C41
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 12:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCDE820861
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 12:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fossix-org.20150623.gappssmtp.com header.i=@fossix-org.20150623.gappssmtp.com header.b="Aq4tw2DO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbfGIMQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 08:16:15 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36830 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfGIMQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 08:16:15 -0400
Received: by mail-pl1-f194.google.com with SMTP id k8so10021047plt.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 05:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fkBqb9r0ZPOja9LVgBYQkYAhfvXLkyoq2mrWQ0Pvb1g=;
        b=Aq4tw2DOBGdNB98EMhXA4w+2ylAiJ1OoZ3NSWIh34kOBQUPX8LuS0VRymUQpuGOvBu
         rGEaItVxkNkDUTz//EY+aLVdfR4b+kKkRdiV4ho1cD1ug5FrdeOBgb36izjxxDzVAevZ
         ACC7a/9tkGYTXuxqeg6ltiNNN2XwoW6yMImECQU0a+vdSq6ZyNXDKtgxo/+vOMqGVigQ
         cJ+kK1ZmrHspDe0nIbIFYWf7UctJ7R5JkluYqRyXrpkNZjH1OBNty7GLFMXo2C//icqj
         FPwKWlEeesGB2W6zZEt7aN04czkEoS9wHXmO+xYnZUnWPewITL541qK60sdqPQU2ALZx
         QouQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fkBqb9r0ZPOja9LVgBYQkYAhfvXLkyoq2mrWQ0Pvb1g=;
        b=gBCvICg9TsGjYD00nzmnV4puY5U5jebQaMZRFun4l0V17BpeSbefkdxzwCAiC7Hr88
         q++JncvLiXG4OrhGQAQey836182YUQ61+gdUL69ibSU1R34OEdoaQNICk+ikN6IoIUVq
         4l6twwMM+9tKZaU4DP6GD2Utj6SUqn1NYWT+rIWINj9eZu0dp+8Js8Y6deOdwqBigVXc
         kDy/O86nSEpJ2BhsCXKKRUTsm+CQOBrOYxDziyGduJH130Bx8yPWQ5yNwE+niozTlhR5
         5fcDDUcRey6iGp1opgx6tLiUlw98rlqxiJZUBh1QjeP1OdulNxy/DZ83Oq3ZHs08ZzCf
         Uv1g==
X-Gm-Message-State: APjAAAXIzgGJR+1Q3RrJzTmBmWnzJP6NsPPNJ3++7+5hTcgrnyf/P5TK
        bgoaUQhT1SFl/avNB0LwJhXAzA==
X-Google-Smtp-Source: APXvYqxoJPumP2n/U3rz8WfX3Lh81RLahpQDrCmW2U3rK49Lkf/SP3QFjcTITL8TkqaPWIT1ztqrew==
X-Received: by 2002:a17:902:24c:: with SMTP id 70mr31615139plc.2.1562674574365;
        Tue, 09 Jul 2019 05:16:14 -0700 (PDT)
Received: from santosiv.in.ibm.com ([223.186.121.175])
        by smtp.gmail.com with ESMTPSA id o15sm21243933pgj.18.2019.07.09.05.16.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 05:16:14 -0700 (PDT)
From:   Santosh Sivaraj <santosh@fossix.org>
To:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-kernel@vger.kernel.org
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Reza Arbab <arbab@linux.ibm.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        christophe leroy <christophe.leroy@c-s.fr>
Subject: [v5 6/6] powerpc: add machine check safe copy_to_user
Date:   Tue,  9 Jul 2019 17:45:24 +0530
Message-Id: <20190709121524.18762-7-santosh@fossix.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190709121524.18762-1-santosh@fossix.org>
References: <20190709121524.18762-1-santosh@fossix.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use  memcpy_mcsafe() implementation to define copy_to_user_mcsafe()

Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
---
 arch/powerpc/Kconfig               |  1 +
 arch/powerpc/include/asm/uaccess.h | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 8c1c636308c8..a173b392c272 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -134,6 +134,7 @@ config PPC
 	select ARCH_HAS_STRICT_KERNEL_RWX	if ((PPC_BOOK3S_64 || PPC32) && !RELOCATABLE && !HIBERNATION)
 	select ARCH_HAS_TICK_BROADCAST		if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAS_UACCESS_FLUSHCACHE	if PPC64
+	select ARCH_HAS_UACCESS_MCSAFE		if PPC64
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
 	select ARCH_HAS_ZONE_DEVICE		if PPC_BOOK3S_64
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index 76f34346b642..8899864a5552 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -386,6 +386,20 @@ static inline unsigned long raw_copy_to_user(void __user *to,
 	return ret;
 }
 
+static __always_inline unsigned long __must_check
+copy_to_user_mcsafe(void __user *to, const void *from, unsigned long n)
+{
+	if (likely(check_copy_size(from, n, true))) {
+		if (access_ok(to, n)) {
+			allow_write_to_user(to, n);
+			n = memcpy_mcsafe((void *)to, from, n);
+			prevent_write_to_user(to, n);
+		}
+	}
+
+	return n;
+}
+
 extern unsigned long __clear_user(void __user *addr, unsigned long size);
 
 static inline unsigned long clear_user(void __user *addr, unsigned long size)
-- 
2.20.1

