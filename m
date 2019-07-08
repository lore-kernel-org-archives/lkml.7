Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D6C2C606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 17:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66322218A4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 17:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Eh1Z2cY2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390555AbfGHRti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 13:49:38 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37151 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390218AbfGHRtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 13:49:33 -0400
Received: by mail-pg1-f196.google.com with SMTP id g15so8061639pgi.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 10:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3Eb3Hb6sMPNCVrucYh3+8MTfpr8uJqt0a1oSlG2FmzA=;
        b=Eh1Z2cY2TLITAWx2bANgQlukRumh7aQ8qMvjId2GjyNdQSlE4Akz5EQfSMUNs2dLbi
         rkR2NqSY4lMvwQf9S2DSQpCn+V6sCrXSfutHEtHfoKNwXdYMkVs+tvmlPiGyIMYHLTac
         U4GrH9ccvKqYgl5u99ugvBNsZsnU7+UIhA3VA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3Eb3Hb6sMPNCVrucYh3+8MTfpr8uJqt0a1oSlG2FmzA=;
        b=qUHe4yrNJvVhbTxMeuUw3xonf4v86DzsuYlvSQvRRTkRxy/bFAIBrTCSOV0/X0EcGi
         Gsx97/3vQzxa8+ZN9oiNMAeiN6/CfEqrlXObyWs+tLbWIVA19LXFiOOSri3ktchOKRPq
         2Fpk8ty4QHmRr81CWDB3kQ9KrHaKuQok4SeNzZW+53zMzqHPn6Le7hWpyskBMnuk/DeY
         xlURhfMQlFZGQBWybZ+OSyG69nUZvCwuharBACMYvD+2i0F1xG88+kIHiSY8yIW1EPHG
         6BuP5IXIvKS+BM6Q4Rm1yC659FEPncbUGD719Vil9wesC5kn62eqGWaidH0tFDDpXTv7
         h5Wg==
X-Gm-Message-State: APjAAAVxI39Wtljo7iaheH0+V/yejXWbVzRjS2990HawpDB3CP2PEgnI
        UcbpWL216Zt4rXREKy6llt1Y5w==
X-Google-Smtp-Source: APXvYqxUXc4eLmCK5ydeVvkEVQiap2JrFMI/RSqJ2b7/EDWXwmMFOd4atDt+r3lAjdEJ37qlAwbKDw==
X-Received: by 2002:a17:90a:3463:: with SMTP id o90mr27861911pjb.15.1562608173232;
        Mon, 08 Jul 2019 10:49:33 -0700 (PDT)
Received: from skynet.sea.corp.google.com ([2620:0:1008:1100:c4b5:ec23:d87b:d6d3])
        by smtp.gmail.com with ESMTPSA id j1sm20151686pfe.101.2019.07.08.10.49.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 10:49:32 -0700 (PDT)
From:   Thomas Garnier <thgarnie@chromium.org>
To:     kernel-hardening@lists.openwall.com
Cc:     kristen@linux.intel.com, keescook@chromium.org,
        Thomas Garnier <thgarnie@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 05/11] x86: pm-trace - Adapt assembly for PIE support
Date:   Mon,  8 Jul 2019 10:48:58 -0700
Message-Id: <20190708174913.123308-6-thgarnie@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190708174913.123308-1-thgarnie@chromium.org>
References: <20190708174913.123308-1-thgarnie@chromium.org>
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
2.22.0.410.gd8fdbe21b5-goog

