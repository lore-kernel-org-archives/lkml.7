Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0540C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 23:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 924262171F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 23:20:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d0sVux2H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbfETXUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 19:20:48 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45358 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727382AbfETXUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 19:20:16 -0400
Received: by mail-pl1-f196.google.com with SMTP id a5so7396782pls.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 16:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7zcfl54ngcYZWe7SGjAVojGJkuuDkL2OOBnEHI8Zvuw=;
        b=d0sVux2H+Kp0vgnzWLkwaPIwsszW/blM2lWdjPDmAFb+mqIIG1s6CfAJxjwUcbjY6o
         fNLaPs6m1ivpVT8hWujSHn6V/uWK7/QnVmFz+fqPxMJVze0DAEF6km91b6qVleXbbxxt
         RAsVRk1pUchvj8zQPNU2JSeZCF/beeoFod/HU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7zcfl54ngcYZWe7SGjAVojGJkuuDkL2OOBnEHI8Zvuw=;
        b=P2x864uxSGeiu9CfvS3hWMfVZQAvNZH9XDXXeghw4l9PfaL58jix5pabUV7PmTtHjL
         3EpV9ZNLuFzq8x+7yj14Xr0kXciIVawlejoiMSL9IGmpS3KiITlHM3yVtkQmmVCdpTNR
         WclL/FulX2L72DugIihCZsRU+aHei7nGqmZ4gI7m9qDPQMkyGELuxDmRe2s1bz3MgiVq
         8N/yuDcWcCcncmhf/Hi5w2mTHtOzpVggqslRxPN+cbd/cJH2q1Gb2eYkIfyVs0KHoKSd
         CRiUISanpHin++oUqr35QQbhSI7rNbAwT+gM+W7Kz4fVWzqnitvNPvJDXnKYlsRyQ8vp
         IK9A==
X-Gm-Message-State: APjAAAXfHPFpxOdtFgcUusIlM3otbEwzdN+svUJ6P9+a/VnmcYYrDUVL
        Z8gWGdJtznLNJwYk1coyrX81kw==
X-Google-Smtp-Source: APXvYqyR5iFeDrOxrxE1hHhUIn+dH4BeM6Xeg5KaFIUtHRV7653rxOhVDxMaJjYMO0sQEPJqcLk2Sg==
X-Received: by 2002:a17:902:e213:: with SMTP id ce19mr80568333plb.30.1558394415530;
        Mon, 20 May 2019 16:20:15 -0700 (PDT)
Received: from skynet.sea.corp.google.com ([2620:0:1008:1100:c4b5:ec23:d87b:d6d3])
        by smtp.gmail.com with ESMTPSA id h13sm19350861pgk.55.2019.05.20.16.20.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 16:20:14 -0700 (PDT)
From:   Thomas Garnier <thgarnie@chromium.org>
To:     kernel-hardening@lists.openwall.com
Cc:     kristen@linux.intel.com, Thomas Garnier <thgarnie@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v7 07/12] x86/CPU: Adapt assembly for PIE support
Date:   Mon, 20 May 2019 16:19:32 -0700
Message-Id: <20190520231948.49693-8-thgarnie@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190520231948.49693-1-thgarnie@chromium.org>
References: <20190520231948.49693-1-thgarnie@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Garnier <thgarnie@google.com>

Change the assembly code to use only relative references of symbols for the
kernel to be PIE compatible. Use the new _ASM_MOVABS macro instead of
the 'mov $symbol, %dst' construct.

Position Independent Executable (PIE) support will allow to extend the
KASLR randomization range below 0xffffffff80000000.

Signed-off-by: Thomas Garnier <thgarnie@google.com>
---
 arch/x86/include/asm/processor.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index c34a35c78618..5490a6ead17c 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -710,11 +710,13 @@ static inline void sync_core(void)
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
2.21.0.1020.gf2820cf01a-goog

