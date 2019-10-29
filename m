Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21951CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 10:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E157A20862
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 10:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eiNLadDt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731547AbfJ2KxO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 06:53:14 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:59242 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfJ2KxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 06:53:14 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9TAmsZc139653;
        Tue, 29 Oct 2019 10:53:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=R8aCAQPt7tXsKDaniy2Dzrc4ISudeNlHfc000ItekbA=;
 b=eiNLadDtEKIcHkCMmkMdCN1M6sKK18PySw1Lk7d2APMhhthgpuoriRtyU5azi9TjM8MR
 3uxBBZe69W3XmzKVuveyf0zZAfUs1rNI+oazo9qfXPvXD87x5NlJXmv78hCV00uaS86P
 4MsucSvLWU9wew8Zh5bfPwXcDTf78NJd7rjrfgh+mwBov6S3dK8TqAFay9PwcRO0d5bS
 8PEzmgfqMKnwLF3kADQm0tWfhzR2tPuET7KneSt73HmvHR+Mgyf5yTVnylKNthM9Jst1
 bZDrJQqPiCjJQQR+wR/YArMZ12CQw7jbb/PecUdga3FEs+JUvJ7KnC4hkDaIeoR/pkNV 5w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2vve3q86w0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Oct 2019 10:53:10 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9TAmL7o017939;
        Tue, 29 Oct 2019 10:51:10 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2vxj8fxw2c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Oct 2019 10:51:09 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9TAp6KA007919;
        Tue, 29 Oct 2019 10:51:08 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 29 Oct 2019 03:51:05 -0700
Date:   Tue, 29 Oct 2019 13:50:58 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.co>,
        linux-sparse@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: detecting misuse of of_get_property
Message-ID: <20191029104917.GI1944@kadam>
References: <ec277c12-c608-6326-7723-be8cab4f524a@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec277c12-c608-6326-7723-be8cab4f524a@rasmusvillemoes.dk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9424 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=806
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910290113
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9424 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=963 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910290113
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This should probably work?

regards,
dan carpenter

diff --git a/check_list.h b/check_list.h
index 564bd1c2..5fa9a269 100644
--- a/check_list.h
+++ b/check_list.h
@@ -191,6 +191,7 @@ CK(check_nospec_barrier)
 CK(check_spectre)
 CK(check_spectre_second_half)
 CK(check_implicit_dependencies)
+CK(check_of_get_property)
 
 /* wine specific stuff */
 CK(check_wine_filehandles)
diff --git a/check_of_get_property.c b/check_of_get_property.c
new file mode 100644
index 00000000..b7aa8824
--- /dev/null
+++ b/check_of_get_property.c
@@ -0,0 +1,47 @@
+/*
+ * Copyright (C) 2019 Oracle.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see http://www.gnu.org/copyleft/gpl.txt
+ */
+
+#include "smatch.h"
+#include "smatch_slist.h"
+
+static int my_id;
+
+static void match_of_get_property(const char *fn, struct expression *expr, void *unused)
+{
+	struct expression *left = expr->left;
+	struct symbol *type;
+
+	type = get_type(left);
+	if (!type || type->type != SYM_PTR)
+		return;
+	type = get_base_type(type);
+	if (type_bits(type) == 8)
+		return;
+	if (type->type == SYM_RESTRICT)
+		return;
+	sm_warning("'%s' returns big endian data", fn);
+}
+
+void check_of_get_property(int id)
+{
+	my_id = id;
+
+	if (option_project != PROJ_KERNEL)
+		return;
+
+	add_function_assign_hook("of_get_property", &match_of_get_property, NULL);
+}
