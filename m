Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0814CC49ED6
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 13:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3D8921479
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 13:54:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730390AbfIJNyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 09:54:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:63760 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726032AbfIJNyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 09:54:05 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8ADksOi026953
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 09:54:04 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2uxbmukstw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 09:53:53 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <groug@kaod.org>;
        Tue, 10 Sep 2019 14:53:50 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 10 Sep 2019 14:53:47 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8ADrLQw40173978
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Sep 2019 13:53:21 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0ADAF42041;
        Tue, 10 Sep 2019 13:53:46 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BDBC442047;
        Tue, 10 Sep 2019 13:53:45 +0000 (GMT)
Received: from bahia.tls.ibm.com (unknown [9.101.4.41])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 10 Sep 2019 13:53:45 +0000 (GMT)
Subject: [PATCH] powerpc/xive: Fix bogus error code returned by OPAL
From:   Greg Kurz <groug@kaod.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Paul Mackerras <paulus@ozlabs.org>,
        =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Tue, 10 Sep 2019 15:53:45 +0200
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19091013-0012-0000-0000-00000349863E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19091013-0013-0000-0000-00002183EB19
Message-Id: <156812362556.1866243.7399893138425681517.stgit@bahia.tls.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-10_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=796 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909100136
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a bug in skiboot that causes the OPAL_XIVE_ALLOCATE_IRQ call
to return the 32-bit value 0xffffffff when OPAL has run out of IRQs.
Unfortunatelty, OPAL return values are signed 64-bit entities and
errors are supposed to be negative. If that happens, the linux code
confusingly treats 0xffffffff as a valid IRQ number and panics at some
point.

A fix was recently merged in skiboot:

e97391ae2bb5 ("xive: fix return value of opal_xive_allocate_irq()")

but we need a workaround anyway to support older skiboots already
on the field.

Internally convert 0xffffffff to OPAL_RESOURCE which is the usual error
returned upon resource exhaustion.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 arch/powerpc/sysdev/xive/native.c |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/sysdev/xive/native.c b/arch/powerpc/sysdev/xive/native.c
index 37987c815913..c35583f84f9f 100644
--- a/arch/powerpc/sysdev/xive/native.c
+++ b/arch/powerpc/sysdev/xive/native.c
@@ -231,6 +231,15 @@ static bool xive_native_match(struct device_node *node)
 	return of_device_is_compatible(node, "ibm,opal-xive-vc");
 }
 
+static int64_t opal_xive_allocate_irq_fixup(uint32_t chip_id)
+{
+	s64 irq = opal_xive_allocate_irq(chip_id);
+
+#define XIVE_ALLOC_NO_SPACE	0xffffffff /* No possible space */
+	return
+		irq == XIVE_ALLOC_NO_SPACE ? OPAL_RESOURCE : irq;
+}
+
 #ifdef CONFIG_SMP
 static int xive_native_get_ipi(unsigned int cpu, struct xive_cpu *xc)
 {
@@ -238,7 +247,7 @@ static int xive_native_get_ipi(unsigned int cpu, struct xive_cpu *xc)
 
 	/* Allocate an IPI and populate info about it */
 	for (;;) {
-		irq = opal_xive_allocate_irq(xc->chip_id);
+		irq = opal_xive_allocate_irq_fixup(xc->chip_id);
 		if (irq == OPAL_BUSY) {
 			msleep(OPAL_BUSY_DELAY_MS);
 			continue;
@@ -259,7 +268,7 @@ u32 xive_native_alloc_irq(void)
 	s64 rc;
 
 	for (;;) {
-		rc = opal_xive_allocate_irq(OPAL_XIVE_ANY_CHIP);
+		rc = opal_xive_allocate_irq_fixup(OPAL_XIVE_ANY_CHIP);
 		if (rc != OPAL_BUSY)
 			break;
 		msleep(OPAL_BUSY_DELAY_MS);

