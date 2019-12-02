Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3513C432C3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 09:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86F1C2231B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 09:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="KwSYsYv9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbfLBJBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 04:01:45 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:23814 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726087AbfLBJBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 04:01:45 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB28uqsK024786;
        Mon, 2 Dec 2019 10:01:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=xJSCoF7uUHStyU5OcsO3VSav2wz6CuhovW+cwvZNC0Q=;
 b=KwSYsYv9scHiQoM03z9oli12C/h35lJz6m+7TB+4I4RPTRZQQT8WywaE91e/QcIZemrh
 p0LjvzxzRnVXf77+5SLGAsbTuIVmpQPNI8l9zGUnifVAhtmLQhWMf4f14yeR9W+A0Fdu
 eZdRlEVWSIjMIGLuSWrz65FA0ATqSLEcIkh62Z3aVuUoY2cKiSWYQTIhDW7ECRVDQsQv
 3nNuakHw9cDJOSiWIv9T72xtLAwR2zt12jUVmx34E18G3kH3PDOUShf9Ux4YcmPr8vRy
 y6/Iyk4DYBoLeQG4pvywAXZ8HBoDk61GfmPASDYN/Pis2PyZwsCVzwG7mmMg+01nCN0/ lg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2wkf2xgq8h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Dec 2019 10:01:25 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D9415100038;
        Mon,  2 Dec 2019 10:01:23 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7DD2E2ACD4A;
        Mon,  2 Dec 2019 10:01:23 +0100 (CET)
Received: from localhost (10.75.127.46) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 2 Dec 2019 10:01:23
 +0100
From:   Fabien Dessenne <fabien.dessenne@st.com>
To:     Jessica Yu <jeyu@kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fabien Dessenne <fabien.dessenne@st.com>
Subject: [PATCH v3] moduleparam: fix kerneldoc
Date:   Mon, 2 Dec 2019 10:01:17 +0100
Message-ID: <1575277277-4435-1-git-send-email-fabien.dessenne@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-02_01:2019-11-29,2019-12-02 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document missing @arg in xxx_param_cb().
Describe all parameters of module_param_[named_]unsafe() and all
*_param_cb() to make ./scripts/kernel-doc happy.

Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
---
Changes since v2: @arg not @args + fix other kernel-doc warnings
Changes since v1: do not replace 'lvalue' with 'value'
---
 include/linux/moduleparam.h | 82 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 77 insertions(+), 5 deletions(-)

diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
index e5c3e23..3ef917f 100644
--- a/include/linux/moduleparam.h
+++ b/include/linux/moduleparam.h
@@ -128,6 +128,9 @@ struct kparam_array
 
 /**
  * module_param_unsafe - same as module_param but taints kernel
+ * @name: the variable to alter, and exposed parameter name.
+ * @type: the type of the parameter
+ * @perm: visibility in sysfs.
  */
 #define module_param_unsafe(name, type, perm)			\
 	module_param_named_unsafe(name, name, type, perm)
@@ -150,6 +153,10 @@ struct kparam_array
 
 /**
  * module_param_named_unsafe - same as module_param_named but taints kernel
+ * @name: a valid C identifier which is the parameter name.
+ * @value: the actual lvalue to alter.
+ * @type: the type of the parameter
+ * @perm: visibility in sysfs.
  */
 #define module_param_named_unsafe(name, value, type, perm)		\
 	param_check_##type(name, &(value));				\
@@ -160,6 +167,7 @@ struct kparam_array
  * module_param_cb - general callback for a module/cmdline parameter
  * @name: a valid C identifier which is the parameter name.
  * @ops: the set & get operations for this parameter.
+ * @arg: args for @ops
  * @perm: visibility in sysfs.
  *
  * The ops can have NULL set or get functions.
@@ -171,36 +179,96 @@ struct kparam_array
 	__module_param_call(MODULE_PARAM_PREFIX, name, ops, arg, perm, -1,    \
 			    KERNEL_PARAM_FL_UNSAFE)
 
+#define __level_param_cb(name, ops, arg, perm, level)			\
+	__module_param_call(MODULE_PARAM_PREFIX, name, ops, arg, perm, level, 0)
 /**
- * <level>_param_cb - general callback for a module/cmdline parameter
- *                    to be evaluated before certain initcall level
+ * core_param_cb - general callback for a module/cmdline parameter
+ *                 to be evaluated before core initcall level
  * @name: a valid C identifier which is the parameter name.
  * @ops: the set & get operations for this parameter.
+ * @arg: args for @ops
  * @perm: visibility in sysfs.
  *
  * The ops can have NULL set or get functions.
  */
-#define __level_param_cb(name, ops, arg, perm, level)			\
-	__module_param_call(MODULE_PARAM_PREFIX, name, ops, arg, perm, level, 0)
-
 #define core_param_cb(name, ops, arg, perm)		\
 	__level_param_cb(name, ops, arg, perm, 1)
 
+/**
+ * postcore_param_cb - general callback for a module/cmdline parameter
+ *                     to be evaluated before postcore initcall level
+ * @name: a valid C identifier which is the parameter name.
+ * @ops: the set & get operations for this parameter.
+ * @arg: args for @ops
+ * @perm: visibility in sysfs.
+ *
+ * The ops can have NULL set or get functions.
+ */
 #define postcore_param_cb(name, ops, arg, perm)		\
 	__level_param_cb(name, ops, arg, perm, 2)
 
+/**
+ * arch_param_cb - general callback for a module/cmdline parameter
+ *                 to be evaluated before arch initcall level
+ * @name: a valid C identifier which is the parameter name.
+ * @ops: the set & get operations for this parameter.
+ * @arg: args for @ops
+ * @perm: visibility in sysfs.
+ *
+ * The ops can have NULL set or get functions.
+ */
 #define arch_param_cb(name, ops, arg, perm)		\
 	__level_param_cb(name, ops, arg, perm, 3)
 
+/**
+ * subsys_param_cb - general callback for a module/cmdline parameter
+ *                   to be evaluated before subsys initcall level
+ * @name: a valid C identifier which is the parameter name.
+ * @ops: the set & get operations for this parameter.
+ * @arg: args for @ops
+ * @perm: visibility in sysfs.
+ *
+ * The ops can have NULL set or get functions.
+ */
 #define subsys_param_cb(name, ops, arg, perm)		\
 	__level_param_cb(name, ops, arg, perm, 4)
 
+/**
+ * fs_param_cb - general callback for a module/cmdline parameter
+ *               to be evaluated before fs initcall level
+ * @name: a valid C identifier which is the parameter name.
+ * @ops: the set & get operations for this parameter.
+ * @arg: args for @ops
+ * @perm: visibility in sysfs.
+ *
+ * The ops can have NULL set or get functions.
+ */
 #define fs_param_cb(name, ops, arg, perm)		\
 	__level_param_cb(name, ops, arg, perm, 5)
 
+/**
+ * device_param_cb - general callback for a module/cmdline parameter
+ *                   to be evaluated before device initcall level
+ * @name: a valid C identifier which is the parameter name.
+ * @ops: the set & get operations for this parameter.
+ * @arg: args for @ops
+ * @perm: visibility in sysfs.
+ *
+ * The ops can have NULL set or get functions.
+ */
 #define device_param_cb(name, ops, arg, perm)		\
 	__level_param_cb(name, ops, arg, perm, 6)
 
+/**
+ * late_param_cb - general callback for a module/cmdline parameter
+ *                 to be evaluated before late initcall level
+ * @name: a valid C identifier which is the parameter name.
+ * @ops: the set & get operations for this parameter.
+ * @arg: args for @ops
+ * @perm: visibility in sysfs.
+ *
+ * The ops can have NULL set or get functions.
+ */
 #define late_param_cb(name, ops, arg, perm)		\
 	__level_param_cb(name, ops, arg, perm, 7)
 
@@ -263,6 +331,10 @@ static inline void kernel_param_unlock(struct module *mod)
 
 /**
  * core_param_unsafe - same as core_param but taints kernel
+ * @name: the name of the cmdline and sysfs parameter (often the same as var)
+ * @var: the variable
+ * @type: the type of the parameter
+ * @perm: visibility in sysfs
  */
 #define core_param_unsafe(name, var, type, perm)		\
 	param_check_##type(name, &(var));				\
-- 
2.7.4

