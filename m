Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF836C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C04BE206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555611152;
	bh=VlRwvFeVS27XkufMQVWUTqzFXe6sBA7YAlDf+xHlN9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JPe2AkPyrxWbb5/fDHBYnrbznAaX6BvJulrFvLWit0KGYyfI1gYc1OWA/FLYbQWUC
	 /UB+1hmx9AwdLFjqAiIhDIV9GtpuJ7/YlHkoYq4bJDscMVv4IpeZ99Zu8Efk5jw0Ez
	 GbOm2hubNorXw4oKStqCNWfWGckrY5zOQ8NOaz3I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404115AbfDRSMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:12:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:44968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404120AbfDRSM1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:12:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 124FB20652;
        Thu, 18 Apr 2019 18:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555611146;
        bh=VlRwvFeVS27XkufMQVWUTqzFXe6sBA7YAlDf+xHlN9A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nNAKjJRvokfxHDcCEuHYOKBVAU7drCFaLYotQLxITrFADXgt3eC+WHj5CMgnQq4z9
         lTMCKIhefMFwlGO2SpSYtexTeisnG7fQcHTiZM+vb59hslSh7TzunE1NWlE/vzUML8
         u8XrGveQ4T/z7v7Anz62hsYHvqShYn0kyfIeId94=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kedar A Dongre <kedar.a.dongre@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 77/93] PCI: Blacklist power management of Gigabyte X299 DESIGNARE EX PCIe ports
Date:   Thu, 18 Apr 2019 19:57:55 +0200
Message-Id: <20190418160444.876514268@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160436.781762249@linuxfoundation.org>
References: <20190418160436.781762249@linuxfoundation.org>
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
index c25acace7d91..5a94a3cf61cd 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2501,6 +2501,25 @@ void pci_config_pm_runtime_put(struct pci_dev *pdev)
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
@@ -2546,6 +2565,9 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
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



