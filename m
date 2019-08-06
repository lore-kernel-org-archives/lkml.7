Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A05C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 17:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C19B2075B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 17:25:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PazcMOEE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733127AbfHFRZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 13:25:57 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:37799 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729161AbfHFRZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 13:25:57 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x76HA2qh161644;
        Tue, 6 Aug 2019 17:25:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=6beAYrbmjek/m+Is/s8mOMW8AHrNTc8IovGO2vElIgA=;
 b=PazcMOEE9N/+UfvOtERu+QgGIGJm8qQEDZNLMrHh+cvg6t/3913s67oBcJ4q4MktHPfj
 33Y5QwMfrfKmQzWH4KCHBY5dPYr7FQMutII8TjoCK/VCX3bB9EcWUbSXwLpjDAMIjcjQ
 QbK6Myrv5SDA9n5HKTiJwdOez6HjkOO0hAAKwVKEgU4D/h50lT1QjBpR0aYnI5/psi07
 +bbXAMIjcKym7mE3IE52Bk8wIdmT9j1x2XltzOF4l2TxS2TjLPRcFWNd9bk3q4tR/ZhE
 TGUTEwcUjDk75SzFy60OKwug5ZL7zodpdW1SwBJXATr1Y3h+ZxM0SzYFfXmt0UQY9arx sA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2u527pqgqm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Aug 2019 17:25:51 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x76H8OCf120521;
        Tue, 6 Aug 2019 17:25:51 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2u75bvpga5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Aug 2019 17:25:51 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x76HPotX004263;
        Tue, 6 Aug 2019 17:25:50 GMT
Received: from brm-x32-03.us.oracle.com (/10.80.150.35)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 06 Aug 2019 10:25:50 -0700
From:   Jane Chu <jane.chu@oracle.com>
To:     n-horiguchi@ah.jp.nec.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     linux-nvdimm@lists.01.org
Subject: [PATCH v4 0/2] mm/memory-failure: Poison read receives SIGKILL instead of SIGBUS issue 
Date:   Tue,  6 Aug 2019 11:25:43 -0600
Message-Id: <1565112345-28754-1-git-send-email-jane.chu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9341 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=974
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908060156
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9341 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908060156
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change in v4:
 - remove trailing white space

Changes in v3:
 - move **tk cleanup to its own patch

Changes in v2:
 - move 'tk' allocations internal to add_to_kill(), suggested by Dan;
 - ran checkpatch.pl check, pointed out by Matthew;
 - Noaya pointed out that v1 would have missed the SIGKILL
   if "tk->addr == -EFAULT", since the code returns early.
   Incorporated Noaya's suggestion, also, skip VMAs where
   "tk->size_shift == 0" for zone device page, and deliver SIGBUS
   when "tk->size_shift != 0" so the payload is helpful;
 - added Suggested-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>

Jane Chu (2):
  mm/memory-failure.c clean up around tk pre-allocation
  mm/memory-failure: Poison read receives SIGKILL instead of SIGBUS if
    mmaped more than once

 mm/memory-failure.c | 62 ++++++++++++++++++++++-------------------------------
 1 file changed, 26 insertions(+), 36 deletions(-)

-- 
1.8.3.1

