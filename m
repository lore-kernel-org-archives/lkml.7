Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8FE0C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 09:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5E9E2084F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 09:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oG7eN65w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbfEOJvt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 05:51:49 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:56828 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfEOJvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 05:51:49 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4F9iIYM108706;
        Wed, 15 May 2019 09:51:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=hTSKDL8zkeZ4HUn7umTph6LN7jixr5+DzfTaKalFJUg=;
 b=oG7eN65wu9iqD+5CbxfZghtCGh+tzsvaQy7ytoPvzLlmC2lA+bx75unguEMMJd+OghgY
 QkH20/NOAnRsuzhYUNAXOwAl+YlrwpzS6topKKvaDHmJ+Guwd6FoR+WHI8yHzhfhj5Tq
 jHjbYpRxG+vBMGVhteYO2Y1vayR2wxyNvoFvz9fKa8x9+s3XHhNCMOSNPNn9Kq7fUrWX
 UhToDeHcaqhPTsv5CvSulGupHL/BG6FDE1GQKNwJEQGz8FeM8GT2x53cDIjwBRWJjAkS
 HUFFyyUc0Pl8RDxa/bMblLY0GG5qI0WjAVfY7jqsUUP33f5jJMEIPV6BXjXwQEBEPgcS bQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2sdnttuph6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 May 2019 09:51:43 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4F9pMKt020222;
        Wed, 15 May 2019 09:51:42 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2sggdur2nm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 May 2019 09:51:42 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4F9pdcq005716;
        Wed, 15 May 2019 09:51:39 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 15 May 2019 02:51:39 -0700
Date:   Wed, 15 May 2019 12:51:30 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        Kevin Wang <kevin1.wang@amd.com>
Cc:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Huang Rui <ray.huang@amd.com>,
        Likun Gao <Likun.Gao@amd.com>,
        Chengming Gui <Jack.Gui@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] drm/amd/powerplay: fix locking in smu_feature_set_supported()
Message-ID: <20190515095130.GF3409@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9257 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905150063
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9257 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905150063
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a typo so the code unlocks twice instead of taking the lock and
then releasing it.

Fixes: f14a323db5b0 ("drm/amd/powerplay: implement update enabled feature state to smc for smu11")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 52d919a8b70a..85ac29af5363 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -310,7 +310,7 @@ int smu_feature_set_supported(struct smu_context *smu, int feature_id,
 
 	WARN_ON(feature_id > feature->feature_num);
 
-	mutex_unlock(&feature->mutex);
+	mutex_lock(&feature->mutex);
 	if (enable)
 		test_and_set_bit(feature_id, feature->supported);
 	else
-- 
2.20.1

