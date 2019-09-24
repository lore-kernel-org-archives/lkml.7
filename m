Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C86C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 16:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5EE921783
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 16:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569343403;
	bh=bNCnRboeCVn87mOl7ww26nNSv6sQjpBOKLRnr2WZNgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dqLSphnZ6jxagWGp1MxZWbWy4HTUVLC/LszXH573L3BaKInDAbGYoZjMX2gn14jbx
	 RuTomjWE7S3OCYkxWyHy53+smqza0KLUCMtBFH6gII9/jJ5k+RZSzvbT78x6rsXjrl
	 gE+oE2hbHHG41s4FH1hxAoUXVb+xV8RwRmlWxU0s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2632911AbfIXQnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 12:43:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:59608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2632851AbfIXQm7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 12:42:59 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F6F120872;
        Tue, 24 Sep 2019 16:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569343378;
        bh=bNCnRboeCVn87mOl7ww26nNSv6sQjpBOKLRnr2WZNgI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G+ED3QqjkdB2PsGj+POyJErZhShzEGBAcTDAPLvST1VZ0sFYYNOuJA6w6y+7Le5x+
         anphW9picA49k7GD9SUd1ODBZ2TMlVea6ZqJ8lUlXLU1mqMidy3rcMzZVV0sEALHn3
         yLuBOE2powQcC50Viyy8phtSlniBZpefWIYmIldY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nathan Huckleberry <nhuck@google.com>,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Scott Wood <oss@buserror.net>, Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 5.3 27/87] clk: qoriq: Fix -Wunused-const-variable
Date:   Tue, 24 Sep 2019 12:40:43 -0400
Message-Id: <20190924164144.25591-27-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190924164144.25591-1-sashal@kernel.org>
References: <20190924164144.25591-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Huckleberry <nhuck@google.com>

[ Upstream commit a95fb581b144b5e73da382eaedb2e32027610597 ]

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
Link: https://lkml.kernel.org/r/20190627220642.78575-1-nhuck@google.com
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Acked-by: Scott Wood <oss@buserror.net>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/clk-qoriq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-qoriq.c b/drivers/clk/clk-qoriq.c
index 07f3b252f3e0c..bed140f7375f0 100644
--- a/drivers/clk/clk-qoriq.c
+++ b/drivers/clk/clk-qoriq.c
@@ -686,7 +686,7 @@ static const struct clockgen_chipinfo chipinfo[] = {
 		.guts_compat = "fsl,qoriq-device-config-1.0",
 		.init_periph = p5020_init_periph,
 		.cmux_groups = {
-			&p2041_cmux_grp1, &p2041_cmux_grp2
+			&p5020_cmux_grp1, &p5020_cmux_grp2
 		},
 		.cmux_to_group = {
 			0, 1, -1
-- 
2.20.1

