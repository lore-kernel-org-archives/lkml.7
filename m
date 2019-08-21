Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A26C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 07:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA73D20644
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 07:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QhIkl/oq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbfHUHKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 03:10:14 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:40370 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727206AbfHUHKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 03:10:13 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7L791VL056530;
        Wed, 21 Aug 2019 07:10:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2019-08-05; bh=en2vKBGfxU9xNd7R+KnkNsD7JrLQKyLTZlqk0KmNiiA=;
 b=QhIkl/oqzvCI2Hc12/tXiOOVcrwTrAXizgkEkxdeCX3F4q7qHu4zRpGpcwi6EWHZz5Mc
 XxJJoKuFUnI93TwRoZKbZEF2Q1Edk1xOOfBX7wSroWA8rIc/TQ+9lAN7kq4vK8qCXXky
 MjWo15njAU0B5cf3awzBFkSF73jYrtSl8x4kHiFChESgyhW89jS5CiVOu2r7hN/s1BO7
 Vw4s5qzvxzHKZebEXefdFstJTaNnOaUxE5nrnxAKX0xJPFB9cgKD8iG3/jv8A+JBKHZA
 DYT3X4R4+jXq1c3paowQ+K6g8PM31/4J2+aUdY5O2Oa9uA+WRLwL1tHxdTRPzZG09u2s 3w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2ue90tkhcj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Aug 2019 07:10:06 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7L78hXh115021;
        Wed, 21 Aug 2019 07:10:06 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2ug269nf38-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Aug 2019 07:10:06 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7L7A1vw023745;
        Wed, 21 Aug 2019 07:10:01 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 21 Aug 2019 00:10:00 -0700
Date:   Wed, 21 Aug 2019 10:09:53 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH 3/4] misc: xilinx_sdfec: Prevent a divide by zero in
 xsdfec_reg0_write()
Message-ID: <20190821070953.GC26957@mwanda>
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
 engine=8.0.1-1906280000 definitions=main-1908210077
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9355 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908210077
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "psize" value comes from the user so we need to verify that it's
non-zero before we check if "n % psize" or it will crash.

Fixes: 20ec628e8007 ("misc: xilinx_sdfec: Add ability to configure LDPC")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
The parentheses in this condition are a no-op.  They're just confusing.
Perhaps something else was intended?

 drivers/misc/xilinx_sdfec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/xilinx_sdfec.c b/drivers/misc/xilinx_sdfec.c
index 813b82c59360..3fc53d20abf3 100644
--- a/drivers/misc/xilinx_sdfec.c
+++ b/drivers/misc/xilinx_sdfec.c
@@ -460,7 +460,7 @@ static int xsdfec_reg0_write(struct xsdfec_dev *xsdfec, u32 n, u32 k, u32 psize,
 {
 	u32 wdata;
 
-	if (n < XSDFEC_REG0_N_MIN || n > XSDFEC_REG0_N_MAX ||
+	if (n < XSDFEC_REG0_N_MIN || n > XSDFEC_REG0_N_MAX || psize == 0 ||
 	    (n > XSDFEC_REG0_N_MUL_P * psize) || n <= k || ((n % psize) != 0)) {
 		dev_dbg(xsdfec->dev, "N value is not in range");
 		return -EINVAL;
-- 
2.20.1

