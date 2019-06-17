Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D176EC31E44
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 04:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B03DA204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 04:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbfFQEmW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 00:42:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48732 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725840AbfFQEmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 00:42:22 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5H4bsTb066826
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 00:42:20 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2t634b1na5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 00:42:20 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <alastair@au1.ibm.com>;
        Mon, 17 Jun 2019 05:42:18 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 17 Jun 2019 05:42:16 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5H4g7tp27001144
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Jun 2019 04:42:07 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5821342042;
        Mon, 17 Jun 2019 04:42:15 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0857F42041;
        Mon, 17 Jun 2019 04:42:15 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 17 Jun 2019 04:42:14 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id DE718A0208;
        Mon, 17 Jun 2019 14:42:13 +1000 (AEST)
From:   "Alastair D'Silva" <alastair@au1.ibm.com>
To:     alastair@d-silva.org
Cc:     Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ocxl: Allow contexts to be attached with a NULL mm
Date:   Mon, 17 Jun 2019 14:41:52 +1000
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19061704-0020-0000-0000-0000034AAC54
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061704-0021-0000-0000-0000219DEF49
Message-Id: <20190617044152.13707-1-alastair@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-17_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=642 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906170042
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alastair D'Silva <alastair@d-silva.org>

If an OpenCAPI context is to be used directly by a kernel driver, there
may not be a suitable mm to use.

The patch makes the mm parameter to ocxl_context_attach optional.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 drivers/misc/ocxl/context.c |  9 ++++++---
 drivers/misc/ocxl/link.c    | 12 ++++++++----
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/ocxl/context.c b/drivers/misc/ocxl/context.c
index bab9c9364184..994563a078eb 100644
--- a/drivers/misc/ocxl/context.c
+++ b/drivers/misc/ocxl/context.c
@@ -69,6 +69,7 @@ static void xsl_fault_error(void *data, u64 addr, u64 dsisr)
 int ocxl_context_attach(struct ocxl_context *ctx, u64 amr, struct mm_struct *mm)
 {
 	int rc;
+	unsigned long pidr = 0;
 
 	// Locks both status & tidr
 	mutex_lock(&ctx->status_mutex);
@@ -77,9 +78,11 @@ int ocxl_context_attach(struct ocxl_context *ctx, u64 amr, struct mm_struct *mm)
 		goto out;
 	}
 
-	rc = ocxl_link_add_pe(ctx->afu->fn->link, ctx->pasid,
-			mm->context.id, ctx->tidr, amr, mm,
-			xsl_fault_error, ctx);
+	if (mm)
+		pidr = mm->context.id;
+
+	rc = ocxl_link_add_pe(ctx->afu->fn->link, ctx->pasid, pidr, ctx->tidr,
+			      amr, mm, xsl_fault_error, ctx);
 	if (rc)
 		goto out;
 
diff --git a/drivers/misc/ocxl/link.c b/drivers/misc/ocxl/link.c
index cce5b0d64505..43542f124807 100644
--- a/drivers/misc/ocxl/link.c
+++ b/drivers/misc/ocxl/link.c
@@ -523,7 +523,8 @@ int ocxl_link_add_pe(void *link_handle, int pasid, u32 pidr, u32 tidr,
 	pe->amr = cpu_to_be64(amr);
 	pe->software_state = cpu_to_be32(SPA_PE_VALID);
 
-	mm_context_add_copro(mm);
+	if (mm)
+		mm_context_add_copro(mm);
 	/*
 	 * Barrier is to make sure PE is visible in the SPA before it
 	 * is used by the device. It also helps with the global TLBI
@@ -546,7 +547,8 @@ int ocxl_link_add_pe(void *link_handle, int pasid, u32 pidr, u32 tidr,
 	 * have a reference on mm_users. Incrementing mm_count solves
 	 * the problem.
 	 */
-	mmgrab(mm);
+	if (mm)
+		mmgrab(mm);
 	trace_ocxl_context_add(current->pid, spa->spa_mem, pasid, pidr, tidr);
 unlock:
 	mutex_unlock(&spa->spa_lock);
@@ -652,8 +654,10 @@ int ocxl_link_remove_pe(void *link_handle, int pasid)
 	if (!pe_data) {
 		WARN(1, "Couldn't find pe data when removing PE\n");
 	} else {
-		mm_context_remove_copro(pe_data->mm);
-		mmdrop(pe_data->mm);
+		if (pe_data->mm) {
+			mm_context_remove_copro(pe_data->mm);
+			mmdrop(pe_data->mm);
+		}
 		kfree_rcu(pe_data, rcu);
 	}
 unlock:
-- 
2.21.0

