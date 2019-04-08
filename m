Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D8C2C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 00:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48E02206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 00:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="S+CWtlhP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfDHArk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 20:47:40 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36747 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfDHArj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 20:47:39 -0400
Received: by mail-pf1-f194.google.com with SMTP id z5so6563779pfn.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2019 17:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3NrrFXRzlBefqigwOFcrvwedDkfSu5n5snsiy+v3Z/o=;
        b=S+CWtlhPfIRI02mW6vv74ADaidQPPQtyxcAUuZY6oiMp3YhLDBZJLgU6ZaErZQYtTw
         mark4fmmP8WnuVKVlfHmfIlPzidVSdCWwjpH9kwMxT3FuBIKLMkpWrkNwVvOytwFAhbu
         2SrRUdKKI6NR1/QvPXJBwDHzNeFQuT/3Ztmoo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3NrrFXRzlBefqigwOFcrvwedDkfSu5n5snsiy+v3Z/o=;
        b=Tq3v1riMWdqH32bMIOLhE1LXzjT9R2HYfwZLGim1fvTInYj/CNjIb7YfVTNd3PII6c
         L87Pt2j2kUc73to5O+u3RytPxX5Jcg9its/ifDmnuBkvIO08iTdI37oRHonknSUFjE49
         xKPvt5vXz1JHATBrF5m8We/1wyV5R6TiyfgKIchyAd9qp5iOTO2f2dSlpOyBwLAAVzhw
         qm4COlsiGz9gHEtIhcwNtSE8/NzpiHH7j1tpaXfTgNmZqvHNcg5gmXGJf32M5l/xo3Xa
         l2CeipsN3VrmLsh22vtjhP5ZgwNNb2d4ezcwQ9WFN6+paO1KHzdeKgi8y8QutkaWqlKg
         ewSA==
X-Gm-Message-State: APjAAAWW3Yc1EcxiepTcuIn7Om/NYqs4Mp5d9NNYzwLqgxvmrZ/yxS7/
        AD6ce5j0PnHBLF9ASF32BdNO8FumD1M=
X-Google-Smtp-Source: APXvYqy+wviVqSRBrnlHxu7mI+DADJXm9Q23RiKCQINA+TxYym5/3o9z3SIAakHuzOQkMr+VrHC0EQ==
X-Received: by 2002:a63:c40c:: with SMTP id h12mr14187369pgd.39.1554684458228;
        Sun, 07 Apr 2019 17:47:38 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id h4sm20208531pgv.61.2019.04.07.17.47.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Apr 2019 17:47:37 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        kernel-team@android.com, paulmck@linux.vnet.ibm.com,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
Subject: [PATCH v2] srcu: Remove unused vmlinux srcu linker entries
Date:   Sun,  7 Apr 2019 20:47:19 -0400
Message-Id: <20190408004719.178484-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SRCU for modules optimization (commit title "srcu: Allocate per-CPU
data for DEFINE_SRCU() in modules") introduced vmlinux linker entries
which is unused since it applies only to the built-in vmlinux. So remove
it to prevent any space usage due to the 8 byte alignment it added.
vmlinux.lds.h has no effect on module loading and is not used for
building the module object, so the changes were not needed in the first
place since the optimization is specific to modules.

Tested with SRCU torture_type and rcutorture. Put prints in module
loader to confirm it is able to find and initialize the srcu structures.

Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: kernel-team@android.com
Cc: paulmck@linux.vnet.ibm.com
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
v1->v2: Added more context to change log.

 include/asm-generic/vmlinux.lds.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index c2d919a1566e..f8f6f04c4453 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -338,10 +338,6 @@
 		KEEP(*(__tracepoints_ptrs)) /* Tracepoints: pointer array */ \
 		__stop___tracepoints_ptrs = .;				\
 		*(__tracepoints_strings)/* Tracepoints: strings */	\
-		. = ALIGN(8);						\
-		__start___srcu_struct = .;				\
-		*(___srcu_struct_ptrs)					\
-		__end___srcu_struct = .;				\
 	}								\
 									\
 	.rodata1          : AT(ADDR(.rodata1) - LOAD_OFFSET) {		\
-- 
2.21.0.392.gf8f6787159e-goog
