Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A81D1C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 11:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B0042070D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 11:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="0T7FC52l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbfE2LLA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 07:11:00 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:36010 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfE2LLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 07:11:00 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4TB46qZ050499;
        Wed, 29 May 2019 11:10:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=j3HAaoMqE6iuqyfvW0nAhvODR9j2mUzCGvByfduj3lw=;
 b=0T7FC52lvVRETlu4Q2nJLBteQPUIiBdTb9iykHn5qi1kSA56R3oDOwbFQ+YoEQf8qLPu
 15x/91qY7jMjVLLfUF3imVRRNq0Li/sKD+jgzUFviCE0Nw4GzBqTr68y26M6d58MRm9p
 HxrevIN7lisSCzyNknHoOWs9QXi4ax4Ceiwvrj3a1mNef5vgQnY3MS5xC9rOEtkuJjNJ
 XYGDgmeBeAU/s1lw+ZmCMkVT/1pAqM3dTpImiZ4Is5bGHhiy4molzBAcj+KTIZkYS4y0
 nGOt5UF+VuSeQ2D5AefIEvTItFEDbsfTFVXd9/rln2lhLSGe+xLc/VTWnj9I4gzzXMiK xw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 2spu7dh5m9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 May 2019 11:10:51 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4TBA0Qp024008;
        Wed, 29 May 2019 11:10:50 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2sr31v6rfq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 May 2019 11:10:50 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4TBAms6002516;
        Wed, 29 May 2019 11:10:48 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 May 2019 04:10:48 -0700
Date:   Wed, 29 May 2019 14:10:41 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     David Airlie <airlied@linux.ie>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] agp: Re-order a condition to please static checkers
Message-ID: <20190529111041.GE19119@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9271 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905290075
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9271 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905290075
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's nicer to check for integer overflow first and then check for if
the "page_count" is within bounds, otherwise static checkers complain.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/char/agp/generic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/agp/generic.c b/drivers/char/agp/generic.c
index 658664a5a5aa..89901e5710bf 100644
--- a/drivers/char/agp/generic.c
+++ b/drivers/char/agp/generic.c
@@ -227,8 +227,8 @@ struct agp_memory *agp_allocate_memory(struct agp_bridge_data *bridge,
 		return NULL;
 
 	cur_memory = atomic_read(&bridge->current_memory_agp);
-	if ((cur_memory + page_count > bridge->max_memory_agp) ||
-	    (cur_memory + page_count < page_count))
+	if ((cur_memory + page_count < page_count) ||
+	    (cur_memory + page_count > bridge->max_memory_agp))
 		return NULL;
 
 	if (type >= AGP_USER_TYPES) {
-- 
2.20.1

