Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6943C3A5A2
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 00:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BF3A20B7C
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 00:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="fO39l9GW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389994AbfIWApp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 20:45:45 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35870 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730404AbfIWApl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 20:45:41 -0400
Received: by mail-pg1-f195.google.com with SMTP id h17so4443081pgb.3
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2019 17:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=etFOng1NSMlGr92KlrcTFVrPRQRxbWjcN6/2wjvKnb8=;
        b=fO39l9GWblA4imhZOOmvXoFwH2V9A46JomP+wWxqplazbuPQxOAopvpwuMhDz6+x//
         EZ9rQ7jQojULwJl45Z2YA4CLQBGA2Jn5knfHZ7Pv5jo+e2v2yqE5fpO7/po15yIHZdCe
         xVSpfdNL9/no1QTzYtU6kdrZdi/+LCclix77edyqL21dMfqYMzz0rb7U97Xe+ABc8oYp
         QezHxT/VqeF0XVKX/v0ibo+OZvYy73cTFqwx4nSPIZryN5qI2C4KsTdV8bSHwKyxLMAJ
         S+f7Lh5dyiSl7RUB5rvKJwyaLNAZV8lddPDa/LksDBbMylUeVdBhOWw7CypoQVvDwrSy
         o8EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=etFOng1NSMlGr92KlrcTFVrPRQRxbWjcN6/2wjvKnb8=;
        b=lE8oC9QfwbmvKfI+O+PomsRN67UZl6V3sAGzU9F+Q3fIgg+HXg06fD5l+zwpsKAcOZ
         nxt9TlPb9OUIkv3aWewswfuMj50cE7RY9Mq8sel3FYa5fBoqGdjZMsZ1mdpyDrTbZYv2
         gE30Xo5QsCjKo1pKqI2q5Yn1BYsci8MaXJLPTRXENkxNDLIrTXns1rKko42m8inTBDn1
         CadnN/dsWb44DrK7Y3EHeHPpNqXeIO+fnG6Ijp3mlqBAZ6NX38KQWfH5gxe7uz+VqaTY
         0KD4RiJFFDN6BVzyABNWc57s4IDC4VBl1tHnZsEFuyUI2NznAsCCLH3vDQN5O3HC/ac9
         AHRQ==
X-Gm-Message-State: APjAAAWmmpkt8f8F0dfajNmv8mnLhl74oWiXPt7eRu8H9EGlB5f8U8yt
        xWZCVdRvMbP9Rgii/V2blZJJyQ==
X-Google-Smtp-Source: APXvYqyxP0lWJyTG/EzXGCE+z0Ba/ovVgEyGLWvJbKiSiuNzBkE6CXeRmeSRUIIaJY5Qr03rNmPIog==
X-Received: by 2002:a62:8702:: with SMTP id i2mr30820956pfe.187.1569199540103;
        Sun, 22 Sep 2019 17:45:40 -0700 (PDT)
Received: from localhost.localdomain (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id l7sm9139392pjy.12.2019.09.22.17.45.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 22 Sep 2019 17:45:39 -0700 (PDT)
From:   Vincent Chen <vincent.chen@sifive.com>
To:     linux-riscv@lists.infradead.org
Cc:     paul.walmsley@sifive.com, palmer@sifive.com, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, vincent.chen@sifive.com
Subject: [PATCH 3/4] riscv: Correct the handling of unexpected ebreak in do_trap_break()
Date:   Mon, 23 Sep 2019 08:45:16 +0800
Message-Id: <1569199517-5884-4-git-send-email-vincent.chen@sifive.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1569199517-5884-1-git-send-email-vincent.chen@sifive.com>
References: <1569199517-5884-1-git-send-email-vincent.chen@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the kernel space, all ebreak instructions are determined at compile
time because the kernel space debugging module is currently unsupported.
Hence, it should be treated as a bug if an ebreak instruction which does
not belong to BUG_TRAP_TYPE_WARN or BUG_TRAP_TYPE_BUG is executed in
kernel space. For the userspace, debugging module or user problem may
intentionally insert an ebreak instruction to trigger a SIGTRAP signal.
To approach the above two situations, the do_trap_break() will direct
the BUG_TRAP_TYPE_NONE ebreak exception issued in kernel space to die()
and will send a SIGTRAP to the trapped process only when the ebreak is
in userspace.

Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
---
 arch/riscv/kernel/traps.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 82f42a55451e..dd13bc90aeb6 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -130,8 +130,6 @@ asmlinkage void do_trap_break(struct pt_regs *regs)
 		type = report_bug(regs->sepc, regs);
 		switch (type) {
 #ifdef CONFIG_GENERIC_BUG
-		case BUG_TRAP_TYPE_NONE:
-			break;
 		case BUG_TRAP_TYPE_WARN:
 			regs->sepc += get_break_insn_length(regs->sepc);
 			return;
@@ -140,8 +138,9 @@ asmlinkage void do_trap_break(struct pt_regs *regs)
 		default:
 			die(regs, "Kernel BUG");
 		}
-	}
-	force_sig_fault(SIGTRAP, TRAP_BRKPT, (void __user *)(regs->sepc));
+	} else
+		force_sig_fault(SIGTRAP, TRAP_BRKPT,
+				(void __user *)(regs->sepc));
 }
 
 #ifdef CONFIG_GENERIC_BUG
-- 
2.7.4

