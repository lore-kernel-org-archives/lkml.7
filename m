Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 890D9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 05:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F31A206B8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 05:49:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="un9P7yug"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730900AbfB1FtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 00:49:07 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:35846 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfB1FtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 00:49:06 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1S5hRd9061393;
        Thu, 28 Feb 2019 05:49:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=3n236jEWGDIhs2uGKjoGecsZgjAP6npnZNHS3+h9DFk=;
 b=un9P7yugjPQjr1thidH2Rmc9rFGHG2Tu4tGR/qVud3Jsj1eQAA37+MGp5IxCBIsbIjYn
 1geNNo5igkPpkd997k6fp7n7AYlOWBTF9Fk0VY3zrQPPwpsqSBS6vPCddc507P9HUZGS
 7n3YIyrS5q+l+nlr+vCt877dXbELe4UO5NmzOjnlw9wRK/qVf6NLCn9cQhhoZXQz/2VD
 5ikZzM1oDNWD1ezbxR0e8xONzwHfbQqfC1dy85WOg2YhaFFeTA4al7v5JWsx5nsOZ6Ze
 1cOBNn+vVSZx+eGBBfvU9LzGhvC9AhXktsz87RQxS7Iuhe9H1E0nu7D4GTCQ4bhBvsOh +g== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2qtupef2q8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Feb 2019 05:49:03 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1S5mvVt029759
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Feb 2019 05:48:57 GMT
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1S5muLH006005;
        Thu, 28 Feb 2019 05:48:56 GMT
Received: from kadam (/197.157.0.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 27 Feb 2019 21:48:56 -0800
Date:   Thu, 28 Feb 2019 08:48:49 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Andy Gross <andy.gross@linaro.org>,
        Mahesh Sivasubramanian <msivasub@codeaurora.org>
Cc:     David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] soc: qcom: cmd-db: Fix an error code in cmd_db_dev_probe()
Message-ID: <20190228054849.GD3253@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9180 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902280039
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The memremap() function doesn't return error pointers, it returns NULL.
This code is returning "ret = PTR_ERR(NULL);" which is success, but it
should return -ENOMEM.

Fixes: 312416d9171a ("drivers: qcom: add command DB driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/soc/qcom/cmd-db.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
index c701b3b010f1..f6c3d17b05c7 100644
--- a/drivers/soc/qcom/cmd-db.c
+++ b/drivers/soc/qcom/cmd-db.c
@@ -248,8 +248,8 @@ static int cmd_db_dev_probe(struct platform_device *pdev)
 	}
 
 	cmd_db_header = memremap(rmem->base, rmem->size, MEMREMAP_WB);
-	if (IS_ERR_OR_NULL(cmd_db_header)) {
-		ret = PTR_ERR(cmd_db_header);
+	if (!cmd_db_header) {
+		ret = -ENOMEM;
 		cmd_db_header = NULL;
 		return ret;
 	}
-- 
2.17.1

