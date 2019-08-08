Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 816E1C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 10:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D7AB2173E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 10:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Lp0XK4Wo";
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aEn/rqYR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732098AbfHHKdv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 06:33:51 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:38494 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731038AbfHHKdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 06:33:50 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x78AXj7k031418;
        Thu, 8 Aug 2019 10:33:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=Df67e4pvMVSVwZ+aRQleA2HupVdX9I05YkQVq0xLpfo=;
 b=Lp0XK4WoOtub8q0CATAPADmsz3sbKGGXu8r0IZdaVJSINfJfVhGfM+CQDiBQvPlaqvcl
 Kbc6WbyVLBh8/bn/E65JzeanW1/383qvdpBcx6C0OikW7loz2uDdEdnpYOgYlja53qXm
 9TSQV0T7md3TA5P4v96KVGpfhPX3UgaYGDRJrNeZfVfUa+l/0ATsXp11vNu6f9IF3/OQ
 WTFtsL+BGt8QIlc7JGz94CTmf8A764YntCoM+nSg/2bdQS0D2sdJmV+lwq1W1zpm+DTT
 veW9bITqKwCY2D3I2mpuAdzDrt3mkTUDsDTRTld79O0gehLUhkQ53rkbihIW26cxoJ7q gw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=Df67e4pvMVSVwZ+aRQleA2HupVdX9I05YkQVq0xLpfo=;
 b=aEn/rqYRsDLEv93PUZlYYLKgRsyskwy0F4ZcYY/5oQE+7maNrE1UE3+sWeHLGwNBRE8T
 zApSkSIuKQNEgLliyWUT1SXY1wfuA5vye29KAA7kb4dN9WFnRUado/Iu61mk/vnLF2jC
 Y4Wdok2L+AGuXnnBJLyjRXSWlsu4bImiTlgGHPyP72CPaFXXVOhSL5v7eAc3v8y/R6KX
 1kTc7LwTVWmMrftHzs1yWHQVJktetBpSPunDVRLvrX5YKxh7WTPy82m6DtGq+Lyv9apy
 jimQQcT7/WLSI+iVqlts+GQEX+xkMzF6xgGJFl2gqRMfenEQPaLygwcsQz34p0eccIQd rA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2u8hps04kg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Aug 2019 10:33:44 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x78AWZp3042979;
        Thu, 8 Aug 2019 10:33:44 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2u763k4ben-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Aug 2019 10:33:44 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x78AXhvN023894;
        Thu, 8 Aug 2019 10:33:43 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 08 Aug 2019 03:33:42 -0700
Date:   Thu, 8 Aug 2019 13:33:35 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Support Opensource <support.opensource@diasemi.com>,
        Eric Jeong <eric.jeong.opensource@diasemi.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] regulator: slg51000: Fix a couple NULL vs IS_ERR() checks
Message-ID: <20190808103335.GD30506@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9342 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=893
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908080115
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9342 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=943 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908080116
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The devm_gpiod_get_from_of_node() function never returns NULL, it
returns error pointers on error.

Fixes: a867bde3dd03 ("regulator: slg51000: add slg51000 regulator driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/regulator/slg51000-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/slg51000-regulator.c b/drivers/regulator/slg51000-regulator.c
index 04b732991d69..4d859fef55e6 100644
--- a/drivers/regulator/slg51000-regulator.c
+++ b/drivers/regulator/slg51000-regulator.c
@@ -205,7 +205,7 @@ static int slg51000_of_parse_cb(struct device_node *np,
 	ena_gpiod = devm_gpiod_get_from_of_node(chip->dev, np,
 						"enable-gpios", 0,
 						gflags, "gpio-en-ldo");
-	if (ena_gpiod) {
+	if (!IS_ERR(ena_gpiod)) {
 		config->ena_gpiod = ena_gpiod;
 		devm_gpiod_unhinge(chip->dev, config->ena_gpiod);
 	}
@@ -459,7 +459,7 @@ static int slg51000_i2c_probe(struct i2c_client *client,
 					       GPIOD_OUT_HIGH
 					       | GPIOD_FLAGS_BIT_NONEXCLUSIVE,
 					       "slg51000-cs");
-	if (cs_gpiod) {
+	if (!IS_ERR(cs_gpiod)) {
 		dev_info(dev, "Found chip selector property\n");
 		chip->cs_gpiod = cs_gpiod;
 	}
-- 
2.20.1

