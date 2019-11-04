Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE41ACA9ECF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 09:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D0FC2245D
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 09:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Rk94t5TF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbfKDJKd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 04:10:33 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:41616 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfKDJKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 04:10:32 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA49976c100924;
        Mon, 4 Nov 2019 09:10:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2019-08-05;
 bh=roilGUmbFv/GpGLtZL/JxWvuhLiWtGDGU3pEf7QNJdU=;
 b=Rk94t5TFt6sQB93LOLcjE2UVxWCD+WxZ+mvEPU8fy7ivzRucxQzIy+wgxxE2pjp5Qulr
 K8hbfz/xzcTcM1O3k3JY73zsUT0fQMfrFeBqD2BXJhBL3IZwSQkqNAH7LaTUOz7uvMaP
 ljepEcmGujHrXRCD6ZyzrOJPsJT+S7N66rhED72WvKSb2pFeJ6ebtUC1QCmQTSjZ9uth
 ibivx/2KRHh5HyWsvWOjbdq5xx4lLjbWWvAdVMDdLFiHOX2DeKDDDWx2UY5tb/X38qHa
 S8rpShX7P5gDwJpwFoIsdR6UNN+NhHVOAiJNmqx2IOCI4jPWcQ+TZHqbhUy84Pcz7QbH ug== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2w12eqwpyh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Nov 2019 09:10:14 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA499EGY090692;
        Mon, 4 Nov 2019 09:10:14 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2w1kxcvkdm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Nov 2019 09:10:14 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xA49AC4Q007859;
        Mon, 4 Nov 2019 09:10:12 GMT
Received: from z2.cn.oracle.com (/10.182.71.218)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 Nov 2019 01:10:11 -0800
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     yamada.masahiro@socionext.com, jeyu@kernel.org,
        gladkov.alexey@gmail.com, rusty@rustcorp.com.au,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>
Subject: [PATCH] moduleparam: fix parameter description mismatch
Date:   Mon,  4 Nov 2019 17:09:37 +0800
Message-Id: <1572858577-8349-1-git-send-email-zhenzhong.duan@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9430 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1911040091
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9430 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1911040091
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first parameter of module_param is @name, but @value is used
in description. Fix it.

Fixes: 546970bc6afc ("param: add kerneldoc to moduleparam.h")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
---
 include/linux/moduleparam.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
index 5ba250d..e5c3e23 100644
--- a/include/linux/moduleparam.h
+++ b/include/linux/moduleparam.h
@@ -100,11 +100,11 @@ struct kparam_array
 
 /**
  * module_param - typesafe helper for a module/cmdline parameter
- * @value: the variable to alter, and exposed parameter name.
+ * @name: the variable to alter, and exposed parameter name.
  * @type: the type of the parameter
  * @perm: visibility in sysfs.
  *
- * @value becomes the module parameter, or (prefixed by KBUILD_MODNAME and a
+ * @name becomes the module parameter, or (prefixed by KBUILD_MODNAME and a
  * ".") the kernel commandline parameter.  Note that - is changed to _, so
  * the user can use "foo-bar=1" even for variable "foo_bar".
  *
-- 
1.8.3.1

