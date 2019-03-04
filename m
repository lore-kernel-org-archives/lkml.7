Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F779C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4730320830
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:03:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbfCDUDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 15:03:44 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:52945 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfCDUDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 15:03:41 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MFKbB-1glHpP2plR-00FgVC; Mon, 04 Mar 2019 21:03:18 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: fix uninitialized variable warning
Date:   Mon,  4 Mar 2019 21:03:07 +0100
Message-Id: <20190304200317.1229196-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:dKyJTi6zwvLIK6HWRwyR2h8jCFc+6JgkVrmI6oCJE+Zv3s6Bw1W
 6BgDkjUaHWD40RaOBGd5MwMa8hOL131etmqlz7VRGWesmueGDx1ta0cmTEiGCE8XEXJWK7U
 BJDZtvfzEZE/rckNNlAci6kqHj5khzi4r0Gw0Iag6OFNnF0vfURjF39duyR5hTiZOvnNf+0
 9Px2loGkdKeeoIt9ZYoaQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kn8eG3ON4tA=:E3xXcuWYg6ajevejuU4S2i
 KIh5gegm6VK3vj49J4KUrZMJ/3++YCiw1WZQ59r3oOvOjlnCAcHlVGOI8wYzMVdnBQ48sZxu0
 Zdq16Swx1Vg8QY5NdRIBlwunOMooQaAIuq60v1gFqI7IxcSmYiRspWw1a18nm8UPaw+fh5b42
 Uj/c+mVtvHEOm9Z7nDYA0qsG6iOqocl5pxasJ5JE50zfobEbklUsgm3iN67JSlb3F95Y9EHog
 cTDnso/hKlshEHwPGb2Nqiasl6tiUKrHpe5fNaUxodRt49RbI1A2V9sQgGxQ5Ka+5dES3OTZn
 Mq67Vg9BLfr90yxwlNDIFk5WmPET1rELhCfQ9r+aPXb9k0ruXiVPLZLD+ArInck9sH4gX6pHN
 dUon9JYGTKL6Z5ZOL1cITMd/Y4acQyLLo6YpCHVXNY6rF7tDUYYeCoxhr9o+TSKx+yJX5dFg5
 1/gfGyV2ZhjBKqAtabY8Xx4PqYsjnYt8e7ODpQhyEqg3xuuargLvM7tnJRpDsQnjOXI/arx84
 pqF8g0k45GYaNwnm/DBel9D3+AhgbciHa44hQeQDddqMRGFjKus3NLqGou7Ki0ziRxs1W933S
 0q2PxZE5FnmXMtnYrcx9FVN10/6mM+wY1/Awk+l1VkuUwncVAEAoXqksh/5soYVphSHMCgp8p
 WeR2tRTLEIkhquL26Ogn6w3PwJN6PmgJSZNkurcxbA4YR9D9obLOwAcsm/EK9Hl/LAZ94VprZ
 QsLvmVVgXtxf3HvRh/S12i0RQJRZYqOV2sF+Pg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pm8xxx_xoadc_probe() function triggers a bogus warning
about an uninitialized variable:

drivers/iio/adc/qcom-pm8xxx-xoadc.c: In function 'pm8xxx_xoadc_probe':
drivers/iio/adc/qcom-pm8xxx-xoadc.c:633:8: error: 'ch' may be used uninitialized in this function [-Werror=maybe-uninitialized]

Reword the function so the compiler can see more easily that it
is always initialized.

Fixes: 63c3ecd946d4 ("iio: adc: add a driver for Qualcomm PM8xxx HK/XOADC")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/iio/adc/qcom-pm8xxx-xoadc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/adc/qcom-pm8xxx-xoadc.c b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
index c30c002f1fef..7939238001c8 100644
--- a/drivers/iio/adc/qcom-pm8xxx-xoadc.c
+++ b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
@@ -423,7 +423,7 @@ static irqreturn_t pm8xxx_eoc_irq(int irq, void *d)
 static struct pm8xxx_chan_info *
 pm8xxx_get_channel(struct pm8xxx_xoadc *adc, u8 chan)
 {
-	struct pm8xxx_chan_info *ch;
+	struct pm8xxx_chan_info *ch = NULL;
 	int i;
 
 	for (i = 0; i < adc->nchans; i++) {
@@ -431,8 +431,6 @@ pm8xxx_get_channel(struct pm8xxx_xoadc *adc, u8 chan)
 		if (ch->hwchan->amux_channel == chan)
 			break;
 	}
-	if (i == adc->nchans)
-		return NULL;
 
 	return ch;
 }
-- 
2.20.0

