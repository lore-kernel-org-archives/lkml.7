Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB53FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC4FE20872
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571263397;
	bh=zulwJW+pFqxRdc+QRRcLKC+H8uvFao+73JzAqy7FiWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dsvablG3gN1HHIsCApqY5KmP3q4Dq650HYZlGd+XMryCW5KkoXYqrh8c66/XAxBot
	 +XML5GW+I1RGw8zP3cUOor7fl9k6W2D/ZrHMXXij/qp1jLoda/yFoYOfnM2lz42k+s
	 TcWoRjT+an/RWBekbrM2+Sm9k9B16PpqKSzUOYeI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406803AbfJPWDQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 18:03:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:54306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438513AbfJPV72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:59:28 -0400
Received: from localhost (unknown [192.55.54.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51ACB21D7F;
        Wed, 16 Oct 2019 21:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571263167;
        bh=zulwJW+pFqxRdc+QRRcLKC+H8uvFao+73JzAqy7FiWs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LZwYYhOcHL98n8GC3NUxnRZxq4cdvoqb6G4Dcbw67bErHqlTxjI1xYTv9Brf5M8pq
         j+jFppqlnRrv/onoABxtUILdFyAnxxcI68Rdsv7v5rHezcWwhjlXh9O7mPID7/+n5n
         fCtaH9F0UwPCe9PEQIT3PYlDyqzocAvBY4w8hi/o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marco Felsch <m.felsch@pengutronix.de>,
        Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 095/112] iio: light: fix vcnl4000 devicetree hooks
Date:   Wed, 16 Oct 2019 14:51:27 -0700
Message-Id: <20191016214905.888866494@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016214844.038848564@linuxfoundation.org>
References: <20191016214844.038848564@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Felsch <m.felsch@pengutronix.de>

[ Upstream commit 1436a78c63495dd94c8d4f84a76d78d5317d481b ]

Since commit ebd457d55911 ("iio: light: vcnl4000 add devicetree hooks")
the of_match_table is supported but the data shouldn't be a string.
Instead it shall be one of 'enum vcnl4000_device_ids'. Also the matching
logic for the vcnl4020 was wrong. Since the data retrieve mechanism is
still based on the i2c_device_id no failures did appeared till now.

Fixes: ebd457d55911 ("iio: light: vcnl4000 add devicetree hooks")
Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
Reviewed-by: Angus Ainslie (Purism) angus@akkea.ca
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/light/vcnl4000.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index ca0d27b46ea22..16dacea9eadfa 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -398,15 +398,15 @@ static int vcnl4000_probe(struct i2c_client *client,
 static const struct of_device_id vcnl_4000_of_match[] = {
 	{
 		.compatible = "vishay,vcnl4000",
-		.data = "VCNL4000",
+		.data = (void *)VCNL4000,
 	},
 	{
 		.compatible = "vishay,vcnl4010",
-		.data = "VCNL4010",
+		.data = (void *)VCNL4010,
 	},
 	{
-		.compatible = "vishay,vcnl4010",
-		.data = "VCNL4020",
+		.compatible = "vishay,vcnl4020",
+		.data = (void *)VCNL4010,
 	},
 	{
 		.compatible = "vishay,vcnl4040",
@@ -414,7 +414,7 @@ static const struct of_device_id vcnl_4000_of_match[] = {
 	},
 	{
 		.compatible = "vishay,vcnl4200",
-		.data = "VCNL4200",
+		.data = (void *)VCNL4200,
 	},
 	{},
 };
-- 
2.20.1



