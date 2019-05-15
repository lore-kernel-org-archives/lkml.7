Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4629EC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 09:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 113C420881
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 09:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QxKz7pdr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbfEOJcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 05:32:04 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:41294 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfEOJcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 05:32:03 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4F9Oka8107637;
        Wed, 15 May 2019 09:31:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=hSu1AVv1i5MwGTlZX96Y2ojOopFKVDPdwp7odcEtjSU=;
 b=QxKz7pdrvgFAsizbgDOzDRwgYaxCVVOCZKxT6V2UQ5YrwlWM7dnYddmmQKgH52xwsiyF
 yDDDPg8rcWPTiSRhLHcrfOWh85hHiUa09rekpc6c9sHJ+lkRMXfYq2DRBrwFMBzJMrmL
 Y2vBL5aZCUseBkHAt9O1AGsDRf/hOnHL54ANFoej5iUdPo31j0lRklAWgJNzt1/0BJVx
 hIQ4pDwXPVxYnhQIfgbbYz4wOAEwQhednYjrmtjracQG/RdLKozlYNDNg4j8yZlrn9/Q
 xt3n+qqTSnvriClxUItv5X4b1emGDhmSzilE3u2FbxHgB4z21FJsZStgbjbbsBpuaqNC QQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2sdq1qkgaa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 May 2019 09:31:53 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4F9Vdrw093333;
        Wed, 15 May 2019 09:31:52 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2sdnqk433v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 May 2019 09:31:52 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4F9VoVH001813;
        Wed, 15 May 2019 09:31:50 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 15 May 2019 02:31:49 -0700
Date:   Wed, 15 May 2019 12:31:41 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Amelie Delaunay <amelie.delaunay@st.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] mfd: stmfx: Uninitialized variable in stmfx_irq_handler()
Message-ID: <20190515093141.GA3409@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9257 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905150061
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9257 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905150061
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The problem is that on 64bit systems then we don't clear the higher
bits of the "pending" variable.  So when we do:

	ack = pending & ~BIT(STMFX_REG_IRQ_SRC_EN_GPIO);
	if (ack) {

the if (ack) condition relies on uninitialized data.  The fix it that
I've changed "pending" from an unsigned long to a u32.  I changed "n" as
well, because that's a number in the 0-10 range and it fits easily
inside an int.  We do need to add a cast to "pending" when we use it in
the for_each_set_bit() loop, but that doesn't cause a proble, it's
fine.

Fixes: 06252ade9156 ("mfd: Add ST Multi-Function eXpander (STMFX) core driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/mfd/stmfx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/stmfx.c b/drivers/mfd/stmfx.c
index fe8efba2d45f..fee75b5d098e 100644
--- a/drivers/mfd/stmfx.c
+++ b/drivers/mfd/stmfx.c
@@ -204,12 +204,12 @@ static struct irq_chip stmfx_irq_chip = {
 static irqreturn_t stmfx_irq_handler(int irq, void *data)
 {
 	struct stmfx *stmfx = data;
-	unsigned long n, pending;
+	u32 pending;
 	u32 ack;
+	int n;
 	int ret;
 
-	ret = regmap_read(stmfx->map, STMFX_REG_IRQ_PENDING,
-			  (u32 *)&pending);
+	ret = regmap_read(stmfx->map, STMFX_REG_IRQ_PENDING, &pending);
 	if (ret)
 		return IRQ_NONE;
 
@@ -224,7 +224,7 @@ static irqreturn_t stmfx_irq_handler(int irq, void *data)
 			return IRQ_NONE;
 	}
 
-	for_each_set_bit(n, &pending, STMFX_REG_IRQ_SRC_MAX)
+	for_each_set_bit(n, (unsigned long *)&pending, STMFX_REG_IRQ_SRC_MAX)
 		handle_nested_irq(irq_find_mapping(stmfx->irq_domain, n));
 
 	return IRQ_HANDLED;
-- 
2.20.1

