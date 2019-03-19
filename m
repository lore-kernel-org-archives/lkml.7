Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7026C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 10:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B723520857
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 10:08:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfCSKIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 06:08:48 -0400
Received: from gloria.sntech.de ([185.11.138.130]:57530 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbfCSKIs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 06:08:48 -0400
Received: from ip5f5a6320.dynamic.kabel-deutschland.de ([95.90.99.32] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1h6Bfe-0005eJ-Up; Tue, 19 Mar 2019 11:08:34 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Tony Xie <tony.xie@rock-chips.com>, lee.jones@linaro.org
Cc:     broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, chenjh@rock-chips.com,
        xsf@rock-chips.com, zhangqing@rock-chips.com,
        huangtao@rock-chips.com
Subject: Re: [PATCH v7 0/6] support a new type of PMIC,including two chips(rk817 and rk809)
Date:   Tue, 19 Mar 2019 11:08:33 +0100
Message-ID: <36121846.smLYK4jT4q@diego>
In-Reply-To: <20190102102002.29245-1-tony.xie@rock-chips.com>
References: <20190102102002.29245-1-tony.xie@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

Am Mittwoch, 2. Januar 2019, 11:19:56 CET schrieb Tony Xie:
> Most of functions and registers of the rk817 and rk808 are the same,
> so they can share allmost all codes.

do you have this series on your radar somewhere or should Tony
resend the series? As it looks like it fell through the cracks somehow.


Thanks
Heiko


> Their specifications are as follows:
>   1) The RK809 and RK809 consist of 5 DCDCs, 9 LDOs and have the same
> registers
>      for these components except dcdc5.
>   2) The dcdc5 is a boost dcdc for RK817 and is a buck for RK809.
>   3) The RK817 has one switch but The Rk809 has two.
> 
> Changes in V2:
> 1. initialize the pm_pwroff_fn to NULL.
> 2. use EXPORT_SYMBOL_GPL to export pm_power_off_prepare.
> 3. change patch 2/3/4/5 subjects.
> 
> Changes in V3
> 1. change patch 4 subjects
> 2. replace pr_ with dev_ for printing in patch 2
> 3. modify switch1 and switch2 configs in patch 2
> 4. explain gpio information for rk809 and rk817 in patch 4
> 
> Changes in V4:
> 1. modify some codes for patch 2 and patch 5 according to comments
> 2. add reviewer mail lists for patch 3 and 4
> 
> Changes in V5:
> modify some codes for patch 1 according to reveiw comments for v3.
>  1) remove the pm_power_off_prepare() and replace with shutdown
> call-back from syscore
>  2) move the macro REGMAP_IRQ_M into the regmap.h and rename it
> REGMAP_IRQ_LINE
>  3) make some dev_warn() log clear
> 
> Changes in V6:
> modify some codes according to reveiw comments for v5.
> 
> Changes in V7:
> modify some codes for patch 2 according to reveiw comments.
> 
> Tony Xie (6):
>   mfd: rk808: remove the id_table
>   mfd: rk808: Add RK817 and RK809 support
>   regulator: rk808: add RK809 and RK817 support.
>   dt-bindings: mfd: rk808: Add binding information for RK809 and RK817.
>   rtc: rk808: add RK809 and RK817 support.
>   clk: RK808: add RK809 and RK817 support.
> 
>  .../devicetree/bindings/mfd/rk808.txt         |  44 ++
>  drivers/clk/Kconfig                           |   9 +-
>  drivers/clk/clk-rk808.c                       |  64 +-
>  drivers/mfd/Kconfig                           |   6 +-
>  drivers/mfd/rk808.c                           | 199 +++++-
>  drivers/regulator/Kconfig                     |   4 +-
>  drivers/regulator/rk808-regulator.c           | 657 +++++++++++++++++-
>  drivers/rtc/Kconfig                           |   4 +-
>  drivers/rtc/rtc-rk808.c                       |  68 +-
>  include/linux/mfd/rk808.h                     | 175 +++++
>  10 files changed, 1164 insertions(+), 66 deletions(-)




