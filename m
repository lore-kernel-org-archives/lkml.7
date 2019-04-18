Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EECA4C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEF7C2186A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555610535;
	bh=ud88wz96+Er1HDj7Vha8lLCEXeTzTeBw0oM/AVnQtQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VpLxV+XXzPFMt55ll98vQzoA98w0AjKjsx2RqFnlm7+2HrKCd8akr1ymqC89du0Ve
	 vPpqL+6BGUS98JNZLyRXXyQVe8/lN5IHgWffU8QMVncQgdDRpLW4o2TkngivufGn09
	 HBM2mNed8UhqZ2UMjdUkKLlUvzO1VBY3zCd9Bs2Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390202AbfDRSCO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:02:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:58164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390702AbfDRSCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:02:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50C7D2186A;
        Thu, 18 Apr 2019 18:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610528;
        bh=ud88wz96+Er1HDj7Vha8lLCEXeTzTeBw0oM/AVnQtQY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=neV+cqor08nyIZmCn6/FoERlwFkG8W0eZMzsi8rdHgr16Gu8nBrERY2kcQK0BmnvF
         fooaiHh7Zyrmj2IMBvMlgVpJCOxOYbohr9cdx8212Fesdq9AoLcSaXxKfy7Mx34ntl
         MRMrLl85DpUFxEGusJCE+gwE+W9iWem+KvXWUErA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kedar A Dongre <kedar.a.dongre@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 097/110] PCI: Blacklist power management of Gigabyte X299 DESIGNARE EX PCIe ports
Date:   Thu, 18 Apr 2019 19:57:26 +0200
Message-Id: <20190418160446.934925240@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160437.484158340@linuxfoundation.org>
References: <20190418160437.484158340@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 85b0cae89d5266e6a7abb2e83c6f716326fc494c ]

Gigabyte X299 DESIGNARE EX motherboard has one PCIe root port that is
connected to an Alpine Ridge Thunderbolt controller.  This port has slot
implemented bit set in the config space but other than that it is not
hotplug capable in the sense we are expecting in Linux (it has
dev->is_hotplug_bridge set to 0):

  00:1c.4 PCI bridge: Intel Corporation 200 Series PCH PCI Express Root Port #5
    Bus: primary=00, secondary=05, subordinate=46, sec-latency=0
    Memory behind bridge: 78000000-8fffffff [size=384M]
    Prefetchable memory behind bridge: 00003800f8000000-00003800ffffffff [size=128M]
    ...
    Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
    ...
      SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
	      Slot #8, PowerLimit 25.000W; Interlock- NoCompl+
      SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
	      Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
      SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
	      Changed: MRL- PresDet+ LinkState+

This system is using ACPI based hotplug to notify the OS that it needs to
rescan the PCI bus (ACPI hotplug).

If there is nothing connected in any of the Thunderbolt ports the root port
will not have any runtime PM active children and is thus automatically
runtime suspended pretty soon after boot by PCI PM core.  Now, when a
device is connected the BIOS SMI handler responsible for enumerating newly
added devices is not able to find anything because the port is in D3.

Prevent this from happening by blacklisting PCI power management of this
particular Gigabyte system.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=202031
Reported-by: Kedar A Dongre <kedar.a.dongre@intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pci.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7eb1549cea81..30649addc625 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2489,6 +2489,25 @@ void pci_config_pm_runtime_put(struct pci_dev *pdev)
 		pm_runtime_put_sync(parent);
 }
 
+static const struct dmi_system_id bridge_d3_blacklist[] = {
+#ifdef CONFIG_X86
+	{
+		/*
+		 * Gigabyte X299 root port is not marked as hotplug capable
+		 * which allows Linux to power manage it.  However, this
+		 * confuses the BIOS SMI handler so don't power manage root
+		 * ports on that system.
+		 */
+		.ident = "X299 DESIGNARE EX-CF",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Gigabyte Technology Co., Ltd."),
+			DMI_MATCH(DMI_BOARD_NAME, "X299 DESIGNARE EX-CF"),
+		},
+	},
+#endif
+	{ }
+};
+
 /**
  * pci_bridge_d3_possible - Is it possible to put the bridge into D3
  * @bridge: Bridge to check
@@ -2530,6 +2549,9 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
 		if (bridge->is_hotplug_bridge)
 			return false;
 
+		if (dmi_check_system(bridge_d3_blacklist))
+			return false;
+
 		/*
 		 * It should be safe to put PCIe ports from 2015 or newer
 		 * to D3.
-- 
2.19.1



