Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4494CC31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 05:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 122D320657
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 05:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FcdQ/hXD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730614AbfFSFc0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 01:32:26 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:55920 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfFSFcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 01:32:25 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5J5P521177654;
        Wed, 19 Jun 2019 05:32:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=mocTtvdGYNVUl/q4ExDY/sG+3HeXGdnqOCW2dwUTTYw=;
 b=FcdQ/hXDOTVVLdBhMPLOx1LvtmYQ0mRT2yZ4hHY5uQjd7McGMPAdQGdcg2EU2X5QWDSw
 DsjY9EWBq6yWibz6YeDDd9GSQc//TV9v3r+JzEzrTVvJqY8vQUWkwsBYtiPW1ca0Mqnl
 HORXM81qDjCyWT+M+ecIrQGBRVh0gd0XEVg1/WXfnp8LQyhhcvWCq+EqsH6Dvyxsj1MQ
 hQ0QcY2B3ViyctdyrnlYgEhDS8uM3XJc2YGwfxC1mQInUeHHg4tuf5EH4SEiD0LwOcN4
 33dl0JZ+ylh1gQlNTksvGHjQ7PWTwfKhpxsa68kQeZhl8Yb07mg79DV5n65XsTO4EfoE pw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2t780994jk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jun 2019 05:32:15 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5J5V8Ib071995;
        Wed, 19 Jun 2019 05:32:15 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2t77ymveds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jun 2019 05:32:14 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5J5WDka009329;
        Wed, 19 Jun 2019 05:32:13 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 18 Jun 2019 22:32:13 -0700
Date:   Wed, 19 Jun 2019 08:32:05 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jon Mason <jdmason@kudzu.us>, Logan Gunthorpe <logang@deltatee.com>
Cc:     Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
        linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] NTB: test: remove a duplicate check
Message-ID: <20190619053205.GA10452@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9292 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906190043
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9292 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906190043
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We already verified that the "nm->isr_ctx" allocation succeeded so there
is no need to check again here.

Fixes: a6bed7a54165 ("NTB: Introduce NTB MSI Test Client")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
Hey Logan, can pick a patch prefix when you're introducing a new module?
"[PATCH] NTB/test: Introduce NTB MSI Test Client" or whatever.

 drivers/ntb/test/ntb_msi_test.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/ntb/test/ntb_msi_test.c b/drivers/ntb/test/ntb_msi_test.c
index 99d826ed9c34..9ba3c3162cd0 100644
--- a/drivers/ntb/test/ntb_msi_test.c
+++ b/drivers/ntb/test/ntb_msi_test.c
@@ -372,9 +372,6 @@ static int ntb_msit_probe(struct ntb_client *client, struct ntb_dev *ntb)
 	if (ret)
 		goto remove_dbgfs;
 
-	if (!nm->isr_ctx)
-		goto remove_dbgfs;
-
 	ntb_link_enable(ntb, NTB_SPEED_AUTO, NTB_WIDTH_AUTO);
 
 	return 0;
-- 
2.20.1

