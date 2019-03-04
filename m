Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B308C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49467208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551688372;
	bh=IN3dbLPmIzQKUWujsAh1kqxQ4E72OzcAvICWqIp1kxc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vLwxkb9uGMEzfaokLtmzmj/aYt2A7S4MepMkXma/VjPuhBULkWvYdz0ct8/K7I71P
	 qb2ltImMVx4Rf0GzzCK/rctg8Mx2t4jhIfJfzmXrvwpqJVf3ks3cysAut4Q9BgnOQ1
	 NDjBJn8JOE65ONiDvESyhVIb0ScZoUjN/E+4PA+s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbfCDIcv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:32:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:36396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727920AbfCDIck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:32:40 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74A16208E4;
        Mon,  4 Mar 2019 08:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551688360;
        bh=IN3dbLPmIzQKUWujsAh1kqxQ4E72OzcAvICWqIp1kxc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M9t1MqMcgdBkxH9Pe7/lHbgkPgLACet/R2qvru+hn5d7HW/AXIyw7zDji3BoGRx5a
         E6u+ffaFJU0GkOQndIR0gZJgtnO9QfA2xkYtWs1qIrKZRu1k00xTI/1OSD+EEDL2cy
         bKxQIw1tgeET8PBpt+IOfylHRvD9i9EfqIdM8Lk8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shuming Fan <shumingf@realtek.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 21/88] ASoC: rt5682: Fix PLL source register definitions
Date:   Mon,  4 Mar 2019 09:22:04 +0100
Message-Id: <20190304081631.446168515@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081630.610632175@linuxfoundation.org>
References: <20190304081630.610632175@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit ee7ea2a9a318a89d21b156dc75e54d53904bdbe5 ]

Fix typo which causes headphone no sound while using BCLK
as PLL source.

Signed-off-by: Shuming Fan <shumingf@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/rt5682.h | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/rt5682.h b/sound/soc/codecs/rt5682.h
index d82a8301fd745..96944cff0ed73 100644
--- a/sound/soc/codecs/rt5682.h
+++ b/sound/soc/codecs/rt5682.h
@@ -849,18 +849,18 @@
 #define RT5682_SCLK_SRC_PLL2			(0x2 << 13)
 #define RT5682_SCLK_SRC_SDW			(0x3 << 13)
 #define RT5682_SCLK_SRC_RCCLK			(0x4 << 13)
-#define RT5682_PLL1_SRC_MASK			(0x3 << 10)
-#define RT5682_PLL1_SRC_SFT			10
-#define RT5682_PLL1_SRC_MCLK			(0x0 << 10)
-#define RT5682_PLL1_SRC_BCLK1			(0x1 << 10)
-#define RT5682_PLL1_SRC_SDW			(0x2 << 10)
-#define RT5682_PLL1_SRC_RC			(0x3 << 10)
-#define RT5682_PLL2_SRC_MASK			(0x3 << 8)
-#define RT5682_PLL2_SRC_SFT			8
-#define RT5682_PLL2_SRC_MCLK			(0x0 << 8)
-#define RT5682_PLL2_SRC_BCLK1			(0x1 << 8)
-#define RT5682_PLL2_SRC_SDW			(0x2 << 8)
-#define RT5682_PLL2_SRC_RC			(0x3 << 8)
+#define RT5682_PLL2_SRC_MASK			(0x3 << 10)
+#define RT5682_PLL2_SRC_SFT			10
+#define RT5682_PLL2_SRC_MCLK			(0x0 << 10)
+#define RT5682_PLL2_SRC_BCLK1			(0x1 << 10)
+#define RT5682_PLL2_SRC_SDW			(0x2 << 10)
+#define RT5682_PLL2_SRC_RC			(0x3 << 10)
+#define RT5682_PLL1_SRC_MASK			(0x3 << 8)
+#define RT5682_PLL1_SRC_SFT			8
+#define RT5682_PLL1_SRC_MCLK			(0x0 << 8)
+#define RT5682_PLL1_SRC_BCLK1			(0x1 << 8)
+#define RT5682_PLL1_SRC_SDW			(0x2 << 8)
+#define RT5682_PLL1_SRC_RC			(0x3 << 8)
 
 
 
-- 
2.19.1



