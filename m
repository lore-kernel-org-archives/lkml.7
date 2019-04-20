Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08DB7C282E4
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 21:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC955208C0
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 21:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728546AbfDTVuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 17:50:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36580 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728220AbfDTVuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 17:50:08 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3KLmlBx092106
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2019 17:50:06 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ryydqhv0k-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2019 17:50:06 -0400
Received: from localhost
        by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Sat, 20 Apr 2019 22:50:05 +0100
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
        by e36.co.us.ibm.com (192.168.1.136) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 20 Apr 2019 22:50:01 +0100
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3KLnvvH51839204
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 20 Apr 2019 21:49:57 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 59FA37805C;
        Sat, 20 Apr 2019 21:49:57 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 914957805F;
        Sat, 20 Apr 2019 21:49:55 +0000 (GMT)
Received: from akrowiak-ThinkPad-P50.ibm.com (unknown [9.85.174.45])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Sat, 20 Apr 2019 21:49:55 +0000 (GMT)
From:   Tony Krowiak <akrowiak@linux.ibm.com>
To:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com,
        frankja@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, pmorel@linux.ibm.com,
        pasic@linux.ibm.com, alex.williamson@redhat.com,
        kwankhede@nvidia.com, Tony Krowiak <akrowiak@linux.ibm.com>
Subject: [PATCH v2 6/8] s390: kvm: test CRYCB masks before setting them
Date:   Sat, 20 Apr 2019 17:49:38 -0400
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555796980-27920-1-git-send-email-akrowiak@linux.ibm.com>
References: <1555796980-27920-1-git-send-email-akrowiak@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19042021-0020-0000-0000-00000EDA1D94
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010964; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01191979; UDB=6.00624739; IPR=6.00972782;
 MB=3.00026529; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-20 21:50:03
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042021-0021-0000-0000-000065813CD6
Message-Id: <1555796980-27920-7-git-send-email-akrowiak@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-20_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=683 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904200165
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no sense in blocking all vCPUs to set the masks in the guest's
CRYCB if the mask values will not be changed, so let's verify

Let's verify that mask values will be changed before blocking all vCPUs
in order to set the crypto masks in the guest's CRYCB.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 4638303ba6a8..38835717c815 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2217,12 +2217,43 @@ static void kvm_s390_set_crycb_format(struct kvm *kvm)
 		kvm->arch.crypto.crycbd |= CRYCB_FORMAT1;
 }
 
+static int kvm_arch_crypto_test_masks(struct kvm *kvm, unsigned long *apm,
+				      unsigned long *aqm, unsigned long *adm)
+{
+	int ret;
+	struct kvm_s390_crypto_cb *crycb = kvm->arch.crypto.crycb;
+
+	switch (kvm->arch.crypto.crycbd & CRYCB_FORMAT_MASK) {
+	case CRYCB_FORMAT2: /* APCB1 use 256 bits */
+		ret = bitmap_equal(apm, (unsigned long *)crycb->apcb1.apm, 256);
+		ret &= bitmap_equal(aqm,
+				    (unsigned long *)crycb->apcb1.aqm, 256);
+		ret &= bitmap_equal(adm,
+				    (unsigned long *)crycb->apcb1.adm, 256);
+		break;
+	case CRYCB_FORMAT1:
+	case CRYCB_FORMAT0: /* Fall through both use APCB0 */
+		ret = bitmap_equal(apm, (unsigned long *)crycb->apcb0.apm, 64);
+		ret &= bitmap_equal(aqm, (unsigned long *)crycb->apcb0.aqm, 16);
+		ret &= bitmap_equal(adm, (unsigned long *)crycb->apcb0.adm, 16);
+		break;
+	default:	/* Can not happen */
+		ret = 0;
+		break;
+	}
+	return ret;
+}
+
 void kvm_arch_crypto_set_masks(struct kvm *kvm, unsigned long *apm,
 			       unsigned long *aqm, unsigned long *adm)
 {
 	struct kvm_s390_crypto_cb *crycb = kvm->arch.crypto.crycb;
 
 	mutex_lock(&kvm->lock);
+	if (kvm_arch_crypto_test_masks(kvm, apm, aqm, adm)) {
+		mutex_unlock(&kvm->lock);
+		return;
+	}
 	kvm_s390_vcpu_block_all(kvm);
 
 	switch (kvm->arch.crypto.crycbd & CRYCB_FORMAT_MASK) {
-- 
2.7.4

