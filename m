Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B89C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 18:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0022F20825
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 18:48:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391365AbfIESsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 14:48:12 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:47964 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388235AbfIESsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 14:48:11 -0400
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x85Ikh4d031776;
        Thu, 5 Sep 2019 18:47:43 GMT
Received: from g4t3425.houston.hpe.com (g4t3425.houston.hpe.com [15.241.140.78])
        by mx0b-002e3701.pphosted.com with ESMTP id 2uu0r3bvw5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Sep 2019 18:47:43 +0000
Received: from stormcage.eag.rdlabs.hpecorp.net (stormcage.eag.rdlabs.hpecorp.net [128.162.236.70])
        by g4t3425.houston.hpe.com (Postfix) with ESMTP id 3069D92;
        Thu,  5 Sep 2019 18:47:42 +0000 (UTC)
Received: by stormcage.eag.rdlabs.hpecorp.net (Postfix, from userid 5508)
        id E4529201EAAAB; Thu,  5 Sep 2019 13:47:41 -0500 (CDT)
Message-Id: <20190905184741.820520333@stormcage.eag.rdlabs.hpecorp.net>
References: <20190905184741.256857552@stormcage.eag.rdlabs.hpecorp.net>
User-Agent: quilt/0.46-1
Date:   Thu, 05 Sep 2019 13:47:45 -0500
From:   Mike Travis <mike.travis@hpe.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Hedi Berriche <hedi.berriche@hpe.com>,
        Steve Wahl <steve.wahl@hpe.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH 4/8] x86/platform/uv: Setup UV functions for Hubless UV Systems
Content-Disposition: inline; filename=setup-hubless-init
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-05_06:2019-09-04,2019-09-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 impostorscore=0 adultscore=0 spamscore=0 mlxscore=0 mlxlogscore=888
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1909050176
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add more support for UV systems that do not contain a UV Hub (AKA
"hubless").  This update adds support for additional functions required:

    Use PCH NMI handler instead of a UV Hub NMI handler.

    Initialize the UV BIOS callback interface used to support specific
    UV functions.

Signed-off-by: Mike Travis <mike.travis@hpe.com>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
Reviewed-by: Dimitri Sivanich <dimitri.sivanich@hpe.com>
To: Thomas Gleixner <tglx@linutronix.de>
To: Ingo Molnar <mingo@redhat.com>
To: H. Peter Anvin <hpa@zytor.com>
To: Andrew Morton <akpm@linux-foundation.org>
To: Borislav Petkov <bp@alien8.de>
To: Christoph Hellwig <hch@infradead.org>
Cc: Dimitri Sivanich <dimitri.sivanich@hpe.com>
Cc: Russ Anderson <russ.anderson@hpe.com>
Cc: Hedi Berriche <hedi.berriche@hpe.com>
Cc: Steve Wahl <steve.wahl@hpe.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/kernel/apic/x2apic_uv_x.c |   20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

--- linux.orig/arch/x86/kernel/apic/x2apic_uv_x.c
+++ linux/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -1457,6 +1457,20 @@ static void __init build_socket_tables(v
 	}
 }
 
+/* Initialize UV hubless systems */
+static __init int uv_system_init_hubless(void)
+{
+	int rc;
+
+	/* Setup PCH NMI handler */
+	uv_nmi_setup_hubless();
+
+	/* Init kernel/BIOS interface */
+	rc = uv_bios_init();
+
+	return rc;
+}
+
 static void __init uv_system_init_hub(void)
 {
 	struct uv_hub_info_s hub_info = {0};
@@ -1596,8 +1610,8 @@ static void __init uv_system_init_hub(vo
 }
 
 /*
- * There is a small amount of UV specific code needed to initialize a
- * UV system that does not have a "UV HUB" (referred to as "hubless").
+ * There is a different code path needed to initialize a UV system that does
+ * not have a "UV HUB" (referred to as "hubless").
  */
 void __init uv_system_init(void)
 {
@@ -1607,7 +1621,7 @@ void __init uv_system_init(void)
 	if (is_uv_system())
 		uv_system_init_hub();
 	else
-		uv_nmi_setup_hubless();
+		uv_system_init_hubless();
 }
 
 apic_driver(apic_x2apic_uv_x);

-- 
