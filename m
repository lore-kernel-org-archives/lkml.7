Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 729CBC3A5A6
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 03:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A4C52173E
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 03:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YJQb4GF2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbfH0DMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 23:12:37 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59410 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728025AbfH0DMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 23:12:36 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7R39dZ4064070;
        Tue, 27 Aug 2019 03:12:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2019-08-05;
 bh=CJ907zIBS0LpmHhbkysVeFPKJdRDkZEt0B6aL9TfLEE=;
 b=YJQb4GF2b9ZG5Q90WwvauLpreMwZi/m/y70MYsaiGJfZb1UyY6H5yrFaFm2nAu0HLJyt
 dF/janBQrx1i5Tx/lvFrwonE/dZtr1TvvoR7onUAQweUwzf/jDxoY+M03YCq85TsGbeL
 Hkwmnr48ayyS0+tdPP2WZIwUAQZQNGabqJjHwQSzskceguf0NEsSepX+kF3m1L9E9yjt
 kDkh2QrRcyVxDQW/G1cDt5J0uIUhM8ubR9eSmPPwwWRsUaTwb8LFrNURark7hVm1WEDY
 zb70PJ5aJZ9p4TfVt0J6xRsc/ewBcy7fW8yMIl7UwTqu4V6qBwxcZ3KpgI7mJS7zxJUF Gw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2umv7j81r1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Aug 2019 03:12:22 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7R37hsx105267;
        Tue, 27 Aug 2019 03:12:22 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2umj27kf3y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Aug 2019 03:12:21 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7R3CDjE021834;
        Tue, 27 Aug 2019 03:12:13 GMT
Received: from localhost.localdomain (/10.159.230.41)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 26 Aug 2019 20:12:12 -0700
From:   Santosh Shilimkar <santosh.shilimkar@oracle.com>
To:     arm@kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     khilman@kernel.org, arnd@arndb.de, olof@lixom.net,
        linux-kernel@vger.kernel.org, santosh.shilimkar@oracle.com
Subject: [GIT PULL] SOC: TI soc updates for 5.4
Date:   Mon, 26 Aug 2019 20:11:47 -0700
Message-Id: <1566875507-8067-1-git-send-email-santosh.shilimkar@oracle.com>
X-Mailer: git-send-email 1.9.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9361 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=807
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908270033
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9361 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=878 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908270033
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 609488bc979f99f805f34e9a32c1e3b71179d10b:

  Linux 5.3-rc2 (2019-07-28 12:47:02 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/drivers_soc_for_5.4

for you to fetch changes up to 23013399a2252e9f592c2c52a62b213d3ef09217:

  soc: ti: ti_sci_pm_domains: Add support for exclusive and shared access (2019-08-26 20:00:41 -0700)

----------------------------------------------------------------
soc: TI soc updates for 5.4

 -  Update firmware to support PM domain shared and exclusive support
 -  Update driver and dt binding docs for the same.

----------------------------------------------------------------

Lokesh Vutla (3):
  firmware: ti_sci: Allow for device shared and exclusive requests
  dt-bindings: ti_sci_pm_domains: Add support for exclusive and shared
    access
  soc: ti: ti_sci_pm_domains: Add support for exclusive and shared
    access

 .../devicetree/bindings/soc/ti/sci-pm-domain.txt   | 11 +++++-
 MAINTAINERS                                        |  1 +
 drivers/firmware/ti_sci.c                          | 45 +++++++++++++++++++++-
 drivers/soc/ti/ti_sci_pm_domains.c                 | 23 ++++++++++-
 include/dt-bindings/soc/ti,sci_pm_domain.h         |  9 +++++
 include/linux/soc/ti/ti_sci_protocol.h             |  3 ++
 6 files changed, 86 insertions(+), 6 deletions(-)
 create mode 100644 include/dt-bindings/soc/ti,sci_pm_domain.h

-- 
1.9.1

