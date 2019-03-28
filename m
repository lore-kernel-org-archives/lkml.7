Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C35C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 14:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B3BE2075E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 14:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LVceLrCI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbfC1OSA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 10:18:00 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:46994 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfC1OR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 10:17:59 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2SE9Vj4038417;
        Thu, 28 Mar 2019 14:17:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=97fBova06FBtMVNalMuq00CqX3eX38Wr++PqStloLTE=;
 b=LVceLrCIfW+6AgQWp1/76H99Dd0B9zYBlk4pk3SMbvpeXKEPeyzUDmTptFPNeHUovH2a
 z3y26QkQTksOeHFYPUoT1SyZfPFFk9J3sFkonCaXVntlvKPiAsNXtZNwsHJbUBjJek5F
 KnnrVOvJkqWkl2ET/bJEeS+rKpo6MKEDfPXoQ99A8shiJMzKAdGzrEdsve2PC1Aato+w
 tjr6mcIAW7g581+gCi2JLsgPLBo7HxUVKkCnMfOPrtR8WArrT6B+WA3B8iZNN/Yvrv97
 yycY/KHKRvngpwRpbeQ7llrOacgmwfFsOcIgXCRF/QfGlCknfLrGoVKO4b4BxZ4BaS5m Sw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2re6g16vu5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Mar 2019 14:17:57 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2SEHvwo021246
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Mar 2019 14:17:57 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2SEHvVT026233;
        Thu, 28 Mar 2019 14:17:57 GMT
Received: from kadam (/41.202.241.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 28 Mar 2019 07:17:56 -0700
Date:   Thu, 28 Mar 2019 17:17:42 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] vlynq: Fix uninitialized error code in probe()
Message-ID: <20190328141742.GM32590@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9208 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=998 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903280097
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "result" variable isn't initialized on this error path.

Fixes: 55e331cf7ebe ("drivers: add support for the TI VLYNQ bus")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/vlynq/vlynq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/vlynq/vlynq.c b/drivers/vlynq/vlynq.c
index c0227f9418eb..44d3485d1108 100644
--- a/drivers/vlynq/vlynq.c
+++ b/drivers/vlynq/vlynq.c
@@ -727,7 +727,8 @@ static int vlynq_probe(struct platform_device *pdev)
 	dev->local_irq = dev->irq_end - dev->irq_start;
 	dev->remote_irq = dev->local_irq - 1;
 
-	if (device_register(&dev->dev))
+	result = device_register(&dev->dev);
+	if (result)
 		goto fail_register;
 	platform_set_drvdata(pdev, dev);
 
-- 
2.17.1

