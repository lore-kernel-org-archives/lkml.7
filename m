Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E01C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 10:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D06D121D81
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 10:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I2h95FJd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730507AbfJDKXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 06:23:23 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:41324 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730173AbfJDKXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 06:23:22 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x94AMe8G034304;
        Fri, 4 Oct 2019 10:23:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=swaVTqtr5y/z7JmmgDSDknFRcupEJeXLjsqarFMdI80=;
 b=I2h95FJdtEletzPZq92JHCKmVl+FDkvM6O9nEcDf40oGqhJ2ezdPN6bYpgfpsdVzanEI
 V6SO63YwFPsqby03b82MXXxKnjXJg08K/uIebEknmWcbdniauEtWzxZnI+HqeTryGGD1
 YX4cHdDyNsh2P5lcoEjL8tXLAtWA3PeaifTgxi6Dx4so+twknPI5rsM+mTt2VSMGY2cW
 J4HrElj+tUVY7EdfFTWQTJzZJIwXqRCf50HpQwzRdNSbuDNA7w94jSsB0AbgghjMBvZ/
 EVGI8I04gi9tPm+8qUwttaz8TAMxou3EUg2B/NzLyPDUzmHCr2pbZpAHre3b1Z4EJIG7 Tw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2va05sa90e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Oct 2019 10:23:08 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x94AIftW045278;
        Fri, 4 Oct 2019 10:23:08 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2vdt3pdguf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Oct 2019 10:23:07 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x94AN0ET030028;
        Fri, 4 Oct 2019 10:23:02 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 04 Oct 2019 03:23:00 -0700
Date:   Fri, 4 Oct 2019 13:22:51 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     David Airlie <airlied@linux.ie>
Cc:     Daniel Vetter <daniel@ffwll.ch>, Sam Ravnborg <sam@ravnborg.org>,
        Emil Velikov <emil.velikov@collabora.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] drm/i810: Prevent underflow in ioctl
Message-ID: <20191004102251.GC823@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9399 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910040096
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9399 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910040096
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "used" variables here come from the user in the ioctl and it can be
negative.  It could result in an out of bounds write.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/gpu/drm/i810/i810_dma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i810/i810_dma.c b/drivers/gpu/drm/i810/i810_dma.c
index 2a77823b8e9a..e66c38332df4 100644
--- a/drivers/gpu/drm/i810/i810_dma.c
+++ b/drivers/gpu/drm/i810/i810_dma.c
@@ -728,7 +728,7 @@ static void i810_dma_dispatch_vertex(struct drm_device *dev,
 	if (nbox > I810_NR_SAREA_CLIPRECTS)
 		nbox = I810_NR_SAREA_CLIPRECTS;
 
-	if (used > 4 * 1024)
+	if (used < 0 || used > 4 * 1024)
 		used = 0;
 
 	if (sarea_priv->dirty)
@@ -1048,7 +1048,7 @@ static void i810_dma_dispatch_mc(struct drm_device *dev, struct drm_buf *buf, in
 	if (u != I810_BUF_CLIENT)
 		DRM_DEBUG("MC found buffer that isn't mine!\n");
 
-	if (used > 4 * 1024)
+	if (used < 0 || used > 4 * 1024)
 		used = 0;
 
 	sarea_priv->dirty = 0x7f;
-- 
2.20.1

