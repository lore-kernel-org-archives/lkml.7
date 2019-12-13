Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D683C2D0C9
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 03:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7422624679
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 03:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Aa6U+JD3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731932AbfLMDHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 22:07:14 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:38974 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731465AbfLMDHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 22:07:14 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBD374jn002520;
        Thu, 12 Dec 2019 21:07:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576206424;
        bh=P2vJoPklK2vOl7x3hsP0IoRW0iDntiu2jXuS39HL8uQ=;
        h=From:To:CC:Subject:Date;
        b=Aa6U+JD3qArPqIlL3fVzaJFe8PXoAJVeAJy1TYicx+h9LvJc+8AuhdIvaVXMZvHnH
         uki2SmHmSl0JqeCB3ZZDyErcWrJBcotJ5RQ6OjzxM/UKeT6wi8bMt9lXwiZnCGSvL7
         LY69J1VhtMkYMuDN21paO4Xmosi5TEFE+QiQnGbU=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBD374S2018385
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 12 Dec 2019 21:07:04 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 12
 Dec 2019 21:07:04 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 12 Dec 2019 21:07:04 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBD374lv058827;
        Thu, 12 Dec 2019 21:07:04 -0600
From:   Dave Gerlach <d-gerlach@ti.com>
To:     Tony Lindgren <tony@atomide.com>,
        Santosh Shilimkar <ssantosh@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH 0/5] ARM: OMAP2+: Introduce cpuidle for am335x/am437x
Date:   Thu, 12 Dec 2019 21:07:50 -0600
Message-ID: <20191213030755.16096-1-d-gerlach@ti.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
This series adds support for cpuidle on am335x and am437x using the
cpuidle_arm driver. When testing on am335x-evm and am437x-gp-evm the
follow power consumption reductions are seen on v5.5-rc1 baseline:


Idling at command line, CPUFreq userspace governor to 300MHz:
  am335x-evm:
    VDD_MPU: 48 mW -> 5 mW

  am437x-gp-evm:
    VDD_MPU: 32 mW -> 3 mW


Idling at command line, CPUFreq userspace governor to 1GHz:
  am335x-evm:
    VDD_MPU: 313 mW -> 18 mW

  am437x-gp-evm:
    VDD_MPU: 208 mW -> 10 mW

A forthcoming series will add idle states to the device tree for each
am335x and am437x to add C1 state for MPU Gate which gates the clock to
the main CPU.  am335x makes use of the wkup_m3_ipc driver for this to
use the same wkup_m3 to gate the cpu clock that is used for suspend, so
the same firmware found here is required [1] to be placed in
/lib/firmware.

First patch adds dt-binding for enable-method for each SoC which is needed
for cpuidle-arm driver to probe, second patch adds platform code for cpuidle,
third patch modifies both platform code and pm33xx soc driver to add needed
flags and callback for idling, fourth patch actually enables cpuidle in the
soc pm33xx driver, and then that last patch enables the needed CONFIG options
in omap2plus_defconfig.

Regards,
Dave

[1] https://git.ti.com/cgit/processor-firmware/ti-amx3-cm3-pm-firmware/tree/bin/am335x-pm-firmware.elf?h=ti-v4.1.y

Dave Gerlach (5):
  dt-bindings: arm: cpu: Add TI AM335x and AM437x enable method
  ARM: OMAP2+: pm33xx-core: Add cpuidle_ops for am335x/am437x
  ARM: OMAP2+: pm33xx-core: Extend platform_data ops for cpuidle
  soc: ti: pm33xx: Add base cpuidle support
  ARM: omap2plus_defconfig: Add CONFIG_ARM_CPUIDLE

 .../devicetree/bindings/arm/cpus.yaml         |   2 +
 arch/arm/configs/omap2plus_defconfig          |   2 +
 arch/arm/mach-omap2/pm33xx-core.c             | 137 +++++++++++++++++-
 drivers/soc/ti/pm33xx.c                       |  21 ++-
 include/linux/platform_data/pm33xx.h          |   6 +-
 5 files changed, 160 insertions(+), 8 deletions(-)

-- 
2.20.1

