Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93B5C04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 23:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA7CC2171F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 23:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BcEzpaCt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbfETXUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 19:20:40 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34024 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727426AbfETXUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 19:20:20 -0400
Received: by mail-pg1-f195.google.com with SMTP id c13so7520755pgt.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 16:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M1E8RaUn9zcJYuZZG/7uL4HyNdEDRlNB8oeiw9QadoE=;
        b=BcEzpaCtHDeErP/BWLjRyK7fBTLMOKLcQuvK1NL+Ewf75ZVTEmchKagvJas138fFpL
         etBB19RzMP4xlK44gIOaNkXNur2K5KlwyPYFy+UCAR8CYMqPnPkHC5ZRIuwT9tVZI1X7
         SEpRCJTIhgZIMaMDFFfQ6unPUoEFaArraP16M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M1E8RaUn9zcJYuZZG/7uL4HyNdEDRlNB8oeiw9QadoE=;
        b=pVoneiAFVqvlBNK7u1i5dRUjT3Ou5N6ko4kx6OTtSOAanodOpNKjDDBucGZ9GkRGED
         YTo8Z/iT91IhKsV5RDSKgVzb+0e0+kGQNIRnL5KE4BLspZLAyVR25K1N/wfzHnGF0zBE
         zwOOlvTi7OKUTd/DYguOEin1emhNS6FRkzSGVzWxgPfUiRYcWAmhmRZThpLW+D+wkMEU
         OZSFzj4c8zTtoLbLp5egghQNpDGWWzPjfaHRHFzDcjj/p9CV1xKeDRqHVG0KSCiQ7Luz
         VFgpQK4IsAAMlH3wGKHmQN0GD97uJpnOUsHxrXolH54H/Rzjbu/QG5Pwhb7Jqy5cJpNh
         aZnw==
X-Gm-Message-State: APjAAAVwoY+wg+agHU7LXKLMf5itfTh4cTtBf452BeTCHu56r/V3h+dU
        Pl25DWT7Z+PBCSpFqdaVQMW9ZRNa9gI=
X-Google-Smtp-Source: APXvYqyT2kryQV+6jF2IYoOf+x3y5b6AlPsCieYaesFkPafg3IMH+szJ+l/D5ocyk156zDt8vQJpkA==
X-Received: by 2002:a63:730f:: with SMTP id o15mr78268823pgc.315.1558394420454;
        Mon, 20 May 2019 16:20:20 -0700 (PDT)
Received: from skynet.sea.corp.google.com ([2620:0:1008:1100:c4b5:ec23:d87b:d6d3])
        by smtp.gmail.com with ESMTPSA id h13sm19350861pgk.55.2019.05.20.16.20.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 16:20:20 -0700 (PDT)
From:   Thomas Garnier <thgarnie@chromium.org>
To:     kernel-hardening@lists.openwall.com
Cc:     kristen@linux.intel.com, Thomas Garnier <thgarnie@google.com>,
        Juergen Gross <jgross@suse.com>,
        Alok Kataria <akataria@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 11/12] x86/paravirt: Adapt assembly for PIE support
Date:   Mon, 20 May 2019 16:19:36 -0700
Message-Id: <20190520231948.49693-12-thgarnie@chromium.org>
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

if PIE is enabled, switch the paravirt assembly constraints to be
compatible. The %c/i constrains generate smaller code so is kept by
default.

Position Independent Executable (PIE) support will allow to extend the
KASLR randomization range below 0xffffffff80000000.

Signed-off-by: Thomas Garnier <thgarnie@google.com>
---
 arch/x86/include/asm/paravirt_types.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 2474e434a6f7..93be18bdb63e 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -343,9 +343,17 @@ extern struct paravirt_patch_template pv_ops;
 #define PARAVIRT_PATCH(x)					\
 	(offsetof(struct paravirt_patch_template, x) / sizeof(void *))
 
+#ifdef CONFIG_X86_PIE
+#define paravirt_opptr_call "a"
+#define paravirt_opptr_type "p"
+#else
+#define paravirt_opptr_call "c"
+#define paravirt_opptr_type "i"
+#endif
+
 #define paravirt_type(op)				\
 	[paravirt_typenum] "i" (PARAVIRT_PATCH(op)),	\
-	[paravirt_opptr] "i" (&(pv_ops.op))
+	[paravirt_opptr] paravirt_opptr_type (&(pv_ops.op))
 #define paravirt_clobber(clobber)		\
 	[paravirt_clobber] "i" (clobber)
 
@@ -393,7 +401,7 @@ int paravirt_disable_iospace(void);
  */
 #define PARAVIRT_CALL					\
 	ANNOTATE_RETPOLINE_SAFE				\
-	"call *%c[paravirt_opptr];"
+	"call *%" paravirt_opptr_call "[paravirt_opptr];"
 
 /*
  * These macros are intended to wrap calls through one of the paravirt
-- 
2.21.0.1020.gf2820cf01a-goog

