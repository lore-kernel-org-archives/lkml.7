Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B83C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 05:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70E982075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 05:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbfCKFlP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 01:41:15 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:43066 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725770AbfCKFlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 01:41:15 -0400
X-UUID: 678f9efb02b8453c8f4877084a7eda01-20190311
X-UUID: 678f9efb02b8453c8f4877084a7eda01-20190311
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <qii.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1125975366; Mon, 11 Mar 2019 13:41:09 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 11 Mar 2019 13:41:01 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 11 Mar 2019 13:41:00 +0800
From:   Qii Wang <qii.wang@mediatek.com>
To:     <wsa@the-dreams.de>
CC:     <linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <leilk.liu@mediatek.com>,
        <qii.wang@mediatek.com>, <xinping.qian@mediatek.com>,
        <liguo.zhang@mediatek.com>, <robh@kernel.org>
Subject: [PATCH v6 0/6] add i2c support for mt8183
Date:   Mon, 11 Mar 2019 13:40:34 +0800
Message-ID: <1552282840-12778-1-git-send-email-qii.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 49EEDC9833C41D4A7A8C635CE863D998353A8222888F30AB380AA5CFE76CA8682000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series are based on 5.0-rc1(i2c/for-next) and these series
http://lists.infradead.org/pipermail/linux-mediatek/2019-February/017570.html
http://lists.infradead.org/pipermail/linux-mediatek/2019-February/017320.html
http://lists.infradead.org/pipermail/linux-mediatek/2019-January/017196.html 

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

 Documentation/devicetree/bindings/i2c/i2c-mtk.txt |   4 +-
 arch/arm64/boot/dts/mediatek/mt8183.dtsi          | 190 ++++++++++++++++
 drivers/i2c/busses/i2c-mt65xx.c                   | 255 ++++++++++++++++------
 3 files changed, 387 insertions(+), 62 deletions(-)

-- 
1.9.1
