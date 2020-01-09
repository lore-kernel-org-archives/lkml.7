Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 997EFC282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7027620661
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aTSsRJ6I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733307AbgAIQJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:09:02 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23092 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733294AbgAIQJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:09:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578586139;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GX1HWyW2RBViA1jhSt+OmG2SA1mVF9hKLd9ureUedGg=;
        b=aTSsRJ6IgqQEh5knQz0FQy2z1kFC1Ts3do/5PzbuU53TGLFDiRFY63RZ3UqTZLzNR2UZMQ
        93Pv1lu5STjFa/upjQ3/bgFFxasAfa0SrUQj77hKKWXtFxolP/mF9hc+53unCqum1phgS2
        0paDjcUx+KhZoVD2KbICEe2/zSBBKFI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-e9hcG7msPNmwT6IxcyufyQ-1; Thu, 09 Jan 2020 11:08:58 -0500
X-MC-Unique: e9hcG7msPNmwT6IxcyufyQ-1
Received: by mail-wr1-f72.google.com with SMTP id b13so3031949wrx.22
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 08:08:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GX1HWyW2RBViA1jhSt+OmG2SA1mVF9hKLd9ureUedGg=;
        b=IHb6bPPjHT0BmZFRLGOKdkdyyn0U2+F/HE6EH6JKwM8Oe/5kbKPROtmwqM06L28pUl
         6aH8ru3utK4rs6SRTj+fbnFtsZ1aKGUcJsHoAEww4U4GUurnbstbuTNWeq/dHcso32Ey
         seR+2xUHU6AzUdwELVGC6COZIJHoZ4ftpsBMMesSTBn0RpStbVK01QMjr1blC8406pza
         YDSGT1BQmfCydWHmHmbF8jnaY+sPnBL0D0dFsqa+CQOe2yFNCJBsMq/65igSQ8TNtYSQ
         RkRXQXgc1NTXlsPe73RsNYyFkkX9RGw0xsQ+glU5JUhTq+DcKCUCyR+AmY8ZIlvXR2Xh
         3Yvw==
X-Gm-Message-State: APjAAAXDg2cUR94OfRVI7T1eGKgaDSFd5956YrWnC1tz6s7xvikBgjZc
        ih1S5zOT9McXJe+OtYlL8kSMpUggLhe6E/lh0UkyQPfxRELwaVjr566PZqZT5qkQ7wYK/kniRJU
        DBLsLvE1CovbWsh5TRO70JOKD
X-Received: by 2002:a7b:c750:: with SMTP id w16mr6091430wmk.46.1578586137410;
        Thu, 09 Jan 2020 08:08:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqwjCp+Y4dd1UCQgpsIRC3EeNqpxSOKmFBNBlJEwGBmeaO0pEch53HDZj8tK+YxsBYtcqb3jbQ==
X-Received: by 2002:a7b:c750:: with SMTP id w16mr6091403wmk.46.1578586137235;
        Thu, 09 Jan 2020 08:08:57 -0800 (PST)
Received: from redfedo.redhat.com (host81-140-166-164.range81-140.btcentralplus.com. [81.140.166.164])
        by smtp.gmail.com with ESMTPSA id v8sm8403505wrw.2.2020.01.09.08.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 08:08:56 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC v5 47/57] arm64: assembler: Add macro to annotate asm function having non standard stack-frame.
Date:   Thu,  9 Jan 2020 16:02:50 +0000
Message-Id: <20200109160300.26150-48-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200109160300.26150-1-jthierry@redhat.com>
References: <20200109160300.26150-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Raphael Gault <raphael.gault@arm.com>

Some functions don't have standard stack-frames but are intended
this way. In order for objtool to ignore those particular cases
we add a macro that enables us to annotate the cases we chose
to mark as particular.

Signed-off-by: Raphael Gault <raphael.gault@arm.com>
Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 include/linux/frame.h | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/include/linux/frame.h b/include/linux/frame.h
index 02d3ca2d9598..1e35e58ab259 100644
--- a/include/linux/frame.h
+++ b/include/linux/frame.h
@@ -11,14 +11,31 @@
  *
  * For more information, see tools/objtool/Documentation/stack-validation.txt.
  */
+#ifndef __ASSEMBLY__
 #define STACK_FRAME_NON_STANDARD(func) \
 	static void __used __section(.discard.func_stack_frame_non_standard) \
 		*__func_stack_frame_non_standard_##func = func
+#else
+	/*
+	 * This macro is the arm64 assembler equivalent of the
+	 * macro STACK_FRAME_NON_STANDARD define at
+	 * ~/include/linux/frame.h
+	 */
+	.macro	asm_stack_frame_non_standard	func
+	.pushsection ".discard.func_stack_frame_non_standard"
+	.quad	\func
+	.popsection
+	.endm

+#endif /* __ASSEMBLY__ */
 #else /* !CONFIG_STACK_VALIDATION */

+#ifndef __ASSEMBLY__
 #define STACK_FRAME_NON_STANDARD(func)
-
+#else
+	.macro	asm_stack_frame_non_standard	func
+	.endm
+#endif /* __ASSEMBLY__ */
 #endif /* CONFIG_STACK_VALIDATION */

 #endif /* _LINUX_FRAME_H */
--
2.21.0

