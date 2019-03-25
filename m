Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B84C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 05:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 269422075D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 05:35:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729342AbfCYFfi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 01:35:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34552 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726242AbfCYFfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 01:35:38 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2P5Z4Oo044713
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 01:35:37 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2reqrpapt0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 01:35:36 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <alastair@au1.ibm.com>;
        Mon, 25 Mar 2019 05:35:35 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Mar 2019 05:35:33 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2P5ZWFa59899954
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Mar 2019 05:35:32 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9040F4203F;
        Mon, 25 Mar 2019 05:35:32 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3D8E042047;
        Mon, 25 Mar 2019 05:35:32 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 25 Mar 2019 05:35:32 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 8CE1CA0161;
        Mon, 25 Mar 2019 16:35:30 +1100 (AEDT)
From:   "Alastair D'Silva" <alastair@au1.ibm.com>
To:     alastair@d-silva.org
Cc:     Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/4] ocxl: OpenCAPI Cleanup
Date:   Mon, 25 Mar 2019 16:34:51 +1100
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190320053448.2098-1-alastair@au1.ibm.com>
References: <20190320053448.2098-1-alastair@au1.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19032505-0008-0000-0000-000002D11AE0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032505-0009-0000-0000-0000223D40FA
Message-Id: <20190325053456.14599-1-alastair@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-25_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=802 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903250043
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alastair D'Silva <alastair@d-silva.org>

Some minor cleanups for the OpenCAPI driver as a prerequisite
for an ocxl driver refactoring to allow the driver core to
be utilised by external drivers.

Changelog:
V4:
  - Drop printf format changes as they omit the format indicator for '0'
V3:
  - Add missed header in 'ocxl: Remove some unused exported symbols'.
    This addresses the introduced sparse warnings
V2:
  - remove intermediate assignment of 'link' var in
                'Rename struct link to ocxl_link'
  - Don't shift definition of ocxl_context_attach in
                'Remove some unused exported symbols'


Alastair D'Silva (4):
  ocxl: Rename struct link to ocxl_link
  ocxl: read_pasid never returns an error, so make it void
  ocxl: Remove superfluous 'extern' from headers
  ocxl: Remove some unused exported symbols

 drivers/misc/ocxl/config.c        | 13 ++---
 drivers/misc/ocxl/file.c          |  5 +-
 drivers/misc/ocxl/link.c          | 36 ++++++-------
 drivers/misc/ocxl/ocxl_internal.h | 85 +++++++++++++++++++------------
 include/misc/ocxl.h               | 53 ++++++-------------
 5 files changed, 91 insertions(+), 101 deletions(-)

-- 
2.20.1

