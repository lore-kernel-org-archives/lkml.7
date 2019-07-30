Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF34C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 19:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3513D20693
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 19:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WTaj/tCW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388352AbfG3TN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 15:13:59 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41693 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388005AbfG3TNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 15:13:18 -0400
Received: by mail-pg1-f194.google.com with SMTP id x15so20205374pgg.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 12:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=okwXTawHyuFa4icd55twJCHtmhUjDA75Nfe9+fhiSRI=;
        b=WTaj/tCWBI6QVlq4nKTsAxYz1lBPqS7a9eK0QDXPMmbAPy3XkclyuEpGhNiM9+Qc+a
         GfZPY1tJuv8B58Sdyy1D7YxyiHEVqzCtOyRukRfXTl4S9nHMyfrDJWQu9PKz6P5BMI8I
         gB3+kX3pX//wpXa3Ez7mNRLg83QLHpddaT690=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=okwXTawHyuFa4icd55twJCHtmhUjDA75Nfe9+fhiSRI=;
        b=RBflFaP8caW0uXMy6dL13sShTlWWMi3QLNHQWs6Iur2xmHyoJzGUOPlL1jLRIwNZFB
         Pspef2eS2FEnPF/y1iAp4k4pOdQTU6qR0jUsiOvlo3WTlLHDmeuiRotcI4gQLTmjt3T6
         +XNesofyaxZvvdaUS2v55BiGnHhG+Ssl3wYmVYkJXQrSACKqIo4hg6wXemaa9V/AtnJI
         fMwgUSlUGXb+c8nDcGrm4hxHgb+SxQMZdtEAZldMHrCoJuviHsek/nS/8D9u3KNBRn7a
         6KIPkpiJR03oyV+k7SFJPGLur5plO+SfQg6/43zMuQxYiAprqcMO4ET3q0sYPqsLaeRz
         dU/g==
X-Gm-Message-State: APjAAAViDEcNYl+SOUUMkzgF+4CFA3lzKnhbHqELkt2f3ICHDOv6OKqq
        qq2Ci563HUSjWlZK7p38yN7OOA==
X-Google-Smtp-Source: APXvYqyboxn+AlEAdie6u7CC57V8sWfALD8FpbLQHIYoEr0y0DEAHDVqK2YOnXcRGhf2UDGdqqHftQ==
X-Received: by 2002:a63:184b:: with SMTP id 11mr49666372pgy.112.1564513997493;
        Tue, 30 Jul 2019 12:13:17 -0700 (PDT)
Received: from skynet.sea.corp.google.com ([2620:0:1008:1100:c4b5:ec23:d87b:d6d3])
        by smtp.gmail.com with ESMTPSA id n89sm84649540pjc.0.2019.07.30.12.13.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 12:13:17 -0700 (PDT)
From:   Thomas Garnier <thgarnie@chromium.org>
To:     kernel-hardening@lists.openwall.com
Cc:     kristen@linux.intel.com, keescook@chromium.org,
        Thomas Garnier <thgarnie@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 05/11] x86: pm-trace - Adapt assembly for PIE support
Date:   Tue, 30 Jul 2019 12:12:49 -0700
Message-Id: <20190730191303.206365-6-thgarnie@chromium.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190730191303.206365-1-thgarnie@chromium.org>
References: <20190730191303.206365-1-thgarnie@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change assembly to use the new _ASM_MOVABS macro instead of _ASM_MOV for
the assembly to be PIE compatible.

Position Independent Executable (PIE) support will allow to extend the
KASLR randomization range below 0xffffffff80000000.

Signed-off-by: Thomas Garnier <thgarnie@chromium.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/include/asm/pm-trace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/pm-trace.h b/arch/x86/include/asm/pm-trace.h
index bfa32aa428e5..972070806ce9 100644
--- a/arch/x86/include/asm/pm-trace.h
+++ b/arch/x86/include/asm/pm-trace.h
@@ -8,7 +8,7 @@
 do {								\
 	if (pm_trace_enabled) {					\
 		const void *tracedata;				\
-		asm volatile(_ASM_MOV " $1f,%0\n"		\
+		asm volatile(_ASM_MOVABS " $1f,%0\n"		\
 			     ".section .tracedata,\"a\"\n"	\
 			     "1:\t.word %c1\n\t"		\
 			     _ASM_PTR " %c2\n"			\
-- 
2.22.0.770.g0f2c4a37fd-goog

