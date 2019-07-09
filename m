Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC9DC73C46
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 320582087F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729275AbfGIStX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 14:49:23 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56933 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbfGIStX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 14:49:23 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <seth.forshee@canonical.com>)
        id 1hkvB4-0006CQ-9K
        for linux-kernel@vger.kernel.org; Tue, 09 Jul 2019 18:49:22 +0000
Received: by mail-io1-f71.google.com with SMTP id v3so17535472ios.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 11:49:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PxPSNMyhSc6n3DVu8+8initQj1WYg71cqa7Dt37YRsc=;
        b=oDxc1/8GvO5rSl1Lm57Y6TEt1PP8wWxUAwGEPK+yw1oUSKiFFhQCJTZCyg66/7ag6l
         Ck0dU0WMmCgKvX6vovPjAl08+I/rZpN3EnczX2b6Sw4Q0C057FdhnWNJaIPrC6VKP7x9
         GgNAUZND4OOyq2oKGiJ7VvgDasCZOtObuRbfvaGLp93dkw2gHl1VDUfOaiU7zTHgEIVF
         39cyGqfbqYECxLkki3sLBXZ37Ih+9XCuz6Wgf/Av0oInBt2lLHS7V+wtC0Cpobm/GyeC
         9aUe2q308KQSIChc+wlHUC97v2fawc3xgea9HYAiqPjDZ3mvDBmUhVO0/yd/AN28ZWwp
         IYHA==
X-Gm-Message-State: APjAAAU2cH/wCkTLl5CCiKQUupCBESSP2cy05rWNHOVw0I2ZcYRemA4L
        PZZ6NZcMfY+wsn+O8c+a9XpDRwbr6m7HQVEhZ5nVf3SSk+D0Vq9YN5x6IfJimdafd5843b//1zR
        b2uS5rtU8iD0uW02g6TvqyEssSqE9rAuzowizfJksFg==
X-Received: by 2002:a02:cc50:: with SMTP id i16mr3728954jaq.50.1562698161274;
        Tue, 09 Jul 2019 11:49:21 -0700 (PDT)
X-Google-Smtp-Source: APXvYqww71No87FKb3rA8fwT+GlZqF9MtRtPIDfWtG04OMqHpUZRPq3+YiRqWPLQiJMSyPtIx7hDRg==
X-Received: by 2002:a02:cc50:: with SMTP id i16mr3728928jaq.50.1562698160978;
        Tue, 09 Jul 2019 11:49:20 -0700 (PDT)
Received: from localhost ([2605:a601:ac2:fb20:b0e0:a018:77ee:9817])
        by smtp.gmail.com with ESMTPSA id n17sm20052182iog.63.2019.07.09.11.49.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 11:49:20 -0700 (PDT)
From:   Seth Forshee <seth.forshee@canonical.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: add -fcf-protection=none to retpoline flags
Date:   Tue,  9 Jul 2019 13:49:19 -0500
Message-Id: <20190709184919.20178-1-seth.forshee@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-mindirect-branch and -fcf-protection are not compatible, and
so kernel builds fail with a gcc build where -fcf-protection is
enabled by default. Add -fcf-protection=none to the retpoline
flags to fix this.

Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
---
 Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Makefile b/Makefile
index 3e4868a6498b..050f11d19777 100644
--- a/Makefile
+++ b/Makefile
@@ -636,6 +636,10 @@ RETPOLINE_CFLAGS_CLANG := -mretpoline-external-thunk
 RETPOLINE_VDSO_CFLAGS_CLANG := -mretpoline
 RETPOLINE_CFLAGS := $(call cc-option,$(RETPOLINE_CFLAGS_GCC),$(call cc-option,$(RETPOLINE_CFLAGS_CLANG)))
 RETPOLINE_VDSO_CFLAGS := $(call cc-option,$(RETPOLINE_VDSO_CFLAGS_GCC),$(call cc-option,$(RETPOLINE_VDSO_CFLAGS_CLANG)))
+# -mindirect-branch is incompatible with -fcf-protection, so ensure the
+# latter is disabled
+RETPOLINE_CFLAGS += $(call cc-option,-fcf-protection=none,)
+RETPOLINE_VDSO_CFLAGS += $(call cc-option,-fcf-protection=none,)
 export RETPOLINE_CFLAGS
 export RETPOLINE_VDSO_CFLAGS
 
-- 
2.20.1

