Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 607A0C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3284920836
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551688230;
	bh=G0vQXuzPr/TBFG23I+3mP6z3dlJUVjqBgFL96O8LyqQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MTaKPOm3DtspyY8uINAttlX2Ijo4QNvVzeNC+7pgdSvscFgB0rk3ArmyxXI+fv3Hi
	 8Qec5xnajpuJtbqn4BztRxx/he5iXU/iuoBP8mjQVy5yUmgJWdk6yyR4u8EavoAG+w
	 1U79Xr9i6DBqYYKa/FVqcsu+v+8v6qv+e0tNvv6s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbfCDIa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:30:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:58566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727694AbfCDIaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:30:25 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52A0121019;
        Mon,  4 Mar 2019 08:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551688224;
        bh=G0vQXuzPr/TBFG23I+3mP6z3dlJUVjqBgFL96O8LyqQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RAjd090gInjnHi2E/TMoZRtcE+S7NHHdakK9kMYYLL6h0JjxGy2s+jG41UTxk419p
         o3dVCeMX9jkJZ94/4WPg5zf4mAOq5pxq6AQdxtbvAztkl5zObOXxpCAZzYTyyBwakc
         /4KMmRvaA2fZIOBk2vF99jlsd5Qbuf15sVOb1aps=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shuming Fan <shumingf@realtek.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 21/78] ASoC: rt5682: Fix PLL source register definitions
Date:   Mon,  4 Mar 2019 09:22:04 +0100
Message-Id: <20190304081626.445088506@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081625.508788074@linuxfoundation.org>
References: <20190304081625.508788074@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
index 8068140ebe3f1..cdd659f4df93d 100644
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



