Return-Path: <SRS0=64FT=XQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A58FC49ED7
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 06:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CDD22184C
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 06:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="e9F2FhzK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730941AbfIUGAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Sep 2019 02:00:46 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:37850 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbfIUGAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Sep 2019 02:00:45 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8L603gp125363;
        Sat, 21 Sep 2019 06:00:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=SMoq7TZ0NiQ8MxwG7eDaPmFmoJSB00R5hX+Hdmm23DU=;
 b=e9F2FhzKB9HwNYraob4tnlRcxJM+Iso37WuafIE7+YVkeoJeiQHf6Q7roNQxj183DXr0
 x4Jp6awk1sfeBi+bFs+UHVkmllwANrVTLEcnaYEO660MuCbh45eI4+HZUrJ01SNkSSpA
 YquicE8QOhZAeW0Ex6LRkFIPb+ZcUbG2KM2pxsFWy5DkWTjab+Czs0tfinvebnnjk/J4
 Um5i1AbYjvTQeCmodOTY5Nvx6ifKBxha4wtoEWzCuhxr92wDkXTAYJ2hdXfjG4X9EqM+
 u6UGO7ax8yxnx3yRXFfrXEzfjka09psln+ZEvKg6TC1nL8WBNjJ5OE1hPaFJV474AU6t eQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2v5b9t87wc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 21 Sep 2019 06:00:40 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8L5wc19114889;
        Sat, 21 Sep 2019 06:00:40 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2v59x8vpp5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 21 Sep 2019 06:00:39 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8L60csn018213;
        Sat, 21 Sep 2019 06:00:38 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 21 Sep 2019 06:00:37 +0000
Date:   Sat, 21 Sep 2019 09:00:31 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Song Liu <song@kernel.org>, NeilBrown <neilb@suse.de>
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] md/raid0: Fix an error message in raid0_make_request()
Message-ID: <20190921060031.GB18726@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9386 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909210065
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9386 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909210066
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first argument to WARN() is supposed to be a condition.  The
original code will just print the mdname() instead of the full warning
message.

Fixes: c84a1372df92 ("md/raid0: avoid RAID0 data corruption due to layout confusion.")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/md/raid0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
index f61693e59684..3956ea502f97 100644
--- a/drivers/md/raid0.c
+++ b/drivers/md/raid0.c
@@ -615,7 +615,7 @@ static bool raid0_make_request(struct mddev *mddev, struct bio *bio)
 		tmp_dev = map_sector(mddev, zone, sector, &sector);
 		break;
 	default:
-		WARN("md/raid0:%s: Invalid layout\n", mdname(mddev));
+		WARN(1, "md/raid0:%s: Invalid layout\n", mdname(mddev));
 		bio_io_error(bio);
 		return true;
 	}
-- 
2.20.1

