Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D4DCA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 18:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5942520679
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 18:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CAURuji1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731583AbfJ2S2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 14:28:01 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:37134 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727282AbfJ2S2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 14:28:01 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9TIOKxm171399;
        Tue, 29 Oct 2019 18:27:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=3AATR/URPY9uyZaZu/wUmJ2Mmcno1iZta5grAKv46Tg=;
 b=CAURuji1EtN3K6OGy/DGSnsNq4Qj9vpPCto45l5eIF6ATqG1GT6ryOu3pgZmH7zXKCSo
 XJh0NAUoOkB7TYTQHqIfWZsQi6E/LdjOwnWgHPpYYTPdgpN+PcK+GoY4Fi0V/5nKMC0m
 iuhLFcnZfdWtMQ8a1MEjLRCc5vlWyhgxOmMrjjiVwbXeuRYXwDOTNvdHxJDuVtYyDJWY
 xfQ7yt8cBntk0Uj0coyhf2vex2ThVTN+/UlLaemfy+Qh134rQ/d9lWC9l4LZwmb4H44T
 6qT3pgVePGxMzci203Cy1u9N089JXkkZzO86jT7R7U+PHRT3wM13EIH4NE5W8bPE7nqk NQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2vve3qb3je-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Oct 2019 18:27:51 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9TI8SEf052470;
        Tue, 29 Oct 2019 18:27:50 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2vxj8gqhyy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Oct 2019 18:27:50 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9TIRmHE013828;
        Tue, 29 Oct 2019 18:27:48 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 29 Oct 2019 11:27:47 -0700
Date:   Tue, 29 Oct 2019 21:27:42 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Kukjin Kim <kgene@kernel.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] soc: samsung: exynos-asv: Potential NULL dereference in
 exynos_asv_update_opps()
Message-ID: <20191029182742.GC17569@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9425 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910290160
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9425 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910290161
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dev_pm_opp_get_opp_table() returns error pointers if it's disabled
in the config and it returns NULL if there is an error.  This code only
checks for error pointers so it could lead to an Oops inside the
dev_pm_opp_put_opp_table() function.

Fixes: 5ea428595cc5 ("soc: samsung: Add Exynos Adaptive Supply Voltage driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
When we add a new driver, could we specify the which prefix will be used
going forward?  In other words commit 5ea428595cc5 could have the
prefix "soc: samsung: exynos-asv: Add Exynos Adaptive Supply Voltage
driver".  The "exynos-asv" bit was missing so the first person to send a
fix has to guess what is desired.

 drivers/soc/samsung/exynos-asv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/samsung/exynos-asv.c b/drivers/soc/samsung/exynos-asv.c
index 8abf4dfaa5c5..30bb7b7cc769 100644
--- a/drivers/soc/samsung/exynos-asv.c
+++ b/drivers/soc/samsung/exynos-asv.c
@@ -93,7 +93,7 @@ static int exynos_asv_update_opps(struct exynos_asv *asv)
 			continue;
 
 		opp_table = dev_pm_opp_get_opp_table(cpu);
-		if (IS_ERR(opp_table))
+		if (IS_ERR_OR_NULL(opp_table))
 			continue;
 
 		if (!last_opp_table || opp_table != last_opp_table) {
-- 
2.20.1

