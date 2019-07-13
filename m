Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE4DC742DD
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 06:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22C6E217D4
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 06:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbfGMGAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jul 2019 02:00:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57914 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726274AbfGMGAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 02:00:49 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6D5uLsl020918
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2019 02:00:48 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tq8vh93dx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2019 02:00:47 -0400
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Sat, 13 Jul 2019 07:00:47 +0100
Received: from b03cxnp07028.gho.boulder.ibm.com (9.17.130.15)
        by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 13 Jul 2019 07:00:43 +0100
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6D60gUO33161678
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 13 Jul 2019 06:00:42 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 819CFC605A;
        Sat, 13 Jul 2019 06:00:42 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9FF0CC6061;
        Sat, 13 Jul 2019 06:00:39 +0000 (GMT)
Received: from morokweng.localdomain.com (unknown [9.85.135.203])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Sat, 13 Jul 2019 06:00:39 +0000 (GMT)
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
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: [PATCH v2 01/13] powerpc/pseries: Introduce option to build secure virtual machines
Date:   Sat, 13 Jul 2019 03:00:11 -0300
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190713060023.8479-1-bauerman@linux.ibm.com>
References: <20190713060023.8479-1-bauerman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19071306-0036-0000-0000-00000AD65FE7
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011419; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01231434; UDB=6.00648705; IPR=6.01012726;
 MB=3.00027699; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-13 06:00:46
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071306-0037-0000-0000-00004C91A6A1
Message-Id: <20190713060023.8479-2-bauerman@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-13_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907130070
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce CONFIG_PPC_SVM to control support for secure guests and include
Ultravisor-related helpers when it is selected

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 arch/powerpc/include/asm/ultravisor.h  |  2 +-
 arch/powerpc/kernel/Makefile           |  4 +++-
 arch/powerpc/platforms/pseries/Kconfig | 11 +++++++++++
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/ultravisor.h b/arch/powerpc/include/asm/ultravisor.h
index a5e4516c8ddb..f5dc5af739b8 100644
--- a/arch/powerpc/include/asm/ultravisor.h
+++ b/arch/powerpc/include/asm/ultravisor.h
@@ -28,7 +28,7 @@ extern int early_init_dt_scan_ultravisor(unsigned long node, const char *uname,
  * This call supports up to 6 arguments and 4 return arguments. Use
  * UCALL_BUFSIZE to size the return argument buffer.
  */
-#if defined(CONFIG_PPC_POWERNV)
+#if defined(CONFIG_PPC_POWERNV) || defined(CONFIG_PPC_SVM)
 long ucall(unsigned long opcode, unsigned long *retbuf, ...);
 #else
 static long ucall(unsigned long opcode, unsigned long *retbuf, ...)
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 929f79d3e6a9..ea671f03eba2 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -155,7 +155,9 @@ endif
 
 obj-$(CONFIG_EPAPR_PARAVIRT)	+= epapr_paravirt.o epapr_hcalls.o
 obj-$(CONFIG_KVM_GUEST)		+= kvm.o kvm_emul.o
-obj-$(CONFIG_PPC_POWERNV)	+= ultravisor.o ucall.o
+ifneq ($(CONFIG_PPC_POWERNV)$(CONFIG_PPC_SVM),)
+obj-y				+= ultravisor.o ucall.o
+endif
 
 # Disable GCOV, KCOV & sanitizers in odd or sensitive code
 GCOV_PROFILE_prom_init.o := n
diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
index f7b484f55553..d09deb05bb66 100644
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -145,3 +145,14 @@ config PAPR_SCM
 	tristate "Support for the PAPR Storage Class Memory interface"
 	help
 	  Enable access to hypervisor provided storage class memory.
+
+config PPC_SVM
+	bool "Secure virtual machine (SVM) support for POWER"
+	depends on PPC_PSERIES
+	help
+	 There are certain POWER platforms which support secure guests using
+	 the Protected Execution Facility, with the help of an Ultravisor
+	 executing below the hypervisor layer. This enables support for
+	 those guests.
+
+	 If unsure, say "N".

