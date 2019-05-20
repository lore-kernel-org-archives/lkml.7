Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7AC9C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 23:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70F332171F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 23:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G0HLUh6e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbfETXUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 19:20:33 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41212 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727431AbfETXUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 19:20:23 -0400
Received: by mail-pl1-f193.google.com with SMTP id f12so7420236plt.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 16:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UAWq/U5Cl0xown3M4zRB/+A5GL/fjUvY6epXW6tZYg8=;
        b=G0HLUh6e5TXicptzdHaHOv99joSx3699BQ8oyB/a0rkjhYW7ff2j5Ih3DdY0sE2cQQ
         KhjhgRjPCPS1V8fXDvwbrPnkCGW/mVdHN6Ttl77xBMR/BZADsnAvSEtUZOsfEC6E6IUX
         AyND8sQeuZOujIQL/Ec8EEinbyM55WevZVORQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UAWq/U5Cl0xown3M4zRB/+A5GL/fjUvY6epXW6tZYg8=;
        b=Rk6JZAqzvI/4zHijFfRPHVd2Swpf2uABpn5N14sbMmgSOU9BKcCQwltyaVO6YDAHur
         Deebhxtdxz0CZbl+3/TlsxLXgm2hbodKnmes2ynNkvtyQEC3N3OVpmJnOpoThgx60xfW
         r265NBi3lxaVk9HWqx9agY4NMqF2qcKcitAhMr8isN4qzi+H/D7NX9GERo3d1+TAPJCE
         3VcOmyS0UlipUZ418mER9MNYwChxUJwV2xDDHCBPo/LYLFfKu6VAZCcMlIBaPOrRMFcH
         LFWkupvMxZ3CC1+BgEcUiEwIHb4iXkv17uHKnHWiZF7aZTbIGYkQ3E8jootGDLFihAct
         IpiA==
X-Gm-Message-State: APjAAAVKNmR6ONk1fODwhoiVh+Fv7ThMExM+F3X46q79/2pi1PyGz12o
        Ux0oXy3Ex9/OyoKIRKw7RUBEPw==
X-Google-Smtp-Source: APXvYqxuu3FAJVEvYAXGWouOaAg7HLWlZ4XubtLPm7DBKhdz9pXfHrYPG/mUBKLkmdSNklZAcrdxLA==
X-Received: by 2002:a17:902:6bc4:: with SMTP id m4mr2396808plt.266.1558394422567;
        Mon, 20 May 2019 16:20:22 -0700 (PDT)
Received: from skynet.sea.corp.google.com ([2620:0:1008:1100:c4b5:ec23:d87b:d6d3])
        by smtp.gmail.com with ESMTPSA id h13sm19350861pgk.55.2019.05.20.16.20.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 16:20:22 -0700 (PDT)
From:   Thomas Garnier <thgarnie@chromium.org>
To:     kernel-hardening@lists.openwall.com
Cc:     kristen@linux.intel.com, Thomas Garnier <thgarnie@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Nadav Amit <namit@vmware.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v7 12/12] x86/alternatives: Adapt assembly for PIE support
Date:   Mon, 20 May 2019 16:19:37 -0700
Message-Id: <20190520231948.49693-13-thgarnie@chromium.org>
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

Change the assembly options to work with pointers instead of integers.

Position Independent Executable (PIE) support will allow to extend the
KASLR randomization range below 0xffffffff80000000.

Signed-off-by: Thomas Garnier <thgarnie@google.com>
---
 arch/x86/include/asm/alternative.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 094fbc9c0b1c..28a838106e5f 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -243,7 +243,7 @@ static inline int alternatives_text_reserved(void *start, void *end)
 /* Like alternative_io, but for replacing a direct call with another one. */
 #define alternative_call(oldfunc, newfunc, feature, output, input...)	\
 	asm volatile (ALTERNATIVE("call %P[old]", "call %P[new]", feature) \
-		: output : [old] "i" (oldfunc), [new] "i" (newfunc), ## input)
+		: output : [old] "X" (oldfunc), [new] "X" (newfunc), ## input)
 
 /*
  * Like alternative_call, but there are two features and respective functions.
@@ -256,8 +256,8 @@ static inline int alternatives_text_reserved(void *start, void *end)
 	asm volatile (ALTERNATIVE_2("call %P[old]", "call %P[new1]", feature1,\
 		"call %P[new2]", feature2)				      \
 		: output, ASM_CALL_CONSTRAINT				      \
-		: [old] "i" (oldfunc), [new1] "i" (newfunc1),		      \
-		  [new2] "i" (newfunc2), ## input)
+		: [old] "X" (oldfunc), [new1] "X" (newfunc1),		      \
+		  [new2] "X" (newfunc2), ## input)
 
 /*
  * use this macro(s) if you need more than one output parameter
-- 
2.21.0.1020.gf2820cf01a-goog

