Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 718B4CA9EC3
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 18:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4760020830
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 18:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Z8vduQv0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731049AbfJ2SOb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 14:14:31 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:37282 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730417AbfJ2SOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 14:14:31 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9TI5Edg175947;
        Tue, 29 Oct 2019 18:14:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2019-08-05;
 bh=WkZ9zbwFeDXQfqWTR1gASliBtGitlEcG01F4/M1sPtI=;
 b=Z8vduQv06HXTJGt+06q4bnJkBE2cRhWRisjZxjdSYIeERv/78O+GdM9jwxF+35dV2ypt
 3WVsAN2kgaaSHAnNQHWQ2jyxzzVnBF5jVXeCcsHaXfs67dPLHVyOiWSzPEmuV5gw6gmR
 wBFlhtgyY+GcbgKpxNfE1dvyyxpye+YhQgBoIakyMkNsPQJSXmn+nADRs68JalP6lyzR
 Nd/kFl7sKdMyqq56WN+q5jqVoKVNsze04zNMoql2NtIqZmtGtjgUXcGjZtjljDEkOeNB
 1PQ1+WEu+3n9fV6J6zCshuvRgC/1Bpr7MOliem9mpsvkREdNRrTIZXHFdtf6VYIRtsUI Sw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2vvdjub7v8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Oct 2019 18:14:23 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9TI8lO6040494;
        Tue, 29 Oct 2019 18:14:22 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2vxpgfdmvv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Oct 2019 18:14:22 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9TIELHG005793;
        Tue, 29 Oct 2019 18:14:21 GMT
Received: from localhost.localdomain (/10.159.132.196)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 29 Oct 2019 11:14:21 -0700
From:   Santosh Shilimkar <santosh.shilimkar@oracle.com>
To:     arm@kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     khilman@kernel.org, arnd@arndb.de, olof@lixom.net,
        linux-kernel@vger.kernel.org, santosh.shilimkar@oracle.com
Subject: [RESEND][GIT PULL 1/2] soc: TI soc updates for v5.5
Date:   Tue, 29 Oct 2019 11:14:15 -0700
Message-Id: <1572372856-20598-1-git-send-email-santosh.shilimkar@oracle.com>
X-Mailer: git-send-email 1.9.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9425 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=4 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910290160
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9425 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=4
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910290160
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:

  Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git for_5.5/driver-soc

for you to fetch changes up to faee19ece8263738c147cb0140e0fbc7b5397ca8:

  memory: emif: remove set but not used variables 'cs1_used' and 'custom_configs' (2019-10-29 09:57:57 -0700)

----------------------------------------------------------------
Tero Kristo (9):
      dt-bindings: omap: add new binding for PRM instances
      soc: ti: add initial PRM driver with reset control support
      soc: ti: omap-prm: poll for reset complete during de-assert
      soc: ti: omap-prm: add support for denying idle for reset clockdomain
      soc: ti: omap-prm: add omap4 PRM data
      soc: ti: omap-prm: add data for am33xx
      soc: ti: omap-prm: add dra7 PRM data
      soc: ti: omap-prm: add am4 PRM data
      soc: ti: omap-prm: add omap5 PRM data

Wei Yongjun (1):
      soc: ti: omap-prm: fix return value check in omap_prm_probe()

YueHaibing (1):
      memory: emif: remove set but not used variables 'cs1_used' and 'custom_configs'

 .../devicetree/bindings/arm/omap/prm-inst.txt      |  29 ++
 arch/arm/mach-omap2/Kconfig                        |   1 +
 drivers/memory/emif.c                              |   5 +-
 drivers/soc/ti/Makefile                            |   1 +
 drivers/soc/ti/omap_prm.c                          | 391 +++++++++++++++++++++
 include/linux/platform_data/ti-prm.h               |  21 ++
 6 files changed, 444 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/omap/prm-inst.txt
 create mode 100644 drivers/soc/ti/omap_prm.c
 create mode 100644 include/linux/platform_data/ti-prm.h
