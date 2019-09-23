Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C15C3A5A2
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 00:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38A0E20830
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 00:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="PmBToTGz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389784AbfIWApf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 20:45:35 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39618 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730404AbfIWApe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 20:45:34 -0400
Received: by mail-pg1-f195.google.com with SMTP id u17so6987498pgi.6
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2019 17:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Xe6w22bWITBFPjRp++ggW69XwtTJrJMismAgnjjWSps=;
        b=PmBToTGz0+dZ/glKnK/OlEoCj1mNWi/zbC2c9P4ZtOaJh5w3AQinn0yAoCpOrlmf86
         2m5U4WdDZn+vS7w6Sv06LAsngXesLM1oS1JbpoEkBq6R/k+gspCkfd/qRezSZbNlZxnD
         RIu54SEfR/BFLOqT7EwmoUeQ+E7JKNB73Agv7weHGFxcum3Gd2B+RAziKVcZC+eVPZaI
         qqQTsI9BGvWjYhqxWwpQ1JupMfdd8tqP6hCswZQdzlJanzfkDS84qxBBoDDdENWsZAdw
         uQBS/uv0EH5hERpRmTpVZWPVD5mi6v3VihJsIxwUiFqMGqKozQ5cEm4KxBnpjvW54buN
         Wibw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Xe6w22bWITBFPjRp++ggW69XwtTJrJMismAgnjjWSps=;
        b=ZRdRpiApFx5XkvxeJF29VFXOobmQfoGGNRH/rSbbkp8+XbLIn17rUVJSMUT5ye21jp
         CsOvBKg32NQfMbVW2lVIZ8miEghUWPXJyifa9PcSWeuYwmQnTvQe9SQQk27f7gfiVLh0
         mPFuc2PwDD8QA/qZOVeOfDT4k56sHu12xwgG+AKml7SZoTM9575PataYcW390F8M5K7p
         tzKqrhFNp5sHotB8H5v7CSHwW8g/xNE6yQNJFvt9uXPkbhvPEE5cheu3Ppd9hkEmwZOg
         eGoiwa0ehswEBRM5d1ccoa/XH5zf5XfSXnYvFO4aiRe6/SxUHMR3cknN829oE7yGz8kj
         XPiA==
X-Gm-Message-State: APjAAAUOMddXGr8nSgAAdJfEqQ6ZPdzKpaLa2FJWjPFWBl2evQ8o/a2K
        cYF+IerZ1rYVC4NqmbjxGvfcFg==
X-Google-Smtp-Source: APXvYqxg4RUC/k2zKdp20whugiWXsLNyuWV+p9lSYD7axTO2cCrPhiQ6pzUiMr0f5rXmVr+g0e8oZA==
X-Received: by 2002:a17:90a:2464:: with SMTP id h91mr18803713pje.9.1569199534032;
        Sun, 22 Sep 2019 17:45:34 -0700 (PDT)
Received: from localhost.localdomain (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id l7sm9139392pjy.12.2019.09.22.17.45.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 22 Sep 2019 17:45:33 -0700 (PDT)
From:   Vincent Chen <vincent.chen@sifive.com>
To:     linux-riscv@lists.infradead.org
Cc:     paul.walmsley@sifive.com, palmer@sifive.com, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, vincent.chen@sifive.com
Subject: [PATCH 1/4] riscv: avoid kernel hangs when trapped in BUG()
Date:   Mon, 23 Sep 2019 08:45:14 +0800
Message-Id: <1569199517-5884-2-git-send-email-vincent.chen@sifive.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1569199517-5884-1-git-send-email-vincent.chen@sifive.com>
References: <1569199517-5884-1-git-send-email-vincent.chen@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the CONFIG_GENERIC_BUG is disabled by disabling CONFIG_BUG, if a
kernel thread is trapped by BUG(), the whole system will be in the
loop that infinitely handles the ebreak exception instead of entering the
die function. To fix this problem, the do_trap_break() will always call
the die() to deal with the break exception as the type of break is
BUG_TRAP_TYPE_BUG.

Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
---
 arch/riscv/kernel/traps.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 424eb72d56b1..055a937aca70 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -124,23 +124,23 @@ static inline unsigned long get_break_insn_length(unsigned long pc)
 
 asmlinkage void do_trap_break(struct pt_regs *regs)
 {
-#ifdef CONFIG_GENERIC_BUG
 	if (!user_mode(regs)) {
 		enum bug_trap_type type;
 
 		type = report_bug(regs->sepc, regs);
 		switch (type) {
+#ifdef CONFIG_GENERIC_BUG
 		case BUG_TRAP_TYPE_NONE:
 			break;
 		case BUG_TRAP_TYPE_WARN:
 			regs->sepc += get_break_insn_length(regs->sepc);
 			break;
 		case BUG_TRAP_TYPE_BUG:
+#endif /* CONFIG_GENERIC_BUG */
+		default:
 			die(regs, "Kernel BUG");
 		}
 	}
-#endif /* CONFIG_GENERIC_BUG */
-
 	force_sig_fault(SIGTRAP, TRAP_BRKPT, (void __user *)(regs->sepc));
 }
 
-- 
2.7.4

