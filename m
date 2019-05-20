Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 078ECC04E87
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 23:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDB2B2173C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 23:20:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UjHBMQNV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbfETXUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 19:20:10 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33325 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbfETXUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 19:20:07 -0400
Received: by mail-pg1-f194.google.com with SMTP id h17so7526016pgv.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 16:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u/wnY+KqFixg56gyP1D7CB7HYKg32m+bqFWSsKBa+/I=;
        b=UjHBMQNV86pahygu8pDM7RodmVPNoOF5hJ3fT3xbyH0dL1de2+tRNhk/hUmxNtJl1q
         +WhScnJIT/kY02tSuiJfwqhs0EkygcgfQQ2Hl2HZpixKp6zgVRzVT74gxZBzXqobqJWx
         rLMNTGXxUbQq9oPM7H/xYWCXBM//FHTX0NQ7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u/wnY+KqFixg56gyP1D7CB7HYKg32m+bqFWSsKBa+/I=;
        b=Jzac/yHbI+ePn6Svgv/L/bIUgGit0+AEVWJmVDU+U/qWE41T0PizKx6iu1JdOTN1qi
         lJXOs2JzSApTc3bKwvW7UhLo20GSsMjvIIoWV3Q0+KCux7BiLjvH96nK3AnpcDCM+AIJ
         T84S+T9rIQ03+UjukIIC3fCC3IVJdJwIIkBlOTdwxALdSm+erjIQo7rgFXbhBeNKla+7
         zqkx6RUAjvYlWAMs8O5LurMeoIzpTaX8WtINZR7EqYQfhEUM7b8Eeno9unF+/tAZqQOP
         gz4H/ZfYmMkZB07knKgVvNSfRFYOvHisKLW7hI/zn5Vgvx5Fxi9thF/1ErXcjMQ+iL2F
         EnEQ==
X-Gm-Message-State: APjAAAXryFyNXBzbdm9/nhTQ4ERWtlIenGcTNUZv/TmT9zB6gXQdk0lL
        FHCA5XpMDTDNqa6LkQeYYXat9A==
X-Google-Smtp-Source: APXvYqzV7SBvojMe///9CX7UEbIEQn/fen5oCvVGd76rfHpQHJwNd6ySlPIAhPdQ4X7SwFRT1BafWw==
X-Received: by 2002:a62:2f87:: with SMTP id v129mr9812794pfv.9.1558394407163;
        Mon, 20 May 2019 16:20:07 -0700 (PDT)
Received: from skynet.sea.corp.google.com ([2620:0:1008:1100:c4b5:ec23:d87b:d6d3])
        by smtp.gmail.com with ESMTPSA id h13sm19350861pgk.55.2019.05.20.16.20.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 16:20:06 -0700 (PDT)
From:   Thomas Garnier <thgarnie@chromium.org>
To:     kernel-hardening@lists.openwall.com
Cc:     kristen@linux.intel.com, Thomas Garnier <thgarnie@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Nadav Amit <namit@vmware.com>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 03/12] x86: Add macro to get symbol address for PIE support
Date:   Mon, 20 May 2019 16:19:28 -0700
Message-Id: <20190520231948.49693-4-thgarnie@chromium.org>
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

Add a new _ASM_MOVABS macro to fetch a symbol address. It will be used
to replace "_ASM_MOV $<symbol>, %dst" code construct that are not
compatible with PIE.

Signed-off-by: Thomas Garnier <thgarnie@google.com>
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
2.21.0.1020.gf2820cf01a-goog

