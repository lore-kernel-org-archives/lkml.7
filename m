Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08CDCA9ECF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 09:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0A8021655
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 09:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WUeVPs72"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbfKDJPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 04:15:03 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:48888 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfKDJPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 04:15:03 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA49EF8h131247;
        Mon, 4 Nov 2019 09:14:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=hE/jxSBVe+1FqR4NlJp5P3S1KuZxeNyQgypPmuBvD4o=;
 b=WUeVPs72wtXFQ1HcHu3qy0rYFoCPaezVIe7bcgpuMZ0sDh+c9otoOCrZO22gd6vJ3KqC
 U7X6+lt8vRG24o0nexMr46cxs7WBHYuqvkp+sX8AreJwg2oEdgLnmrQtJuqDvIMYawpY
 DJrNqDW02f2f8qMSUbe48as1bKRRvtRlScfhzvmjoP5IqOTUa9YavScq9fPlFDZBAvmF
 roEoZPDH20kh4JKBpx5NkWOoTDdczNoFXdDlklv7tWECytFtfNYi+F4+hn6s2oui9vLX
 iMtIxqBlcYvZMdaA5FittRwSR5OR/Rkm04U7MeF0G9vMArgj4lZNT+nwniASI/ugOEv8 rw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2w117tnwxf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Nov 2019 09:14:27 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA49EGTK147171;
        Mon, 4 Nov 2019 09:14:26 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2w1kxm1895-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Nov 2019 09:14:26 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xA49CxRu010162;
        Mon, 4 Nov 2019 09:13:07 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 Nov 2019 01:12:58 -0800
Date:   Mon, 4 Nov 2019 12:12:52 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] locking/lockdep: update the comment for __lock_release()
Message-ID: <20191104091252.GA31509@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9430 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1911040092
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9430 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1911040092
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This changes "to the list" to "from the list" and also deletes the
obsolete comment about the "@nested" argument.  The "nested" argument
was removed in commit 5facae4f3549 ("locking/lockdep: Remove unused
@nested argument from lock_release()").

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 kernel/locking/lockdep.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 8123518f9045..32282e7112d3 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -4208,11 +4208,9 @@ static int __lock_downgrade(struct lockdep_map *lock, unsigned long ip)
 }
 
 /*
- * Remove the lock to the list of currently held locks - this gets
+ * Remove the lock from the list of currently held locks - this gets
  * called on mutex_unlock()/spin_unlock*() (or on a failed
  * mutex_lock_interruptible()).
- *
- * @nested is an hysterical artifact, needs a tree wide cleanup.
  */
 static int
 __lock_release(struct lockdep_map *lock, unsigned long ip)
-- 
2.20.1

