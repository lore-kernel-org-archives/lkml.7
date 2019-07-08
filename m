Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B0BC606C6
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 17:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 909B12189F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 17:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kX90Ll+0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389911AbfGHRtb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 13:49:31 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42283 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387859AbfGHRt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 13:49:28 -0400
Received: by mail-pf1-f193.google.com with SMTP id q10so7947653pff.9
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 10:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0L49s/tWIr71dLFXxs4rfeHHocb58NImeCdr+Rzo5s4=;
        b=kX90Ll+0cRk6+cX3z7g100Lvynrw4C5hMo5BnzRzRtlwGM1SCgzPgr8cWLjxOwF/BH
         B3ujW2/jzYFPNZVRkZ9z+ArIVfQTIDSQ5sOGukWTuGC+K8GbG9wRsTQHtuuUpJTWWNBc
         l/tmk51wikJRccwc1UT3lvcAgVY397QRbxcpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0L49s/tWIr71dLFXxs4rfeHHocb58NImeCdr+Rzo5s4=;
        b=Nd8HNrVLFS0CxmM1NaFUNS5GiJqcEJYXALrQ53/GjuUy+cS1y2NmYYI+XSHDLQCD51
         iwsp9MgKq6u7PAvo5PL+OUVgXFqPDdybxqY45Xsu2sVElyKbLmtzFguok9KT9Km4pkHR
         7i7tCtYeSRPzqOojFvVX8a1y9FZsNAXXETp6LMzzz8K+TqDQpWfU4uRNg3tloUPkREg1
         Z91sf/THkf3eyJZfQVF5m73pqnExS0oV17ym3lTZvKD+FUaqCouBHqJ1CaHL5WxKbOlB
         j+Cv5cXevzFZT4Ltkls/6lBvd3haxZchh1OsKF5mrkx9vqUNNRcYSWLppx1wVh71Zgrc
         gyMQ==
X-Gm-Message-State: APjAAAW4D9QiyVmr7M9D/YJX0yeLiCla7C0XHH10oam92oMUygCgiVvo
        pTLC0qJBKXPS+Eh2yDxIeRWBnA==
X-Google-Smtp-Source: APXvYqz/KlBgj7sxPbh2laDw0LEqUS36n2xByyCuU9PYhQLrDTew/w1U79e8dcnArD+lta4tuhReaA==
X-Received: by 2002:a17:90a:2430:: with SMTP id h45mr28211684pje.14.1562608168271;
        Mon, 08 Jul 2019 10:49:28 -0700 (PDT)
Received: from skynet.sea.corp.google.com ([2620:0:1008:1100:c4b5:ec23:d87b:d6d3])
        by smtp.gmail.com with ESMTPSA id j1sm20151686pfe.101.2019.07.08.10.49.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 10:49:27 -0700 (PDT)
From:   Thomas Garnier <thgarnie@chromium.org>
To:     kernel-hardening@lists.openwall.com
Cc:     kristen@linux.intel.com, keescook@chromium.org,
        Thomas Garnier <thgarnie@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>, Nadav Amit <namit@vmware.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 02/11] x86: Add macro to get symbol address for PIE support
Date:   Mon,  8 Jul 2019 10:48:55 -0700
Message-Id: <20190708174913.123308-3-thgarnie@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190708174913.123308-1-thgarnie@chromium.org>
References: <20190708174913.123308-1-thgarnie@chromium.org>
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
2.22.0.410.gd8fdbe21b5-goog

