Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 461F8CA9EA0
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 03:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 148F621872
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 03:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="emoRtX2t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbfJZD1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 23:27:16 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:60514 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfJZD1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 23:27:15 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9Q3PxxT037712;
        Sat, 26 Oct 2019 03:26:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=GAD53LJIDAlRMuq0ujQb7sRDQvwZBR3lHpUfNYQyzRw=;
 b=emoRtX2taVpbl0COt6aH3LFB8PSzDNJr81cNQFCgJYXe8nWJNDZfehs0pFe6xFYe5Rli
 Y1GLydjtPXyWRd2/JkxeNDP2/vBLcPzNXyB809QF4sM8yHNQK0pSxe9E3lo7tOdUelCb
 r16ywIz9HLWssPVMD06HQfj/nRuSzBYnCdvWdhlf0+zh9iBvmUxJZ5T66tDeM9x5NE5Y
 DJvpIfd8zdEppGTobtCNa+MROE5Uw3/SoioeuL42lA2+IeNYTz9w4IHBTzae8z/ZcobH
 pUuV0gwNZkepMmEDbQZJQW5Hkq7cR8FOomv+OzQFSXL3oQ61Id4HYwM05s4wtqiXmzdT sA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2vve3pr11k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 26 Oct 2019 03:26:49 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9Q3OKvK082899;
        Sat, 26 Oct 2019 03:24:48 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2vvc6mmwjw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 26 Oct 2019 03:24:48 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9Q3OmRc025649;
        Sat, 26 Oct 2019 03:24:48 GMT
Received: from z2.cn.oracle.com (/10.182.71.218)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 25 Oct 2019 20:24:47 -0700
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     kvm@vger.kernel.org, mtosatti@redhat.com,
        joao.m.martins@oracle.com, rafael.j.wysocki@intel.com,
        rkrcmar@redhat.com, pbonzini@redhat.com,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>
Subject: [PATCH 3/5] KVM: ensure pool time is longer than block_ns
Date:   Sat, 26 Oct 2019 11:23:57 +0800
Message-Id: <1572060239-17401-4-git-send-email-zhenzhong.duan@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1572060239-17401-1-git-send-email-zhenzhong.duan@oracle.com>
References: <1572060239-17401-1-git-send-email-zhenzhong.duan@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9421 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=911
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910260033
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9421 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=998 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910260034
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When (block_ns == vcpu->halt_poll_ns), there is not a margin so that
vCPU may still get into block state unnecessorily.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
---
 virt/kvm/kvm_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 1b6fe3b..48a1f1a 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2371,7 +2371,7 @@ void kvm_vcpu_block(struct kvm_vcpu *vcpu)
 		if (!vcpu_valid_wakeup(vcpu)) {
 			shrink_halt_poll_ns(vcpu);
 		} else if (halt_poll_ns) {
-			if (block_ns <= vcpu->halt_poll_ns)
+			if (block_ns < vcpu->halt_poll_ns)
 				;
 			/* we had a short halt and our poll time is too small */
 			else if (block_ns < halt_poll_ns)
-- 
1.8.3.1

