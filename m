Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51778C33CA1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24811206ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iPWeoA+W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387498AbgAIQKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:10:17 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40186 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387485AbgAIQKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:10:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578586215;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZnSP0pZ70yH/YNEnLlm1kliMX25WmuqwN7ivPVxI2v0=;
        b=iPWeoA+WxBrHmuZ/iOBu748x5nQNDWBsbBhnBZNmlk9NcSypiROSZoUQ2/3IIHc7RRmKhG
        IDYVb9xulHArURe9hSWchqy7G8qpBJnZe4YI7R6rxzi5TbNOCJOxDkhzkT4hiTCbZT070O
        S6pBR3gfKRLn+7mfpnqst/Ky57VgJw4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-H7VIe-VDMLylRbExWbAbtg-1; Thu, 09 Jan 2020 11:10:14 -0500
X-MC-Unique: H7VIe-VDMLylRbExWbAbtg-1
Received: by mail-wm1-f71.google.com with SMTP id t16so1104411wmt.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 08:10:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZnSP0pZ70yH/YNEnLlm1kliMX25WmuqwN7ivPVxI2v0=;
        b=R74Yz3t8j+zOBnnvAf1ucFvszl121ezPx+V82sOunrFMjUEnwo3xk4PyXCCyqzC+k4
         HfwQq/dC5/hXO8oIae5Yy3MVT9B88usiZbw06XZDlwbJS+lzupAqPNLPTPPMvKK2kA5t
         QNf3iKQyacOkvjQPq/1pPsDgFaJ38jhGS5tDBKXPXdLbt4yVmFf92qNyYgikj2f6IYUs
         qoE+cJlUWQh167KM5zl7J462/93kePPiwHKIr/3ZVt30wT9S9Ux+LPOEkHYf13iKe9oi
         iydqUU3dE+ArPcE6Ncmvm69Xqtj2ukNWUKGlN7V8yNdR0v4jr/E/x9rfLrr585uNlo8N
         mv2w==
X-Gm-Message-State: APjAAAUlqS61ALIQPk1bA9x+Clw3pQj6UAQdYyr3qRrsMkSC/Tq+3y3r
        idryHf55wB3FG9kWTF9D4fMFNidOjtEzw7Py0rQ9P6qGkJdavW2CW4zrOCpr+5GAyNdqb379q+h
        ktXU8j4+u2KYZaMgQbM+Z+IJY
X-Received: by 2002:a05:600c:108a:: with SMTP id e10mr5542129wmd.38.1578586212973;
        Thu, 09 Jan 2020 08:10:12 -0800 (PST)
X-Google-Smtp-Source: APXvYqxZtD+rP6Em4mTjnCX/pV4lGl7JJYz5/HOrqpOas0kvGyMcAfBoXa6ico6Rve7JUKRHzsZgbw==
X-Received: by 2002:a05:600c:108a:: with SMTP id e10mr5542098wmd.38.1578586212717;
        Thu, 09 Jan 2020 08:10:12 -0800 (PST)
Received: from redfedo.redhat.com (host81-140-166-164.range81-140.btcentralplus.com. [81.140.166.164])
        by smtp.gmail.com with ESMTPSA id y17sm2820948wma.36.2020.01.09.08.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 08:10:12 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC v5 57/57] arm64: crypto: Remove redundant branch
Date:   Thu,  9 Jan 2020 16:03:00 +0000
Message-Id: <20200109160300.26150-58-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200109160300.26150-1-jthierry@redhat.com>
References: <20200109160300.26150-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having a unconditional branch between the macros do_cond_yield_neon and
endif_yeild_neon causes the endif_yeild_neon to be unreachable. It so
happens that endif_yeild_neon expands to a branch and already allows to
provide the label to jump to after the yeild.

Get rid of the redundant branch instruction.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 arch/arm64/crypto/sha1-ce-core.S   | 3 +--
 arch/arm64/crypto/sha2-ce-core.S   | 3 +--
 arch/arm64/crypto/sha3-ce-core.S   | 3 +--
 arch/arm64/crypto/sha512-ce-core.S | 3 +--
 4 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/crypto/sha1-ce-core.S b/arch/arm64/crypto/sha1-ce-core.S
index c2ce1f820706..50ca9d11a61f 100644
--- a/arch/arm64/crypto/sha1-ce-core.S
+++ b/arch/arm64/crypto/sha1-ce-core.S
@@ -132,8 +132,7 @@ CPU_LE(	rev32		v11.16b, v11.16b	)
 	st1		{dgav.4s}, [x19]
 	str		dgb, [x19, #16]
 	do_cond_yield_neon
-	b		0b
-	endif_yield_neon
+	endif_yield_neon 0b
 
 	b		1b
 
diff --git a/arch/arm64/crypto/sha2-ce-core.S b/arch/arm64/crypto/sha2-ce-core.S
index 6f728a419009..c64716f5de19 100644
--- a/arch/arm64/crypto/sha2-ce-core.S
+++ b/arch/arm64/crypto/sha2-ce-core.S
@@ -139,8 +139,7 @@ CPU_LE(	rev32		v19.16b, v19.16b	)
 	if_will_cond_yield_neon
 	st1		{dgav.4s, dgbv.4s}, [x19]
 	do_cond_yield_neon
-	b		0b
-	endif_yield_neon
+	endif_yield_neon 0b
 
 	b		1b
 
diff --git a/arch/arm64/crypto/sha3-ce-core.S b/arch/arm64/crypto/sha3-ce-core.S
index a7d587fa54f6..2448d8dec0de 100644
--- a/arch/arm64/crypto/sha3-ce-core.S
+++ b/arch/arm64/crypto/sha3-ce-core.S
@@ -203,8 +203,7 @@ ENTRY(sha3_ce_transform)
 	st1	{v20.1d-v23.1d}, [x8], #32
 	st1	{v24.1d}, [x8]
 	do_cond_yield_neon
-	b		0b
-	endif_yield_neon
+	endif_yield_neon 0b
 
 	b	1b
 
diff --git a/arch/arm64/crypto/sha512-ce-core.S b/arch/arm64/crypto/sha512-ce-core.S
index ce65e3abe4f2..703724703f8f 100644
--- a/arch/arm64/crypto/sha512-ce-core.S
+++ b/arch/arm64/crypto/sha512-ce-core.S
@@ -207,8 +207,7 @@ CPU_LE(	rev64		v19.16b, v19.16b	)
 	if_will_cond_yield_neon
 	st1		{v8.2d-v11.2d}, [x19]
 	do_cond_yield_neon
-	b		0b
-	endif_yield_neon
+	endif_yield_neon 0b
 
 	b		1b
 
-- 
2.21.0

