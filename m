Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28FA1C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 18:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F21FB2086D
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 18:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kragniz.eu header.i=@kragniz.eu header.b="otXMEY+g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbfCBSx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 13:53:28 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53582 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbfCBSx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 13:53:28 -0500
Received: by mail-wm1-f67.google.com with SMTP id e74so1068441wmg.3
        for <linux-kernel@vger.kernel.org>; Sat, 02 Mar 2019 10:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kragniz.eu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4FGOdncDHbK3s78NRDogLsHrdNSs3gwwfJvuwuycjTQ=;
        b=otXMEY+gZCA/3ap302sSLJrGQrHSnokNs3qisAPmBJx5yAulqo5HTlLFUW+6e2PX2c
         7s9ihcJMg+UOxfgGV+xcnp+8AgXeFYF0GY0oJY1SSMe7+sHuMiDae4hWaU8kwGXTIR/p
         erYk0Y90MH8cnwnfpdqlkJs5vu5xDKjUzEfhs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4FGOdncDHbK3s78NRDogLsHrdNSs3gwwfJvuwuycjTQ=;
        b=paC1PIiA/QJA7w7mRKuIEnzwwQCTvyAbv66t4p1Xn4T7f7BdAGF3T5J9TfrJ0cIUBg
         Q5MGBXbs5Nkwpzh5H3yvUV2SK7V09CTNIrzpTaqjAkth7VAfOtLdluvSQnCvJy8j1Hpi
         lEumbtEsO8XvdGX9w1iFvgNltJ4+f5NWnMfCZhsPJLF9SURhU8tqmGDra51q8+lUERUq
         LnbcqJcFfCDBHURQfpwUnaYFnIqaO213Xz+DJQ2IFTRrB1oEp9KmxU+DqRtMFGhEPt/E
         ZqO66M3PPHS0ob8NHQE70p27VXtro2uZ8Q9xLdh4cs0UWQi/hnTTY4cQ0QnQp0V+EwKo
         aJqg==
X-Gm-Message-State: APjAAAWKP4GpHMQK36+MjMlvpXukOo7Jacmzd18wMhvIqzM+nyQ0XWUg
        KBJYPAFCU6iTqNY0D8HInBkPEQ==
X-Google-Smtp-Source: APXvYqwSXc9vWse2GZI0ufZXVZ9EQ+kpxr0iC1+LaNDZBA3SJjreLXDWRns0P3ZXFu5r5KY47SVUYQ==
X-Received: by 2002:a1c:6505:: with SMTP id z5mr7090681wmb.7.1551552806252;
        Sat, 02 Mar 2019 10:53:26 -0800 (PST)
Received: from localhost.localdomain ([95.149.160.3])
        by smtp.gmail.com with ESMTPSA id a24sm3285691wmm.1.2019.03.02.10.53.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Mar 2019 10:53:25 -0800 (PST)
From:   Louis Taylor <louis@kragniz.eu>
To:     tglx@linutronix.de
Cc:     mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        fanc.fnst@cn.fujitsu.com, bhe@redhat.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com, ndesaulniers@google.com,
        jflat@chromium.org, Louis Taylor <louis@kragniz.eu>
Subject: [PATCH] x86/KASLR: always return a value from process_mem_region
Date:   Sat,  2 Mar 2019 18:49:29 +0000
Message-Id: <20190302184929.28971-1-louis@kragniz.eu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When compiling with -Wreturn-type, clang warns:

arch/x86/boot/compressed/kaslr.c:704:1: warning: control may reach end of
      non-void function [-Wreturn-type]

This function's return statement should probably have been placed
outside the #endif, so move it there

Link: https://github.com/ClangBuiltLinux/linux/issues/360
Signed-off-by: Louis Taylor <louis@kragniz.eu>
---
 arch/x86/boot/compressed/kaslr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index fa0332dda9f2..2e53c056ba20 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -697,8 +697,8 @@ static bool process_mem_region(struct mem_vector *region,
 			return 1;
 		}
 	}
-	return 0;
 #endif
+	return 0;
 }
 
 #ifdef CONFIG_EFI
-- 
2.20.1

