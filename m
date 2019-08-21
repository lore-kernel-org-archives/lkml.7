Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D41C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 07:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59DD12332A
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 07:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CoombSlk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbfHUHGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 03:06:36 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:46920 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727206AbfHUHGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 03:06:36 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7L748MM065586;
        Wed, 21 Aug 2019 07:06:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=eIL56nE/v5J5wgXacoh7ataFYepKi+JaBEV1KC2ZerA=;
 b=CoombSlkWRADBJyfkyxQBnjIcic1m+R7g146uZbOzI5Q2NCK2rJzbjHQNv0ecVzlZw5z
 3khmhUaX4o6ZEbwcYeA1/feSavEBpI/0kn0Vu+sHmhK018+cY832m7IWFK6YhxkjTMF5
 aWnxcrh6mEFD0c+RJE50t6x+8FP4P7nIgY08ZwUyxIE/nLCQX8+16Vr5wPJ7zM2sr9Vk
 Ubz0U0VWcp64OI9alL7ADWBOrTzaQNvOxkKwraUWooIdLhcy8t7EdW4rmJQEkyXL0aO0
 4ibBxr+d9fJypHqNLTTK8wPVCdrbWWGmfe5454WTIoaSg1wpAEc+AnTJxXRFtzZp2HfR pQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2uea7qub3v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Aug 2019 07:06:19 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7L74ELt174828;
        Wed, 21 Aug 2019 07:06:18 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2ug1ga8hpy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Aug 2019 07:06:18 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7L76EMS021546;
        Wed, 21 Aug 2019 07:06:14 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 21 Aug 2019 00:06:13 -0700
Date:   Wed, 21 Aug 2019 10:06:06 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH 1/4] misc: xilinx_sdfec: Fix a couple small information leaks
Message-ID: <20190821070606.GA26957@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9355 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908210076
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9355 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908210076
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These structs have holes in them so we end up disclosing a few bytes of
uninitialized stack data.

drivers/misc/xilinx_sdfec.c:305 xsdfec_get_status() warn: check that 'status' doesn't leak information (struct has a hole after 'activity')
drivers/misc/xilinx_sdfec.c:449 xsdfec_get_turbo() warn: check that 'turbo_params' doesn't leak information (struct has a hole after 'scale')

We need to zero out the holes with memset().

Fixes: 6bd6a690c2e7 ("misc: xilinx_sdfec: Add stats & status ioctls")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/misc/xilinx_sdfec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/misc/xilinx_sdfec.c b/drivers/misc/xilinx_sdfec.c
index 912e939dec62..dc1b8b412712 100644
--- a/drivers/misc/xilinx_sdfec.c
+++ b/drivers/misc/xilinx_sdfec.c
@@ -295,6 +295,7 @@ static int xsdfec_get_status(struct xsdfec_dev *xsdfec, void __user *arg)
 	struct xsdfec_status status;
 	int err;
 
+	memset(&status, 0, sizeof(status));
 	spin_lock_irqsave(&xsdfec->error_data_lock, xsdfec->flags);
 	status.state = xsdfec->state;
 	xsdfec->state_updated = false;
@@ -440,6 +441,7 @@ static int xsdfec_get_turbo(struct xsdfec_dev *xsdfec, void __user *arg)
 	if (xsdfec->config.code == XSDFEC_LDPC_CODE)
 		return -EIO;
 
+	memset(&turbo_params, 0, sizeof(turbo_params));
 	reg_value = xsdfec_regread(xsdfec, XSDFEC_TURBO_ADDR);
 
 	turbo_params.scale = (reg_value & XSDFEC_TURBO_SCALE_MASK) >>
-- 
2.20.1

