Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A0BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDB1D20880
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbfCRPu6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 11:50:58 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.130]:6601 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726513AbfCRPu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 11:50:58 -0400
Received: from [46.226.53.50] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-c.eu-west-1.aws.symcld.net id 87/21-27207-F5EBF8C5; Mon, 18 Mar 2019 15:50:55 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJIsWRWlGSWpSXmKPExsVy8IPnUd34ff0
  xBgv/KVpMffiEzWL1x8eMFt+udDBZXN41h82i/+IsVgdWj52z7rJ7bFrVyebx7Ecbm8fnTXIB
  LFGsmXlJ+RUJrBkXJ8YW7Oes2P4sqIGxl6OLkYtDSGA9o8T9J51MXYycQE6FxMQFB8FsNgFDi
  Xlv3jOC2CwCqhKT+veyg9jCAiESm5afZgOxRQQ8JFq3b2AGGcQssIJR4vqPU2BFvAIOEmde3G
  CEsAUlTs58wgJiMwtISBx88QKogQNomZbE8mORIGEJAXuJ6e+vgoUlBPQlGo/FQoQNJb7P+sY
  CYZtLPFi0nmUCI/8sJENnIRm6gJFpFaNFUlFmekZJbmJmjq6hgYGuoaGRrpEBEJuY6yVW6Sbr
  pZbqlqcWl+ga6iWWF+sVV+Ym56To5aWWbGIEBnNKwanvOxiXrEg/xCjJwaQkyvtlZ3+MEF9Sf
  kplRmJxRnxRaU5q8SFGGQ4OJQneZXuAcoJFqempFWmZOcC4gklLcPAoifDag6R5iwsSc4sz0y
  FSpxh1OR62fp7LLMSSl5+XKiXOa7wXqEgApCijNA9uBCzGLzHKSgnzMjIwMAjxFKQW5WaWoMq
  /YhTnYFQS5l0JsoonM68EbtMroCOYgI5YNw/siJJEhJRUA6P2tfRjMfIsnVEHH8VFKMxsOF3g
  9/hHS0asavBn/279ea/KF18piXx8b1Hkmf9rrXb2PrTYcOxTjbvvlfRO87wPvPeWVf66K3Fk7
  uLyjkOS4Uo9rWaspltNbrTMutP1cAL3KSY5Tsm4Y//6k5mvvOveyfBq0570Z2vMgn+LT+p6+Y
  Q3RaHqeYsSS3FGoqEWc1FxIgASrVsA7AIAAA==
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-13.tower-302.messagelabs.com!1552924255!4098769!1
X-Originating-IP: [193.240.73.197]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 23052 invoked from network); 18 Mar 2019 15:50:55 -0000
Received: from unknown (HELO sw-ex-cashub01.diasemi.com) (193.240.73.197)
  by server-13.tower-302.messagelabs.com with AES128-SHA256 encrypted SMTP; 18 Mar 2019 15:50:55 -0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 SW-EX-CASHUB01.diasemi.com (10.20.16.140) with Microsoft SMTP Server id
 14.3.408.0; Mon, 18 Mar 2019 15:50:54 +0000
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 22547)      id
 59B483FBD8; Mon, 18 Mar 2019 15:50:54 +0000 (GMT)
From:   Steve Twiss <stwiss.opensource@diasemi.com>
Date:   Mon, 18 Mar 2019 15:32:01 +0000
Subject: [PATCH] regulator: core: fix error path for
 regulator_set_voltage_unlocked
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Maciej Purski <m.purski@samsubg.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Support Opensource <support.opensource@diasemi.com>
Message-ID: <20190318155054.59B483FBD8@swsrvapps-01.diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-ServerInfo: sw-ex-cashub01.diasemi.com, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 18/03/2019 13:18:00
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
Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
---
 drivers/regulator/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 68473d0..caf8743 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -3326,7 +3326,7 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
 		goto out2;
 
 out:
-	return 0;
+	return ret;
 out2:
 	voltage->min_uV = old_min_uV;
 	voltage->max_uV = old_max_uV;
-- 
1.9.3

