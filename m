Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76E8C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1E11218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730987AbfDXPRP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 11:17:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41884 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730449AbfDXPRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 11:17:13 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3OF0SlD087732
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 11:17:12 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2s2qfu9jfe-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 11:17:11 -0400
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <eajames@linux.ibm.com>;
        Wed, 24 Apr 2019 16:17:07 +0100
Received: from b03cxnp08025.gho.boulder.ibm.com (9.17.130.17)
        by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 24 Apr 2019 16:17:04 +0100
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3OFH3md31850636
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Apr 2019 15:17:03 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 232A5BE04F;
        Wed, 24 Apr 2019 15:17:03 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8CBF1BE058;
        Wed, 24 Apr 2019 15:17:02 +0000 (GMT)
Received: from talon7.ibm.com (unknown [9.41.179.222])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 24 Apr 2019 15:17:02 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-aspeed@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-media@vger.kernel.org, andrew@aj.id.au, joel@jms.id.au,
        robh+dt@kernel.org, mark.rutland@arm.com, mchehab@kernel.org,
        hverkuil@xs4all.nl, Eddie James <eajames@linux.ibm.com>
Subject: [PATCH v2 0/4] Aspeed: Enable video engine
Date:   Wed, 24 Apr 2019 10:16:56 -0500
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
x-cbid: 19042415-0036-0000-0000-00000AAE56F0
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010987; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01193747; UDB=6.00625813; IPR=6.00974570;
 MB=3.00026577; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-24 15:17:07
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042415-0037-0000-0000-00004B845CC5
Message-Id: <1556119020-7609-1-git-send-email-eajames@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-24_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=902 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904240117
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series enables the video engine on Aspeed BMC platforms. The use of the
video engine reset line, originally planned to be made externally available in
the clock driver, is removed from the video engine driver. A node for the video
engine is added to the AST2500 devicetree.
The series also includes a missing property for reserved memory in the
devicetree documentation, and a small change to make the video engine driver
start without reserved memory.

Changes since v1:
 - Drop clock patch since it's been applied
 - Add a missing semi-colon in the devicetree doc

Eddie James (4):
  media: platform: Aspeed: Remove use of reset line
  media: platform: Aspeed: Make reserved memory optional
  media: dt-bindings: aspeed-video: Add missing memory-region property
  ARM: dts: aspeed-g5: Add video engine

 .../devicetree/bindings/media/aspeed-video.txt     |  6 ++++
 arch/arm/boot/dts/aspeed-g5.dtsi                   | 10 +++++++
 drivers/media/platform/aspeed-video.c              | 33 ++++------------------
 3 files changed, 22 insertions(+), 27 deletions(-)

-- 
1.8.3.1

