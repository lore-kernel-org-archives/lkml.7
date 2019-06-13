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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A970C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 18:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E23320866
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 18:26:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JBRxYDcT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbfFMS0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 14:26:48 -0400
Received: from mail-oi1-f201.google.com ([209.85.167.201]:36897 "EHLO
        mail-oi1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727314AbfFMS0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 14:26:47 -0400
Received: by mail-oi1-f201.google.com with SMTP id f19so7184560oib.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 11:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ffhihfkZ6rU48da7c4itXkMX6+7iKvBZxVtyPBW0dvg=;
        b=JBRxYDcTsltAW0dCoEwLXWjwsQt5Z/2JzGjYnbuj4qxFmq4LeZ7O2J1p5udBWrIF9S
         PJAVTo3ZWkYDdRJZMsvZkPvaEslKeCCPjBZpty3RVyQ7M9exVSP//dA4iOHRG+FiiNbO
         42e9XnCYO9ibWz3JcdlFyMR3pTapZqrnET0uWPzzP8mfXeHZ0+ylBV8jOvEqqgxWQy7G
         X+VZYMQ0Eno/CVI0bOoacAWsTfjYlnMTRYQStVNpdMt5g+/GvXTxEX5gj+YCMXQ1ekLI
         PLtkDq0UbdXc0+QyPRYfT+priqT8WF8ABTIyCe63mvUA2htlCHDYnMp2bVW5M3o7zwQF
         17Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ffhihfkZ6rU48da7c4itXkMX6+7iKvBZxVtyPBW0dvg=;
        b=C9M2ncIkmJGeYh1L3xCasjXswSqmQgTxxllYCFoqVIj4KIc7aTRZQqjc4xVKCCrDLc
         b8cISVGB4S1Djp8pwTZNAGMhQ6/glkNifYpaRnqG+DkSXgVTDZUQp+nrBmVk6oD7yBso
         tcfE1Ikk2cA+ZdYpEaA/4wvUK8lwF+50N9GC/cHwfIZ6kRyCdKzhhL7B4RP9pe0XZIfp
         pUAu8MQYmnslyvRsdJI2U9D40AnKRBU3jntH/eBtNf4SeT3Av85o9Kcx4wo93LnsZekN
         4OE+lKx22nmhnFb6slj6veP/abB9w4IyuD8gw40vulHiA91RH8cnM/C69GSsqOSPjY9G
         wMkQ==
X-Gm-Message-State: APjAAAVtZ464cbTNGEkq2bMOGuytaqBxQyYhk3UNUNGWWBVLTuwiAm8J
        lz1BP7Qkp9JlsH+Db0JrjwCZS32/Fw==
X-Google-Smtp-Source: APXvYqwqbZ9nx1MLboNvYLtE4y2Q0RGIlz6+JhhOq0GywUq9+xpBgrzQUdinVSGw00Y6l9pXNeqWHxe7fw==
X-Received: by 2002:a9d:6a5a:: with SMTP id h26mr31490210otn.319.1560450406919;
 Thu, 13 Jun 2019 11:26:46 -0700 (PDT)
Date:   Thu, 13 Jun 2019 11:26:10 -0700
In-Reply-To: <CAKwvOdn930hhHcnCA9arJ5=9SsT-6BfFC_1punmUZX2xWM-Hnw@mail.gmail.com>
Message-Id: <20190613182610.238801-1-nhuck@google.com>
Mime-Version: 1.0
References: <CAKwvOdn930hhHcnCA9arJ5=9SsT-6BfFC_1punmUZX2xWM-Hnw@mail.gmail.com>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH v2] memory: tegra: Fix -Wunused-const-variable
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
Changes from v1 -> v2:
* Moved definition of tegra124_mc_emem_regs into existing ifdef
 drivers/memory/tegra/tegra124.c | 44 ++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/memory/tegra/tegra124.c b/drivers/memory/tegra/tegra124.c
index 8f8487bda642..6985a4e33325 100644
--- a/drivers/memory/tegra/tegra124.c
+++ b/drivers/memory/tegra/tegra124.c
@@ -33,28 +33,6 @@
 #define MC_EMEM_ARB_MISC1			0xdc
 #define MC_EMEM_ARB_RING1_THROTTLE		0xe0
 
-static const unsigned long tegra124_mc_emem_regs[] = {
-	MC_EMEM_ARB_CFG,
-	MC_EMEM_ARB_OUTSTANDING_REQ,
-	MC_EMEM_ARB_TIMING_RCD,
-	MC_EMEM_ARB_TIMING_RP,
-	MC_EMEM_ARB_TIMING_RC,
-	MC_EMEM_ARB_TIMING_RAS,
-	MC_EMEM_ARB_TIMING_FAW,
-	MC_EMEM_ARB_TIMING_RRD,
-	MC_EMEM_ARB_TIMING_RAP2PRE,
-	MC_EMEM_ARB_TIMING_WAP2PRE,
-	MC_EMEM_ARB_TIMING_R2R,
-	MC_EMEM_ARB_TIMING_W2W,
-	MC_EMEM_ARB_TIMING_R2W,
-	MC_EMEM_ARB_TIMING_W2R,
-	MC_EMEM_ARB_DA_TURNS,
-	MC_EMEM_ARB_DA_COVERS,
-	MC_EMEM_ARB_MISC0,
-	MC_EMEM_ARB_MISC1,
-	MC_EMEM_ARB_RING1_THROTTLE
-};
-
 static const struct tegra_mc_client tegra124_mc_clients[] = {
 	{
 		.id = 0x00,
@@ -1049,6 +1027,28 @@ static const struct tegra_mc_reset tegra124_mc_resets[] = {
 };
 
 #ifdef CONFIG_ARCH_TEGRA_124_SOC
+static const unsigned long tegra124_mc_emem_regs[] = {
+	MC_EMEM_ARB_CFG,
+	MC_EMEM_ARB_OUTSTANDING_REQ,
+	MC_EMEM_ARB_TIMING_RCD,
+	MC_EMEM_ARB_TIMING_RP,
+	MC_EMEM_ARB_TIMING_RC,
+	MC_EMEM_ARB_TIMING_RAS,
+	MC_EMEM_ARB_TIMING_FAW,
+	MC_EMEM_ARB_TIMING_RRD,
+	MC_EMEM_ARB_TIMING_RAP2PRE,
+	MC_EMEM_ARB_TIMING_WAP2PRE,
+	MC_EMEM_ARB_TIMING_R2R,
+	MC_EMEM_ARB_TIMING_W2W,
+	MC_EMEM_ARB_TIMING_R2W,
+	MC_EMEM_ARB_TIMING_W2R,
+	MC_EMEM_ARB_DA_TURNS,
+	MC_EMEM_ARB_DA_COVERS,
+	MC_EMEM_ARB_MISC0,
+	MC_EMEM_ARB_MISC1,
+	MC_EMEM_ARB_RING1_THROTTLE
+};
+
 static const struct tegra_smmu_soc tegra124_smmu_soc = {
 	.clients = tegra124_mc_clients,
 	.num_clients = ARRAY_SIZE(tegra124_mc_clients),
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

