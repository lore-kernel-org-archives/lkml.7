Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D9FDC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 737882183E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388431AbfDRJPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 05:15:17 -0400
Received: from lizzard.sbs.de ([194.138.37.39]:41633 "EHLO lizzard.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbfDRJPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 05:15:16 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id x3I9F53j004674
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Apr 2019 11:15:05 +0200
Received: from [139.25.68.37] (md1q0hnc.ad001.siemens.net [139.25.68.37] (may be forged))
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id x3I9F5qm010308;
        Thu, 18 Apr 2019 11:15:05 +0200
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-serial@vger.kernel.org,
        Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Su Bao Cheng <baocheng.su@siemens.com>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] serial: 8250_exar: Adjust IOT2000 matching
Message-ID: <ac8f8999-44b9-e364-4582-3b0ee735f6a8@siemens.com>
Date:   Thu, 18 Apr 2019 11:15:04 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); de; rv:1.8.1.12)
 Gecko/20080226 SUSE/2.0.0.12-1.1 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Su Bao Cheng <baocheng.su@siemens.com>

Since there are more IOT2040 variants with identical hardware but
different asset tags, the asset tag matching should be adjusted to
support them.

As only the IOT2040 variants have the Exar chip on board, matching on
their board name is enough. In the future there will be no other devices
with the "SIMATIC IOT2000" DMI board name but different hardware.

Signed-off-by: Su Bao Cheng <baocheng.su@siemens.com>
Reviewed-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 drivers/tty/serial/8250/8250_exar.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 0089aa305ef9..edd6dfe055bf 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -361,12 +361,15 @@ static const struct exar8250_platform iot2040_platform = {
 	.register_gpio = iot2040_register_gpio,
 };
 
+/*
+ * For SIMATIC IOT2000, only IOT2040 and its variants have the Exar device,
+ * IOT2020 doesn't have. Therefore it is sufficient to match on the common
+ * board name after the device was found.
+ */
 static const struct dmi_system_id exar_platforms[] = {
 	{
 		.matches = {
 			DMI_EXACT_MATCH(DMI_BOARD_NAME, "SIMATIC IOT2000"),
-			DMI_EXACT_MATCH(DMI_BOARD_ASSET_TAG,
-					"6ES7647-0AA00-1YA2"),
 		},
 		.driver_data = (void *)&iot2040_platform,
 	},
-- 
2.16.4
