Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDF5C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 18:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF0C220882
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 18:25:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731373AbfDBSZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 14:25:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43618 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728724AbfDBSZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 14:25:14 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x32IIjJ5033103
        for <linux-kernel@vger.kernel.org>; Tue, 2 Apr 2019 14:25:13 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rmchrhdcq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 14:25:12 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <eajames@linux.ibm.com>;
        Tue, 2 Apr 2019 19:25:12 +0100
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 2 Apr 2019 19:25:07 +0100
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x32IP6s420643990
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 2 Apr 2019 18:25:06 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0B292AE060;
        Tue,  2 Apr 2019 18:25:06 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 32DE9AE05F;
        Tue,  2 Apr 2019 18:25:05 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.3.116.186])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  2 Apr 2019 18:25:05 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        joel@jms.id.au, andrew@aj.id.au, mchehab@kernel.org,
        linux-clk@vger.kernel.org, sboyd@kernel.org,
        mturquette@baylibre.com, devicetree@vger.kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org
Subject: [PATCH 0/5] Aspeed: Enable video engine
Date:   Tue,  2 Apr 2019 18:24:59 +0000
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 19040218-0064-0000-0000-000003C58251
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010862; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01183363; UDB=6.00619524; IPR=6.00964111;
 MB=3.00026264; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-02 18:25:10
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040218-0065-0000-0000-00003CECF1B4
Message-Id: <1554229504-5661-1-git-send-email-eajames@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-02_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=896 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904020122
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series enables the video engine on Aspeed BMC platforms. The video engine
clocking is added to the Aspeed clock driver. The use of the video engine reset
line, originally planned to be made externally available in the clock driver,
is removed from the video engine driver. Finally a node for the video engine is
added to the AST2500 devicetree.
The series also includes a missing property for reserved memory in the
devicetree documentation, and a small change to make the video engine driver
start without reserved memory.

Eddie James (5):
  media: platform: Aspeed: Remove use of reset line
  media: platform: Aspeed: Make reserved memory optional
  media: dt-bindings: aspeed-video: Add missing memory-region property
  clk: Aspeed: Setup video engine clocking
  ARM: dts: aspeed-g5: Add video engine

 .../devicetree/bindings/media/aspeed-video.txt     |  6 ++++
 arch/arm/boot/dts/aspeed-g5.dtsi                   | 10 ++++++
 drivers/clk/clk-aspeed.c                           | 42 ++++++++++++++++++++--
 drivers/media/platform/aspeed-video.c              | 33 ++++-------------
 4 files changed, 61 insertions(+), 30 deletions(-)

-- 
1.8.3.1

