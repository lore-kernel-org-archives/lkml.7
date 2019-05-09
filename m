Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CDEC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 16:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E82962173B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 16:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="c5sPk/UW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfEIQJ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 12:09:27 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41398 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbfEIQJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 12:09:26 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x49G41OP084863;
        Thu, 9 May 2019 16:09:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=0ju7H5Gj2niL871BBOn8Ga4UpgCjBl63hHSs8faALiA=;
 b=c5sPk/UWjvgCBKfpceUko8ZPiLjVtYZaJKfjeFrS72vCgisTcb/wqPpU408mjOlf1zAt
 N1dzXSOlBOYvO2FncI11/uZ6nX23dOWmdBrDMUjR1+aL79jZzdLe0yfSDijwAMGgDo7t
 Jwd8WePcB86Gdcg6BPC/D+blKGY+7lLdlbQc2A15l75HX8D8fJUSlZ9YvE3sij/XmWAR
 XtmMALWB/8Q2p3irGRUnm4mJb2te+1BFPLTPjInczB9VrVVJKnEKiaBZLN9I5+4vaK3N
 qmmdijdE3imqVZbniq7DGl8Ig6/MmEpd721BGHN8sPajfXcxwCio29Ce9ZhcvXUEPi2z tA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2s94bgc066-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 May 2019 16:09:19 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x49G75FA107183;
        Thu, 9 May 2019 16:07:19 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2scpy5rqhu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 May 2019 16:07:19 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x49G7G0I017023;
        Thu, 9 May 2019 16:07:16 GMT
Received: from oracle.com (/75.80.107.76)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 09 May 2019 09:07:16 -0700
From:   Larry Bassel <larry.bassel@oracle.com>
To:     mike.kravetz@oracle.com, willy@infradead.org,
        dan.j.williams@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
Cc:     Larry Bassel <larry.bassel@oracle.com>
Subject: [PATCH, RFC 1/2] Add config option to enable FS/DAX PMD sharing
Date:   Thu,  9 May 2019 09:05:32 -0700
Message-Id: <1557417933-15701-2-git-send-email-larry.bassel@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1557417933-15701-1-git-send-email-larry.bassel@oracle.com>
References: <1557417933-15701-1-git-send-email-larry.bassel@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9252 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905090092
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9252 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905090092
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If enabled, sharing of FS/DAX PMDs will be attempted.

Signed-off-by: Larry Bassel <larry.bassel@oracle.com>
---
 arch/x86/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index e721273..e11702e 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -297,6 +297,9 @@ config ARCH_SUSPEND_POSSIBLE
 config ARCH_WANT_HUGE_PMD_SHARE
 	def_bool y
 
+config MAY_SHARE_FSDAX_PMD
+	def_bool y
+
 config ARCH_WANT_GENERAL_HUGETLB
 	def_bool y
 
-- 
1.8.3.1

