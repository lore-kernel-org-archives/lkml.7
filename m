Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DATE_IN_PAST_96_XX,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3CEBC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 18:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD23A20842
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 18:08:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730946AbfCESIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 13:08:42 -0500
Received: from mail1.bemta25.messagelabs.com ([195.245.230.2]:11250 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730887AbfCESIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 13:08:34 -0500
Received: from [46.226.52.98] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-a.eu-west-1.aws.symcld.net id CC/2D-18573-D1BBE7C5; Tue, 05 Mar 2019 18:08:29 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHIsWRWlGSWpSXmKPExsVy8IPnUV2Z3XU
  xBnMeGVlMffiEzeLblQ4mi8u75rBZfH6/n9WBxWPnrLvsHptWdbJ5TJ/zn9Hj8ya5AJYo1sy8
  pPyKBNaMS//fMBcc5qyY+XoGSwPjXI4uRi4OIYF1jBJXzu1g72LkBHIqJPat+8IIYvMKJEtMO
  bGLGcTmFHCUONi7jhWixkGi8fZfNhCbTcBQYt6b92D1LAKqEnvPTQerERYIkFh05yqYLSLgId
  G6fQMzyDJmgT5Gic3nL7BBLBCUODnzCQuIzSwgIXHwxQugIg6gBVoSy49FgoQlBOwlpr+/Cha
  WENCXaDwWCxE2lPg+6xsLhG0ucXv1A9YJjIKzkAydhWToAkamVYwWSUWZ6RkluYmZObqGBga6
  hoZGuoaWxkBsppdYpZuol1qqW55aXKJrqJdYXqxXXJmbnJOil5dasokRGPYpBQeP7GDcsCL9E
  KMkB5OSKG9fV12MEF9SfkplRmJxRnxRaU5q8SFGGQ4OJQleh11AOcGi1PTUirTMHGAEwqQlOH
  iURHjFdwKleYsLEnOLM9MhUqcYdTlOL3w4l1mIJS8/L1VKnPcUSJEASFFGaR7cCFgyuMQoKyX
  My8jAwCDEU5BalJtZgir/ilGcg1FJmJcFZApPZl4J3KZXQEcwAR3x+XI1yBEliQgpqQbGgBqR
  PMXVy/TvMsWrfkw1vhGY9ujgo18rFF/3dUo81mo9q/W7gv+O2dT7RqcTD9wNZQpeIOBd9pnhV
  zI72/Gogi3HtMKbPr+8KyYW+y/6RY5fBO+VHdlLbLTPmj8xqwxrqkw9/1t59orTarPeST4TVP
  tb9If1WeUTF7Unb52jX3/xmHsq7cduJZbijERDLeai4kQAY453DQEDAAA=
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-20.tower-262.messagelabs.com!1551809306!2441267!12
X-Originating-IP: [193.240.73.197]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 30312 invoked from network); 5 Mar 2019 18:08:28 -0000
Received: from unknown (HELO sw-ex-cashub01.diasemi.com) (193.240.73.197)
  by server-20.tower-262.messagelabs.com with AES128-SHA256 encrypted SMTP; 5 Mar 2019 18:08:28 -0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 SW-EX-CASHUB01.diasemi.com (10.20.16.140) with Microsoft SMTP Server id
 14.3.408.0; Tue, 5 Mar 2019 18:08:27 +0000
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 22547)      id
 44F443FC16; Tue,  5 Mar 2019 18:08:25 +0000 (GMT)
Message-ID: <f3e0a68a956e63e46cfa22de3716ab24f422edf9.1551808797.git.stwiss.opensource@diasemi.com>
In-Reply-To: <cover.1551808797.git.stwiss.opensource@diasemi.com>
References: <cover.1551808797.git.stwiss.opensource@diasemi.com>
From:   Steve Twiss <stwiss.opensource@diasemi.com>
Date:   Tue, 26 Feb 2019 15:51:28 +0000
Subject: [PATCH 12/13] regulator: wm831x isink: Fix notifier mutex lock
 warning
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     Support Opensource <support.opensource@diasemi.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Cirrus Patches <patches@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-ServerInfo: sw-ex-cashub01.diasemi.com, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 05/03/2019 17:23:00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mutex for the regulator_dev must be controlled by the caller of
the regulator_notifier_call_chain(), as described in the comment
for that function.

Failure to mutex lock and unlock surrounding the notifier call results
in a kernel WARN_ON_ONCE() which will dump a backtrace for the
regulator_notifier_call_chain() when that function call is first made.
The mutex can be controlled using the regulator_lock/unlock() API.

Fixes: d4d6b722e780 ("regulator: Add WM831x ISINK support")
Suggested-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
---
 drivers/regulator/wm831x-isink.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/regulator/wm831x-isink.c b/drivers/regulator/wm831x-isink.c
index 6dd891d..11f3511 100644
--- a/drivers/regulator/wm831x-isink.c
+++ b/drivers/regulator/wm831x-isink.c
@@ -140,9 +140,11 @@ static irqreturn_t wm831x_isink_irq(int irq, void *data)
 {
 	struct wm831x_isink *isink = data;
 
+	regulator_lock(isink->regulator);
 	regulator_notifier_call_chain(isink->regulator,
 				      REGULATOR_EVENT_OVER_CURRENT,
 				      NULL);
+	regulator_unlock(isink->regulator);
 
 	return IRQ_HANDLED;
 }
-- 
1.9.3

