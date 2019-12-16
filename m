Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81958C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5598421775
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576519587;
	bh=qfLIyuP8vUYwtGD85lTzXF8+5mCQRvrpZUQQVQpkGXw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YJfsXOubxh4YW4O88J+QiPwmWqM5eo2/LnIF1K9CNkz2XUu41dDkj2Qap+FmtMEXI
	 WiRj+gWCV+J8eeF3+pRWI7QPTmcwXMma8y+GZeOeLYiNikTiFvbQj47ykGRE48bgkg
	 cddUmodARkH6g3C+wsvHZEXpDMpjItqEbOnwmE80=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729976AbfLPSG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:06:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:46488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729700AbfLPSGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:06:22 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF0952166E;
        Mon, 16 Dec 2019 18:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576519582;
        bh=qfLIyuP8vUYwtGD85lTzXF8+5mCQRvrpZUQQVQpkGXw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uupPAW8VIgWOU5eSJRBZ85rmY/3zNz3vMTvu7TR0yMNEd8p2Jaas2Tn8nufoye3IH
         XaWBWAxefk/OcLOBexkaNA6kivIl097pVFQGWBh0CPfcKzDO6wLbpdIknIMElOI1Va
         ZEugfU5gaN4k+bSwD0SWCR5D6L8rDSR33cUB2R4g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        Pavel Machek <pavel@ucw.cz>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 124/140] power: supply: cpcap-battery: Fix signed counter sample register
Date:   Mon, 16 Dec 2019 18:49:52 +0100
Message-Id: <20191216174823.568255325@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174747.111154704@linuxfoundation.org>
References: <20191216174747.111154704@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit c68b901ac4fa969db8917b6a9f9b40524a690d20 ]

The accumulator sample register is signed 32-bits wide register on
droid 4. And only the earlier version of cpcap has a signed 24-bits
wide register. We're currently passing it around as unsigned, so
let's fix that and use sign_extend32() for the earlier revision.

Signed-off-by: Tony Lindgren <tony@atomide.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/cpcap-battery.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/cpcap-battery.c
index 3bae02380bb22..e183a22de7153 100644
--- a/drivers/power/supply/cpcap-battery.c
+++ b/drivers/power/supply/cpcap-battery.c
@@ -82,7 +82,7 @@ struct cpcap_battery_config {
 };
 
 struct cpcap_coulomb_counter_data {
-	s32 sample;		/* 24-bits */
+	s32 sample;		/* 24 or 32 bits */
 	s32 accumulator;
 	s16 offset;		/* 10-bits */
 };
@@ -213,7 +213,7 @@ static int cpcap_battery_get_current(struct cpcap_battery_ddata *ddata)
  * TI or ST coulomb counter in the PMIC.
  */
 static int cpcap_battery_cc_raw_div(struct cpcap_battery_ddata *ddata,
-				    u32 sample, s32 accumulator,
+				    s32 sample, s32 accumulator,
 				    s16 offset, u32 divider)
 {
 	s64 acc;
@@ -224,7 +224,6 @@ static int cpcap_battery_cc_raw_div(struct cpcap_battery_ddata *ddata,
 	if (!divider)
 		return 0;
 
-	sample &= 0xffffff;		/* 24-bits, unsigned */
 	offset &= 0x7ff;		/* 10-bits, signed */
 
 	switch (ddata->vendor) {
@@ -259,7 +258,7 @@ static int cpcap_battery_cc_raw_div(struct cpcap_battery_ddata *ddata,
 
 /* 3600000μAms = 1μAh */
 static int cpcap_battery_cc_to_uah(struct cpcap_battery_ddata *ddata,
-				   u32 sample, s32 accumulator,
+				   s32 sample, s32 accumulator,
 				   s16 offset)
 {
 	return cpcap_battery_cc_raw_div(ddata, sample,
@@ -268,7 +267,7 @@ static int cpcap_battery_cc_to_uah(struct cpcap_battery_ddata *ddata,
 }
 
 static int cpcap_battery_cc_to_ua(struct cpcap_battery_ddata *ddata,
-				  u32 sample, s32 accumulator,
+				  s32 sample, s32 accumulator,
 				  s16 offset)
 {
 	return cpcap_battery_cc_raw_div(ddata, sample,
@@ -312,6 +311,8 @@ cpcap_battery_read_accumulated(struct cpcap_battery_ddata *ddata,
 	/* Sample value CPCAP_REG_CCS1 & 2 */
 	ccd->sample = (buf[1] & 0x0fff) << 16;
 	ccd->sample |= buf[0];
+	if (ddata->vendor == CPCAP_VENDOR_TI)
+		ccd->sample = sign_extend32(24, ccd->sample);
 
 	/* Accumulator value CPCAP_REG_CCA1 & 2 */
 	ccd->accumulator = ((s16)buf[3]) << 16;
-- 
2.20.1



