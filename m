Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24722C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 17:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE8192082F
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 17:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="uB0pEDFq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbfI2RJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 13:09:20 -0400
Received: from mx5.ucr.edu ([138.23.62.67]:52283 "EHLO mx5.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbfI2RJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 13:09:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1569776959; x=1601312959;
  h=from:to:cc:subject:date:message-id;
  bh=fmr7YP/ut3UpiMsxws7I4CnuC7FsVpaYEYfqva0mvp4=;
  b=uB0pEDFq75OutIaa4lqusFdH6JJUf9j2AzEIp3GBcxycg8ovki9qTqfo
   hkbkXmmzRjm2tYpXQqPcGRIW4dW1l6YsDPaBWHEQe/EmpP+X13CqQ7Hf8
   8tGG63xNr8p2bbVgZkJzDbwc9FJPVp+45A+iV5L4SjJN0QuJ7elQFLP8z
   rJ9hOYK9mc5Z+FGMmA4qQmXgf+/m0e36+2GVC0eRCAjeV5YdiCZb4wmdn
   ToZjIWaZSGsEpmUcUy3BOkdLu39KISbrH0zCSdr62ifqGCATSdSx4cvTC
   5G/i1oJcG7L59qYRSBSIgaA0Yts4WN7GeslQvDdakunBmgj6zPNIDetvJ
   Q==;
IronPort-SDR: bnKKeyQGJjkr20CoJj2Sdd4fg6UGUv2EoMENcNGXu1ryJIbPyTKoAo3HV9Em5sbp/VlazvPC7k
 RRZdVFOZbXbii8IglmHLIaOD/AzczPs4AX3HPENWZ5v/vDw69h82hzpA5RiW3lZ6v2SbqO121U
 3z7BCHR7sh73uIJFWKfA/b6GUCdafXMCTHYXBmf5MrbhJX0Q3KrNnWjB1rf0y1EjCFDLPgwbB7
 Nm0ZinlZ/m/3tXVtHSFx6/6xlBO90bMCFztZtd07ju/6VnmELmuxdU3rtQbCGxFRULM/lmvNwY
 SOs=
IronPort-PHdr: =?us-ascii?q?9a23=3Azj+bFxI6IGTNlN9G6dmcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgRI/jxwZ3uMQTl6Ol3ixeRBMOHsqkC17Kd6vixEUU7or+5+EgYd5JNUx?=
 =?us-ascii?q?JXwe43pCcHRPC/NEvgMfTxZDY7FskRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQ?=
 =?us-ascii?q?viPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCezbL9oIxi6sQrdutQKjYZmN6081g?=
 =?us-ascii?q?bHrnxUdupM2GhmP0iTnxHy5sex+J5s7SFdsO8/+sBDTKv3Yb02QaRXAzo6PW?=
 =?us-ascii?q?814tbrtQTYQguU+nQcSGQWnQFWDAXD8Rr3Q43+sir+tup6xSmaIcj7Rq06VD?=
 =?us-ascii?q?i+86tmTgLjhTwZPDAl7m7Yls1wjLpaoB2/oRx/35XUa5yROPZnY6/RYc8WSW?=
 =?us-ascii?q?9HU8ZUVixBGZi8b4oJD+oOIO1WsZDzrEYArRu/GwasAP7gwSJMinL4waE21u?=
 =?us-ascii?q?IsGhzE0gM9BdIDqHTaosvoOqkcUu67y7LFwSnfY/5MxTvw8pTEfgwnrPqRXb?=
 =?us-ascii?q?xwa83RyUw3GgzHj1WRqIzlPy6S1u8QtGWa7+thVeK1hG4mtw19vjaiy9wxio?=
 =?us-ascii?q?bVnIIZ0E7L+jhkwIssI9CzVU11Yca8HZdOqy2XM5F6T8AiTm1ypio2170LtY?=
 =?us-ascii?q?SmcCUOzJkr3wPTZv2DfoSS/B7uWuacLS1miH9kYr6yhRm//E69wePmTMa0yk?=
 =?us-ascii?q?xFri9dn9nJsXACygLc59CcSvt44kehwTGP1x3P6u1cIUA7i67bK5k5z741jJ?=
 =?us-ascii?q?UTsEDDEjbumEX5kaOab0sk9vWs5unjeLnmqZicN4h7igH6LKsigNCwAeM9Mg?=
 =?us-ascii?q?QWXmib//qz1KH78EHnXLlHiuc6n6rZvZzAO8gXu660DxVI3osn7xuzFzKm38?=
 =?us-ascii?q?4ZnXkDIlJFYhWHj43xNlDOIfH4De2wg1WwnDt3yf3LJaDhDYnXLnTZjrjuYK?=
 =?us-ascii?q?t951ZGyAUv1dBf+45UCrYZLfL3W0/xssHYDxAgPwy33ennEtN92Z0aWW+UHK?=
 =?us-ascii?q?+ZP73dsUWS6uIsPeaMfokVtyj5K/Q/4P7ul3A5yhczZ66siKoWenClGbwyMl?=
 =?us-ascii?q?eZaHu02owpDGwQ+AcyUbq52xW5TTdPaiPqDOoH7TYhBdfjUt/O?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2GiBAD+45Bdf8fXVdFmHQEBBQEMBQG?=
 =?us-ascii?q?BZ4NeTBCNHoZDAQEGiyaBCYV6gwuHIQEIAQEBDAEBLQIBAYRAgzojOBMCAwk?=
 =?us-ascii?q?BAQUBAQEBAQUEAQECEAEBCQsLCCeFQoI6KYM1CxYVUlY/AQUBNSI5gkcBgXY?=
 =?us-ascii?q?UBZ9HgQM8jCUziGcBCQ2BSAkBCIEihzWEWYEQgQeEYYQNLIMqgkQEgS8BAQG?=
 =?us-ascii?q?VG5ZJAQYCghAUgXiTByeCN4ICiT05iwYBLacTAgoHBg8jgUaBek0lgWwKgUR?=
 =?us-ascii?q?QEBSCBo4tITOBCI07glQB?=
X-IPAS-Result: =?us-ascii?q?A2GiBAD+45Bdf8fXVdFmHQEBBQEMBQGBZ4NeTBCNHoZDA?=
 =?us-ascii?q?QEGiyaBCYV6gwuHIQEIAQEBDAEBLQIBAYRAgzojOBMCAwkBAQUBAQEBAQUEA?=
 =?us-ascii?q?QECEAEBCQsLCCeFQoI6KYM1CxYVUlY/AQUBNSI5gkcBgXYUBZ9HgQM8jCUzi?=
 =?us-ascii?q?GcBCQ2BSAkBCIEihzWEWYEQgQeEYYQNLIMqgkQEgS8BAQGVG5ZJAQYCghAUg?=
 =?us-ascii?q?XiTByeCN4ICiT05iwYBLacTAgoHBg8jgUaBek0lgWwKgURQEBSCBo4tITOBC?=
 =?us-ascii?q?I07glQB?=
X-IronPort-AV: E=Sophos;i="5.64,563,1559545200"; 
   d="scan'208";a="79424629"
Received: from mail-pg1-f199.google.com ([209.85.215.199])
  by smtpmx5.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Sep 2019 10:09:18 -0700
Received: by mail-pg1-f199.google.com with SMTP id r35so7298518pgb.2
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2019 10:09:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dfAB/2GP8aHKzOrul+nMRwFpXXcn4QXiRUinb90bawg=;
        b=ttwDLC4EsQWqzhrvPgBN34TyW5voEoCIBE0sEGWm9ttSH+OWLGfcjkzRBix4ikxaZd
         2Gxd08lmY7jkXYhPouVyWpfeki3wIi5EYrq6knkTuTOIB4l/a9eRLVPhitUarq2kKGro
         UUR1TZWsg2OKyigkxDedOldcqNTfaTvR9RRvb8q+ZaRKO/LFC9Mue46omfFQe5Oek3fH
         WbFnv5XZxY3w7NR9ASPs+r8ITa7ycPfd+pROmxoZ6Be0GJWjB7eG9nTSSIOw6njPZbpq
         t0FYyt2oDwKb6FkNjZOUP3lE/0T8ccQvpbST9/iBcMFY581Igxw0EiyMrhPKawoWQ/hX
         d/DQ==
X-Gm-Message-State: APjAAAUNJsMAcQ3/VfluE0ZVM58Eymna1sIiosAl8NfeV8StaEnYy9Qn
        3CqZkLeJnQ4jLZtBhBkRpKglwZzH0mk0M9V16Zp1XzGvRkvEvZsKzw4vkVk/Yih6/X1rvI74eBP
        e5QGwoH0Mbd7JraHrOMTffkwTLA==
X-Received: by 2002:a17:90a:a4c6:: with SMTP id l6mr22912019pjw.15.1569776957563;
        Sun, 29 Sep 2019 10:09:17 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzDsp39Vss4vjFYnY1K3kB0U9MwS68tQfmMqZs46zsnnGlrhIvZAS77G/AMzzzPH+taRD/WaA==
X-Received: by 2002:a17:90a:a4c6:: with SMTP id l6mr22912000pjw.15.1569776957226;
        Sun, 29 Sep 2019 10:09:17 -0700 (PDT)
Received: from Yizhuo.cs.ucr.edu (yizhuo.cs.ucr.edu. [169.235.26.74])
        by smtp.googlemail.com with ESMTPSA id v43sm26680984pjb.1.2019.09.29.10.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2019 10:09:16 -0700 (PDT)
From:   Yizhuo <yzhai003@ucr.edu>
Cc:     csong@cs.ucr.edu, zhiyunq@cs.ucr.edu, Yizhuo <yzhai003@ucr.edu>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: pfuze100-regulator: Variable "val" in pfuze100_regulator_probe() could be uninitialized
Date:   Sun, 29 Sep 2019 10:09:57 -0700
Message-Id: <20190929170957.14775-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function pfuze100_regulator_probe(), variable "val" could be
initialized if regmap_read() fails. However, "val" is used to
decide the control flow later in the if statement, which is
potentially unsafe.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
---
 drivers/regulator/pfuze100-regulator.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/pfuze100-regulator.c b/drivers/regulator/pfuze100-regulator.c
index df5df1c495ad..689537927f6f 100644
--- a/drivers/regulator/pfuze100-regulator.c
+++ b/drivers/regulator/pfuze100-regulator.c
@@ -788,7 +788,13 @@ static int pfuze100_regulator_probe(struct i2c_client *client,
 
 		/* SW2~SW4 high bit check and modify the voltage value table */
 		if (i >= sw_check_start && i <= sw_check_end) {
-			regmap_read(pfuze_chip->regmap, desc->vsel_reg, &val);
+			ret = regmap_read(pfuze_chip->regmap,
+						desc->vsel_reg, &val);
+			if (ret) {
+				dev_err(&client->dev, "Fails to read from the register.\n");
+				return ret;
+			}
+
 			if (val & sw_hi) {
 				if (pfuze_chip->chip_id == PFUZE3000 ||
 					pfuze_chip->chip_id == PFUZE3001) {
-- 
2.17.1

