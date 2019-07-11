Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C18D5C742B9
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 938002083B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dT0B4osZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbfGLMEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 08:04:55 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:59388 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbfGLMEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 08:04:54 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6CC408T193538;
        Fri, 12 Jul 2019 12:04:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=cmT+Q26he6loqTunuFKBeKHkRTXIORCg1WJGoyTRd0U=;
 b=dT0B4osZgrJIBjgIG/p8aeYQD6xxSoEnCYjXXaYuYzsGKOv4LR1wp93zJyKSTmygCSTp
 ph73BeOol2YBxWwyvpj38coMoLYOI+cVJZrxfQcWnXol4g5Vhre3eD85sxsxSsoGSu8A
 GJlrREG2eNQDebVAVAHPGheUGv+XBUlucOwWsZCOAbN+RHXjk9TmN9CvX2cWeQPUQsEn
 RJgYIgohkM4CapajncSQK6g2hxYctkZhY4fKZr9JCIM1Tpk168u7sPAV+RrMBo8f9pEO
 9GNJkT2qcB28xgvOK9MKeZmQ5vuPv4YMYiGZiobxNe+0h25W7NyK7Zdryc7tcYbX1m7L VA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2tjk2u5af6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jul 2019 12:04:10 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6CC3Qgd095638;
        Fri, 12 Jul 2019 12:04:09 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2tpefd290c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jul 2019 12:04:09 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6CC4849020751;
        Fri, 12 Jul 2019 12:04:08 GMT
Received: from z2.cn.oracle.com (/10.182.69.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 12 Jul 2019 04:58:39 -0700
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com,
        jgross@suse.com, sstabellini@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>
Subject: [PATCH v7 4/5] x86/paravirt: Remove const mark from x86_hyper_xen_hvm variable
Date:   Thu, 11 Jul 2019 20:02:11 +0800
Message-Id: <1562846532-32152-5-git-send-email-zhenzhong.duan@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1562846532-32152-1-git-send-email-zhenzhong.duan@oracle.com>
References: <1562846532-32152-1-git-send-email-zhenzhong.duan@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9315 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907120132
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9315 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907120132
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

.. as "nopv" support needs it to be changeable at boot up stage.

Checkpatch report warning, so move variable declarations from
hypervisor.c to hypervisor.h

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
---
 arch/x86/include/asm/hypervisor.h | 8 ++++++++
 arch/x86/kernel/cpu/hypervisor.c  | 8 --------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/hypervisor.h b/arch/x86/include/asm/hypervisor.h
index f7b4c53..e41cbf2 100644
--- a/arch/x86/include/asm/hypervisor.h
+++ b/arch/x86/include/asm/hypervisor.h
@@ -58,6 +58,14 @@ struct hypervisor_x86 {
 	bool ignore_nopv;
 };
 
+extern const struct hypervisor_x86 x86_hyper_vmware;
+extern const struct hypervisor_x86 x86_hyper_ms_hyperv;
+extern const struct hypervisor_x86 x86_hyper_xen_pv;
+extern const struct hypervisor_x86 x86_hyper_kvm;
+extern const struct hypervisor_x86 x86_hyper_jailhouse;
+extern const struct hypervisor_x86 x86_hyper_acrn;
+extern struct hypervisor_x86 x86_hyper_xen_hvm;
+
 extern bool nopv;
 extern enum x86_hypervisor_type x86_hyper_type;
 extern void init_hypervisor_platform(void);
diff --git a/arch/x86/kernel/cpu/hypervisor.c b/arch/x86/kernel/cpu/hypervisor.c
index 7eaad41..553bfbf 100644
--- a/arch/x86/kernel/cpu/hypervisor.c
+++ b/arch/x86/kernel/cpu/hypervisor.c
@@ -26,14 +26,6 @@
 #include <asm/processor.h>
 #include <asm/hypervisor.h>
 
-extern const struct hypervisor_x86 x86_hyper_vmware;
-extern const struct hypervisor_x86 x86_hyper_ms_hyperv;
-extern const struct hypervisor_x86 x86_hyper_xen_pv;
-extern const struct hypervisor_x86 x86_hyper_xen_hvm;
-extern const struct hypervisor_x86 x86_hyper_kvm;
-extern const struct hypervisor_x86 x86_hyper_jailhouse;
-extern const struct hypervisor_x86 x86_hyper_acrn;
-
 static const __initconst struct hypervisor_x86 * const hypervisors[] =
 {
 #ifdef CONFIG_XEN_PV
-- 
1.8.3.1

