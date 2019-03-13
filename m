Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D23ADC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 04:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA4AB2173C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 04:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbfCMEHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 00:07:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45520 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725878AbfCMEHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 00:07:47 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2D43vqT036413
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 00:07:46 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2r6pqg0xrp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 00:07:45 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <alastair@au1.ibm.com>;
        Wed, 13 Mar 2019 04:07:43 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 13 Mar 2019 04:07:39 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2D47cSf29753412
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Mar 2019 04:07:39 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D5251A404D;
        Wed, 13 Mar 2019 04:07:38 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 83507A4055;
        Wed, 13 Mar 2019 04:07:38 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 13 Mar 2019 04:07:38 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 33916A00D1;
        Wed, 13 Mar 2019 15:07:37 +1100 (AEDT)
From:   "Alastair D'Silva" <alastair@au1.ibm.com>
Cc:     "Alastair D'Silva" <alastair@d-silva.org>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] ocxl: OpenCAPI Cleanup
Date:   Wed, 13 Mar 2019 15:06:56 +1100
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190227045741.21412-1-alastair@au1.ibm.com>
References: <20190227045741.21412-1-alastair@au1.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19031304-0012-0000-0000-00000301EBAC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031304-0013-0000-0000-000021390FB5
Message-Id: <20190313040702.14276-1-alastair@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-13_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=789 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903130028
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alastair D'Silva <alastair@d-silva.org>

Some minor cleanups for the OpenCAPI driver as a prerequisite
for an ocxl driver refactoring to allow the driver core to
be utilised by external drivers.

Changelog:
V2:
  - remove intermediate assignment of 'link' var in
		'Rename struct link to ocxl_link'
  - Don't shift definition of ocxl_context_attach in
		'Remove some unused exported symbols'

Alastair D'Silva (5):
  ocxl: Rename struct link to ocxl_link
  ocxl: Clean up printf formats
  ocxl: read_pasid never returns an error, so make it void
  ocxl: Remove superfluous 'extern' from headers
  ocxl: Remove some unused exported symbols

 drivers/misc/ocxl/config.c        | 17 ++----
 drivers/misc/ocxl/context.c       |  2 +-
 drivers/misc/ocxl/file.c          |  2 +-
 drivers/misc/ocxl/link.c          | 36 ++++++-------
 drivers/misc/ocxl/ocxl_internal.h | 86 +++++++++++++++++++------------
 drivers/misc/ocxl/trace.h         | 10 ++--
 include/misc/ocxl.h               | 53 ++++++-------------
 7 files changed, 99 insertions(+), 107 deletions(-)

-- 
2.20.1

