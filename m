Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D7F6C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D80E62080A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575412862;
	bh=oqC+a1mAJO+/xTx5ZcTc9RFX81hYZCBJddP4MCD+bZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Gg5XpjWC5xBSZGoBdsTgA/VBciff1lhOvK+36blUkFV3aKoxzeRrmHWrz6F/hdgxS
	 zXB3yYy+mTVq7vi3WHaHmWZvCZrJrM7CVW8a7njqHH5t3ylViUTqsssucDN5i86iu9
	 D9zk72032s7t5deBlK31RHeLah6fbKIdLdn88D+E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728455AbfLCWlA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:41:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:54694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727969AbfLCWkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:40:52 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6032120684;
        Tue,  3 Dec 2019 22:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575412851;
        bh=oqC+a1mAJO+/xTx5ZcTc9RFX81hYZCBJddP4MCD+bZA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W7uerd2VxPEBajHlfEWp7/RYrJ3V8ZIH68pmKto4c8hzBewKBGWFhcImuJXNMYAQH
         aItw9tkKPuaTgKKy+uyqeOCzDpATbtSNi9pTanGPHOsjXHN8mhjaQ9fD95/9MXee5E
         UQaT5xwIlVMRc+zjPecocfIN9KYhfBxFveW6Dwt4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 005/135] clk: meson: gxbb: let sar_adc_clk_div set the parent clock rate
Date:   Tue,  3 Dec 2019 23:34:05 +0100
Message-Id: <20191203213006.733032204@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203213005.828543156@linuxfoundation.org>
References: <20191203213005.828543156@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

[ Upstream commit 44b09b11b813b8550e6b976ea51593bc23bba8d1 ]

The meson-saradc driver manually sets the input clock for
sar_adc_clk_sel. Update the GXBB clock driver (which is used on GXBB,
GXL and GXM) so the rate settings on sar_adc_clk_div are propagated up
to sar_adc_clk_sel which will let the common clock framework select the
best matching parent clock if we want that.

This makes sar_adc_clk_div consistent with the axg-aoclk and g12a-aoclk
drivers, which both also specify CLK_SET_RATE_PARENT.

Fixes: 33d0fcdfe0e870 ("clk: gxbb: add the SAR ADC clocks and expose them")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/meson/gxbb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index dab16d9b1af8b..9834eb2c1b674 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -866,6 +866,7 @@ static struct clk_regmap gxbb_sar_adc_clk_div = {
 		.ops = &clk_regmap_divider_ops,
 		.parent_names = (const char *[]){ "sar_adc_clk_sel" },
 		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
-- 
2.20.1



