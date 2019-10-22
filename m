Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB09CA9EB7
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 03:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A52E8217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 03:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730881AbfJVDyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 23:54:52 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:53990 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729573AbfJVDyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 23:54:52 -0400
X-UUID: 76b88ee9b43842089b9471311eb9d08c-20191022
X-UUID: 76b88ee9b43842089b9471311eb9d08c-20191022
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <anthony.huang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1938651709; Tue, 22 Oct 2019 11:54:45 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 22 Oct 2019 11:54:43 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 22 Oct 2019 11:54:43 +0800
From:   Anthony Huang <anthony.huang@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>
Subject: [RFC PATCH 0/2] Add Mediatek MMDVFS driver
Date:   Tue, 22 Oct 2019 11:51:51 +0800
Message-ID: <1571716313-10215-1-git-send-email-anthony.huang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This RFC patch adds the Mediatek MMDVFS(Multimedia Dynamic Voltage and
Frequency Scaling) driver. The multimedia HWs, such as display, camera,
share the same power supplier, and on some platforms, they share the
same clock MUX. If each HW needs different clock frequency at the same
time, the clock MUX must be set to the clock source which can meet the
highest required clock frequency.

Following implementation is used to achieve the goal. There are OPP tables
for all the clock MUXs for MM HWs defined in DTS, ant these OPP tables have
the same number of levels. The MMDVFS registers the regulator callback and
the MM HWs can get available clock frequencies from OPP tables and set
corresponding voltage by regulor API. The MMDVFS's callback will be
triggered if the voltage is changed and this voltage represents the highest
required OPP level. The MMDVFS has a mapping table: which clock source
should be set to each clock MUX for every OPP level. So all the clock MUXs
will be set to the clock sources according to the current OPP level in the
MMDVFS's regulator callback.



Anthony Huang (2):
  dt-bindings: soc: mediatek: Add document for mmdvfs driver
  soc: mediatek: Add mtk-mmdvfs driver

 .../devicetree/bindings/soc/mediatek/mmdvfs.txt    |  149 ++++++++++
 drivers/soc/mediatek/Kconfig                       |    9 +
 drivers/soc/mediatek/Makefile                      |    1 +
 drivers/soc/mediatek/mtk-mmdvfs.c                  |  313 ++++++++++++++++++++
 4 files changed, 472 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mmdvfs.txt
 create mode 100644 drivers/soc/mediatek/mtk-mmdvfs.c

-- 
1.7.9.5
