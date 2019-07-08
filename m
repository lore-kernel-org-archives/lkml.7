Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5278C606C6
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 17:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2DAC218A4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 17:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BNCUGiWX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390949AbfGHRtl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 13:49:41 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38711 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390267AbfGHRtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 13:49:36 -0400
Received: by mail-pg1-f194.google.com with SMTP id z75so8056635pgz.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 10:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OoW2qUxF2Y13G8sy4evp2ekSnjnyuxDpMJJ26amqb7M=;
        b=BNCUGiWXuQ8qN+niQV/uh0ftqGzahTn53WVCXKLQ7j3/UygHUpJNdM1dz3w0hUR9V9
         3/HTRrHFz27ciHAqn+eej0H+MN7JSSyl9ZHtRUnlgHj1BwgG3ICdq1xpj6Bn5VYDBAUq
         mOamx9j7XPuTvZ7+3bO+ZNE5xM1++o+Pceiv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OoW2qUxF2Y13G8sy4evp2ekSnjnyuxDpMJJ26amqb7M=;
        b=spuuUJaa+S/vEGtd5ATAhMT7lVldLFmuO3wENCymamXNtbG8cijEaZrvtlcax2is9r
         0onf9YAk9mp6M15iH/5vRMHoh1ZxZcWbasjfLvisCT4NZn3lgT9gif7XUVgBEVPvdPwl
         PYErSQY3hP10S4yYbCTyExV0ExWi9tCAcA/F6jF9+rA4BfqwXAHAH8uLjIuq4rZyp9NO
         uRujbsOl2RiS1/Dm9J3AcKJz0frPeQi2siGkAvvAQOMZo7B76dn3PNe57fg8t3o5VY/N
         inNT0A1O+FITSbDM09Ds24cx1YaNPotPZEIwVgOZrV9xpWy++F+6Ybcuvl36omx4nNsp
         VazA==
X-Gm-Message-State: APjAAAWPGslAFKtVtTFv9U9zvu7d0xZ0zv+DJEvPWKxp4ZReLCnNJDkH
        S44d0a5SCFV2fYHvNoFaO86Riw==
X-Google-Smtp-Source: APXvYqw279fFsYnSHVmw/+KLDHUbYaOUU+X8mJqY8GWz4AaJjrinbltbShvM9qQHBj13cCc5O+8nig==
X-Received: by 2002:a17:90a:5288:: with SMTP id w8mr27583562pjh.61.1562608175528;
        Mon, 08 Jul 2019 10:49:35 -0700 (PDT)
Received: from skynet.sea.corp.google.com ([2620:0:1008:1100:c4b5:ec23:d87b:d6d3])
        by smtp.gmail.com with ESMTPSA id j1sm20151686pfe.101.2019.07.08.10.49.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 10:49:35 -0700 (PDT)
From:   Thomas Garnier <thgarnie@chromium.org>
To:     kernel-hardening@lists.openwall.com
Cc:     kristen@linux.intel.com, keescook@chromium.org,
        Thomas Garnier <thgarnie@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Len Brown <len.brown@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v8 06/11] x86/CPU: Adapt assembly for PIE support
Date:   Mon,  8 Jul 2019 10:48:59 -0700
Message-Id: <20190708174913.123308-7-thgarnie@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190708174913.123308-1-thgarnie@chromium.org>
References: <20190708174913.123308-1-thgarnie@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the assembly code to use only relative references of symbols for the
kernel to be PIE compatible. Use the new _ASM_MOVABS macro instead of
the 'mov $symbol, %dst' construct.

Position Independent Executable (PIE) support will allow to extend the
KASLR randomization range below 0xffffffff80000000.

Signed-off-by: Thomas Garnier <thgarnie@chromium.org>
---
 arch/x86/include/asm/processor.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 3eab6ece52b4..3e2154b0e09f 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -713,11 +713,13 @@ static inline void sync_core(void)
 		"pushfq\n\t"
 		"mov %%cs, %0\n\t"
 		"pushq %q0\n\t"
-		"pushq $1f\n\t"
+		"movabsq $1f, %q0\n\t"
+		"pushq %q0\n\t"
 		"iretq\n\t"
 		UNWIND_HINT_RESTORE
 		"1:"
-		: "=&r" (tmp), ASM_CALL_CONSTRAINT : : "cc", "memory");
+		: "=&r" (tmp), ASM_CALL_CONSTRAINT
+		: : "cc", "memory");
 #endif
 }
 
-- 
2.22.0.410.gd8fdbe21b5-goog

