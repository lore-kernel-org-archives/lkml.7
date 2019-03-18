Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB7BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 16:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D658B2133D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 16:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbfCRQbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 12:31:38 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.115]:51918 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726808AbfCRQbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 12:31:37 -0400
Received: from [85.158.142.201] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-b.eu-central-1.aws.symcld.net id 9D/CB-03001-6E7CF8C5; Mon, 18 Mar 2019 16:31:34 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRWlGSWpSXmKPExsVy8IPnUd2nx/t
  jDP73GVlMffiEzWL1x8eMFt+udDBZXN41h82i/+IsVgdWj52z7rJ7bFrVyebx7Ecbm8fnTXIB
  LFGsmXlJ+RUJrBnr1s9nK7jEXXH/9332BsZ3nF2MXBxCAusZJTZOPsLcxcgJ5FRItMzoYAOx2
  QQMJea9ec8IYrMIqEpMvTIDrEZYIFyi9UgnO4gtIuAh0bp9AzPIIGaBFYwS13+cAkvwCjhILF
  +5CMoWlDg58wkLiM0sICFx8MULoAYOoGVaEsuPRYKEJQTsJaa/vwoWlhDQl2g8FgsRNpT4Pus
  bC4RtLrG/cR3TBEb+WUiGzkIydAEj0ypGy6SizPSMktzEzBxdQwMDXUNDY10TXUNLM73EKt0k
  vdRS3eTUvJKiRKCsXmJ5sV5xZW5yTopeXmrJJkZgSKcUshzZwfi+Pf0QoyQHk5Ior+mx/hghv
  qT8lMqMxOKM+KLSnNTiQ4wyHBxKEryhIDnBotT01Iq0zBxgdMGkJTh4lER4Q4ARJsRbXJCYW5
  yZDpE6xajL8bD181xmIZa8/LxUKXFea5AiAZCijNI8uBGwSL/EKCslzMvIwMAgxFOQWpSbWYI
  q/4pRnINRSZg3HuQSnsy8ErhNr4COYAI6Yt08sCNKEhFSUg2Mkmt3sX26uXKSftOSqdKrb1/x
  Stwg//dPk+zRQ+fOr/7uEmESm/bZM7j1qfHfvdstw7om762cqrTiNrv3Epe3+4oYwnOaFl3/V
  vTUknd/ZKcY05Tl0a/e79zsK7mZI65zJ+dFhUlXX4dn9T2x+/JGZ8eqq+JL8q8qNu9PufDsbq
  deIfPuf/trZyuxFGckGmoxFxUnAgB0bodH7wIAAA==
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-6.tower-246.messagelabs.com!1552926693!3116061!1
X-Originating-IP: [193.240.73.197]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 3258 invoked from network); 18 Mar 2019 16:31:33 -0000
Received: from unknown (HELO sw-ex-cashub01.diasemi.com) (193.240.73.197)
  by server-6.tower-246.messagelabs.com with AES128-SHA256 encrypted SMTP; 18 Mar 2019 16:31:33 -0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 SW-EX-CASHUB01.diasemi.com (10.20.16.140) with Microsoft SMTP Server id
 14.3.408.0; Mon, 18 Mar 2019 16:31:32 +0000
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 22547)      id
 1BB633FBA2; Mon, 18 Mar 2019 16:31:32 +0000 (GMT)
From:   Steve Twiss <stwiss.opensource@diasemi.com>
Date:   Mon, 18 Mar 2019 16:17:57 +0000
Subject: [PATCH v2] regulator: core: fix error path for
 regulator_set_voltage_unlocked
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Maciej Purski <m.purski@samsubg.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Support Opensource <support.opensource@diasemi.com>
Message-ID: <20190318163132.1BB633FBA2@swsrvapps-01.diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-ServerInfo: sw-ex-cashub01.diasemi.com, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 18/03/2019 14:58:00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During several error paths in the function
regulator_set_voltage_unlocked() the value of 'ret' can take on negative
error values. However, in calls that go through the 'goto out' statement,
this return value is lost and return 0 is used instead, indicating a
'pass'.

There are several cases where this function should legitimately return a
fail instead of a pass: one such case includes constraints check during
voltage selection in the call to regulator_check_voltage(), which can
have -EINVAL for the case when an unsupported voltage is incorrectly
requested. In that case, -22 is expected as the return value, not 0.

Fixes: 9243a195be7a ("regulator: core: Change voltage setting path")
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
---
 drivers/regulator/core.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 68473d0..968dcd9 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -3322,15 +3322,12 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
 
 	/* for not coupled regulators this will just set the voltage */
 	ret = regulator_balance_voltage(rdev, state);
-	if (ret < 0)
-		goto out2;
+	if (ret < 0) {
+		voltage->min_uV = old_min_uV;
+		voltage->max_uV = old_max_uV;
+	}
 
 out:
-	return 0;
-out2:
-	voltage->min_uV = old_min_uV;
-	voltage->max_uV = old_max_uV;
-
 	return ret;
 }
 
-- 
1.9.3

