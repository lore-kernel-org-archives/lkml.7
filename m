Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88623C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 11:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 555C22081C
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 11:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="elHaOVv7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfE2LG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 07:06:26 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59534 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfE2LG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 07:06:26 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4TB3o6Q041065;
        Wed, 29 May 2019 11:06:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=YsLSH87kGhD3EoOg93XkIPoYdR2SttgsnC5i7XVabKw=;
 b=elHaOVv7LQeXuPh4utXiTks9jTpxcDHyskAPz+fCW91PlhRlpnfArfzkmcWWCCdDbtHA
 2pHr0qHl11MHg7fxjcXGfm0Dn8L+KP4i3iAh01wCu1qemK8Y4luGxeFx5VOW4Q9YCuXI
 JnH4f36BKFj13d9gBUykaTugqEK2UDSZM4or8FnDBu0MAOa7JXUPXREYv4+9N6wWj/xe
 b7TUODT+8wGVa/pxoZmI2j0d9WmEYmdiHyG8XQrH87YRyGHV79VVfdzfdrzVhS6z9aqj
 cOV7c2h2B2X5z/sYUEsDiXpejbe4gfInDcYZFBkwrvIAPNtvb0lxHWW2avdVC5AgKzFS GQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2spxbq8u04-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 May 2019 11:06:17 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4TB4NtL007754;
        Wed, 29 May 2019 11:06:16 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2sqh73mwsn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 May 2019 11:06:16 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4TB69Ma012745;
        Wed, 29 May 2019 11:06:09 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 May 2019 04:06:08 -0700
Date:   Wed, 29 May 2019 14:06:01 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Matt Porter <mporter@kernel.crashing.org>
Cc:     Alexandre Bounine <alex.bou9@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] rapidio/mport_cdev: NUL terminate some strings
Message-ID: <20190529110601.GB19119@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9271 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905290074
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9271 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905290075
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dev_info.name[] array has space for RIO_MAX_DEVNAME_SZ + 1
characters.  But the problem here is that we don't ensure that the user
put a NUL terminator on the end of the string.  It could lead to an out
of bounds read.

Fixes: e8de370188d0 ("rapidio: add mport char device driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/rapidio/devices/rio_mport_cdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/rapidio/devices/rio_mport_cdev.c b/drivers/rapidio/devices/rio_mport_cdev.c
index 4a4a75fa26d5..3440b3e8e578 100644
--- a/drivers/rapidio/devices/rio_mport_cdev.c
+++ b/drivers/rapidio/devices/rio_mport_cdev.c
@@ -1690,6 +1690,7 @@ static int rio_mport_add_riodev(struct mport_cdev_priv *priv,
 
 	if (copy_from_user(&dev_info, arg, sizeof(dev_info)))
 		return -EFAULT;
+	dev_info.name[sizeof(dev_info.name) - 1] = '\0';
 
 	rmcd_debug(RDEV, "name:%s ct:0x%x did:0x%x hc:0x%x", dev_info.name,
 		   dev_info.comptag, dev_info.destid, dev_info.hopcount);
@@ -1821,6 +1822,7 @@ static int rio_mport_del_riodev(struct mport_cdev_priv *priv, void __user *arg)
 
 	if (copy_from_user(&dev_info, arg, sizeof(dev_info)))
 		return -EFAULT;
+	dev_info.name[sizeof(dev_info.name) - 1] = '\0';
 
 	mport = priv->md->mport;
 
-- 
2.20.1
