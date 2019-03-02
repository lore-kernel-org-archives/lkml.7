Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05630C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 16:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5B6320838
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 16:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="crFdc8HA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbfCBQBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 11:01:21 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34805 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbfCBQBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 11:01:21 -0500
Received: by mail-qt1-f193.google.com with SMTP id w4so823492qtc.1;
        Sat, 02 Mar 2019 08:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=55C4QIVJooPy+3I5yed2TidsOYGoYF86opLnJiFVQi4=;
        b=crFdc8HAgo6KcgV2Bu0qDnpOFvTKBCxzjHN24K4YrPT580qNY853/lGILV3bXSPjIU
         DXhBSjpBQn4DDE+2lqDjAyM4SeANaRnRedo/hlrD05AzZwOAdTX3qp06/KfIxAZ0ggVa
         edS3OAlLCB8103RcEf3Nbo09t0nQTAJaxn0Mm6UOH/AQzaPsZ8HhV3jNKX3oFVXlDWFq
         rq69M0wSH6kipXFsRuP2pGuTfPWhtW+ERh1dCbf9jU8HwjQmXji7IlA73ttzzqPFWAxO
         CVCIOG9JhI/YMw205O8fooYSN7o9cUMenavClqqnIkGWFeVSNaAaSecUoz8+NjlwCsRC
         Le+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=55C4QIVJooPy+3I5yed2TidsOYGoYF86opLnJiFVQi4=;
        b=eXYNbN8plsxrLNoP0hwXk3tTRjxdT0wHI84Ks4XXFcLIATSnn5ctdDxmFE0l15NDwP
         y2Dz+7SWVwnuWGPObx3qv3usDVKw46klvAi/EBhEcsmdFQATiDLl1GH9xA6Im1mXlDnU
         UizJN8h6R7EfjrfGuwHvY2jA8Mua4T7GPAtaSP0WdFtCMNv78KVfpbiis46dV+eMd/p8
         NAh1hUaDZgMDmH6OXQLJaSC9pQcOg4Ec1BHF/3eQf/UvMoPK1nxn8VylhcJf1eTSghDa
         D6+D3OCapGptHktzwbHN0ETMlT9+B4VomsmrT1tdeRZIznOn5SZjuSdotvz3iBubVKJQ
         PXMw==
X-Gm-Message-State: APjAAAW8mrxGOzsqpx2JG+O3E1zoacjgVs823x3P3Z1tn3zPlY9Oy5Yk
        nnPzNkd8XqN88sBOp+uPS2I=
X-Google-Smtp-Source: APXvYqyw+Q4TamC6AbJor7nYKgovUpX7+KbigcyVEntE0sTwM7x1rRkUpAzRUCfg3M8NyQjrRMsDkw==
X-Received: by 2002:a0c:bd97:: with SMTP id n23mr8340121qvg.58.1551542479570;
        Sat, 02 Mar 2019 08:01:19 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id 24sm688768qtu.17.2019.03.02.08.01.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Mar 2019 08:01:19 -0800 (PST)
Date:   Sat, 2 Mar 2019 11:01:17 -0500
From:   Arvind Sankar <niveditas98@gmail.com>
To:     intel-wired-lan@lists.osuosl.org
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org
Subject: [PATCH] igb: Fix WARN_ONCE on runtime suspend
Message-ID: <20190302160115.GA6172@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The runtime_suspend device callbacks are not supposed to save
configuration state or change the power state. Commit fb29f76cc566
("igb: Fix an issue that PME is not enabled during runtime suspend")
changed the driver to not save configuration state during runtime
suspend, however the driver callback still put the device into a
low-power state. This causes a warning in the pci pm core and results in
pci_pm_runtime_suspend not calling pci_save_state or pci_finish_runtime_suspend.

Fix this by not changing the power state either, leaving that to pci pm
core, and make the same change for suspend callback as well.

Also move a couple of defines into the appropriate header file instead
of inline in the .c file.

Fixes: fb29f76cc566 ("igb: Fix an issue that PME is not enabled during runtime suspend")
Signed-off-by: Arvind Sankar <niveditas98@gmail.com>
---
 .../net/ethernet/intel/igb/e1000_defines.h    |  2 +
 drivers/net/ethernet/intel/igb/igb_main.c     | 57 +++----------------
 2 files changed, 10 insertions(+), 49 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/e1000_defines.h b/drivers/net/ethernet/intel/igb/e1000_defines.h
index 8a28f3388f69..dca671591ef6 100644
--- a/drivers/net/ethernet/intel/igb/e1000_defines.h
+++ b/drivers/net/ethernet/intel/igb/e1000_defines.h
@@ -194,6 +194,8 @@
 /* enable link status from external LINK_0 and LINK_1 pins */
 #define E1000_CTRL_SWDPIN0  0x00040000  /* SWDPIN 0 value */
 #define E1000_CTRL_SWDPIN1  0x00080000  /* SWDPIN 1 value */
+#define E1000_CTRL_ADVD3WUC 0x00100000  /* D3 WUC */
+#define E1000_CTRL_EN_PHY_PWR_MGMT 0x00200000 /* PHY PM enable */
 #define E1000_CTRL_SDP0_DIR 0x00400000  /* SDP0 Data direction */
 #define E1000_CTRL_SDP1_DIR 0x00800000  /* SDP1 Data direction */
 #define E1000_CTRL_RST      0x04000000  /* Global reset */
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 93f150784cfc..c2b3a2ff1471 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -8754,9 +8754,7 @@ static int __igb_shutdown(struct pci_dev *pdev, bool *enable_wake,
 	struct e1000_hw *hw = &adapter->hw;
 	u32 ctrl, rctl, status;
 	u32 wufc = runtime ? E1000_WUFC_LNKC : adapter->wol;
-#ifdef CONFIG_PM
-	int retval = 0;
-#endif
+	bool wake;
 
 	rtnl_lock();
 	netif_device_detach(netdev);
@@ -8769,14 +8767,6 @@ static int __igb_shutdown(struct pci_dev *pdev, bool *enable_wake,
 	igb_clear_interrupt_scheme(adapter);
 	rtnl_unlock();
 
-#ifdef CONFIG_PM
-	if (!runtime) {
-		retval = pci_save_state(pdev);
-		if (retval)
-			return retval;
-	}
-#endif
-
 	status = rd32(E1000_STATUS);
 	if (status & E1000_STATUS_LU)
 		wufc &= ~E1000_WUFC_LNKC;
@@ -8793,10 +8783,6 @@ static int __igb_shutdown(struct pci_dev *pdev, bool *enable_wake,
 		}
 
 		ctrl = rd32(E1000_CTRL);
-		/* advertise wake from D3Cold */
-		#define E1000_CTRL_ADVD3WUC 0x00100000
-		/* phy power management enable */
-		#define E1000_CTRL_EN_PHY_PWR_MGMT 0x00200000
 		ctrl |= E1000_CTRL_ADVD3WUC;
 		wr32(E1000_CTRL, ctrl);
 
@@ -8810,12 +8796,15 @@ static int __igb_shutdown(struct pci_dev *pdev, bool *enable_wake,
 		wr32(E1000_WUFC, 0);
 	}
 
-	*enable_wake = wufc || adapter->en_mng_pt;
-	if (!*enable_wake)
+	wake = wufc || adapter->en_mng_pt;
+	if (!wake)
 		igb_power_down_link(adapter);
 	else
 		igb_power_up_link(adapter);
 
+	if (enable_wake)
+		*enable_wake = wake;
+
 	/* Release control of h/w to f/w.  If f/w is AMT enabled, this
 	 * would have already happened in close and is redundant.
 	 */
@@ -8858,22 +8847,7 @@ static void igb_deliver_wake_packet(struct net_device *netdev)
 
 static int __maybe_unused igb_suspend(struct device *dev)
 {
-	int retval;
-	bool wake;
-	struct pci_dev *pdev = to_pci_dev(dev);
-
-	retval = __igb_shutdown(pdev, &wake, 0);
-	if (retval)
-		return retval;
-
-	if (wake) {
-		pci_prepare_to_sleep(pdev);
-	} else {
-		pci_wake_from_d3(pdev, false);
-		pci_set_power_state(pdev, PCI_D3hot);
-	}
-
-	return 0;
+	return __igb_shutdown(to_pci_dev(dev), NULL, 0);
 }
 
 static int __maybe_unused igb_resume(struct device *dev)
@@ -8944,22 +8918,7 @@ static int __maybe_unused igb_runtime_idle(struct device *dev)
 
 static int __maybe_unused igb_runtime_suspend(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	int retval;
-	bool wake;
-
-	retval = __igb_shutdown(pdev, &wake, 1);
-	if (retval)
-		return retval;
-
-	if (wake) {
-		pci_prepare_to_sleep(pdev);
-	} else {
-		pci_wake_from_d3(pdev, false);
-		pci_set_power_state(pdev, PCI_D3hot);
-	}
-
-	return 0;
+	return __igb_shutdown(to_pci_dev(dev), NULL, 1);
 }
 
 static int __maybe_unused igb_runtime_resume(struct device *dev)
-- 
2.19.2

