Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB0BC388F4
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 18:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A516920872
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 18:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbfI0SGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 14:06:31 -0400
Received: from 17.mo6.mail-out.ovh.net ([46.105.36.150]:42475 "EHLO
        17.mo6.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbfI0SGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 14:06:30 -0400
Received: from player762.ha.ovh.net (unknown [10.108.57.49])
        by mo6.mail-out.ovh.net (Postfix) with ESMTP id A150A1E308E
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 20:06:28 +0200 (CEST)
Received: from sk2.org (unknown [109.190.253.11])
        (Authenticated sender: steve@sk2.org)
        by player762.ha.ovh.net (Postfix) with ESMTPSA id 0B6C1A546CCA;
        Fri, 27 Sep 2019 18:06:16 +0000 (UTC)
From:   Stephen Kitt <steve@sk2.org>
To:     Tero Kristo <t-kristo@ti.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-omap@vger.kernel.org,
        linux-clk@vger.kernel.org, Tony Lindgren <tony@atomide.com>
Cc:     linux-kernel@vger.kernel.org, Stephen Kitt <steve@sk2.org>
Subject: [PATCH v2] clk/ti/adpll: allocate room for terminating null
Date:   Fri, 27 Sep 2019 20:05:59 +0200
Message-Id: <20190927180559.18162-1-steve@sk2.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cec235b3e2e4e3b206fa9444b643fa56@sk2.org>
References: <cec235b3e2e4e3b206fa9444b643fa56@sk2.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 5738711825322888647
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrfeeigdduudelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The buffer allocated in ti_adpll_clk_get_name doesn't account for the
terminating null. This patch switches to ka_sprintf to avoid
overflowing.

Signed-off-by: Stephen Kitt <steve@sk2.org>
---
 drivers/clk/ti/adpll.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/ti/adpll.c b/drivers/clk/ti/adpll.c
index fdfb90058504..021cf9e2b4db 100644
--- a/drivers/clk/ti/adpll.c
+++ b/drivers/clk/ti/adpll.c
@@ -195,14 +195,8 @@ static const char *ti_adpll_clk_get_name(struct ti_adpll_data *d,
 			return NULL;
 	} else {
 		const char *base_name = "adpll";
-		char *buf;
-
-		buf = devm_kzalloc(d->dev, 8 + 1 + strlen(base_name) + 1 +
-				    strlen(postfix), GFP_KERNEL);
-		if (!buf)
-			return NULL;
-		sprintf(buf, "%08lx.%s.%s", d->pa, base_name, postfix);
-		name = buf;
+		name = devm_kasprintf(d->dev, GFP_KERNEL, "%08lx.%s.%s",
+				      d->pa, base_name, postfix);
 	}
 
 	return name;
-- 
2.20.1

