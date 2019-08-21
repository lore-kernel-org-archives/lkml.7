Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C7BC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 07:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B77BA22CF7
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 07:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C3xv6rQI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbfHUHHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 03:07:18 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:35042 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727206AbfHUHHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 03:07:18 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7L74Ful078588;
        Wed, 21 Aug 2019 07:07:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2019-08-05; bh=cE9s0Cp1ViW4krpgGQjjfgAOVUXuBLNUghjKIjDQfmY=;
 b=C3xv6rQIuzVnjMkkBCEdmoeUR3Yl2ix2bcPFGozJURC5uoX8SeduUvSr8UQQgaHuzbEK
 NjXZ4G8mu9m/BQr0E6l4j27bPK0Yse1fc6qs0qV0C1UffivLx5T+a2yMSROj2caDa6oA
 KhmYTfVGldZPq8Jgulk+CPx/2b6CL2AZ9TuHOWVFlfoJ9FFXF3FKJRsO/bwi5nteCxJM
 frW4eQP3bmg+Uhn5/ik5fOO9h6ZuuGtbC+mYmtcELedYK7wzlnv67DXxD92eidxLZ8gM
 Q0L8zN77Sa1cxCbeSG+ttu+5k//M3ezUH3cnZBjn9Bc5FIX0RVaZ75oE5ej2D6n2GISE mQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2ue9hpka6r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Aug 2019 07:07:11 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7L74EkP174834;
        Wed, 21 Aug 2019 07:07:11 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2ug1ga8jgu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Aug 2019 07:07:11 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7L77AjQ023628;
        Wed, 21 Aug 2019 07:07:10 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 21 Aug 2019 00:07:09 -0700
Date:   Wed, 21 Aug 2019 10:07:02 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH 2/4] misc: xilinx_sdfec: Return -EFAULT if copy_from_user()
 fails
Message-ID: <20190821070702.GB26957@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821070606.GA26957@mwanda>
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9355 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908210076
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9355 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908210076
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The copy_from_user() funciton returns the number of bytes remaining to
be copied but we want to return -EFAULT to the user.

Fixes: 20ec628e8007 ("misc: xilinx_sdfec: Add ability to configure LDPC")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/misc/xilinx_sdfec.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/xilinx_sdfec.c b/drivers/misc/xilinx_sdfec.c
index dc1b8b412712..813b82c59360 100644
--- a/drivers/misc/xilinx_sdfec.c
+++ b/drivers/misc/xilinx_sdfec.c
@@ -651,9 +651,10 @@ static int xsdfec_add_ldpc(struct xsdfec_dev *xsdfec, void __user *arg)
 	if (!ldpc)
 		return -ENOMEM;
 
-	ret = copy_from_user(ldpc, arg, sizeof(*ldpc));
-	if (ret)
+	if (copy_from_user(ldpc, arg, sizeof(*ldpc))) {
+		ret = -EFAULT;
 		goto err_out;
+	}
 
 	if (xsdfec->config.code == XSDFEC_TURBO_CODE) {
 		ret = -EIO;
-- 
2.20.1

