Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E13C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 15:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74062233FF
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 15:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbfH2PvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 11:51:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:27320 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727650AbfH2PvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 11:51:01 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7TFlqeG141085;
        Thu, 29 Aug 2019 11:50:50 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2uphbyrypv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Aug 2019 11:50:50 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7TFjPq3021679;
        Thu, 29 Aug 2019 15:50:49 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma01wdc.us.ibm.com with ESMTP id 2ujvv6n8vn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Aug 2019 15:50:48 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7TFonKu54395238
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Aug 2019 15:50:49 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E7A98AE062;
        Thu, 29 Aug 2019 15:50:48 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F1CA7AE064;
        Thu, 29 Aug 2019 15:50:45 +0000 (GMT)
Received: from maxibm.ibmuc.com (unknown [9.85.151.248])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 29 Aug 2019 15:50:45 +0000 (GMT)
From:   "Maxiwell S. Garcia" <maxiwell@linux.ibm.com>
To:     linuxppc-dev@ozlabs.org
Cc:     kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, paulus@ozlabs.org, mpe@ellerman.id.au,
        andmike@linux.ibm.com, linuxram@us.ibm.com, bauerman@linux.ibm.com,
        cclaudio@linux.ibm.com,
        "Maxiwell S. Garcia" <maxiwell@linux.ibm.com>
Subject: [PATCH v2 0/2] powerpc: Add PowerPC Capabilities ELF note
Date:   Thu, 29 Aug 2019 12:50:19 -0300
Message-Id: <20190829155021.2915-1-maxiwell@linux.ibm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-29_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=837 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908290168
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first patch adds the PowerPC name and the PPC_ELFNOTE_CAPABILITIES
type in the kernel binary ELF note. This type is a bitmap that can be
used to advertise kernel capabilities to userland.

The second patch adds a new documentation file to detail the
ELF Note PowerPC namespace and the PPC_ELFNOTE_CAPABILITIES type.

V2:
* Create the header arch/powerpc/include/asm/elfnote.h with the
  new type PPC_ELFNOTE_CAPABILITIES
* Add documentation file in powerpc dir

Claudio Carvalho (1):
  powerpc: Add PowerPC Capabilities ELF note

Maxiwell S. Garcia (1):
  docs: powerpc: Add ELF note documentation

 Documentation/powerpc/elfnote.rst  | 42 ++++++++++++++++++++++++++++++
 arch/powerpc/include/asm/elfnote.h | 24 +++++++++++++++++
 arch/powerpc/kernel/Makefile       |  2 +-
 arch/powerpc/kernel/note.S         | 40 ++++++++++++++++++++++++++++
 4 files changed, 107 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/powerpc/elfnote.rst
 create mode 100644 arch/powerpc/include/asm/elfnote.h
 create mode 100644 arch/powerpc/kernel/note.S

-- 
2.20.1

