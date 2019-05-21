Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF31C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 04:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7EDE21019
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 04:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbfEUEyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 00:54:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48404 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727484AbfEUEyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 00:54:37 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4L4qTFd033257
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 00:54:36 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2sm7yq4x1x-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 00:54:35 -0400
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Tue, 21 May 2019 05:54:35 +0100
Received: from b03cxnp07028.gho.boulder.ibm.com (9.17.130.15)
        by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 21 May 2019 05:54:32 +0100
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4L4sUm132506058
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 May 2019 04:54:30 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 94263C6055;
        Tue, 21 May 2019 04:54:30 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0E879C605D;
        Tue, 21 May 2019 04:54:14 +0000 (GMT)
Received: from morokweng.localdomain.com (unknown [9.80.203.157])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 21 May 2019 04:54:13 +0000 (GMT)
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
        Anshuman Khandual <anshuman.linux@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christoph Hellwig <hch@lst.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mike Anderson <andmike@linux.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Ram Pai <linuxram@us.ibm.com>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        Ryan Grimm <grimm@linux.vnet.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: [PATCH 12/12] powerpc/configs: Enable secure guest support in pseries and ppc64 defconfigs
Date:   Tue, 21 May 2019 01:49:12 -0300
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190521044912.1375-1-bauerman@linux.ibm.com>
References: <20190521044912.1375-1-bauerman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19052104-0016-0000-0000-000009B70A3A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011134; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01206343; UDB=6.00633451; IPR=6.00987311;
 MB=3.00026980; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-21 04:54:34
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052104-0017-0000-0000-0000434D4C99
Message-Id: <20190521044912.1375-13-bauerman@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-20_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=887 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905210031
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ryan Grimm <grimm@linux.vnet.ibm.com>

Enables running as a secure guest in platforms with an Ultravisor.

Signed-off-by: Ryan Grimm <grimm@linux.vnet.ibm.com>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 arch/powerpc/configs/ppc64_defconfig   | 1 +
 arch/powerpc/configs/pseries_defconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/ppc64_defconfig
index d7c381009636..725297438320 100644
--- a/arch/powerpc/configs/ppc64_defconfig
+++ b/arch/powerpc/configs/ppc64_defconfig
@@ -31,6 +31,7 @@ CONFIG_DTL=y
 CONFIG_SCANLOG=m
 CONFIG_PPC_SMLPAR=y
 CONFIG_IBMEBUS=y
+CONFIG_PPC_SVM=y
 CONFIG_PPC_MAPLE=y
 CONFIG_PPC_PASEMI=y
 CONFIG_PPC_PASEMI_IOMMU=y
diff --git a/arch/powerpc/configs/pseries_defconfig b/arch/powerpc/configs/pseries_defconfig
index 62e12f61a3b2..724a574fe4b2 100644
--- a/arch/powerpc/configs/pseries_defconfig
+++ b/arch/powerpc/configs/pseries_defconfig
@@ -42,6 +42,7 @@ CONFIG_DTL=y
 CONFIG_SCANLOG=m
 CONFIG_PPC_SMLPAR=y
 CONFIG_IBMEBUS=y
+CONFIG_PPC_SVM=y
 # CONFIG_PPC_PMAC is not set
 CONFIG_RTAS_FLASH=m
 CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y

