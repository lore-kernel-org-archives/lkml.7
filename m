Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5522C74A41
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 02:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7058E21019
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 02:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=etsukata-com.20150623.gappssmtp.com header.i=@etsukata-com.20150623.gappssmtp.com header.b="NpTdo9jW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbfGKCfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 22:35:23 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43379 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727709AbfGKCfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 22:35:22 -0400
Received: by mail-pl1-f194.google.com with SMTP id cl9so2178581plb.10
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 19:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsukata-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IN1HYshmaqAJriNIg/bZOqzewRr8acPoLDBpyQjw6+k=;
        b=NpTdo9jWQZX+yg26ULYTVFecxuZR8Diixxrm8vyFz2JYll+MhEYCs4UVOBVCzJLB9Z
         LfpWYi3JX8muO231TyRgQBCW3aX3MOjm9aE3IdqBt8HMO/bd8TtmPePnOVrJWptGEA7M
         LXOhB14Vfa8mbVPvKbxolV00g/Ee70qS3osH/1lyfJjiuoBr0Pes07tYp3Y64hP1kSIu
         4EgPGSCFK8dX//H8s8thCqUv0wtsVIr5JM0x21sf6cz7cIVUrxflbRuk4fF0mZHZ7D8f
         rQ1aWwjNKff3WzCtOt90BPLVVhQE7rv06Fy07AvCwQ7W5WLrKr6EmZvAp7ZOOMKfNRRz
         ClMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IN1HYshmaqAJriNIg/bZOqzewRr8acPoLDBpyQjw6+k=;
        b=g/2oSe8QJuf41j/dGK+CI4Zpvh6LYvtkAu52Vm+BJk2OvyxT3UytIjA0fZIZJGGA5e
         aOrxzvjlE4XRmDYLouPZa2S8Np14RYXl9jq2R6fRKeZcE/7kG+v3qTl9x5JuyrRLvfze
         cAtMkeUwr2Sxw5+R27SQ9czV1tDJjkDUFF5dUGCahZba5SPupPXrgrc7d4Cvpqd35rIS
         jXx4mnMIxzRqpEKsRwYq0kTzYNx+qQr4lGhAFe1yxw8TXSN1wy7k1JLkO15bOtQgoXQS
         gxA1e2ZzPVfOWE1zIAnJZlZ/5Z/wYn7IKMpl8UpiTuKJNeXix/V1iKN89r8axXqfnplL
         8iGA==
X-Gm-Message-State: APjAAAWxv19S/N/UAr0rtjbgR+tfLUsYyYqpBDTpvILsu95uYTRxVBtG
        aPvUFMmNxyoDMG06hXDVoRc=
X-Google-Smtp-Source: APXvYqzNfOYkq9qVmHQ0rwjBDo8PtN9hhp2nffMbsSK+LkN5hlfLyTQJFjhh4zk81Uazs5dd59+fjA==
X-Received: by 2002:a17:902:e202:: with SMTP id ce2mr1711323plb.272.1562812522261;
        Wed, 10 Jul 2019 19:35:22 -0700 (PDT)
Received: from localhost.localdomain (p2517222-ipngn21701marunouchi.tokyo.ocn.ne.jp. [118.7.246.222])
        by smtp.gmail.com with ESMTPSA id p1sm4390411pff.74.2019.07.10.19.35.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 10 Jul 2019 19:35:21 -0700 (PDT)
From:   Eiichi Tsukata <devel@etsukata.com>
To:     tglx@linutronix.de, peterz@infradead.org,
        torvalds@linux-foundation.org, rostedt@goodmis.org,
        jpoimboe@redhat.com, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Eiichi Tsukata <devel@etsukata.com>
Subject: [PATCH] x86/stacktrace: Fix infinite loop in arch_stack_walk_user()
Date:   Thu, 11 Jul 2019 11:35:01 +0900
Message-Id: <20190711023501.963-1-devel@etsukata.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current arch_stack_walk_user() checks `if (fp == frame.next_fp)`
to prevent infinite loop by self reference but it's not enogh for
circular reference.

Once we find a lack of return address, there is no need to continue
loop, so let's break out.

Fixes: 02b67518e2b1 ("tracing: add support for userspace stacktraces in tracing/iter_ctrl")
Signed-off-by: Eiichi Tsukata <devel@etsukata.com>
---
 arch/x86/kernel/stacktrace.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/stacktrace.c b/arch/x86/kernel/stacktrace.c
index 2abf27d7df6b..b1a1f4b4c943 100644
--- a/arch/x86/kernel/stacktrace.c
+++ b/arch/x86/kernel/stacktrace.c
@@ -129,11 +129,8 @@ void arch_stack_walk_user(stack_trace_consume_fn consume_entry, void *cookie,
 			break;
 		if ((unsigned long)fp < regs->sp)
 			break;
-		if (frame.ret_addr) {
-			if (!consume_entry(cookie, frame.ret_addr, false))
-				return;
-		}
-		if (fp == frame.next_fp)
+		if (!frame.ret_addr ||
+		    !consume_entry(cookie, frame.ret_addr, false))
 			break;
 		fp = frame.next_fp;
 	}
-- 
2.21.0

