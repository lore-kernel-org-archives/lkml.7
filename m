Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 350F7C4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 22:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D790205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 22:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jSDkNA5L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfF0WGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 18:06:50 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:44001 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbfF0WGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 18:06:50 -0400
Received: by mail-pg1-f201.google.com with SMTP id k136so2020238pgc.10
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 15:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=iOIuT1w8SKhqU0tOLmAe3kv4MDfWt/x8OJo6YX/y9oc=;
        b=jSDkNA5LQH+FSb/Qia4R2KWHwPty4yHuIwp6TJEEqqLl1T/gXBFnKMEi9LxoaWJHZQ
         hH+hOrQqD7UnMmr3mWtGH49tjIW16QGlONkTFjiQtqKyEZaPLDcUcZ+htsFAUCqCO48K
         zGHef5GViOZGayMfOhTwZs+NLQgMHai+TYSVybcPcbVxXFX1UbEiO22y4eQPV/GlxQUk
         gzdH2QAw2DoxRDrmf5YUa/qHP6bOaqEIKMQUrUAY+a+WmT+kAm+P0JZJEb7Elb13rN1v
         6xr2884AZ6xA/T4W+TYMeYPLdT5gx69GJohtrUjGVT9jmCD2TlmcE4LQFq9rrDdi3ozi
         mEyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=iOIuT1w8SKhqU0tOLmAe3kv4MDfWt/x8OJo6YX/y9oc=;
        b=JMEGSRbs+ScjavbRodlBg5Vhjcn8yEGehSwgpcttlzYHN5FQp3sI1g0/VVPR4UfpXJ
         b2Aeugzl9ZmAWjA/alBIW9kMiOKJbv7n2/jPKUDtE2jBqPNK4Diw05Zy0QB3JPSUDwIg
         xSYSbLA+Iy+Lpw9Z7dA8DlZsueEr2VQm/OLAfttyrxaDm3nBMvjfL3+TLWip3jZm2D48
         Xmc2xwn5usdor2zzwgqFTNcuOkjfzoKBI/vFTLBvrEIU+6rf8VI10BgbRzq3z0HK3SRT
         Vm6Zm1+6n/R36E6ash5bjblToc4etgLksKglRfxRNpm7sM9wihs9j+Rzzc2gGo18wBag
         zmsA==
X-Gm-Message-State: APjAAAVF3mTz3NnwIU4gT6AABE2indJbVFC7M6RWxPJJ83JfxLdpfdTg
        8dPyT95/Pf6ZEPtBVKF816ASG4mIUA==
X-Google-Smtp-Source: APXvYqw0vM2adqB+1ViXyVQ+eZ77pfsjezHBzZi9i6+3YHTu/RBpst5O7BkRfwtHoSrYiz3lcajuOqBxrA==
X-Received: by 2002:a63:6986:: with SMTP id e128mr6240631pgc.220.1561673209121;
 Thu, 27 Jun 2019 15:06:49 -0700 (PDT)
Date:   Thu, 27 Jun 2019 15:06:42 -0700
Message-Id: <20190627220642.78575-1-nhuck@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH] clk: qoriq: Fix -Wunused-const-variable
From:   Nathan Huckleberry <nhuck@google.com>
To:     mturquette@baylibre.com, sboyd@kernel.org,
        yogeshnarayan.gaur@nxp.com, oss@buserror.net
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Huckleberry <nhuck@google.com>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/clk/clk-qoriq.c:138:38: warning: unused variable
'p5020_cmux_grp1' [-Wunused-const-variable] static const struct
clockgen_muxinfo p5020_cmux_grp1

drivers/clk/clk-qoriq.c:146:38: warning: unused variable
'p5020_cmux_grp2' [-Wunused-const-variable] static const struct
clockgen_muxinfo p5020_cmux_grp2

In the definition of the p5020 chip, the p2041 chip's info was used
instead.  The p5020 and p2041 chips have different info. This is most
likely a typo.

Link: https://github.com/ClangBuiltLinux/linux/issues/525
Cc: clang-built-linux@googlegroups.com
Signed-off-by: Nathan Huckleberry <nhuck@google.com>
---
 drivers/clk/clk-qoriq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-qoriq.c b/drivers/clk/clk-qoriq.c
index 4739a47ec8bd..0f8870527940 100644
--- a/drivers/clk/clk-qoriq.c
+++ b/drivers/clk/clk-qoriq.c
@@ -678,7 +678,7 @@ static const struct clockgen_chipinfo chipinfo[] = {
 		.guts_compat = "fsl,qoriq-device-config-1.0",
 		.init_periph = p5020_init_periph,
 		.cmux_groups = {
-			&p2041_cmux_grp1, &p2041_cmux_grp2
+			&p5020_cmux_grp1, &p5020_cmux_grp2
 		},
 		.cmux_to_group = {
 			0, 1, -1
-- 
2.22.0.410.gd8fdbe21b5-goog

