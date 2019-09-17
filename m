Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B80C4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 09:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2186020862
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 09:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729025AbfIQJl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 05:41:56 -0400
Received: from esa1.mentor.iphmx.com ([68.232.129.153]:59521 "EHLO
        esa1.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbfIQJlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 05:41:55 -0400
IronPort-SDR: h+f8eAdXMEpt3M/xWQI43brTxySYkFPubScoLZAnapYvkjDLW05KIw6UrVSuCfZrlcgZBs6JBf
 Nmxv72na5ahAzQU0XOT3aJtJDaf8kqEqeo1Zrh3TQmj/ji6gFttjFBDDTw5iCF9nIEHXBwa1i1
 61B+zYMfwtSdwN1Vm+YiNlkaamiz5CTZMvHtY0UScm1tOgk2WbzMquTpkc1i0deHIN+fRoczBP
 b8Fw9SqgRaXd4LQ4pPm44PJeR9j5yknLrInyIZ5aSH1jWjJrgdWp3I3DVbQPTxkHeUmuht78MS
 ycw=
X-IronPort-AV: E=Sophos;i="5.64,515,1559548800"; 
   d="scan'208";a="43223206"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa1.mentor.iphmx.com with ESMTP; 17 Sep 2019 01:41:54 -0800
IronPort-SDR: 13LxyqrJqej512kgfwMyxMFbe+/u+fp7/vyeuVHsibgEDnmBI57oXqX9K9K55DxzCukrUoKTyR
 71lK/PWPQs4R7L3pzC8Ud5LGC+fS643FCP0CoWS0Ft9Y95MHSJAfg4mijXVN+T3Rz0XQT40wBf
 rxTWj+dKsoznfTwCcQuBaFuyDphi/r2PtVkLQdkm7uZ2uGkOmYYo6ODVJBk6Uxp2w9IdOKJW1g
 zVl3e5hWWT4VCT1mPimkcfYVhxGZQOGBHi/8VBxQ4+LK5IoIVZE5EDaNAlpSJOuBmnOmgDVRiM
 XQo=
From:   Jiada Wang <jiada_wang@mentor.com>
To:     <nick@shmanahar.org>, <dmitry.torokhov@gmail.com>,
        <jikos@kernel.org>, <benjamin.tissoires@redhat.com>,
        <rydberg@bitmath.org>
CC:     <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jiada_wang@mentor.com>
Subject: [PATCH v3 35/49] input: atmel_mxt_ts: Add Missing Delay for reset handling of Atmel touch panel controller in detachable displays.
Date:   Tue, 17 Sep 2019 18:41:23 +0900
Message-ID: <20190917094137.18851-2-jiada_wang@mentor.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190917094137.18851-1-jiada_wang@mentor.com>
References: <20190917094137.18851-1-jiada_wang@mentor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: svr-orw-mbx-04.mgc.mentorg.com (147.34.90.204) To
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: keerthikumarp <Keerthikumar.Padmanabha@in.bosch.com>

In case of attached display, the touchpanel reset is controlled
via imx gpio's from  atmel driver and the delay between
touchpanel reset and the time at which the chip becomes capable to
communicate with the host processor, has be taken care.

However in case of detachable displays, the touchpanel reset is
controlled via a deserializer gpio which is triggered just before
the atmel driver is probed.The delay between touchpanel reset and
the time at which the chip becomes capable to communicate (as
specified in datasheet) was not being accounted for. This patch
introduces that delay.

Signed-off-by: keerthikumarp <Keerthikumar.Padmanabha@in.bosch.com>
Signed-off-by: George G. Davis <george_davis@mentor.com>
Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 4670880e52a2..4fa27e2f7163 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -4113,6 +4113,10 @@ static int mxt_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		msleep(MXT_RESET_GPIO_TIME);
 		gpiod_set_value(data->reset_gpio, 1);
 		msleep(MXT_RESET_INVALID_CHG);
+	} else {
+		dev_dbg(&client->dev,
+			"atmel reset pin not found in device tree");
+		msleep(MXT_RESET_TIME);
 	}
 
 	error = mxt_initialize(data);
-- 
2.19.2

