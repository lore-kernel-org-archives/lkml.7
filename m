Return-Path: <SRS0=/uHP=YM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 589D4CA9EAC
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 14:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B9B7222BD
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 14:23:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbfJSOXb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Oct 2019 10:23:31 -0400
Received: from 2.mo68.mail-out.ovh.net ([46.105.52.162]:43604 "EHLO
        2.mo68.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfJSOXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Oct 2019 10:23:30 -0400
Received: from player714.ha.ovh.net (unknown [10.108.42.196])
        by mo68.mail-out.ovh.net (Postfix) with ESMTP id EF17B145F3D
        for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2019 16:07:01 +0200 (CEST)
Received: from sk2.org (gw.sk2.org [88.186.243.14])
        (Authenticated sender: steve@sk2.org)
        by player714.ha.ovh.net (Postfix) with ESMTPSA id BA673B1A3FB1;
        Sat, 19 Oct 2019 14:06:51 +0000 (UTC)
From:   Stephen Kitt <steve@sk2.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Tero Kristo <t-kristo@ti.com>,
        Tony Lindgren <tony@atomide.com>, linux-clk@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Kitt <steve@sk2.org>
Subject: [PATCH v3] clk/ti/adpll: allocate room for terminating null
Date:   Sat, 19 Oct 2019 16:06:34 +0200
Message-Id: <20191019140634.15596-1-steve@sk2.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191019155441.2b1b349f@heffalump.sk2.org>
References: <20191019155441.2b1b349f@heffalump.sk2.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 1766818431945362904
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrkedugddtiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The buffer allocated in ti_adpll_clk_get_name doesn't account for the
terminating null. This patch switches to devm_kasprintf to avoid
overflowing.

Signed-off-by: Stephen Kitt <steve@sk2.org>
---
Changes since v2:
  - Move "adpll" into the format string and drop base_name entirely.

Changes since v1:
  - Use devm_kasprintf instead of manually allocating the target
    buffer.
---
 drivers/clk/ti/adpll.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/ti/adpll.c b/drivers/clk/ti/adpll.c
index fdfb90058504..bb2f2836dab2 100644
--- a/drivers/clk/ti/adpll.c
+++ b/drivers/clk/ti/adpll.c
@@ -194,15 +194,8 @@ static const char *ti_adpll_clk_get_name(struct ti_adpll_data *d,
 		if (err)
 			return NULL;
 	} else {
-		const char *base_name = "adpll";
-		char *buf;
-
-		buf = devm_kzalloc(d->dev, 8 + 1 + strlen(base_name) + 1 +
-				    strlen(postfix), GFP_KERNEL);
-		if (!buf)
-			return NULL;
-		sprintf(buf, "%08lx.%s.%s", d->pa, base_name, postfix);
-		name = buf;
+		name = devm_kasprintf(d->dev, GFP_KERNEL, "%08lx.adpll.%s",
+				      d->pa, postfix);
 	}
 
 	return name;
-- 
2.20.1

