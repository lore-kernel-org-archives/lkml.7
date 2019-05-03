Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB65DC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 13:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6A942070B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 13:17:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FrqgKEcB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbfECNRK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 09:17:10 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:54828 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbfECNRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 09:17:10 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x43DEGPk139327;
        Fri, 3 May 2019 13:17:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=vlCSxJN8BUUTjnqBqXalyKb7GIxVl2UFBGtLovvlGgA=;
 b=FrqgKEcBjOG8a0turrqKK8tO+u885/fjydv2g31iW1+b54WQ7K1XwLOeXrfclnWN7AQ9
 mcXw9mB+V3F1THJlucHga4lxZDBdxI1Dckk/eEv+6rK/tMaz3i19+ol/nYsm+4ifjESj
 WIZZcmMuFgLb+jpvD2932PGAUxzCOmhq5E7bO1SJyLZCwZmbtEfZASWKqg1hs6D0QfUS
 ++IBBX6ln5t585HLIHsae/JQo1gJCVqWsGmMwfapPEboMi7J8NiRscVOYm2KR+7NlbKO
 euhdRAOCCiMiQk8rsxh6gaVxkBoCjAIMimtADLeWUqpM6muTuf5t28e4txdiYsuMuLbO Xw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 2s6xhypn95-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 May 2019 13:17:02 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x43DGowD177600;
        Fri, 3 May 2019 13:17:02 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2s7rtc9eu4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 May 2019 13:17:01 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x43DGxOO007680;
        Fri, 3 May 2019 13:17:00 GMT
Received: from mwanda (/196.104.111.181)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 03 May 2019 06:16:58 -0700
Date:   Fri, 3 May 2019 16:16:51 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Krzysztof Halasa <khalasa@piap.pl>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] soc: ixp4xx: qmgr: Fix an NULL vs IS_ERR() check in probe
Message-ID: <20190503131651.GC1236@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9245 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905030083
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9245 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905030083
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The devm_ioremap_resource() function doesn't retunr NULL, it returns
error pointers.

Fixes: ecc133c6da60 ("soc: ixp4xx: qmgr: Pass resources")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/soc/ixp4xx/ixp4xx-qmgr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/ixp4xx/ixp4xx-qmgr.c b/drivers/soc/ixp4xx/ixp4xx-qmgr.c
index 13a8a13c9b01..bb90670ec160 100644
--- a/drivers/soc/ixp4xx/ixp4xx-qmgr.c
+++ b/drivers/soc/ixp4xx/ixp4xx-qmgr.c
@@ -385,8 +385,8 @@ static int ixp4xx_qmgr_probe(struct platform_device *pdev)
 	if (!res)
 		return -ENODEV;
 	qmgr_regs = devm_ioremap_resource(dev, res);
-	if (!qmgr_regs)
-		return -ENOMEM;
+	if (IS_ERR(qmgr_regs))
+		return PTR_ERR(qmgr_regs);
 
 	irq1 = platform_get_irq(pdev, 0);
 	if (irq1 <= 0)
-- 
2.18.0

