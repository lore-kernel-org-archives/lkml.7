Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4052AC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 08:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16BA620684
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 08:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbfDZI46 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 04:56:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50154 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725800AbfDZI46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 04:56:58 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3Q8sSmE035366
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 04:56:57 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2s3x3x2hyf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 04:56:56 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Fri, 26 Apr 2019 09:56:54 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 26 Apr 2019 09:56:53 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3Q8upI159244714
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Apr 2019 08:56:51 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 492F6AE051;
        Fri, 26 Apr 2019 08:56:51 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9087CAE045;
        Fri, 26 Apr 2019 08:56:50 +0000 (GMT)
Received: from morel-ThinkPad-W530.boeblingen.de.ibm.com (unknown [9.145.15.72])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 26 Apr 2019 08:56:50 +0000 (GMT)
From:   Pierre Morel <pmorel@linux.ibm.com>
To:     david@redhat.com
Cc:     linux-kernel@vger.kernel.org, cohuck@redhat.com,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        frankja@linux.ibm.com, akrowiak@linux.ibm.com,
        borntraeger@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com
Subject: [PATCH] KVM: s390: vsie: Do not shadow CRYCB when no AP and no keys
Date:   Fri, 26 Apr 2019 10:56:50 +0200
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 19042608-0016-0000-0000-000002756B8D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042608-0017-0000-0000-000032D1E7CA
Message-Id: <1556269010-22258-1-git-send-email-pmorel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-26_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=722 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904260064
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the guest do not have AP instructions nor Key management
we should return without shadowing the CRYCB.

We did not check correctly in the past.

Fixes: b10bd9a256ae ("s390: vsie: Use effective CRYCBD.31 to check CRYCBD
validity")
Fixes: 6ee74098201b ("KVM: s390: vsie: allow CRYCB FORMAT-0")

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/vsie.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index c6983d9..ac411e9 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -290,6 +290,7 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	u8 ecb3_flags;
 	u32 ecd_flags;
 	int apie_h;
+	int apie_s;
 	int key_msk = test_kvm_facility(vcpu->kvm, 76);
 	int fmt_o = crycbd_o & CRYCB_FORMAT_MASK;
 	int fmt_h = vcpu->arch.sie_block->crycbd & CRYCB_FORMAT_MASK;
@@ -298,7 +299,8 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	scb_s->crycbd = 0;
 
 	apie_h = vcpu->arch.sie_block->eca & ECA_APIE;
-	if (!apie_h && (!key_msk || fmt_o == CRYCB_FORMAT0))
+	apie_s = apie_h & scb_o->eca;
+	if (!apie_s && (!key_msk || (fmt_o == CRYCB_FORMAT0)))
 		return 0;
 
 	if (!crycb_addr)
@@ -309,7 +311,7 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 		    ((crycb_addr + 128) & PAGE_MASK))
 			return set_validity_icpt(scb_s, 0x003CU);
 
-	if (apie_h && (scb_o->eca & ECA_APIE)) {
+	if (apie_s) {
 		ret = setup_apcb(vcpu, &vsie_page->crycb, crycb_addr,
 				 vcpu->kvm->arch.crypto.crycb,
 				 fmt_o, fmt_h);
-- 
2.7.4

