Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98FBC43215
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 22:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B75352071B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 22:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfKVW2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 17:28:04 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54436 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726089AbfKVW2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 17:28:04 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAMMNMog067356;
        Fri, 22 Nov 2019 17:26:28 -0500
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wdv0why7c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Nov 2019 17:26:28 -0500
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xAMMKplf032360;
        Fri, 22 Nov 2019 22:26:27 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma03dal.us.ibm.com with ESMTP id 2wa8r7t2ru-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Nov 2019 22:26:27 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xAMMQQR552953380
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Nov 2019 22:26:26 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4FBC7112065;
        Fri, 22 Nov 2019 22:26:26 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C732F112062;
        Fri, 22 Nov 2019 22:26:25 +0000 (GMT)
Received: from wrightj-ThinkPad-W520.rchland.ibm.com (unknown [9.10.101.53])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 22 Nov 2019 22:26:25 +0000 (GMT)
From:   Jim Wright <wrightj@linux.vnet.ibm.com>
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        mark.rutland@arm.com, corbet@lwn.net
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jim Wright <jlwright@us.ibm.com>
Subject: [PATCH 0/2] hwmon: Add UCD90320 power sequencer chip
Date:   Fri, 22 Nov 2019 16:25:40 -0600
Message-Id: <20191122222542.29661-1-wrightj@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-22_05:2019-11-21,2019-11-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=520 clxscore=1011 impostorscore=0 mlxscore=0 phishscore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911220177
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jim Wright <jlwright@us.ibm.com>

Add support for TI UCD90320 power sequencer chip.

Jim Wright (2):
  dt-bindings: hwmon/pmbus: Add UCD90320 power sequencer
  hwmon: Add support for UCD90320 Power Sequencer

 .../bindings/hwmon/pmbus/ucd90320.txt         | 13 +++++++
 Documentation/hwmon/ucd9000.rst               | 12 +++++-
 drivers/hwmon/pmbus/Kconfig                   |  6 +--
 drivers/hwmon/pmbus/ucd9000.c                 | 39 +++++++++++++------
 4 files changed, 53 insertions(+), 17 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/pmbus/ucd90320.txt

-- 
2.17.1

