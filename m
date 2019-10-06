Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C87ECE58B
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E52E2087E
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570382715;
	bh=rrI29aVED5YRGj5/zZGCVu7KrelVkMFejMQpJYStOqc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pFBNcQpUV8KS7Scc3mrv7xfb4i5sqv+7prPEKg8sJXHvsctXrnphahB7EciQLvC64
	 +qXZ4iGxYwwXXkwEf6uizfYZv41ymCsBMuCn3SX8VDbOqAAyAq+cvsHtgTFetc2fkk
	 r2Pb/UmANhd+P8HMSI4nfs3AkGWxZfE96yZ0EK90=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfJFRZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 13:25:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:50176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728048AbfJFRZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 13:25:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73DB22077B;
        Sun,  6 Oct 2019 17:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570382709;
        bh=rrI29aVED5YRGj5/zZGCVu7KrelVkMFejMQpJYStOqc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YnjbCmig7C20cEWLRKBVDNAdAaSl69RNgvJGJ2foiLpjbVN7dOTxVyYeDACEolxvO
         ZbM4ebN4ahcmouAaBaN4VGARzyFVegl2dFwhU1w+gQzXJxj3v3qk+B+6t3Ry5lJf4N
         uL0R5jQkFV6hlKX5rX2SSxuA9xaBh+8psg4wCGls=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Huckleberry <nhuck@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Scott Wood <oss@buserror.net>, Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 11/68] clk: qoriq: Fix -Wunused-const-variable
Date:   Sun,  6 Oct 2019 19:20:47 +0200
Message-Id: <20191006171114.168283342@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191006171108.150129403@linuxfoundation.org>
References: <20191006171108.150129403@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index b0ea753b8709d..1a292519d84f2 100644
--- a/drivers/clk/clk-qoriq.c
+++ b/drivers/clk/clk-qoriq.c
@@ -610,7 +610,7 @@ static const struct clockgen_chipinfo chipinfo[] = {
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



