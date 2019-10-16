Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE8DFA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 13:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67E3420663
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 13:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbZlVSMX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393548AbfJPNNf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 09:13:35 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35738 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728176AbfJPNNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 09:13:34 -0400
Received: by mail-pg1-f196.google.com with SMTP id p30so14294208pgl.2;
        Wed, 16 Oct 2019 06:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C3WMejLIjX/sN4h8RDr6kyJEZVhRO/kXeqFDRFF6Id8=;
        b=lbZlVSMXAaG45YMMWa8UqrZlE3mNsCasc5BFMYhZcETMQqmJCvgmOTLr7gfz8HrKHu
         eEdTYOcFOGto7xSuq4Ubox4D2RUcQXEtZbmkFSB/I/JDek6+CuHQ+WWMPQTHIs/Mk/mP
         qXFlhQxgDQQMvILeKOUlNYmP7iCbES0YFtXHKZGxxvUTQcFZypFfH5dHUzdQLJ/Qpv+d
         h3HtGKJHsCkcxMoKujCuTiPiTt1JRu3lR+jbO/Crwj7/pGNEX6sXJOJnk2P+T2/Xnan8
         5l9QrDaWaeEXuS7aPnU4jZq+Km9U5QgJJgLrtR+qcC4JIka0Vh6UmV871gOHIJrimT6I
         uJHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=C3WMejLIjX/sN4h8RDr6kyJEZVhRO/kXeqFDRFF6Id8=;
        b=eW84I/8sIG+AvtGCvbkQObt50qlegioBy+Tf38GwAK3SBjtM1yaJqL3jmYtzXmJILV
         VYltFYkEJ5E3bLPq5/e4YdMuyZ2blNgb71d1CY8WbwbWKO23AXDbRZGH3FwlD/j+etaW
         24nIbhE28qEyNvV/XmEkZVudWf3xhHDxGIYdHaCqMZ64rXMEU2Ms0q1bPZlq4Zx7FJZ7
         iZytYiIRMpjalOvarSvPGE0ad9amjCddd+zp+GkAfLpnIQs2ga2vJGV7v9oVVYKF2yTJ
         CwB7sQ8O6fY5Zx8IEXbxaPzvt4mytqqj0dt2LVJq2NDb5W43TIaaNCGXIdTko7+Z/DA0
         4lYw==
X-Gm-Message-State: APjAAAUjs10LPHmhjyg9AV62H9cL45KSSNQIISkgoXeSg9cO84AtJaxi
        xrK4i56Xd4vDX2WmHXUn89o=
X-Google-Smtp-Source: APXvYqyqahV9zVwQW3dqjD79x3+FqITP01LbOa2/B5n0zWhcO1UPkVNuw7hURrivflb7cequRdvdPQ==
X-Received: by 2002:a17:90a:a781:: with SMTP id f1mr5116963pjq.29.1571231613537;
        Wed, 16 Oct 2019 06:13:33 -0700 (PDT)
Received: from localhost.localdomain ([45.124.203.14])
        by smtp.gmail.com with ESMTPSA id n3sm28433569pff.102.2019.10.16.06.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 06:13:32 -0700 (PDT)
From:   Joel Stanley <joel@jms.id.au>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-aspeed@lists.ozlabs.org, Andrew Jeffery <andrew@aj.id.au>
Subject: [PATCH] clk: ast2600: Fix enabling of clocks
Date:   Wed, 16 Oct 2019 23:43:19 +1030
Message-Id: <20191016131319.31318-1-joel@jms.id.au>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The struct clk_ops enable callback for the aspeed gates mixes up the set
to clear and write to set registers.

Fixes: d3d04f6c330a ("clk: Add support for AST2600 SoC")
Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/clk/clk-ast2600.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk-ast2600.c b/drivers/clk/clk-ast2600.c
index 1c1bb39bb04e..b1318e6b655b 100644
--- a/drivers/clk/clk-ast2600.c
+++ b/drivers/clk/clk-ast2600.c
@@ -266,10 +266,11 @@ static int aspeed_g6_clk_enable(struct clk_hw *hw)
 
 	/* Enable clock */
 	if (gate->flags & CLK_GATE_SET_TO_DISABLE) {
-		regmap_write(gate->map, get_clock_reg(gate), clk);
-	} else {
-		/* Use set to clear register */
+		/* Clock is clear to enable, so use set to clear register */
 		regmap_write(gate->map, get_clock_reg(gate) + 0x04, clk);
+	} else {
+		/* Clock is set to enable, so use write to set register */
+		regmap_write(gate->map, get_clock_reg(gate), clk);
 	}
 
 	if (gate->reset_idx >= 0) {
-- 
2.23.0

