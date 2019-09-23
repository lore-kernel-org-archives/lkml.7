Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DEAFC4740C
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 00:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 644C520B7C
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 00:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="KscoU/sk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730571AbfIWApk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 20:45:40 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42220 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730404AbfIWApi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 20:45:38 -0400
Received: by mail-pl1-f193.google.com with SMTP id e5so5738042pls.9
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2019 17:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Chejk/4+FmCtrFrzQ3cdh4eTfnbOVSILTOMfH5BS3rg=;
        b=KscoU/skknCbbY8YZs5H+cAOddHExj4kT3l2GqX65Qs42T2g2BLJ54/9rRxImmw1UJ
         4T+vSMp30+jX7EQr7yLlnw1/JMWgD1jPDci+wH8ngsQUbX4sOABn5I6dcBkOO1Q2eVAm
         MM/HVsl6/x48oqbevT5I/loUiE1aaPKLNzNxdzPT+wjfs6/aFJl4CPxyN2uTncujwFEG
         RQhmbpjr/TruZWtqmbjS3M+ObiSvMNaBcUCcY1cUu2v5Kr9hJFHGVj4JOZD91LiZKs0Z
         3KBUDZghfRVtT/2ak7BUWOsBhPvJwTL74as+9gWJsXjF0GvvNKGQG1lWKJq006JrUP5m
         DLHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Chejk/4+FmCtrFrzQ3cdh4eTfnbOVSILTOMfH5BS3rg=;
        b=BhHpNDfbHXPtMKGfLtzVvC3zg1LSc6O4Fs2dOSWWWTrFOMcYEiJ9kHvq6QXSX4VXJ9
         XV/7d632I46JoKQCA5kVdrF1hSEk5/DB5m6aTy6YhjpD2YobkoCCT6/NlqpZ1xR62C4H
         af9DBh6aCdIivVcwDZhD4G/QUCyeDpeG8HDsbnYaIijeM5AqUb2AbJ5Nca4dWNQp0MeJ
         BjLswl3dKm2OAswIaYLsW81O7VLsrFQVpEnyjktq8+uJFKDyQ12oyGrKLOVSUu3n2MbI
         3vlKHhwsaN3MHuBnC9m9NnKO4aaHqCcpYLdvTUo1dWjtwyM+Jx34R/5ykve/93M/r25y
         hLag==
X-Gm-Message-State: APjAAAWn4VSGQDuCFW3pMhlWDYvQlXoP0HyQ9Ufj6vROcFkB1gap4Xzs
        qvn/+f9ROdUQhf88ASuBhzEUYA==
X-Google-Smtp-Source: APXvYqxTVhkh+52M6mkBzcoHkL548c6/8rX+BxMVIXbVMNx8toD/c9dkZqmokUYv/q5COofkwXP/Tg==
X-Received: by 2002:a17:902:7615:: with SMTP id k21mr28543207pll.116.1569199537599;
        Sun, 22 Sep 2019 17:45:37 -0700 (PDT)
Received: from localhost.localdomain (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id l7sm9139392pjy.12.2019.09.22.17.45.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 22 Sep 2019 17:45:37 -0700 (PDT)
From:   Vincent Chen <vincent.chen@sifive.com>
To:     linux-riscv@lists.infradead.org
Cc:     paul.walmsley@sifive.com, palmer@sifive.com, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, vincent.chen@sifive.com
Subject: [PATCH 2/4] rsicv: avoid sending a SIGTRAP to a user thread trapped in WARN()
Date:   Mon, 23 Sep 2019 08:45:15 +0800
Message-Id: <1569199517-5884-3-git-send-email-vincent.chen@sifive.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1569199517-5884-1-git-send-email-vincent.chen@sifive.com>
References: <1569199517-5884-1-git-send-email-vincent.chen@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On RISC-V, when the kernel runs code on behalf of a user thread, and the
kernel executes a WARN() or WARN_ON(), the user thread will be sent
a bogus SIGTRAP.  Fix the RISC-V kernel code to not send a SIGTRAP when
a WARN()/WARN_ON() is executed.

Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
---
 arch/riscv/kernel/traps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 055a937aca70..82f42a55451e 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -134,7 +134,7 @@ asmlinkage void do_trap_break(struct pt_regs *regs)
 			break;
 		case BUG_TRAP_TYPE_WARN:
 			regs->sepc += get_break_insn_length(regs->sepc);
-			break;
+			return;
 		case BUG_TRAP_TYPE_BUG:
 #endif /* CONFIG_GENERIC_BUG */
 		default:
-- 
2.7.4

