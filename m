Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC807C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 07:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C66D22CF7
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 07:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hOJj2K/7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbfHUHOO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 03:14:14 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:44934 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727504AbfHUHOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 03:14:14 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7L7DiYf087377;
        Wed, 21 Aug 2019 07:14:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=2P4kNV5f2bdRIjdmMi0NVT3ayqfEeBJ0buEu0sEHelA=;
 b=hOJj2K/7bj8BlIDAFJp6J7fBEtTE+nqLHKwTNcuUtz86WpBSM+zqRcEpa5Y+P/EWDnnQ
 RIzBFeYdrUC3gC5lpm7UewwTkgVom/ERg9mjqb/Y91AgwDMhgLRteL77SEQI6xkqtYMf
 hPWSDs7roAsiSMh4n4wHG91ZeqFP8HxYcIrPyi1WqDeNkYBZGEALWsLe7SqtzJfSwaln
 Bu6NloHak4NreE8LL2ti9GICN1YW3PAjvmSorPUr5kiJVv6uXcAjndcu1XeIbFYPuZM5
 eZDNhcqXn7kUeoXRBGwPm57wqyf4BZ0c8Q3MeS28BZvptyHadGvJXULTvSm3METlHs/N jA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2ue9hpkbe3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Aug 2019 07:14:11 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7L7DACq166327;
        Wed, 21 Aug 2019 07:14:11 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2ugj7pk00t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Aug 2019 07:14:11 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7L7EA2Z029385;
        Wed, 21 Aug 2019 07:14:10 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 21 Aug 2019 00:14:09 -0700
Date:   Wed, 21 Aug 2019 10:14:03 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH] tools/power: intel-speed-select:  Fix a read overflow in
 isst_set_tdp_level_msr()
Message-ID: <20190821071403.GG26957@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9355 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908210078
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9355 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908210078
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The isst_send_msr_command() function will read 8 bytes but we are
passing an address to an int (4 bytes) so it results in a read overflow.

Fixes: 3fb4f7cd472c ("tools/power/x86: A tool to validate Intel Speed Select commands")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 tools/power/x86/intel-speed-select/isst-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/power/x86/intel-speed-select/isst-core.c b/tools/power/x86/intel-speed-select/isst-core.c
index 8de4ac39a008..f724322856ed 100644
--- a/tools/power/x86/intel-speed-select/isst-core.c
+++ b/tools/power/x86/intel-speed-select/isst-core.c
@@ -190,6 +190,7 @@ int isst_get_get_trl(int cpu, int level, int avx_level, int *trl)
 
 int isst_set_tdp_level_msr(int cpu, int tdp_level)
 {
+	unsigned long long level = tdp_level;
 	int ret;
 
 	debug_printf("cpu: tdp_level via MSR %d\n", cpu, tdp_level);
@@ -202,8 +203,7 @@ int isst_set_tdp_level_msr(int cpu, int tdp_level)
 	if (tdp_level > 2)
 		return -1; /* invalid value */
 
-	ret = isst_send_msr_command(cpu, 0x64b, 1,
-				    (unsigned long long *)&tdp_level);
+	ret = isst_send_msr_command(cpu, 0x64b, 1, &level);
 	if (ret)
 		return ret;
 
-- 
2.20.1

