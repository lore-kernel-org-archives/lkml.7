Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA040C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 19:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C1BA2087F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 19:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m478ElFD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388211AbfG3TNW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 15:13:22 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42198 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387673AbfG3TNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 15:13:12 -0400
Received: by mail-pf1-f193.google.com with SMTP id q10so30321295pff.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 12:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cCMnXk6r3FPny+fs1rFc2SWMhw3bJ0loL2W4TiBySr8=;
        b=m478ElFD7q//7AsCxpL9OrAKQBrInm/GCtxGDID+1HbrAnQFF52Ffax0qaupTPDbf/
         GHWHftjDWsObpuzqxd4JH6kFG9bWkMamNih32q2W6VEU2kHfJUJMUiqfHVVZTC06mUOj
         MC1EU6K7NgoUvlEjAb13R+v1h/BbOjctlPBjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cCMnXk6r3FPny+fs1rFc2SWMhw3bJ0loL2W4TiBySr8=;
        b=T1SbbDr7Fv+Yd1GY0NQHPZWt90cfq/fHaZ8Tm1FlhvB0a5o5J/y5JRt/cghU0OKnS4
         dr+lKExTf54TM4WqW2hCZlhLUf5SHX8KFHmT6wEbd2gawvtmf1S0+5cKuvMSJOieF3I7
         0wlaRLl9iTGZtgcsz2tdPsJrNak6lf5flmaz0LdjV1hBHtrGTkgXPZP3HooCEWGsxFgl
         D9R9eB24XFvXuhSGlw39qqQ4B4pa1MFTTfj+Mi5m78nbhuZmuUnQT7Vb8nYRUj6FEMo3
         rL92k1neuSbvs6kwU+dMbG7DFwJlOuVrgk0yFfLdDGEjcX05qpHwWxcOiA6nRWcEV0DC
         wAVQ==
X-Gm-Message-State: APjAAAVoa2XjoHk1Y811VCNXKMe18rL3IPJCTPjJHeBuiTpGxDp9tsJi
        xLJC/XFt7F1swD/MxKj1WhbkcQ==
X-Google-Smtp-Source: APXvYqxEEHpoFd295wN4FVenXhrnLJncXmAxP37HqjVX+fNi4I8BrYTgPlqRHeP0sCOCSagbyTiddw==
X-Received: by 2002:a63:fd57:: with SMTP id m23mr44942158pgj.204.1564513992259;
        Tue, 30 Jul 2019 12:13:12 -0700 (PDT)
Received: from skynet.sea.corp.google.com ([2620:0:1008:1100:c4b5:ec23:d87b:d6d3])
        by smtp.gmail.com with ESMTPSA id n89sm84649540pjc.0.2019.07.30.12.13.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 12:13:11 -0700 (PDT)
From:   Thomas Garnier <thgarnie@chromium.org>
To:     kernel-hardening@lists.openwall.com
Cc:     kristen@linux.intel.com, keescook@chromium.org,
        Thomas Garnier <thgarnie@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Nadav Amit <namit@vmware.com>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 02/11] x86: Add macro to get symbol address for PIE support
Date:   Tue, 30 Jul 2019 12:12:46 -0700
Message-Id: <20190730191303.206365-3-thgarnie@chromium.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190730191303.206365-1-thgarnie@chromium.org>
References: <20190730191303.206365-1-thgarnie@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new _ASM_MOVABS macro to fetch a symbol address. It will be used
to replace "_ASM_MOV $<symbol>, %dst" code construct that are not
compatible with PIE.

Signed-off-by: Thomas Garnier <thgarnie@chromium.org>
---
 arch/x86/include/asm/asm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
index 3ff577c0b102..3a686057e882 100644
--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -30,6 +30,7 @@
 #define _ASM_ALIGN	__ASM_SEL(.balign 4, .balign 8)
 
 #define _ASM_MOV	__ASM_SIZE(mov)
+#define _ASM_MOVABS	__ASM_SEL(movl, movabsq)
 #define _ASM_INC	__ASM_SIZE(inc)
 #define _ASM_DEC	__ASM_SIZE(dec)
 #define _ASM_ADD	__ASM_SIZE(add)
-- 
2.22.0.770.g0f2c4a37fd-goog

