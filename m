Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46515C3F68F
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C1B7206ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KYpdglr1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732888AbgAIQEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:04:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43956 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728231AbgAIQEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:04:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578585868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bWQrA7VCFyRmkR4P5YmsvhynTE3rA5d5XHSqEPaJkPo=;
        b=KYpdglr1O/DevWu6KtNToEeJEe04UcPXcu1RJlV2NJusKKzOODBc4vLPLCZdZAldM+EnyC
        jg7b14nnU4cWuarGQNlNafo0hkLyof56EgVZG1092PKlQwT7u1bJH20dfyTCa5kzMPfBCV
        tQKF21yIw3YNZMQmoIxXI7OhL6qTTbw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-2xjqZr9yOcWZmj9aIebroA-1; Thu, 09 Jan 2020 11:04:27 -0500
X-MC-Unique: 2xjqZr9yOcWZmj9aIebroA-1
Received: by mail-wm1-f69.google.com with SMTP id m133so618859wmf.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 08:04:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bWQrA7VCFyRmkR4P5YmsvhynTE3rA5d5XHSqEPaJkPo=;
        b=Yf1oiQKIH+nnOrIyV6AHZ7eDgqQiEq0IYK1Z298EaRxHExEdVUtUT3OcVjW5GFA29k
         0Vv9fslQO2/TSmzD13UQX3C5Ccz3i1tluaOjdRILvYT/CGh4NDWmUsX/9MPmqze9aVKS
         OqdKYPKNBsL2SYpfjnnj7UdR5fhCBKgwljJZKbZYj29Aq6neJd5HMq/XdCSyX/z7pVZ3
         l6pdIgJDen1+edlAymXr3vI1+CEG7SONaDirUrLPcirTJzuH9VR4g4ugdPMMmSRKQm5o
         Os2N3mcbBOzj7ap2NALgdrWMAwQMkoZbdJipYZm0LpGSkC+n+HF/vbBzyBJvqvRiSU+C
         /8vQ==
X-Gm-Message-State: APjAAAVlUbm+H+Iha9ymQ347zrlO9qS6oHzZssn7kMgAIni4DTPSJdQx
        uBL0ZNEoyPOHLkuKTWoyZCFWBHKw9cG/Czli1XIDIT5CdQ66G3zEKmJytXP8mPKgOBIIR7Gajin
        ljbUFESsnsPE4RPN9eTJb+XXh
X-Received: by 2002:adf:8b4f:: with SMTP id v15mr11990371wra.231.1578585866198;
        Thu, 09 Jan 2020 08:04:26 -0800 (PST)
X-Google-Smtp-Source: APXvYqyRBNHddmXJHExrgBfiG3rOVNGpjzR688ErWpsppuCbMLL/G6HOJYCSxBlJEZgOnpRtPnxIbA==
X-Received: by 2002:adf:8b4f:: with SMTP id v15mr11990334wra.231.1578585865969;
        Thu, 09 Jan 2020 08:04:25 -0800 (PST)
Received: from redfedo.redhat.com (host81-140-166-164.range81-140.btcentralplus.com. [81.140.166.164])
        by smtp.gmail.com with ESMTPSA id b17sm8615898wrp.49.2020.01.09.08.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 08:04:25 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC v5 10/57] objtool: Split generic and arch specific CFI definitions
Date:   Thu,  9 Jan 2020 16:02:13 +0000
Message-Id: <20200109160300.26150-11-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200109160300.26150-1-jthierry@redhat.com>
References: <20200109160300.26150-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some CFI definitions used by generic objtool code have no reason to vary
from one architecture to another. Move those definition to generic code
and keep a separate per arch header to provide architecture specific CFI
definitions.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/arch/x86/include/cfi_regs.h  | 25 ++++++++++++++++++++++
 tools/objtool/{arch/x86/include => }/cfi.h | 21 ++----------------
 2 files changed, 27 insertions(+), 19 deletions(-)
 create mode 100644 tools/objtool/arch/x86/include/cfi_regs.h
 rename tools/objtool/{arch/x86/include => }/cfi.h (54%)

diff --git a/tools/objtool/arch/x86/include/cfi_regs.h b/tools/objtool/arch/x86/include/cfi_regs.h
new file mode 100644
index 000000000000..79bc517efba8
--- /dev/null
+++ b/tools/objtool/arch/x86/include/cfi_regs.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef _OBJTOOL_CFI_REGS_H
+#define _OBJTOOL_CFI_REGS_H
+
+#define CFI_AX			0
+#define CFI_DX			1
+#define CFI_CX			2
+#define CFI_BX			3
+#define CFI_SI			4
+#define CFI_DI			5
+#define CFI_BP			6
+#define CFI_SP			7
+#define CFI_R8			8
+#define CFI_R9			9
+#define CFI_R10			10
+#define CFI_R11			11
+#define CFI_R12			12
+#define CFI_R13			13
+#define CFI_R14			14
+#define CFI_R15			15
+#define CFI_RA			16
+#define CFI_NUM_REGS		17
+
+#endif /* _OBJTOOL_CFI_REGS_H */
diff --git a/tools/objtool/arch/x86/include/cfi.h b/tools/objtool/cfi.h
similarity index 54%
rename from tools/objtool/arch/x86/include/cfi.h
rename to tools/objtool/cfi.h
index 4427bf8ed686..1a3e7b807994 100644
--- a/tools/objtool/arch/x86/include/cfi.h
+++ b/tools/objtool/cfi.h
@@ -6,30 +6,13 @@
 #ifndef _OBJTOOL_CFI_H
 #define _OBJTOOL_CFI_H
 
+#include "cfi_regs.h"
+
 #define CFI_UNDEFINED		-1
 #define CFI_CFA			-2
 #define CFI_SP_INDIRECT		-3
 #define CFI_BP_INDIRECT		-4
 
-#define CFI_AX			0
-#define CFI_DX			1
-#define CFI_CX			2
-#define CFI_BX			3
-#define CFI_SI			4
-#define CFI_DI			5
-#define CFI_BP			6
-#define CFI_SP			7
-#define CFI_R8			8
-#define CFI_R9			9
-#define CFI_R10			10
-#define CFI_R11			11
-#define CFI_R12			12
-#define CFI_R13			13
-#define CFI_R14			14
-#define CFI_R15			15
-#define CFI_RA			16
-#define CFI_NUM_REGS		17
-
 struct cfi_reg {
 	int base;
 	int offset;
-- 
2.21.0

