Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0DA3C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 19:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB8C42089E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 19:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbfEHTfi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 15:35:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33236 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727624AbfEHTfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 15:35:38 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x48JWc6V116601
        for <linux-kernel@vger.kernel.org>; Wed, 8 May 2019 15:35:37 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sc33cxymm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 15:35:37 -0400
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <eajames@linux.ibm.com>;
        Wed, 8 May 2019 20:35:36 +0100
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
        by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 8 May 2019 20:35:33 +0100
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x48JZWM864290908
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 May 2019 19:35:32 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3A5E3136063;
        Wed,  8 May 2019 19:35:32 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C29B2136053;
        Wed,  8 May 2019 19:35:31 +0000 (GMT)
Received: from talon7.ibm.com (unknown [9.41.179.222])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed,  8 May 2019 19:35:31 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, joel@jms.id.au, pmeerw@pmeerw.net,
        lars@metafoo.de, knaack.h@gmx.de, jic23@kernel.org,
        Eddie James <eajames@linux.ibm.com>
Subject: [PATCH v2 0/3] iio: Add driver for Infineon DPS310
Date:   Wed,  8 May 2019 14:35:25 -0500
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
x-cbid: 19050819-0016-0000-0000-000009AF5246
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011072; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01200485; UDB=6.00629893; IPR=6.00981371;
 MB=3.00026797; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-08 19:35:35
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050819-0017-0000-0000-00004322DC62
Message-Id: <1557344128-690-1-git-send-email-eajames@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-08_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=755 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905080119
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DPS310 is a temperature and pressure sensor. It can be accessed over i2c
and SPI.

The driver supports polled measurement of temperature and pressure over i2c
only.

Changes since v1:
 - Switch to wait for temperature/pressure sensor ready
 - Various cleanup

Christopher Bostic (1):
  iio: dps310: Temperature measurement errata

Eddie James (1):
  iio: dps310: Add pressure sensing capability

Joel Stanley (1):
  iio: Add driver for Infineon DPS310

 MAINTAINERS                   |   6 +
 drivers/iio/pressure/Kconfig  |  10 +
 drivers/iio/pressure/Makefile |   1 +
 drivers/iio/pressure/dps310.c | 761 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 778 insertions(+)
 create mode 100644 drivers/iio/pressure/dps310.c

-- 
1.8.3.1

