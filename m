Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 612C6CA9EBC
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 03:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3490E21872
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 03:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EB3kZtgk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbfJZDZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 23:25:21 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:58374 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbfJZDZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 23:25:19 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9Q3OQEV036376;
        Sat, 26 Oct 2019 03:25:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=rJ3ijEuVct75QavmF6Pc/dSkrCxgST4YcNmIBmcfHRw=;
 b=EB3kZtgkCMEbFQK3+E/TIDpCIUMJcCD053EY0K6gxwBLgyNnrA0b46jnKr5H6dMxudVG
 beCSJaaVQrez5oGYyXYt0AK2+V0H9KlvTIv9SfQ6iS51qU3BMGUlXwzYpxIhFFRcCGbv
 Zl4wSE9P6XAiF+6DQOreBBKolp6XhT1+eXi9Dhm6ccWJcsxuDEXWAbJTwh9D5bo5p56/
 yldmq1SR4a52nNgOlFvWuxBckeI7jVpp5KwRxg0Vac7agVVudAcRob+yXTSO/eQaqqN1
 5SyIRnm7L6c7rZXruOc/to7R3cLPHCdPdSGygr7Tq7A1lnTOAI0X9CCio992XROJdjpu bg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2vve3pr0tg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 26 Oct 2019 03:25:04 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9Q3P2Iw138479;
        Sat, 26 Oct 2019 03:25:03 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2vvdg6hms7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 26 Oct 2019 03:25:03 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9Q3Oqw1025707;
        Sat, 26 Oct 2019 03:24:52 GMT
Received: from z2.cn.oracle.com (/10.182.71.218)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 25 Oct 2019 20:24:52 -0700
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     kvm@vger.kernel.org, mtosatti@redhat.com,
        joao.m.martins@oracle.com, rafael.j.wysocki@intel.com,
        rkrcmar@redhat.com, pbonzini@redhat.com,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>
Subject: [PATCH 5/5] cpuidle-haltpoll: fix up the branch check
Date:   Sat, 26 Oct 2019 11:23:59 +0800
Message-Id: <1572060239-17401-6-git-send-email-zhenzhong.duan@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1572060239-17401-1-git-send-email-zhenzhong.duan@oracle.com>
References: <1572060239-17401-1-git-send-email-zhenzhong.duan@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9421 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910260033
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9421 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910260034
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure pool time is longer than block_ns, so there is a margin to
avoid vCPU get into block state unnecessorily.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
---
 drivers/cpuidle/governors/haltpoll.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpuidle/governors/haltpoll.c b/drivers/cpuidle/governors/haltpoll.c
index 4b00d7a..59eadaf 100644
--- a/drivers/cpuidle/governors/haltpoll.c
+++ b/drivers/cpuidle/governors/haltpoll.c
@@ -81,9 +81,9 @@ static void adjust_poll_limit(struct cpuidle_device *dev, unsigned int block_us)
 	u64 block_ns = block_us*NSEC_PER_USEC;
 
 	/* Grow cpu_halt_poll_us if
-	 * cpu_halt_poll_us < block_ns < guest_halt_poll_us
+	 * cpu_halt_poll_us <= block_ns < guest_halt_poll_us
 	 */
-	if (block_ns > dev->poll_limit_ns && block_ns <= guest_halt_poll_ns) {
+	if (block_ns >= dev->poll_limit_ns && block_ns < guest_halt_poll_ns) {
 		val = dev->poll_limit_ns * guest_halt_poll_grow;
 
 		/*
@@ -101,7 +101,7 @@ static void adjust_poll_limit(struct cpuidle_device *dev, unsigned int block_us)
 			val = guest_halt_poll_ns;
 
 		dev->poll_limit_ns = val;
-	} else if (block_ns > guest_halt_poll_ns &&
+	} else if (block_ns >= guest_halt_poll_ns &&
 		   guest_halt_poll_allow_shrink) {
 		unsigned int shrink = guest_halt_poll_shrink;
 
-- 
1.8.3.1

