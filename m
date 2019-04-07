Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6FC7C10F0E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 08:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91489213F2
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 08:20:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbfDGIUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 04:20:47 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:32849 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725966AbfDGIUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 04:20:47 -0400
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id x377nY46006873;
        Sun, 7 Apr 2019 10:49:34 +0300
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 1F71763000; Sun,  7 Apr 2019 11:19:31 +0300 (IDT)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     gregkh@linuxfoundation.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, yuenn@google.com,
        venture@google.com, brendanhiggins@google.com,
        avifishman70@gmail.com, joel@jms.id.au
Cc:     linux-iio@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v1] iio: adc: modify NPCM ADC read reference voltage
Date:   Sun,  7 Apr 2019 11:19:28 +0300
Message-Id: <20190407081928.72250-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checking if regulator is valid before reading
NPCM ADC regulator voltage to avoid system crash
in a case the regulator is not valid.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 drivers/iio/adc/npcm_adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/npcm_adc.c b/drivers/iio/adc/npcm_adc.c
index 9e25bbec9c70..193b3b81de4d 100644
--- a/drivers/iio/adc/npcm_adc.c
+++ b/drivers/iio/adc/npcm_adc.c
@@ -149,7 +149,7 @@ static int npcm_adc_read_raw(struct iio_dev *indio_dev,
 		}
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-		if (info->vref) {
+		if (!IS_ERR(info->vref)) {
 			vref_uv = regulator_get_voltage(info->vref);
 			*val = vref_uv / 1000;
 		} else {
-- 
2.14.1

