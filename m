Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38389C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 17:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14AB721925
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 17:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569778822;
	bh=SZIa8j9CJhCBRyj+SHTyx1EHRbuknY5E3dcb6CrkBkc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BjCFrc2Cw0CAzaXbE87Aydgg5LTdImns6gQ4igCfMcX5VXYigq6QQV3LESmf9HUuE
	 J+qXLovDj+Ky3VULlD4aw7qj4KX/kXktbMT29k78xZDFjalfQgfbWPZhajRYNXeUSU
	 t7QxFodQC/rz2mRb0RgvipG0xeX7YaqpHp87KG5Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729771AbfI2RkV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 13:40:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:47012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730476AbfI2Rey (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 13:34:54 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21CBD2196E;
        Sun, 29 Sep 2019 17:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569778493;
        bh=SZIa8j9CJhCBRyj+SHTyx1EHRbuknY5E3dcb6CrkBkc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vNCYxsOsSScyb6Uw2aIL/ruI8eQQ/HqNmRHsCzHHj4ju0/h/T2Kjr4rXaDjUZTDpY
         JcqIOGZMpO4PDuCBH0QXtkOsldyLr0xAjX9I3ZaOLYJuBUY31xDajBRV+kUyVbPvrO
         dP8iyxzbp788QZyXIpe5eJjvbgy51vEUOQ37+oTc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Biwen Li <biwen.li@nxp.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <sashal@kernel.org>, linux-rtc@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 15/33] rtc: pcf85363/pcf85263: fix regmap error in set_time
Date:   Sun, 29 Sep 2019 13:34:03 -0400
Message-Id: <20190929173424.9361-15-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190929173424.9361-1-sashal@kernel.org>
References: <20190929173424.9361-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Biwen Li <biwen.li@nxp.com>

[ Upstream commit 7ef66122bdb3b839e9f51b76d7e600b6e21ef648 ]

Issue:
    - # hwclock -w
      hwclock: RTC_SET_TIME: Invalid argument

Why:
    - Relative commit: 8b9f9d4dc511 ("regmap: verify if register is
      writeable before writing operations"), this patch
      will always check for unwritable registers, it will compare reg
      with max_register in regmap_writeable.

    - The pcf85363/pcf85263 has the capability of address wrapping
      which means if you access an address outside the allowed range
      (0x00-0x2f) hardware actually wraps the access to a lower address.
      The rtc-pcf85363 driver will use this feature to configure the time
      and execute 2 actions in the same i2c write operation (stopping the
      clock and configure the time). However the driver has also
      configured the `regmap maxregister` protection mechanism that will
      block accessing addresses outside valid range (0x00-0x2f).

How:
    - Split of writing regs to two parts, first part writes control
      registers about stop_enable and resets, second part writes
      RTC time and date registers.

Signed-off-by: Biwen Li <biwen.li@nxp.com>
Link: https://lore.kernel.org/r/20190829021418.4607-1-biwen.li@nxp.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/rtc/rtc-pcf85363.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-pcf85363.c b/drivers/rtc/rtc-pcf85363.c
index c04a1edcd5716..c3702684b3426 100644
--- a/drivers/rtc/rtc-pcf85363.c
+++ b/drivers/rtc/rtc-pcf85363.c
@@ -169,7 +169,12 @@ static int pcf85363_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	buf[DT_YEARS] = bin2bcd(tm->tm_year % 100);
 
 	ret = regmap_bulk_write(pcf85363->regmap, CTRL_STOP_EN,
-				tmp, sizeof(tmp));
+				tmp, 2);
+	if (ret)
+		return ret;
+
+	ret = regmap_bulk_write(pcf85363->regmap, DT_100THS,
+				buf, sizeof(tmp) - 2);
 	if (ret)
 		return ret;
 
-- 
2.20.1

