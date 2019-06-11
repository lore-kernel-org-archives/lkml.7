Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C93C31E46
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 21:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B04C2080A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 21:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lZodZ6j9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407046AbfFKVME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 17:12:04 -0400
Received: from mail-vs1-f74.google.com ([209.85.217.74]:49049 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406962AbfFKVMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 17:12:03 -0400
Received: by mail-vs1-f74.google.com with SMTP id i6so4721899vsp.15
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 14:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=5g9SgyaKPTySWfJg3LNPHAqceK/gsh7xBGRzfCQmGiE=;
        b=lZodZ6j9kTTHdQSxiQl6HxxKgL64WvJ7YvP2tsykPRK/+DVTGrsuRNR3mDWaiyWUbZ
         wn0ex2JyYe3PkQC03U8WnDTH5CQOkG/99uFtB5I6R/ybEZE2RX7hTvk3yaAexFFvTq7Y
         bTrzPcRKMbrpjyU8/cyqeqbyqnSXpgNmTZwyyOjFRswu50VOeFk8T1QRtSTk6gShyYvY
         yyynk+3kGhIOMGVFA+Fdg2f+NvY/5QY5HTgEveuEGdNI1dPFmJEUhDECWrDVvEKHAnEx
         MTZJ4ulo/Yvy9cTMLMgC9FvwQO8KcJR+mJOZ7owzHccNoDT0RM8vgOqwBFcpPz8aTwXH
         losw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=5g9SgyaKPTySWfJg3LNPHAqceK/gsh7xBGRzfCQmGiE=;
        b=hDwB8H70FGY2yZtXC5A6Bus9KTRJSY2U/3yQa1ywbRZGg5rCkb5Ut9/Yn3On8QE2WC
         9EXNLUZCbFPOHcXhTL4sQYawO/wpSADUS3AXiDpxVpNj9tUEc/uYBj59WMszViyRNa/l
         8G7wdZBbxvdz+8CmnbthfnRwCVzpg09M5Tt+VIPW4TSrGokwhnBsLYWjXLJG8VptOawB
         i9zCpsqQbzB4Kz3zryr4gmDM04ZvnXWbC68VYcetcaGQo9CgvPsglDB9EmHO/t+qbv+f
         y3lGdhDpPs685118QOoKYKY7LDeQEXaqUZZR8quQeTKjiNwSH9gKR54BC21hYTBDjiNC
         13Sw==
X-Gm-Message-State: APjAAAXqt19YKHie4k2RiyVaMcvIZc0l0i1zxG/aAv6BRRExp+lXLm7n
        cfppnHvhE3NxeYSbgWOixpJlsY99Lg==
X-Google-Smtp-Source: APXvYqwnBVTE2y+yCuUnSh2UkR+2gJYYnucwu2hfaq7zr1chGY37x8d+vTStgxxXq1D/CHRAzz2qSl0P1g==
X-Received: by 2002:a67:ad07:: with SMTP id t7mr7944256vsl.214.1560287522570;
 Tue, 11 Jun 2019 14:12:02 -0700 (PDT)
Date:   Tue, 11 Jun 2019 14:11:34 -0700
Message-Id: <20190611211134.96159-1-nhuck@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH] clk: qcom: Fix -Wunused-const-variable
From:   Nathan Huckleberry <nhuck@google.com>
To:     agross@kernel.org, david.brown@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nathan Huckleberry <nhuck@google.com>,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang produces the following warning

drivers/clk/qcom/gcc-msm8996.c:133:32: warning: unused variable
'gcc_xo_gpll0_gpll2_gpll3_gpll0_early_div_map' [-Wunused-const-variable]
static const struct
parent_map gcc_xo_gpll0_gpll2_gpll3_gpll0_early_div_map[] =
{ ^drivers/clk/qcom/gcc-msm8996.c:141:27: warning: unused variable
'gcc_xo_gpll0_gpll2_gpll3_gpll0_early_div' [-Wunused-const-variable] static
const char * const gcc_xo_gpll0_gpll2_gpll3_gpll0_early_div[] = { ^
drivers/clk/qcom/gcc-msm8996.c:187:32: warning: unused variable
'gcc_xo_gpll0_gpll2_gpll3_gpll1_gpll4_gpll0_early_div_map'
[-Wunused-const-variable] static const struct parent_map
gcc_xo_gpll0_gpll2_gpll3_gpll1_gpll4_gpll0_early_div_map[] = { ^
drivers/clk/qcom/gcc-msm8996.c:197:27: warning: unused variable
'gcc_xo_gpll0_gpll2_gpll3_gpll1_gpll4_gpll0_early_div'
[-Wunused-const-variable] static const char * const
gcc_xo_gpll0_gpll2_gpll3_gpll1_gpll4_gpll0_early_div[] = {

It looks like these were never used.

Fixes: b1e010c0730a ("clk: qcom: Add MSM8996 Global Clock Control (GCC) driver")
Cc: clang-built-linux@googlegroups.com
Link: https://github.com/ClangBuiltLinux/linux/issues/518
Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Nathan Huckleberry <nhuck@google.com>
---
 drivers/clk/qcom/gcc-msm8996.c | 36 ----------------------------------
 1 file changed, 36 deletions(-)

diff --git a/drivers/clk/qcom/gcc-msm8996.c b/drivers/clk/qcom/gcc-msm8996.c
index d2f39a972cad..d004cdaa0e39 100644
--- a/drivers/clk/qcom/gcc-msm8996.c
+++ b/drivers/clk/qcom/gcc-msm8996.c
@@ -130,22 +130,6 @@ static const char * const gcc_xo_gpll0_gpll4_gpll0_early_div[] = {
 	"gpll0_early_div"
 };
 
-static const struct parent_map gcc_xo_gpll0_gpll2_gpll3_gpll0_early_div_map[] = {
-	{ P_XO, 0 },
-	{ P_GPLL0, 1 },
-	{ P_GPLL2, 2 },
-	{ P_GPLL3, 3 },
-	{ P_GPLL0_EARLY_DIV, 6 }
-};
-
-static const char * const gcc_xo_gpll0_gpll2_gpll3_gpll0_early_div[] = {
-	"xo",
-	"gpll0",
-	"gpll2",
-	"gpll3",
-	"gpll0_early_div"
-};
-
 static const struct parent_map gcc_xo_gpll0_gpll1_early_div_gpll1_gpll4_gpll0_early_div_map[] = {
 	{ P_XO, 0 },
 	{ P_GPLL0, 1 },
@@ -184,26 +168,6 @@ static const char * const gcc_xo_gpll0_gpll2_gpll3_gpll1_gpll2_early_gpll0_early
 	"gpll0_early_div"
 };
 
-static const struct parent_map gcc_xo_gpll0_gpll2_gpll3_gpll1_gpll4_gpll0_early_div_map[] = {
-	{ P_XO, 0 },
-	{ P_GPLL0, 1 },
-	{ P_GPLL2, 2 },
-	{ P_GPLL3, 3 },
-	{ P_GPLL1, 4 },
-	{ P_GPLL4, 5 },
-	{ P_GPLL0_EARLY_DIV, 6 }
-};
-
-static const char * const gcc_xo_gpll0_gpll2_gpll3_gpll1_gpll4_gpll0_early_div[] = {
-	"xo",
-	"gpll0",
-	"gpll2",
-	"gpll3",
-	"gpll1",
-	"gpll4",
-	"gpll0_early_div"
-};
-
 static struct clk_fixed_factor xo = {
 	.mult = 1,
 	.div = 1,
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

