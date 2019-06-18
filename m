Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 854F2C31E5C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 02:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60E2C20863
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 02:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jlP6OPia"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbfFRCYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 22:24:16 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39625 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727399AbfFRCYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 22:24:16 -0400
Received: by mail-ed1-f68.google.com with SMTP id m10so19179139edv.6;
        Mon, 17 Jun 2019 19:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lx4lm8ezQLxxXg3cFWwVWTQoCE1WyQJtp8daTAQGnAE=;
        b=jlP6OPiaGGXIC88z3BmvU0tzqiZKK0Fu03WqTR4mlUBJ/9Nmrf/bztr+YMPrHFEBHN
         4OtXRSalf315AkYk2Sb1ZJdvxbF44nnow/W6T1VH2B8HhOuKTGpwkgUMhbZu7M3QVsFx
         Oyjvg9uVF8a8Fk1L4nrrrcvx18cZBd2qVHUbm6L98nGWzAMzF64ITvsxzoAszFnup8Z2
         yEs21DUkTKQnCQb0O3e5ALSd04ciENiZXpwkxUDLlOJpwaLt8mApuZCgOtMT8d9YRs2r
         BXNUKJsBTLS0Eo0Q0JV+MrWV+m49QQjl9opBWlRhHtHEg+1f/JEdQFssE0rqa6WZh5Vl
         CUGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lx4lm8ezQLxxXg3cFWwVWTQoCE1WyQJtp8daTAQGnAE=;
        b=NBSkgVUZ5aPjHRAW2fbJIqRra1OsJw892IAui3q75leFxvQJsdutyFiUxHX4+yX4R6
         7NjFW4Nu/XWdcGyASUCDy+B5vYqa6e1EVx7uKOf4JM1YsdsZ3KI2YkMjFu24RTP96rnJ
         NEfb8UuJP76L88H8snz/LZanToaNwNlkHigqRRmBLCX48vxzctCoiysrQDR8V9RGPVNh
         1iN/a6l0dQf83+MB1dTDUpWRPgYoblwxpKE/Kpn4fD0wP00G8hezqXf6dLUcc4vFlbXu
         i5WvdXXkI5O4Ot0sfHazXlkRSA7e714RAtZmuVCnd+gsuNgCXne2c5HSlrURgTLC2POd
         RFLA==
X-Gm-Message-State: APjAAAUm+jFfLGPe5hfWrOS6nE+pB76c3tJiuSLfgY5Nhl9ktYQFkVrl
        ekjzvIgwG++0it/aFIKct7A=
X-Google-Smtp-Source: APXvYqyG3IJ3H2I8Zal9OtLEww9Kb70iUkIe3c10nl8TyAfukGGZgdUW4a9aSQn2zNroQWQqhwolKg==
X-Received: by 2002:aa7:c99a:: with SMTP id c26mr28682275edt.118.1560824654244;
        Mon, 17 Jun 2019 19:24:14 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f9:2b:2b15::2])
        by smtp.gmail.com with ESMTPSA id m3sm4064055edi.33.2019.06.17.19.24.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 19:24:13 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Abel Vesa <abel.vesa@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH] clk: imx6q: Annotate imx6q_obtain_fixed_clk_hw with __init
Date:   Mon, 17 Jun 2019 19:24:05 -0700
Message-Id: <20190618022405.27952-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with clang, the following modpost warning occurs:

WARNING: vmlinux.o(.text+0x974dbc): Section mismatch in reference from
the function imx6q_obtain_fixed_clk_hw() to the function
.init.text:imx_obtain_fixed_clock_hw()
The function imx6q_obtain_fixed_clk_hw() references
the function __init imx_obtain_fixed_clock_hw().
This is often because imx6q_obtain_fixed_clk_hw lacks a __init
annotation or the annotation of imx_obtain_fixed_clock_hw is wrong.

imx6q_obtain_fixed_clk_hw is only used in imx6q_clocks_init, which is
marked __init so do that to imx6q_obtain_fixed_clk_hw to avoid this
warning.

Fixes: 992b703b5b38 ("clk: imx6q: Switch to clk_hw based API")
Link: https://github.com/ClangBuiltLinux/linux/issues/541
Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/clk/imx/clk-imx6q.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
index 2caa71e91119..18914e0a1850 100644
--- a/drivers/clk/imx/clk-imx6q.c
+++ b/drivers/clk/imx/clk-imx6q.c
@@ -418,8 +418,9 @@ static void disable_anatop_clocks(void __iomem *anatop_base)
 	writel_relaxed(reg, anatop_base + CCM_ANALOG_PLL_VIDEO);
 }
 
-static struct clk_hw *imx6q_obtain_fixed_clk_hw(struct device_node *np,
-						const char *name, unsigned long rate)
+static struct clk_hw __init *imx6q_obtain_fixed_clk_hw(struct device_node *np,
+							const char *name,
+							unsigned long rate)
 {
 	struct clk *clk = of_clk_get_by_name(np, name);
 	struct clk_hw *hw;
-- 
2.22.0

