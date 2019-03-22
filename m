Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB9BC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7015218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257214;
	bh=TRgFqfXBxRYsK7Yo4zv/Deih6TEcR2qf4nAvuZ4X3NA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=X7FPxhWHlWzlAwVS5tJ7u3YvbRrUr11wpDLpf5K+R3TBc3qTsfygmdIpCEyRYO72k
	 GMR6a8MrqvNem3ERKfGwoU2xgRHOphGIhAvF/7yM9mhqVYJlX2FSl15nnrXMy5EFYX
	 INU4fiZTVTSksR1JNHlSiefFLk1TkFvpu0l6Ja+4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390705AbfCVMUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:20:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:58994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390673AbfCVMUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:20:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7775B21900;
        Fri, 22 Mar 2019 12:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257199;
        bh=TRgFqfXBxRYsK7Yo4zv/Deih6TEcR2qf4nAvuZ4X3NA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p16v9Ob0KDUkCupEAIn1rID83nDNxfP1H56BX0veJvYI0L7TlBVg0Iqag/EdfqMQB
         USEj+h0j3XKbU0rA69z79EXmLAZvYCf+Kp/sNLGUAsUtPqMSxPZfPYIfnXBETTAQlv
         gem26Git08reNpurqsVkBXtTEIIpFMPjEH1J0GqM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 5.0 131/238] PCI: pciehp: Disable Data Link Layer State Changed event on suspend
Date:   Fri, 22 Mar 2019 12:15:50 +0100
Message-Id: <20190322111306.217018026@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mika Westerberg <mika.westerberg@linux.intel.com>

commit bbe54ea5330d828cc396d451c0e1e5c3f9764c1e upstream.

Commit 0e157e528604 ("PCI/PME: Implement runtime PM callbacks") tried to
solve an issue where the hierarchy immediately wakes up when it is
transitioned into D3cold.  However, it turns out to prevent PME
propagation on some systems that do not support D3cold.

I looked more closely at what might cause the immediate wakeup.  It happens
when the ACPI power resource of the root port is turned off.  The AML code
associated with the _OFF() method of the ACPI power resource starts a PCIe
L2/L3 Ready transition and waits for it to complete.  Right after the L2/L3
Ready transition is started the root port receives a PME from the
downstream port.

The simplest hierarchy where this happens looks like this:

  00:1d.0 PCIe Root Port
    ^
    |
    v
    05:00.0 PCIe switch #1 upstream port
      06:01.0 PCIe switch #1 downstream hotplug port
        ^
        |
        v
        08:00.0 PCIe switch #2 upstream port

It seems that the PCIe link between the two switches, before
PME_Turn_Off/PME_TO_Ack is complete for the whole hierarchy, goes
inactive and triggers PME towards the root port bringing it back to D0.
The L2/L3 Ready sequence is described in PCIe r4.0 spec sections 5.2 and
5.3.3 but unfortunately they do not state what happens if DLLSCE is
enabled during the sequence.

Disabling Data Link Layer State Changed event (DLLSCE) seems to prevent
the issue and still allows the downstream hotplug port to notice when a
device is plugged/unplugged.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=202593
Fixes: 0e157e528604 ("PCI/PME: Implement runtime PM callbacks")
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
CC: stable@vger.kernel.org	# v4.20+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/hotplug/pciehp_hpc.c |   17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -736,12 +736,25 @@ void pcie_clear_hotplug_events(struct co
 
 void pcie_enable_interrupt(struct controller *ctrl)
 {
-	pcie_write_cmd(ctrl, PCI_EXP_SLTCTL_HPIE, PCI_EXP_SLTCTL_HPIE);
+	u16 mask;
+
+	mask = PCI_EXP_SLTCTL_HPIE | PCI_EXP_SLTCTL_DLLSCE;
+	pcie_write_cmd(ctrl, mask, mask);
 }
 
 void pcie_disable_interrupt(struct controller *ctrl)
 {
-	pcie_write_cmd(ctrl, 0, PCI_EXP_SLTCTL_HPIE);
+	u16 mask;
+
+	/*
+	 * Mask hot-plug interrupt to prevent it triggering immediately
+	 * when the link goes inactive (we still get PME when any of the
+	 * enabled events is detected). Same goes with Link Layer State
+	 * changed event which generates PME immediately when the link goes
+	 * inactive so mask it as well.
+	 */
+	mask = PCI_EXP_SLTCTL_HPIE | PCI_EXP_SLTCTL_DLLSCE;
+	pcie_write_cmd(ctrl, 0, mask);
 }
 
 /*


