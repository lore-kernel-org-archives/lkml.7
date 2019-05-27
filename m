Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BAC6C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 12:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05D8C21721
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 12:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfE0MOJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 08:14:09 -0400
Received: from muru.com ([72.249.23.125]:51128 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726063AbfE0MOI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 08:14:08 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 79BD780F3;
        Mon, 27 May 2019 12:14:27 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     Dave Gerlach <d-gerlach@ti.com>, Faiz Abbas <faiz_abbas@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Roger Quadros <rogerq@ti.com>, Suman Anna <s-anna@ti.com>,
        Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH 00/12] ti-sysc driver changes to drop custom hwmods property
Date:   Mon, 27 May 2019 05:13:36 -0700
Message-Id: <20190527121348.45251-1-tony@atomide.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Here are changes to improve ti-sysc driver to the point where we can
finally drop the custom hwmods property for most cases. This series
drops hwmods property only for omap4 UART and MMC as those can be
tested with core retention idle.

I'll be posting more patches for dropping hwmods properties as they
get tested.

Regards,

Tony


Tony Lindgren (12):
  bus: ti-sysc: Support 16-bit writes too
  bus: ti-sysc: Make OCP reset work for sysstatus and sysconfig reset
    bits
  bus: ti-sysc: Allow QUIRK_LEGACY_IDLE even if legacy_mode is not set
  bus: ti-sysc: Enable interconnect target module autoidle bit on enable
  bus: ti-sysc: Handle clockactivity for enable and disable
  bus: ti-sysc: Handle swsup idle mode quirks
  bus: ti-sysc: Set ENAWAKEUP if available
  bus: ti-sysc: Add support for disabling module without legacy mode
  bus: ti-sysc: Do rstctrl reset handling in two phases
  bus: ti-sysc: Detect uarts also on omap34xx
  ARM: dts: Drop legacy custom hwmods property for omap4 uart
  ARM: dts: Drop legacy custom hwmods property for omap4 mmc

 arch/arm/boot/dts/omap4-l4.dtsi       |   9 --
 drivers/bus/ti-sysc.c                 | 182 ++++++++++++++++++++------
 include/linux/platform_data/ti-sysc.h |   1 +
 3 files changed, 140 insertions(+), 52 deletions(-)

-- 
2.21.0
