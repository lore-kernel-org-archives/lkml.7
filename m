Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E56C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 12:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61E3020883
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 12:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731082AbfDBMgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 08:36:20 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:53362 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730456AbfDBMgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 08:36:17 -0400
X-UUID: 0abdcd6b405d4f8aa2bd212ef5536e7e-20190402
X-UUID: 0abdcd6b405d4f8aa2bd212ef5536e7e-20190402
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <qii.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1604574743; Tue, 02 Apr 2019 20:36:08 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 2 Apr 2019 20:36:07 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 2 Apr 2019 20:36:06 +0800
From:   Qii Wang <qii.wang@mediatek.com>
To:     <wsa@the-dreams.de>
CC:     <linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <leilk.liu@mediatek.com>,
        <qii.wang@mediatek.com>, <xinping.qian@mediatek.com>,
        <liguo.zhang@mediatek.com>, <robh@kernel.org>
Subject: [PATCH RESEND v6 0/6] add i2c support for mt8183
Date:   Tue, 2 Apr 2019 20:35:54 +0800
Message-ID: <1554208560-14817-1-git-send-email-qii.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series are based on 5.1-rc1 and the patch
https://patchwork.kernel.org/patch/10856987/(for dts)
We provide six patches to support mt8183 IC.

Main changes compared to v5:
--add i2c controller nodes in mt8183.dtsi
--add a note that old i2c controllers also have I2C_ARB_LOST bit
--add a flag(ltiming_adjust) to avoid unnecessary settings
--add Reviewed-by from Rob Herring, Nicolas and Matthias

Main changes compared to v4:
--modify the commit of arb clock dt-binding
--split a patch(3/3) into three(3/5 4/5 5/5)

Main changes compared to v3:
--remove the patches which have been applied to for-next
--remove i2c fallback for i3c controller 

Main changes compared to v2:
--update commit message
--add Reviewed-by from Rob Herring, Nicolas and Sean

Main changes compared to v1:
--remove useless dt-binding for mt7629
--split a patch into two(2/6 3/6)
--muti-user feature was dropped

Qii Wang (6):
  i2c: mediatek: Add offsets array for new i2c registers
  dt-bindings: i2c: Add Mediatek MT8183 i2c binding
  i2c: mediatek: Add arb clock in i2c driver
  i2c: mediatek: Add i2c and apdma sync in i2c driver
  i2c: mediatek: Add i2c support for MediaTek MT8183
  dts: arm64: mt8183: Add I2C nodes

 Documentation/devicetree/bindings/i2c/i2c-mtk.txt |    4 +-
 arch/arm64/boot/dts/mediatek/mt8183.dtsi          |  192 ++++++++++++++++
 drivers/i2c/busses/i2c-mt65xx.c                   |  255 ++++++++++++++++-----
 3 files changed, 389 insertions(+), 62 deletions(-)

-- 
1.7.9.5
