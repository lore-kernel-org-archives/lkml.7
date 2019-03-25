Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39872C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 124FD205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730459AbfCYV66 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 17:58:58 -0400
Received: from muru.com ([72.249.23.125]:42566 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729478AbfCYV66 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 17:58:58 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id D222C80CC;
        Mon, 25 Mar 2019 21:59:10 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     Dave Gerlach <d-gerlach@ti.com>, Faiz Abbas <faiz_abbas@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Roger Quadros <rogerq@ti.com>, Suman Anna <s-anna@ti.com>,
        Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 00/14] ti-sysc changes to probe devices with dts data only
Date:   Mon, 25 Mar 2019 14:58:35 -0700
Message-Id: <20190325215849.13182-1-tony@atomide.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Here are some ti-sysc interconnect target module changes that allow
dropping legacy platform data for many devices in favor of devicetree
provided data.

This series depends on patch series "[PATCH 0/7] omap changes to
allocate struct omap_hwmod dynamically".

I'll be posting patches separately to drop platform data. Meanwhile,
the easiest way to test this series is to just temporarily comment
out selected platform data entries one driver at a time. This can be
done in the SoC specific struct omap_hwmod_ocp_if array at the end of
the arch/arm/mach-omap2/omap_hwmod_*_data.c files.

Note that we are not yet handling all the quirks yet listed in
arch/arm/mach-omap2/omap_hwmod.h in "omap_hwmod.flags definitions".
We currently do not yet handle quirks for devices with:

HWMOD_NO_OCP_AUTOIDLE
HWMOD_NO_IDLEST
HWMOD_BLOCK_WFI
HWMOD_FORCE_MSTANDBY
HWMOD_RECONFIG_IO_CHAIN
HWMOD_CLKDM_NOAUTO

I'll be posting patches for these later on as needed.

Regards,

Tony


Tony Lindgren (14):
  bus: ti-sysc: Fix sysc_unprepare() when no clocks have been allocated
  bus: ti-sysc: Handle missed no-idle property in addition to
    no-idle-on-init
  bus: ti-sysc: Make functions static
  bus: ti-sysc: Move legacy platform data idling into separate functions
  bus: ti-sysc: Add separate functions for handling clocks
  bus: ti-sysc: Enable all clocks directly during init to read revision
  bus: ti-sysc: Allocate mdata as needed and do platform data based init
    later
  bus: ti-sysc: Manage clocks for the interconnect target module in all
    cases
  bus: ti-sysc: Move rstctrl reset to happen later
  bus: ti-sysc: Add support for early quirks based on register address
  bus: ti-sysc: Add quirk handling for external optional functional
    clock
  bus: ti-sysc: Pass clockactivity quirk to platform functions
  bus: ti-sysc: Handle swsup idle mode quirks
  bus: ti-sysc: Detect DMIC for debugging

 .../devicetree/bindings/bus/ti-sysc.txt       |   2 +
 arch/arm/mach-omap2/omap_hwmod.c              |  10 +
 drivers/bus/ti-sysc.c                         | 537 ++++++++++++++----
 include/linux/platform_data/ti-sysc.h         |   9 +-
 4 files changed, 438 insertions(+), 120 deletions(-)

-- 
2.21.0
