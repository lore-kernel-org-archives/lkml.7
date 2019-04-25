Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF552C282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 10:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A01A0214AE
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 10:12:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbfDYKMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 06:12:44 -0400
Received: from regular1.263xmail.com ([211.150.70.196]:49826 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbfDYKMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 06:12:41 -0400
Received: from zhangqing?rock-chips.com (unknown [192.168.167.13])
        by regular1.263xmail.com (Postfix) with ESMTP id 73959785;
        Thu, 25 Apr 2019 18:12:33 +0800 (CST)
X-263anti-spam: KSV:0;BIG:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ADDR-CHECKED4: 1
X-ABS-CHECKED: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P797T140025968707328S1556187150403323_;
        Thu, 25 Apr 2019 18:12:32 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <e11f934d71261e75036e5e9d47d74e6f>
X-RL-SENDER: zhangqing@rock-chips.com
X-SENDER: zhangqing@rock-chips.com
X-LOGIN-NAME: zhangqing@rock-chips.com
X-FST-TO: heiko@sntech.de
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From:   Elaine Zhang <zhangqing@rock-chips.com>
To:     heiko@sntech.de
Cc:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        xxx@rock-chips.com, xf@rock-chips.com, huangtao@rock-chips.com,
        Elaine Zhang <zhangqing@rock-chips.com>
Subject: [PATCH v2 0/3] thermal: rockchip: fix up thermal driver
Date:   Thu, 25 Apr 2019 18:12:26 +0800
Message-Id: <1556187154-22632-1-git-send-email-zhangqing@rock-chips.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. add pinctrl control.
2. support PX30 soc

change in V2:
PATCH V2 1/3: keep tshut_mode TSHUT_MODE_GPIO;
	      In case of pinctrl get or lookup error, just bail out;
	      No need to use the thermal_pinctrl_select_otp/gpio wrappers,
	      just replace them with:
PATCH V2 2/3: No change in V2.
PATCH V2 2/3: keep tshut_mode TSHUT_MODE_GPIO;
              Remove the grf in 'rk_tsadcv4_initialize' function.

pinctrl_select_state(thermal->pinctrl, thermal->pinctrl_state);
Elaine Zhang (3):
  thermal: rockchip: fix up the tsadc pinctrl setting error
  dt-bindings: rockchip-thermal: Support the PX30 SoC compatible
  thermal: rockchip: Support the PX30 SoC in thermal driver

 .../bindings/thermal/rockchip-thermal.txt          |  1 +
 drivers/thermal/rockchip_thermal.c                 | 74 +++++++++++++++++++++-
 2 files changed, 72 insertions(+), 3 deletions(-)

-- 
1.9.1



