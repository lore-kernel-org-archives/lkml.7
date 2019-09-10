Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B90C49ED7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 15:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E762F2168B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 15:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405990AbfIJPAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 11:00:24 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:32249 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405519AbfIJPAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 11:00:17 -0400
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8AEpgQx006956;
        Tue, 10 Sep 2019 15:00:01 GMT
Received: from g2t2354.austin.hpe.com (g2t2354.austin.hpe.com [15.233.44.27])
        by mx0a-002e3701.pphosted.com with ESMTP id 2ux7qqnhnf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Sep 2019 15:00:01 +0000
Received: from stormcage.eag.rdlabs.hpecorp.net (stormcage.eag.rdlabs.hpecorp.net [128.162.236.70])
        by g2t2354.austin.hpe.com (Postfix) with ESMTP id EA71BBD;
        Tue, 10 Sep 2019 14:59:58 +0000 (UTC)
Received: by stormcage.eag.rdlabs.hpecorp.net (Postfix, from userid 5508)
        id 82B40201FCF15; Tue, 10 Sep 2019 09:59:58 -0500 (CDT)
Message-Id: <20190910145839.732237241@stormcage.eag.rdlabs.hpecorp.net>
References: <20190910145839.604369497@stormcage.eag.rdlabs.hpecorp.net>
User-Agent: quilt/0.46-1
Date:   Tue, 10 Sep 2019 09:58:40 -0500
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
Subject: [PATCH 1/8] x86/platform/uv: Save OEM_ID from ACPI MADT probe
Content-Disposition: inline; filename=save-oem_id
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-10_10:2019-09-10,2019-09-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 mlxscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 mlxlogscore=765
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1909100144
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Save the OEM_ID and OEM_TABLE_ID passed to the apic driver probe function
for later use.  Also, convert the char list arg passed from the kernel
to a true null-terminated string.

Signed-off-by: Mike Travis <mike.travis@hpe.com>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
Reviewed-by: Dimitri Sivanich <dimitri.sivanich@hpe.com>
---
 arch/x86/kernel/apic/x2apic_uv_x.c |   16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

--- linux.orig/arch/x86/kernel/apic/x2apic_uv_x.c
+++ linux/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -14,6 +14,7 @@
 #include <linux/memory.h>
 #include <linux/export.h>
 #include <linux/pci.h>
+#include <linux/acpi.h>
 
 #include <asm/e820/api.h>
 #include <asm/uv/uv_mmrs.h>
@@ -31,6 +32,10 @@ static u64			gru_dist_base, gru_first_no
 static u64			gru_dist_lmask, gru_dist_umask;
 static union uvh_apicid		uvh_apicid;
 
+/* Unpack OEM/TABLE ID's to be NULL terminated strings */
+static u8 oem_id[ACPI_OEM_ID_SIZE + 1];
+static u8 oem_table_id[ACPI_OEM_TABLE_ID_SIZE + 1];
+
 /* Information derived from CPUID: */
 static struct {
 	unsigned int apicid_shift;
@@ -248,11 +253,20 @@ static void __init uv_set_apicid_hibit(v
 	}
 }
 
-static int __init uv_acpi_madt_oem_check(char *oem_id, char *oem_table_id)
+static void __init uv_stringify(int len, char *to, char *from)
+{
+	/* Relies on 'to' being NULL chars so result will be NULL terminated */
+	strncpy(to, from, len-1);
+}
+
+static int __init uv_acpi_madt_oem_check(char *_oem_id, char *_oem_table_id)
 {
 	int pnodeid;
 	int uv_apic;
 
+	uv_stringify(sizeof(oem_id), oem_id, _oem_id);
+	uv_stringify(sizeof(oem_table_id), oem_table_id, _oem_table_id);
+
 	if (strncmp(oem_id, "SGI", 3) != 0) {
 		if (strncmp(oem_id, "NSGI", 4) == 0) {
 			uv_hubless_system = true;

-- 

