Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE9D5CA9EA0
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 03:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8263321872
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 03:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QeZz5+ID"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbfJZDZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 23:25:15 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:58298 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfJZDZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 23:25:14 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9Q3OTDY036445;
        Sat, 26 Oct 2019 03:24:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2019-08-05;
 bh=88h25RwWxlkFw6Utuvr/Tusi+Xq0QgqhBFiEZkcA1vg=;
 b=QeZz5+ID73y0yzcg5x4A69Hds90xi+60cWXgo22tM2uhiuxhhQQvzxVeg+UYrMDINSK7
 rVNBB1csBTOTxLn3RfAgZdnO+f540YkgkKM6sqmpn1QP++mjotnZuKspki3a1xe+GKy/
 co7eMhSQi496Y6PWtrcpvs6nGKE95Y1S/qJo8PjZpLtoPGwVHqjF4QlaD9fWLBxHCkit
 7ggJWFQYDdkR8QZixKErS28G1VTOa8klDcxp8WJ/DcwM3x8In4yev2f/sfbaiPrnt8cq
 mr0zvkX8gkTHmHIRP9eEZrvlJrEQxbMOSie6uNwZH5K7g0/TML0M8iE0x+Jn8JbMzbXk 5A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2vve3pr0sp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 26 Oct 2019 03:24:42 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9Q3OKVV082854;
        Sat, 26 Oct 2019 03:24:42 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2vvc6mmwfm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 26 Oct 2019 03:24:42 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9Q3Of0X022211;
        Sat, 26 Oct 2019 03:24:41 GMT
Received: from z2.cn.oracle.com (/10.182.71.218)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 25 Oct 2019 20:24:40 -0700
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     kvm@vger.kernel.org, mtosatti@redhat.com,
        joao.m.martins@oracle.com, rafael.j.wysocki@intel.com,
        rkrcmar@redhat.com, pbonzini@redhat.com,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>
Subject: [PATCH 0/5] misc fixes on halt-poll code both KVM and guest
Date:   Sat, 26 Oct 2019 11:23:54 +0800
Message-Id: <1572060239-17401-1-git-send-email-zhenzhong.duan@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9421 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910260033
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9421 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910260034
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The last two patches are similar with 2nd and 3rd, but counterpart for guest.

Zhenzhong Duan (5):
  KVM: simplify branch check in host poll code
  KVM: add a check to ensure grow start value is nonzero
  KVM: ensure pool time is longer than block_ns
  cpuidle-haltpoll: add a check to ensure grow start value is nonzero
  cpuidle-haltpoll: fix up the branch check

 drivers/cpuidle/governors/haltpoll.c | 21 +++++++++++++++------
 virt/kvm/kvm_main.c                  | 18 ++++++++++++------
 2 files changed, 27 insertions(+), 12 deletions(-)

-- 
1.8.3.1

