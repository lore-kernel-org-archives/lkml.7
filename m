Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B61A2C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 15:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8432F2075C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 15:39:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="eJgEV+dZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfK2Pj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 10:39:28 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:38516 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726608AbfK2Pj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 10:39:28 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xATFWTk9031802;
        Fri, 29 Nov 2019 16:39:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=5L2Vr3+QLNgwFXp04+K0bONLGB0EfCr01rCMHP53768=;
 b=eJgEV+dZafiEO6YVpl5EZ8dR+suAZQFrKw3vi19BnGvXP0CfE/F4B1SyNsAQpYwQRnhl
 9VzgSbl4KrCYocj5neRTyuz5WntKeF5b3i/1YXa2mFrXuheMoQXE/XdYIrIPsY3bRYZ2
 AuESte0HNfpHSMidnRTwsVwFmJPkIN9G7So6YYKfE06/fAH0wWNQasPu/KcqZrmja4tg
 z9oD8aKOzPf1HXFwDmZDvzKyJHTZsYBOz9d0wJiq7R/joI7NUlStLIUiAOywV+b3Soh9
 x/tZ1D9H9QvddFEzbY3eh17NU9E1Pc1PcBvXj+f2tnZzXAKAl1R0D1Y9pkjMoqel6ggA QA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2whcxyrfrc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Nov 2019 16:39:16 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6585310002A;
        Fri, 29 Nov 2019 16:39:16 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5BA05212AFD;
        Fri, 29 Nov 2019 16:39:16 +0100 (CET)
Received: from localhost (10.75.127.47) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 29 Nov 2019 16:39:16
 +0100
From:   Fabien Dessenne <fabien.dessenne@st.com>
To:     Jessica Yu <jeyu@kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fabien Dessenne <fabien.dessenne@st.com>
Subject: [PATCH v2] moduleparam: fix kerneldoc
Date:   Fri, 29 Nov 2019 16:39:12 +0100
Message-ID: <1575041952-17157-1-git-send-email-fabien.dessenne@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG5NODE1.st.com (10.75.127.13) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-29_04:2019-11-29,2019-11-29 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document missing @args in xxx_param_cb().

Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
---
Changes since v1: do not replace 'lvalue' with 'value'
---
 include/linux/moduleparam.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
index e5c3e23..5215198 100644
--- a/include/linux/moduleparam.h
+++ b/include/linux/moduleparam.h
@@ -160,6 +160,7 @@ struct kparam_array
  * module_param_cb - general callback for a module/cmdline parameter
  * @name: a valid C identifier which is the parameter name.
  * @ops: the set & get operations for this parameter.
+ * @args: args for @ops
  * @perm: visibility in sysfs.
  *
  * The ops can have NULL set or get functions.
@@ -176,6 +177,7 @@ struct kparam_array
  *                    to be evaluated before certain initcall level
  * @name: a valid C identifier which is the parameter name.
  * @ops: the set & get operations for this parameter.
+ * @args: args for @ops
  * @perm: visibility in sysfs.
  *
  * The ops can have NULL set or get functions.
-- 
2.7.4

