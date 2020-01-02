Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA9EC3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D02EF20863
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578004489;
	bh=s9zR26Od/eyqvJREXwIR6CcCbv9tWMzAbtf7PhPWXZ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XtvhDC+5zhvJ8EshFgowahdJld1/lBx7uXXgYho+GBgBMltlx5OUa9ffPFSjFtzva
	 kvEEojr5dnXtHRl0q8+b2sVN+/tlep1gEhpZEWn+bZFhNPnaROBKRfp/qVREorCILY
	 8bfKOIaRLXhhLard4fBmz7a4qWlwfntcwnwhduS0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730734AbgABWes (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:34:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:43718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730718AbgABWep (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:34:45 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9073421D7D;
        Thu,  2 Jan 2020 22:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578004485;
        bh=s9zR26Od/eyqvJREXwIR6CcCbv9tWMzAbtf7PhPWXZ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mVKA6/cus/mg1seeRr+i7HTZwL9KbK6MyaKP8uh1ds1gcqdfXa77W+IFIbunGXLvT
         +IbF6Q34le0n1LCFhdtT2SmcloZLKHImfTzuwv0pUGRNOvb6RnwbpjLpT5iDmoErBn
         AyVJAipBvZQfJlWymk/ijppHOLCrEhqGr2w90vKw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Krzysztof Wilczynski <kw@linux.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 006/137] iio: light: bh1750: Resolve compiler warning and make code more readable
Date:   Thu,  2 Jan 2020 23:06:19 +0100
Message-Id: <20200102220547.463569636@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102220546.618583146@linuxfoundation.org>
References: <20200102220546.618583146@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krzysztof Wilczynski <kw@linux.com>

[ Upstream commit f552fde983d378e7339f9ea74a25f918563bf0d3 ]

Separate the declaration of struct bh1750_chip_info from definition
of bh1750_chip_info_tbl[] in a single statement as it makes the code
hard to read, and with the extra newline it makes it look as if the
bh1750_chip_info_tbl[] had no explicit type.

This change also resolves the following compiler warning about the
unusual position of the static keyword that can be seen when building
with warnings enabled (W=1):

drivers/iio/light/bh1750.c:64:1: warning:
  ‘static’ is not at beginning of declaration [-Wold-style-declaration]

Related to commit 3a11fbb037a1 ("iio: light: add support for ROHM
BH1710/BH1715/BH1721/BH1750/BH1751 ambient light sensors").

Signed-off-by: Krzysztof Wilczynski <kw@linux.com>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/light/bh1750.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/bh1750.c b/drivers/iio/light/bh1750.c
index 8b4164343f20..0cf7032ccdc9 100644
--- a/drivers/iio/light/bh1750.c
+++ b/drivers/iio/light/bh1750.c
@@ -62,9 +62,9 @@ struct bh1750_chip_info {
 
 	u16 int_time_low_mask;
 	u16 int_time_high_mask;
-}
+};
 
-static const bh1750_chip_info_tbl[] = {
+static const struct bh1750_chip_info bh1750_chip_info_tbl[] = {
 	[BH1710] = { 140, 1022, 300, 400,  250000000, 2, 0x001F, 0x03E0 },
 	[BH1721] = { 140, 1020, 300, 400,  250000000, 2, 0x0010, 0x03E0 },
 	[BH1750] = { 31,  254,  69,  1740, 57500000,  1, 0x001F, 0x00E0 },
-- 
2.20.1



