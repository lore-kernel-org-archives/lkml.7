Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FFFC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 12:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DF37212F5
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 12:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LyMN2+S4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730156AbfFXM6l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 08:58:41 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37100 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfFXM6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 08:58:39 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5OCsGs3142975;
        Mon, 24 Jun 2019 12:58:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=KLBclTheGjubyUpbAx+QHqK/8lekhX1YiHOk2x91wZU=;
 b=LyMN2+S4uJvGq8XmNHJVvnpR67iAGd3vC6p4NbKp3UGqqh4hnJ9n8WxpSKKmi4Jq8JWn
 vo8c0Il2jxhJWGEvd9ahOI+n4i2himzhdZR4vvA2N/aDN0CqcyDLMII1wgbKEvvm5A/P
 Zm3lD6r1Gzixk0z+MBa7gZWBtxhw05yVJgoYZBEETB2c+RnkUQ5LfS95bmEd/U9tTXHG
 q60lAks2RT9jdaavL6NcYWtwKXbVxTs95p5DBu7Aq/dLJwxj7e/imHCpHNXsiduY+B1J
 HtFLAFK4xvdKTw5CCwv6wsjcnxfP4Gd7hBPb70KhOrNxKahyU28PKMzhUq9unFMU5nMV Jg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2t9cyq66qa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jun 2019 12:58:20 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5OCwBQl108078;
        Mon, 24 Jun 2019 12:58:19 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2t9p6tjnhh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jun 2019 12:58:19 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5OCwHri010630;
        Mon, 24 Jun 2019 12:58:17 GMT
Received: from z2.cn.oracle.com (/10.182.69.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 24 Jun 2019 05:58:16 -0700
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@kernel.org, bp@alien8.de, hpa@zytor.com,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        sstabellini@kernel.org, Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        xen-devel@lists.xenproject.org
Subject: [PATCH 3/6] x86: Add nopv parameter to disable PV extensions
Date:   Sun, 23 Jun 2019 21:01:40 +0800
Message-Id: <1561294903-6166-3-git-send-email-zhenzhong.duan@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1561294903-6166-1-git-send-email-zhenzhong.duan@oracle.com>
References: <1561294903-6166-1-git-send-email-zhenzhong.duan@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9297 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906240106
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9297 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906240105
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In virtualization environment, PV extensions (drivers, interrupts,
timers, etc) are enabled in the majority of use cases which is the
best option.

However, in some cases (kexec not fully working, benchmarking)
we want to disable PV extensions. As such introduce the
'nopv' parameter that will do it.

There is already 'xen_nopv' parameter for XEN platform but not for
others. 'xen_nopv' can then be removed with this change.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
Cc: xen-devel@lists.xenproject.org
---
 Documentation/admin-guide/kernel-parameters.txt |  4 ++++
 arch/x86/kernel/cpu/hypervisor.c                | 11 +++++++++++
 2 files changed, 15 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 138f666..b352f36 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5268,6 +5268,10 @@
 			improve timer resolution at the expense of processing
 			more timer interrupts.
 
+	nopv=		[X86]
+			Disables the PV optimizations forcing the guest to run
+			as generic guest with no PV drivers.
+
 	xirc2ps_cs=	[NET,PCMCIA]
 			Format:
 			<irq>,<irq_mask>,<io>,<full_duplex>,<do_sound>,<lockup_hack>[,<irq2>[,<irq3>[,<irq4>]]]
diff --git a/arch/x86/kernel/cpu/hypervisor.c b/arch/x86/kernel/cpu/hypervisor.c
index 479ca47..4f2c875 100644
--- a/arch/x86/kernel/cpu/hypervisor.c
+++ b/arch/x86/kernel/cpu/hypervisor.c
@@ -85,10 +85,21 @@ static void __init copy_array(const void *src, void *target, unsigned int size)
 			to[i] = from[i];
 }
 
+static bool nopv;
+static __init int xen_parse_nopv(char *arg)
+{
+	nopv = true;
+	return 0;
+}
+early_param("nopv", xen_parse_nopv);
+
 void __init init_hypervisor_platform(void)
 {
 	const struct hypervisor_x86 *h;
 
+	if (nopv)
+		return;
+
 	h = detect_hypervisor_vendor();
 
 	if (!h)
-- 
1.8.3.1

