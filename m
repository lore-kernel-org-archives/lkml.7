Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C32C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 01:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 174B52084C
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 01:03:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbfGSBDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 21:03:53 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36891 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfGSBDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 21:03:51 -0400
Received: by mail-pg1-f196.google.com with SMTP id i70so2919275pgd.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 18:03:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NeZWfcFnSfb2JXPqpIHsIL/8cap/wG9dpclmggbuVqI=;
        b=IP5Cv0DQokcfIsNyf2nzjXfWCuYqUcmK0Ng1fT3g6fULJdKT8WM/5nPmXWGOQk0l7U
         1i7fDK7td3/zb4i6EhBQnT5axgv7gn7HJdPqDMR5T9mVNv/M9e1sRoIlDADt3gDZt+fI
         aNt9amNwm5U4Oy85EzvdaBLFgk0wAa3y9nK7JJtjZ+N4xNStRwlui4V564HAykjnrEzD
         rTbY+zb2Zrdl3/gaIBt0QRgqLO7sh3LUdJS3jX/EESv9kPo9l2s0sA3cbdcO4JTv+DHm
         m0gSp4ped8XMlD4NBRBzSgqCEQSCM67aiThy1KAtiSpa1/xOKO4n7eXG4nVNj7/1+YBU
         KVnA==
X-Gm-Message-State: APjAAAUYxYWXhp3YQsjG/6NXpTl2bG2IiLZvGkuJwVN1EKrERa+8O/JD
        SeNHjzhZthA5oU6pz4ZD9S4=
X-Google-Smtp-Source: APXvYqy+XLBKrmpgSIKIM8AKepW2XIc4tgzVg6hc2Mhs3ZbM/Y/IDOiTGIkYqPr7R2M6688PuHJoYw==
X-Received: by 2002:a17:90a:d58c:: with SMTP id v12mr53342650pju.7.1563498230854;
        Thu, 18 Jul 2019 18:03:50 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id q144sm28887612pfc.103.2019.07.18.18.03.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 18 Jul 2019 18:03:50 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Nadav Amit <namit@vmware.com>
Subject: [RFC 1/7] compiler: Report x86 segment support
Date:   Thu, 18 Jul 2019 10:41:04 -0700
Message-Id: <20190718174110.4635-2-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190718174110.4635-1-namit@vmware.com>
References: <20190718174110.4635-1-namit@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC v6+ supports x86 segment qualifiers (__seg_gs and __seg_fs). Define
COMPILER_HAS_X86_SEG_SUPPORT when it is supported.

Signed-off-by: Nadav Amit <namit@vmware.com>
---
 include/linux/compiler-gcc.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index e8579412ad21..787b5971e41f 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -149,6 +149,10 @@
 #define COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW 1
 #endif
 
+#if GCC_VERSION >= 60000
+#define COMPILER_HAS_X86_SEG_SUPPORT 1
+#endif
+
 /*
  * Turn individual warnings and errors on and off locally, depending
  * on version.
-- 
2.17.1

