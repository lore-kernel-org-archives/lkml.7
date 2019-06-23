Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 610D4C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 03:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3534A20679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 03:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fNJ5r5+u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbfFXDcN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 23:32:13 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:35814 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727631AbfFXDcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 23:32:12 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5O3ShbY089746;
        Mon, 24 Jun 2019 03:31:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=tlVKfz5CPyjZKGxJcnmO6SrbNRwAlzyDZppyE/7i6UI=;
 b=fNJ5r5+usUpnj86rMq4dgazRJgfqJXVcodjriERpXVDLCCDX2Zhazz2vXZSP9jUwLUqR
 GyHpp/ZuyDraSD3uL5F0DRYsSCuCdBv1OvP4VTM9mY7jWeca9KaLL2Ywg5iOcuyN/tfV
 e4tShK19KTMa6cUfc5jGmwvKeTGjZyDGzqlNuG76E3uJ3iRBoMhrnLhZMWBJV/RKFyjY
 bJiWafdU9zCLXmRBnrFDxqeSVZ8W83XvSRYQKNMM8CNsXc0/AYpwWERjgs+IFMOph/mX
 1L1xZW+8sfjr0s9Dq6pW10BVs79e7wZKXFBBuWR8kUhwfwob2l/P3YIjlSe/9A9Dtihl Rg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2t9brsuude-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jun 2019 03:31:45 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5O3VVrc157598;
        Mon, 24 Jun 2019 03:31:45 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2t9x1ese1d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jun 2019 03:31:45 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5O3Vi3l001969;
        Mon, 24 Jun 2019 03:31:44 GMT
Received: from z2.cn.oracle.com (/10.182.69.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 23 Jun 2019 20:31:43 -0700
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@kernel.org, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, jgross@suse.com, ndesaulniers@google.com,
        gregkh@linuxfoundation.org,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>
Subject: [PATCH v2] x86/speculation/mds: Eliminate leaks by trace_hardirqs_on()
Date:   Sun, 23 Jun 2019 11:35:04 +0800
Message-Id: <1561260904-29669-2-git-send-email-zhenzhong.duan@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1561260904-29669-1-git-send-email-zhenzhong.duan@oracle.com>
References: <1561260904-29669-1-git-send-email-zhenzhong.duan@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9297 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=801
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906240027
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9297 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=846 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906240027
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move mds_idle_clear_cpu_buffers() after trace_hardirqs_on() to ensure
all store buffer entries are flushed.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
---
-v2: remove pointless changes which made a double flush

 arch/x86/include/asm/mwait.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/mwait.h b/arch/x86/include/asm/mwait.h
index eb0f80c..e28f8b7 100644
--- a/arch/x86/include/asm/mwait.h
+++ b/arch/x86/include/asm/mwait.h
@@ -86,9 +86,9 @@ static inline void __mwaitx(unsigned long eax, unsigned long ebx,
 
 static inline void __sti_mwait(unsigned long eax, unsigned long ecx)
 {
-	mds_idle_clear_cpu_buffers();
-
 	trace_hardirqs_on();
+
+	mds_idle_clear_cpu_buffers();
 	/* "mwait %eax, %ecx;" */
 	asm volatile("sti; .byte 0x0f, 0x01, 0xc9;"
 		     :: "a" (eax), "c" (ecx));
-- 
1.8.3.1

