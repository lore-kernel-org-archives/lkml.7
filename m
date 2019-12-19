Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41AE1C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11C7F20674
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576781446;
	bh=Yi1rGX4IfomVzQeG42VPCGKaWMr9zg3TzAfQefDUa/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z1tUelYXe2rpAfDNlXADxEuANDFs254vohMS6x57L81n7kY9VMzm07Fi3BBEow64r
	 hfHY1E14RafzYo2hlmoJQA5f5ZiKG4ThNR+7MFFxMZQNLezNHlM+QqL5bK97RbghIp
	 j4j/gtysEuSoqBfi7xW0DG8jw722uQLAQTsBAvBE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730023AbfLSSul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:50:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:44562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729722AbfLSSui (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:50:38 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32C0020674;
        Thu, 19 Dec 2019 18:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576781437;
        bh=Yi1rGX4IfomVzQeG42VPCGKaWMr9zg3TzAfQefDUa/0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=felxM4PVR4oZar1cIuQjtW8wbme47bWbI9RZTokrhldr8vGvNpEn4cZo1bqRRO270
         KDG3NGDcIfK43lCQyR7Xn1VMsU/f74rEpaOrKirg+FlQs6TUaW0YTwzt/AM5Fsr0p/
         ANjeT5VA28ZkLveP/Fw7Rhj6YahrZxmhReHSI8TM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dexuan Cui <decui@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.14 14/36] PCI/PM: Always return devices to D0 when thawing
Date:   Thu, 19 Dec 2019 19:34:31 +0100
Message-Id: <20191219182859.416871263@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219182848.708141124@linuxfoundation.org>
References: <20191219182848.708141124@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com>

commit f2c33ccacb2d4bbeae2a255a7ca0cbfd03017b7c upstream.

pci_pm_thaw_noirq() is supposed to return the device to D0 and restore its
configuration registers, but previously it only did that for devices whose
drivers implemented the new power management ops.

Hibernation, e.g., via "echo disk > /sys/power/state", involves freezing
devices, creating a hibernation image, thawing devices, writing the image,
and powering off.  The fact that thawing did not return devices with legacy
power management to D0 caused errors, e.g., in this path:

  pci_pm_thaw_noirq
    if (pci_has_legacy_pm_support(pci_dev)) # true for Mellanox VF driver
      return pci_legacy_resume_early(dev)   # ... legacy PM skips the rest
    pci_set_power_state(pci_dev, PCI_D0)
    pci_restore_state(pci_dev)
  pci_pm_thaw
    if (pci_has_legacy_pm_support(pci_dev))
      pci_legacy_resume
	drv->resume
	  mlx4_resume
	    ...
	      pci_enable_msix_range
	        ...
		  if (dev->current_state != PCI_D0)  # <---
		    return -EINVAL;

which caused these warnings:

  mlx4_core a6d1:00:02.0: INTx is not supported in multi-function mode, aborting
  PM: dpm_run_callback(): pci_pm_thaw+0x0/0xd7 returns -95
  PM: Device a6d1:00:02.0 failed to thaw: error -95

Return devices to D0 and restore config registers for all devices, not just
those whose drivers support new power management.

[bhelgaas: also call pci_restore_state() before pci_legacy_resume_early(),
update comment, add stable tag, commit log]
Link: https://lore.kernel.org/r/KU1P153MB016637CAEAD346F0AA8E3801BFAD0@KU1P153MB0166.APCP153.PROD.OUTLOOK.COM
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: stable@vger.kernel.org	# v4.13+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/pci-driver.c |   17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -967,17 +967,22 @@ static int pci_pm_thaw_noirq(struct devi
 			return error;
 	}
 
-	if (pci_has_legacy_pm_support(pci_dev))
-		return pci_legacy_resume_early(dev);
-
 	/*
-	 * pci_restore_state() requires the device to be in D0 (because of MSI
-	 * restoration among other things), so force it into D0 in case the
-	 * driver's "freeze" callbacks put it into a low-power state directly.
+	 * Both the legacy ->resume_early() and the new pm->thaw_noirq()
+	 * callbacks assume the device has been returned to D0 and its
+	 * config state has been restored.
+	 *
+	 * In addition, pci_restore_state() restores MSI-X state in MMIO
+	 * space, which requires the device to be in D0, so return it to D0
+	 * in case the driver's "freeze" callbacks put it into a low-power
+	 * state.
 	 */
 	pci_set_power_state(pci_dev, PCI_D0);
 	pci_restore_state(pci_dev);
 
+	if (pci_has_legacy_pm_support(pci_dev))
+		return pci_legacy_resume_early(dev);
+
 	if (drv && drv->pm && drv->pm->thaw_noirq)
 		error = drv->pm->thaw_noirq(dev);
 


