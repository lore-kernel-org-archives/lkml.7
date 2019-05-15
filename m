Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E71C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 10:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B295D2084A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 10:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="iZ1aTEjK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfEOKIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 06:08:25 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:47466 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfEOKIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 06:08:25 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x4FA8Mct101872;
        Wed, 15 May 2019 05:08:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1557914903;
        bh=TidM7X/0ba3N++fkpG0rUSyLxBKYWqBni+jioHOKfPQ=;
        h=From:To:CC:Subject:Date;
        b=iZ1aTEjKtP9Q5I4FeLy0U7ouBwlbDw9aVtEwNWX7TgkApzro99rHGwCxzR9TRh2hQ
         NrE2CpGDB6QX+u5IdF25Nej+Udpbn9ACnMGpBeD46pgqJheZ6BGATyXLwhKScZ60ez
         NmBKrw6e2/UWZETDkupgdE9/GGzA2aQLOK7S48aw=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x4FA8MVo094295
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 15 May 2019 05:08:22 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 15
 May 2019 05:08:23 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 15 May 2019 05:08:22 -0500
Received: from a0393675ula.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x4FA8JdY030606;
        Wed, 15 May 2019 05:08:20 -0500
From:   Keerthy <j-keerthy@ti.com>
To:     <lee.jones@linaro.org>, <robh+dt@kernel.org>, <broonie@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <t-kristo@ti.com>, <j-keerthy@ti.com>
Subject: [PATCH 0/3] mfd: lp87565: Add support for 4-phase lp87561 combination
Date:   Wed, 15 May 2019 15:38:45 +0530
Message-ID: <20190515100848.19560-1-j-keerthy@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for 4-phase lp87561 combination.

Data Sheet: https://www.ti.com/lit/ds/symlink/lp87561-q1.pdf

Keerthy (3):
  dt-bindings: mfd: lp87565: Add lp87561 configuration
  mfd: lp87565: Add support for 4-phase lp87561 combination
  regulator: lp87565: Add 4-phase lp87561 regulator support

 .../devicetree/bindings/mfd/lp87565.txt       | 36 +++++++++++++++++++
 drivers/mfd/lp87565.c                         |  4 +++
 drivers/regulator/lp87565-regulator.c         |  9 +++++
 include/linux/mfd/lp87565.h                   |  2 ++
 4 files changed, 51 insertions(+)

-- 
2.17.1

