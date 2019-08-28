Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76699C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 12:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CE4322CED
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 12:29:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbfH1M3H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 08:29:07 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:2747 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726541AbfH1M3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 08:29:02 -0400
X-UUID: 6eaa46da8a724eadb1ee62c224dd50aa-20190828
X-UUID: 6eaa46da8a724eadb1ee62c224dd50aa-20190828
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <henryc.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1926949016; Wed, 28 Aug 2019 20:28:52 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 28 Aug 2019 20:28:58 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 28 Aug 2019 20:28:58 +0800
From:   Henry Chen <henryc.chen@mediatek.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Ryan Case <ryandcase@chromium.org>
CC:     Nicolas Boichat <drinkcat@google.com>,
        Fan Chen <fan.chen@mediatek.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH V3 00/10] Add driver for dvfsrc, support for active state of scpsys 
Date:   Wed, 28 Aug 2019 20:28:38 +0800
Message-ID: <1566995328-15158-1-git-send-email-henryc.chen@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patchsets add support for MediaTek hardware module named DVFSRC
(dynamic voltage and frequency scaling resource collector). The DVFSRC is
a HW module which is used to collect all the requests from both software
and hardware and turn into the decision of minimum operating voltage and
minimum DRAM frequency to fulfill those requests.

So, This series is to implement the dvfsrc driver to collect all the
requests of operating voltage or DRAM bandwidth from other device drivers
likes GPU/Camera through 2 frameworks basically:

1. interconnect framework: to aggregate the bandwidth
   requirements from different clients

[1] https://patchwork.kernel.org/cover/10766329/

Below is the emi bandwidth map of mt8183. There has a hw module "DRAM scheduler"
which used to control the throughput. The DVFSRC will collect forecast data
of dram bandwidth from SW consumers(camera/gpu...), and according the forecast
to change the DRAM frequency

           ICC provider         ICC Nodes
                            ----          ----
           ---------       |CPU |   |--->|VPU |
  -----   |         |-----> ----    |     ----
 |DRAM |--|DRAM     |       ----    |     ----
 |     |--|scheduler|----->|GPU |   |--->|DISP|
 |     |--|(EMI)    |       ----    |     ----
 |     |--|         |       -----   |     ----
  -----   |         |----->|MMSYS|--|--->|VDEC|
           ---------        -----   |     ----
             /|\                    |     ----
              |change DRAM freq     |--->|VENC|
           ----------               |     ----
          |  DVFSR   |              |
          |          |              |     ----
           ----------               |--->|IMG |
                                    |     ----
                                    |     ----
                                    |--->|CAM |
                                          ----

2. Active state management of power domains[1]: to handle the operating
   voltage opp requirement from different power domains

[2] https://lwn.net/Articles/744047/

Changes in RFC V3:
* Remove RFC from the subject prefix of the series
* Combine dt-binding patch and move interconnect dt-binding document into
dvfsrc. (Rob)
* Remove unused header, add unit descirption to the bandwidth, rename compatible
name on interconnect driver. (Georgi)
* Fixed some coding style: check flow, naming, used readx_poll_timeout
on dvfsrc driver. (Ryan)
* Rename interconnect driver mt8183.c to mtk-emi.c
* Rename interconnect header mtk,mt8183.h to mtk,emi.h
* mtk-scpsys.c: Add opp table check first to avoid OF runtime parse failed

Changes in RFC V2:
* Remove the DT property dram_type. (Rob)
* Used generic dts property 'opp-level' to get the performace state. (Stephen)
* Remove unecessary dependency config on Kconfig. (Stephen)
* Remove unused header file, fixed some coding style issue, typo,
error handling on dvfsrc driver. (Nicolas/Stephen)
* Remove irq handler on dvfsrc driver. (Stephen)
* Remove init table on dvfsrc driver, combine hw init on trustzone.
* Add interconnect support of mt8183 to aggregate the emi bandwidth.
(Georgi)

RFC V2: https://lore.kernel.org/patchwork/patch/1068113/
RFC V1: https://lore.kernel.org/patchwork/cover/1028535/

Henry Chen (10):
  dt-bindings: soc: Add dvfsrc driver bindings
  dt-bindings: soc: Add opp table on scpsys bindings
  soc: mediatek: add support for the performance state
  arm64: dts: mt8183: add performance state support of scpsys
  soc: mediatek: add header for mediatek SIP interface
  soc: mediatek: add MT8183 dvfsrc support
  arm64: dts: mt8183: add dvfsrc related nodes
  dt-bindings: interconnect: add MT8183 interconnect dt-bindings
  interconnect: mediatek: Add mt8183 interconnect provider driver
  arm64: dts: mt8183: Add interconnect provider DT nodes

 .../devicetree/bindings/soc/mediatek/dvfsrc.txt    |  32 ++
 .../devicetree/bindings/soc/mediatek/scpsys.txt    |  42 +++
 arch/arm64/boot/dts/mediatek/mt8183.dtsi           |  33 ++
 drivers/interconnect/Kconfig                       |   1 +
 drivers/interconnect/Makefile                      |   1 +
 drivers/interconnect/mediatek/Kconfig              |  13 +
 drivers/interconnect/mediatek/Makefile             |   3 +
 drivers/interconnect/mediatek/mtk-emi.c            | 246 ++++++++++++++
 drivers/soc/mediatek/Kconfig                       |  15 +
 drivers/soc/mediatek/Makefile                      |   1 +
 drivers/soc/mediatek/mtk-dvfsrc.c                  | 374 +++++++++++++++++++++
 drivers/soc/mediatek/mtk-scpsys.c                  |  58 ++++
 drivers/soc/mediatek/mtk-scpsys.h                  |  22 ++
 include/dt-bindings/interconnect/mtk,mt8183-emi.h  |  18 +
 include/dt-bindings/soc/mtk,dvfsrc.h               |  14 +
 include/soc/mediatek/mtk_dvfsrc.h                  |  22 ++
 include/soc/mediatek/mtk_sip.h                     |  17 +
 17 files changed, 912 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/mediatek/dvfsrc.txt
 create mode 100644 drivers/interconnect/mediatek/Kconfig
 create mode 100644 drivers/interconnect/mediatek/Makefile
 create mode 100644 drivers/interconnect/mediatek/mtk-emi.c
 create mode 100644 drivers/soc/mediatek/mtk-dvfsrc.c
 create mode 100644 drivers/soc/mediatek/mtk-scpsys.h
 create mode 100644 include/dt-bindings/interconnect/mtk,mt8183-emi.h
 create mode 100644 include/dt-bindings/soc/mtk,dvfsrc.h
 create mode 100644 include/soc/mediatek/mtk_dvfsrc.h
 create mode 100644 include/soc/mediatek/mtk_sip.h

-- 
1.9.1

