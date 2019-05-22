Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B05C072A4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 08:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E25F21019
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 08:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728823AbfEVI1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 04:27:07 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44254 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728406AbfEVI1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 04:27:07 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hTMZv-0008N0-E9; Wed, 22 May 2019 08:26:27 +0000
From:   Colin King <colin.king@canonical.com>
To:     Dan Murphy <dmurphy@ti.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] leds: TI LMU: remove redundant u8 comparisons with less than zero
Date:   Wed, 22 May 2019 09:26:27 +0100
Message-Id: <20190522082627.18354-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The u8 variables ramp_up and ramp_down are being compared to less
than zero, this will always be false. Code is redundant so remove
it.

Addresses-Coverity: ("Unsigned compared against 0")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/leds/leds-ti-lmu-common.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/leds/leds-ti-lmu-common.c b/drivers/leds/leds-ti-lmu-common.c
index adc7293004f1..6db47accfe62 100644
--- a/drivers/leds/leds-ti-lmu-common.c
+++ b/drivers/leds/leds-ti-lmu-common.c
@@ -94,9 +94,6 @@ int ti_lmu_common_set_ramp(struct ti_lmu_bank *lmu_bank)
 		ramp_down = ti_lmu_common_convert_ramp_to_index(lmu_bank->ramp_down_usec);
 	}
 
-	if (ramp_up < 0 || ramp_down < 0)
-		return -EINVAL;
-
 	ramp = (ramp_up << 4) | ramp_down;
 
 	return regmap_write(regmap, lmu_bank->runtime_ramp_reg, ramp);
-- 
2.20.1

