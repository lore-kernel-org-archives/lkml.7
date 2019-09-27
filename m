Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E32BC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 15:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C0A321BE5
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 15:34:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbfI0Peq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 11:34:46 -0400
Received: from 16.mo1.mail-out.ovh.net ([178.33.104.224]:40659 "EHLO
        16.mo1.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727334AbfI0Pep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 11:34:45 -0400
X-Greylist: delayed 2209 seconds by postgrey-1.27 at vger.kernel.org; Fri, 27 Sep 2019 11:34:45 EDT
Received: from player758.ha.ovh.net (unknown [10.108.54.9])
        by mo1.mail-out.ovh.net (Postfix) with ESMTP id 8197E1918A9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 16:57:55 +0200 (CEST)
Received: from sk2.org (unknown [65.39.69.237])
        (Authenticated sender: steve@sk2.org)
        by player758.ha.ovh.net (Postfix) with ESMTPSA id 032C7A59A1F3;
        Fri, 27 Sep 2019 14:57:47 +0000 (UTC)
From:   Stephen Kitt <steve@sk2.org>
To:     Tero Kristo <t-kristo@ti.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-omap@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Stephen Kitt <steve@sk2.org>
Subject: [PATCH] clk/ti/adpll: allocate room for terminating null
Date:   Fri, 27 Sep 2019 16:57:37 +0200
Message-Id: <20190927145737.7832-1-steve@sk2.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 2554385417407385031
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrfeeigdekudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The buffer allocated in ti_adpll_clk_get_name doesn't account for the
terminating null. This patch adds the extra byte, and switches to
snprintf to avoid overflowing.

Signed-off-by: Stephen Kitt <steve@sk2.org>
---
 drivers/clk/ti/adpll.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/ti/adpll.c b/drivers/clk/ti/adpll.c
index fdfb90058504..27933c4e8a27 100644
--- a/drivers/clk/ti/adpll.c
+++ b/drivers/clk/ti/adpll.c
@@ -196,12 +196,13 @@ static const char *ti_adpll_clk_get_name(struct ti_adpll_data *d,
 	} else {
 		const char *base_name = "adpll";
 		char *buf;
+		size_t size = 8 + 1 + strlen(base_name) + 1 +
+			      strlen(postfix) + 1;
 
-		buf = devm_kzalloc(d->dev, 8 + 1 + strlen(base_name) + 1 +
-				    strlen(postfix), GFP_KERNEL);
+		buf = devm_kzalloc(d->dev, size, GFP_KERNEL);
 		if (!buf)
 			return NULL;
-		sprintf(buf, "%08lx.%s.%s", d->pa, base_name, postfix);
+		snprintf(buf, size, "%08lx.%s.%s", d->pa, base_name, postfix);
 		name = buf;
 	}
 
-- 
2.20.1

