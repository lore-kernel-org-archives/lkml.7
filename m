Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C7EC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 297902187F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qq3Uulg+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729028AbfFMR2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 13:28:02 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:48691 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727230AbfFMR2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 13:28:02 -0400
Received: by mail-pf1-f202.google.com with SMTP id u21so11809595pfn.15
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 10:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=YOPSQyByy+sdwJPTHXHLAwPARdzuYkR92/UcWiG15z0=;
        b=qq3Uulg+GNz9qGof5VZ8h8QdhcjR1EeS0zo/SjjfeovzkY3ZDAWYtLBxpGrSALoW9x
         YzPJuHqkfuX1ogcyu8AnpJT3bDQEmsxTojWbxsmDcE+HPCNWeSCyI1TkHMMMwv7ZM7B5
         xoOA8s2uBXemEdGeVyvWVr//eGffvPTa+1URylcVc5w9gIe3CDwV4cV4jX7UN2ZvvGTn
         kIynhzJdDc5gDcy2e28ddL0gz5sQnmlJYNUlz6m99/a3hJudaV8g0j8WuoAa9A5hWbUN
         FRrh9Bfj3Rw2zyzEoizIgUfOSz4BVBYFsc9Rzwd8pBcxZ0Hs0luZjMzXnRvBboZixHsR
         FUhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=YOPSQyByy+sdwJPTHXHLAwPARdzuYkR92/UcWiG15z0=;
        b=XQXy+yqrjsCMqvc0PkKhpRC9njwxRvd3ESvyB0WqDoD2Rug9V+0xDk44NM6d8O18hq
         Mjlw0kMlBgqDgG5ywc62WsvHb6MgBcqCxciejtgHT479LZ5BKAl7cDh4MClUlTvAG7Fu
         ZELnaaIxfj/MEYIY85xGTTTVQisDRBGzaZ5BO2ONVCktqrkv0kfcRYNMTOXL2Y8G6tPA
         /pKJmcMJTu+YvP5BnERO7s2Hc9NKUT9i7Zeyy+UKhtT03jyoblJ9AD819U9FRX9CDwTQ
         2vwtP/NsHush69xuYl/IfOKlYyO+1BZbDTCZjDX/sAUUvu7c2CZUJ4czfPkakm/DVxO2
         R9gg==
X-Gm-Message-State: APjAAAUkcKmLS68kW25kmpUqmng7n6vD36ist7OqJmF5Q1vBIzHKtT31
        5JdXuuBWF5HvIi2G2acURFJI16xATg==
X-Google-Smtp-Source: APXvYqyLxxhPCdTroCrtThxPEGqptQMNlEqmTe4QCMVFCYFfDvC2PYzPkg4R9I7fjg2Z61Mj8vLdfDU/3A==
X-Received: by 2002:a63:5c15:: with SMTP id q21mr17864740pgb.248.1560446881379;
 Thu, 13 Jun 2019 10:28:01 -0700 (PDT)
Date:   Thu, 13 Jun 2019 10:27:46 -0700
Message-Id: <20190613172746.216819-1-nhuck@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH] memory: tegra: Fix -Wunused-const-variable
From:   Nathan Huckleberry <nhuck@google.com>
To:     thierry.reding@gmail.com, jonathanh@nvidia.com
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Huckleberry <nhuck@google.com>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang produces the following warning

drivers/memory/tegra/tegra124.c:36:28: warning: unused variable
'tegra124_mc_emem_regs' [-Wunused-const-variable]
static const unsigned long tegra124_mc_emem_regs[] = {
                           ^

The only usage of this variable is from within an ifdef.
It seems logical to move the variable into the ifdef as well.

Cc: clang-built-linux@googlegroups.com
Link: https://github.com/ClangBuiltLinux/linux/issues/526
Signed-off-by: Nathan Huckleberry <nhuck@google.com>
---
 drivers/memory/tegra/tegra124.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/memory/tegra/tegra124.c b/drivers/memory/tegra/tegra124.c
index 8f8487bda642..8f2af5614595 100644
--- a/drivers/memory/tegra/tegra124.c
+++ b/drivers/memory/tegra/tegra124.c
@@ -33,6 +33,7 @@
 #define MC_EMEM_ARB_MISC1			0xdc
 #define MC_EMEM_ARB_RING1_THROTTLE		0xe0
 
+#ifdef CONFIG_ARCH_TEGRA_124_SOC
 static const unsigned long tegra124_mc_emem_regs[] = {
 	MC_EMEM_ARB_CFG,
 	MC_EMEM_ARB_OUTSTANDING_REQ,
@@ -54,6 +55,7 @@ static const unsigned long tegra124_mc_emem_regs[] = {
 	MC_EMEM_ARB_MISC1,
 	MC_EMEM_ARB_RING1_THROTTLE
 };
+#endif
 
 static const struct tegra_mc_client tegra124_mc_clients[] = {
 	{
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

