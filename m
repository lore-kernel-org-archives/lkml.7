Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CCEC49ED9
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 14:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B09420872
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 14:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404508AbfIJOqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 10:46:47 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:33204 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726060AbfIJOqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 10:46:38 -0400
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8AEfR5i010516;
        Tue, 10 Sep 2019 14:46:23 GMT
Received: from g2t2353.austin.hpe.com (g2t2353.austin.hpe.com [15.233.44.26])
        by mx0b-002e3701.pphosted.com with ESMTP id 2ux1w0r7fc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Sep 2019 14:46:22 +0000
Received: from stormcage.eag.rdlabs.hpecorp.net (stormcage.eag.rdlabs.hpecorp.net [128.162.236.70])
        by g2t2353.austin.hpe.com (Postfix) with ESMTP id 926C497;
        Tue, 10 Sep 2019 14:46:21 +0000 (UTC)
Received: by stormcage.eag.rdlabs.hpecorp.net (Postfix, from userid 5508)
        id 4A79E201FCF23; Tue, 10 Sep 2019 09:46:21 -0500 (CDT)
Message-Id: <20190910144610.406850287@stormcage.eag.rdlabs.hpecorp.net>
References: <20190910144609.909602978@stormcage.eag.rdlabs.hpecorp.net>
User-Agent: quilt/0.46-1
Date:   Tue, 10 Sep 2019 09:46:13 -0500
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
        Steve Wahl <steve.wahl@hpe.com>,
        Justin Ernst <justin.ernst@hpe.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] x86/platform/uv: Setup UV functions for Hubless UV Systems
Content-Disposition: inline; filename=setup-hubless-init
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-10_10:2019-09-10,2019-09-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=655 mlxscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 phishscore=0 spamscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1909100142
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

