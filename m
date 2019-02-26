Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DATE_IN_PAST_96_XX,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDAAC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 18:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B5A420645
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 18:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730933AbfCESIk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 13:08:40 -0500
Received: from mail1.bemta25.messagelabs.com ([195.245.230.3]:24953 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730891AbfCESIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 13:08:34 -0500
Received: from [46.226.52.98] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-a.eu-west-1.aws.symcld.net id 27/6E-26211-D1BBE7C5; Tue, 05 Mar 2019 18:08:29 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDIsWRWlGSWpSXmKPExsVy8IPnUV3Z3XU
  xBkdSLaY+fMJm8e1KB5PF5V1z2Cw+v9/P6sDisXPWXXaPTas62Tymz/nP6PF5k1wASxRrZl5S
  fkUCa8aKibuYCqbwVKzdc429gXEDVxcjF4eQwDpGiSvndrB3MXICORUSGw6fZO1i5ODgFUiWu
  NBWDRLmFHCUONi7jhWixEGi8fZfNhCbTcBQYt6b94wgNouAqsTKWZvA4sICnhKP5j0CGyki4C
  HRun0DM8guZoE+RonN5y+AFfEKCEqcnPmEBcRmFpCQOPjiBTPIXiEBLYnlxyJBwhIC9hLT318
  FC0sI6Es0HouFCBtKfJ/1jQXCNpe4vfoB6wRGwVlIhs5CMnQBI9MqRoukosz0jJLcxMwcXUMD
  A11DQyNdQ0tjXSNjE73EKt1EvdRS3fLU4hJdQ73E8mK94src5JwUvbzUkk2MwJBPKTj4agfjr
  hXphxglOZiURHk7d9XFCPEl5adUZiQWZ8QXleakFh9ilOHgUJLgdQDJCRalpqdWpGXmAKMPJi
  3BwaMkwlsOkuYtLkjMLc5Mh0idYtTlOL3w4VxmIZa8/LxUKXHeUzuBigRAijJK8+BGwBLBJUZ
  ZKWFeRgYGBiGegtSi3MwSVPlXjOIcjErCvNUgq3gy80rgNr0COoIJ6IjPl6tBjihJREhJNTD6
  1l7p3c2w6v8Li5oC95uhdx9oXpspeVNnucrHf9UFAZN+7j3sZG74TvjDrK1eTisunjTMWMH5s
  fCNd5795dgf9rMDJmzc8WLJy9oP57+ocWa9szhqx3HvkfKtiZnrLjFeqZQ9dYLznGR2veItU5
  UJ3i/fX2XMVSx8te23z6aMx8z7AiZMnvB/uRJLcUaioRZzUXEiABeECjT/AgAA
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-20.tower-262.messagelabs.com!1551809306!2441267!13
X-Originating-IP: [193.240.73.197]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 30328 invoked from network); 5 Mar 2019 18:08:28 -0000
Received: from unknown (HELO sw-ex-cashub01.diasemi.com) (193.240.73.197)
  by server-20.tower-262.messagelabs.com with AES128-SHA256 encrypted SMTP; 5 Mar 2019 18:08:28 -0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 SW-EX-CASHUB01.diasemi.com (10.20.16.140) with Microsoft SMTP Server id
 14.3.408.0; Tue, 5 Mar 2019 18:08:27 +0000
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 22547)      id
 425883FC15; Tue,  5 Mar 2019 18:08:25 +0000 (GMT)
Message-ID: <08948a3fe926ba9fbae124fa972df766820d3289.1551808797.git.stwiss.opensource@diasemi.com>
In-Reply-To: <cover.1551808797.git.stwiss.opensource@diasemi.com>
References: <cover.1551808797.git.stwiss.opensource@diasemi.com>
From:   Steve Twiss <stwiss.opensource@diasemi.com>
Date:   Tue, 26 Feb 2019 15:48:46 +0000
Subject: [PATCH 11/13] regulator: wm831x: Fix notifier mutex lock warning
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

Fixes: e4ee831f949a ("regulator: Add WM831x DC-DC buck convertor support")
Suggested-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
---
 drivers/regulator/wm831x-dcdc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/regulator/wm831x-dcdc.c b/drivers/regulator/wm831x-dcdc.c
index 5a5bc4b..4f5461a 100644
--- a/drivers/regulator/wm831x-dcdc.c
+++ b/drivers/regulator/wm831x-dcdc.c
@@ -183,9 +183,11 @@ static irqreturn_t wm831x_dcdc_uv_irq(int irq, void *data)
 {
 	struct wm831x_dcdc *dcdc = data;
 
+	regulator_lock(dcdc->regulator);
 	regulator_notifier_call_chain(dcdc->regulator,
 				      REGULATOR_EVENT_UNDER_VOLTAGE,
 				      NULL);
+	regulator_unlock(dcdc->regulator);
 
 	return IRQ_HANDLED;
 }
@@ -194,9 +196,11 @@ static irqreturn_t wm831x_dcdc_oc_irq(int irq, void *data)
 {
 	struct wm831x_dcdc *dcdc = data;
 
+	regulator_lock(dcdc->regulator);
 	regulator_notifier_call_chain(dcdc->regulator,
 				      REGULATOR_EVENT_OVER_CURRENT,
 				      NULL);
+	regulator_unlock(dcdc->regulator);
 
 	return IRQ_HANDLED;
 }
-- 
1.9.3

