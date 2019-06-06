Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C036AC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 12:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9717220866
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 12:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CJ6xVfHk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbfFFMls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 08:41:48 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59916 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726870AbfFFMls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 08:41:48 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x56CNvve189323;
        Thu, 6 Jun 2019 12:41:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2018-07-02; bh=msmH1U56crPbNRzTsdy2al8tC5H9vw5+sq8L4C2RUK4=;
 b=CJ6xVfHkWbX33y5VWh0/BWBGQNvT7JHh3QbV3oeluLGYSgqO/q9sVDPNf6V+EkjAOPN0
 MccSfZKZWDrbq1OXVvhi53r+hWTL2lJZs81RBesSv2z8fK9Xt8cFQG/9BV7lUdkZdinf
 CyOHysAUR6gOPsYhfCr4A+FIW/vzkl8zudBuNHrC5K0GBaZHCvq4C4CZPuOTtBDHaIEt
 GvgWkFIkS5J9WUzp5rYGYAFDVAtN5zkvpc+FRNbNdHoluEtpyHw+DtdpsJvbBAdp6pWX
 DIOw0yb5dNU4BmCAUdmhL3LgmRLvDi022zwnu7GI5/s02O1YhxU+baXesjMNT85pI5oE 1g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2suj0qr2x0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jun 2019 12:41:37 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x56CeZxp165567;
        Thu, 6 Jun 2019 12:41:36 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2swnhaqv70-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jun 2019 12:41:36 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x56CfZP1023460;
        Thu, 6 Jun 2019 12:41:35 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 06 Jun 2019 05:41:34 -0700
Date:   Thu, 6 Jun 2019 15:41:27 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Amelie DELAUNAY <amelie.delaunay@st.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH v2] mfd: stmfx: Uninitialized variable in stmfx_irq_handler()
Message-ID: <20190606124127.GA17082@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ccefbd0b-3397-a26e-95e7-059fcced9154@st.com>
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9279 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906060090
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9279 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906060090
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
v2: white space changes

 drivers/mfd/stmfx.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/stmfx.c b/drivers/mfd/stmfx.c
index fe8efba2d45f..7c419c078688 100644
--- a/drivers/mfd/stmfx.c
+++ b/drivers/mfd/stmfx.c
@@ -204,12 +204,10 @@ static struct irq_chip stmfx_irq_chip = {
 static irqreturn_t stmfx_irq_handler(int irq, void *data)
 {
 	struct stmfx *stmfx = data;
-	unsigned long n, pending;
-	u32 ack;
-	int ret;
+	u32 pending, ack;
+	int n, ret;
 
-	ret = regmap_read(stmfx->map, STMFX_REG_IRQ_PENDING,
-			  (u32 *)&pending);
+	ret = regmap_read(stmfx->map, STMFX_REG_IRQ_PENDING, &pending);
 	if (ret)
 		return IRQ_NONE;
 
@@ -224,7 +222,7 @@ static irqreturn_t stmfx_irq_handler(int irq, void *data)
 			return IRQ_NONE;
 	}
 
-	for_each_set_bit(n, &pending, STMFX_REG_IRQ_SRC_MAX)
+	for_each_set_bit(n, (unsigned long *)&pending, STMFX_REG_IRQ_SRC_MAX)
 		handle_nested_irq(irq_find_mapping(stmfx->irq_domain, n));
 
 	return IRQ_HANDLED;
-- 
2.20.1

