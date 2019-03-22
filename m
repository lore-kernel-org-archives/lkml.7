Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 217CEC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 20:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6425218E2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 20:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbfCVU4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 16:56:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54016 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726181AbfCVU4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 16:56:22 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2MKmkO2138605
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 16:56:22 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rd4pydxvm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 16:56:22 -0400
Received: from localhost
        by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <arbab@linux.ibm.com>;
        Fri, 22 Mar 2019 20:56:43 -0000
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
        by e35.co.us.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 22 Mar 2019 20:56:38 -0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2MKuFsl65601696
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Mar 2019 20:56:15 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 296EBBE051;
        Fri, 22 Mar 2019 20:56:15 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0A712BE04F;
        Fri, 22 Mar 2019 20:56:14 +0000 (GMT)
Received: from arbab-laptop.localdomain (unknown [9.53.179.210])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 22 Mar 2019 20:56:14 +0000 (GMT)
Received: by arbab-laptop.localdomain (Postfix, from userid 152845)
        id 9680E4608B2; Fri, 22 Mar 2019 15:56:13 -0500 (CDT)
From:   Reza Arbab <arbab@linux.ibm.com>
To:     Dave Airlie <airlied@redhat.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Robert Tarasov <tutankhamen@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     wzabolot@elektron.elka.pw.edu.pl, Pavel Machek <pavel@ucw.cz>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>
Subject: [PATCH 0/2] drm: udl fixes
Date:   Fri, 22 Mar 2019 15:56:11 -0500
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
x-cbid: 19032220-0012-0000-0000-0000171C2E2C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010796; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000282; SDB=6.01178185; UDB=6.00616393; IPR=6.00958883;
 MB=3.00026116; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-22 20:56:41
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032220-0013-0000-0000-00005699C847
Message-Id: <1553288173-10845-1-git-send-email-arbab@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-22_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=588 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903220148
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These fixes were needed to bring my udl devices to life on v5.1-rc1.

Reza Arbab (2):
  drm/udl: Fix off-by-one error in udl_get_edid()
  drm/fb-helper: Do not scale depth down to 0

 drivers/gpu/drm/drm_fb_helper.c     | 6 +++++-
 drivers/gpu/drm/udl/udl_connector.c | 2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

-- 
1.8.3.1

