Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED08C432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 11:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E569521D7A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 11:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VK0mZPIn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404062AbfIYLFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 07:05:18 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:54724 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390976AbfIYLFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 07:05:17 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8PB4NGc047373;
        Wed, 25 Sep 2019 11:05:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=MBMgZ0BS4GRCuOFPNrcE79XIjxoS+eByZyMuxfQnsGk=;
 b=VK0mZPInewqOcxbZggvFObtAINDPeWqISMGMsIHkIMgsDH/dTmYyFXICUIxnNxq4Njsa
 jMeAvn21tvh+uvbuz9qnxXsGCuMl5DErzM0Anqp8OFXRtO/906OFdfIEik/0bo1bTLp6
 3tOtCPmKH2V0OXhT2NB5ACQ6K6cMC7wNWdevlv/kuchbGe1p6jf0O1Bbelj/TQtoslsU
 RgFln2ZoPgwTiX8Vpt8rXNfiI+hX2OKlCnHUrFb7kPwzS2wVWFcdQhxZRntRuoQo9fH+
 Ka+kTS94+zAb7fzsrtRuiJzDwes02r89g7qbBKE9KxJlwp5IdfQC9iCzljpoHN+TYQgY GQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2v5btq3wvr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Sep 2019 11:05:00 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8PB439H145908;
        Wed, 25 Sep 2019 11:04:59 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2v82tjpmwc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Sep 2019 11:04:59 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8PB4ujr010709;
        Wed, 25 Sep 2019 11:04:56 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 25 Sep 2019 04:04:56 -0700
Date:   Wed, 25 Sep 2019 14:04:49 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     tglx@linutronix.de, Enrico Weigelt <info@metux.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] mm, vmpressure: Fix a signedness bug in
 vmpressure_register_event()
Message-ID: <20190925110449.GO3264@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9390 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909250113
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9390 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909250113
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "mode" and "level" variables are enums and in this context GCC will
treat them as unsigned ints so the error handling is never triggered.

I also removed the bogus initializer because it isn't required any more
and it's sort of confusing.

Fixes: 3cadfa2b9497 ("mm/vmpressure.c: convert to use match_string() helper")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 mm/vmpressure.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/vmpressure.c b/mm/vmpressure.c
index f3b50811497a..fe077500cf20 100644
--- a/mm/vmpressure.c
+++ b/mm/vmpressure.c
@@ -362,7 +362,7 @@ int vmpressure_register_event(struct mem_cgroup *memcg,
 	struct vmpressure *vmpr = memcg_to_vmpressure(memcg);
 	struct vmpressure_event *ev;
 	enum vmpressure_modes mode = VMPRESSURE_NO_PASSTHROUGH;
-	enum vmpressure_levels level = -1;
+	enum vmpressure_levels level;
 	char *spec, *spec_orig;
 	char *token;
 	int ret = 0;
@@ -376,7 +376,7 @@ int vmpressure_register_event(struct mem_cgroup *memcg,
 	/* Find required level */
 	token = strsep(&spec, ",");
 	level = match_string(vmpressure_str_levels, VMPRESSURE_NUM_LEVELS, token);
-	if (level < 0) {
+	if ((int)level < 0) {
 		ret = level;
 		goto out;
 	}
@@ -385,7 +385,7 @@ int vmpressure_register_event(struct mem_cgroup *memcg,
 	token = strsep(&spec, ",");
 	if (token) {
 		mode = match_string(vmpressure_str_modes, VMPRESSURE_NUM_MODES, token);
-		if (mode < 0) {
+		if ((int)mode < 0) {
 			ret = mode;
 			goto out;
 		}
-- 
2.20.1

