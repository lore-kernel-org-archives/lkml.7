Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E47C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 04:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 820C12087B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 04:08:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GtFN8KxH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbfEQEIa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 00:08:30 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52590 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbfEQEIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 00:08:30 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4H44FtQ155156;
        Fri, 17 May 2019 04:08:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=fbs2klJYRwSjh6U92tbSHWsFn2CAbHAkPfwjVASkuvs=;
 b=GtFN8KxHn6BoVU9RO4RbeGh9sRr4R5Oqr7OqunHBPO0lQAOucqb2LpUXXiro7vHZBTpl
 zn18pgC9Ba/pf8L/cAM2wqXlfUTy/kH0wctwMu+ijNvbOCB09Xx4LTYN9GoTMsBVKNTa
 RpqfKvYj/5mGspglKTyxP8OSob8A7li66BNNR/n2bRooyGDYJTzIgQ1k1sHzcDb1j4r6
 F59pNJl70JWFYpgmMrHQvLi5OkjzSRywaXlkYQG1B2mrvXCyvItJbSXjelKlaninmeQA
 igjxy5kXNurF9PKFc7MYWrKOFbbkoAwPrz8gzAU102QwDIbmOiZpZd5p4Cljgyga+WV3 ng== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2sdntu76t2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 May 2019 04:08:24 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4H47PEL073951;
        Fri, 17 May 2019 04:08:23 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2sgp33ca87-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 May 2019 04:08:23 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4H48Lbi020359;
        Fri, 17 May 2019 04:08:22 GMT
Received: from brm-x32-03.us.oracle.com (/10.80.150.35)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 17 May 2019 04:08:21 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     n-horiguchi@ah.jp.nec.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     linux-nvdimm@lists.01.org
Subject: [PATCH] mm, memory-failure: clarify error message
Date:   Thu, 16 May 2019 22:08:15 -0600
Message-Id: <1558066095-9495-1-git-send-email-jane.chu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9259 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=954
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905170025
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9259 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=984 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905170025
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some user who install SIGBUS handler that does longjmp out
therefore keeping the process alive is confused by the error
message
  "[188988.765862] Memory failure: 0x1840200: Killing
   cellsrv:33395 due to hardware memory corruption"
Slightly modify the error message to improve clarity.

Signed-off-by: Jane Chu <jane.chu@oracle.com>
---
 mm/memory-failure.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index fc8b517..14de5e2 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -216,10 +216,9 @@ static int kill_proc(struct to_kill *tk, unsigned long pfn, int flags)
 	short addr_lsb = tk->size_shift;
 	int ret;
 
-	pr_err("Memory failure: %#lx: Killing %s:%d due to hardware memory corruption\n",
-		pfn, t->comm, t->pid);
-
 	if ((flags & MF_ACTION_REQUIRED) && t->mm == current->mm) {
+		pr_err("Memory failure: %#lx: Killing %s:%d due to hardware memory "
+			"corruption\n", pfn, t->comm, t->pid);
 		ret = force_sig_mceerr(BUS_MCEERR_AR, (void __user *)tk->addr,
 				       addr_lsb, current);
 	} else {
@@ -229,6 +228,8 @@ static int kill_proc(struct to_kill *tk, unsigned long pfn, int flags)
 		 * This could cause a loop when the user sets SIGBUS
 		 * to SIG_IGN, but hopefully no one will do that?
 		 */
+		pr_err("Memory failure: %#lx: Sending SIGBUS to %s:%d due to hardware "
+			"memory corruption\n", pfn, t->comm, t->pid);
 		ret = send_sig_mceerr(BUS_MCEERR_AO, (void __user *)tk->addr,
 				      addr_lsb, t);  /* synchronous? */
 	}
-- 
1.8.3.1

