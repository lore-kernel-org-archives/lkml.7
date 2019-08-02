Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E8FC32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91B56206A2
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564739112;
	bh=MELHc7NeFRTV+Rr8aDeE6buDLVahjTTMClWcgX8JTqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CTo8myjvEdiavUUfd9Hqb2QAmgNu37ayL4jumV7QOINuIyFffYUMYQ60wGU+NGF+p
	 BQOHV0yT7aSRVE60HZ42rz56DiesmnFFAfSmXkp2CzLK+VcdxXB+OPnwkKRNezVCT6
	 nJC3+FdVkjaqUrZP1JrrTn2FimTCXHUGeaPNP6h8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405371AbfHBJpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 05:45:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:48676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405353AbfHBJpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 05:45:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06C8A20679;
        Fri,  2 Aug 2019 09:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564739103;
        bh=MELHc7NeFRTV+Rr8aDeE6buDLVahjTTMClWcgX8JTqg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1TouRBO28FhsGi1CLcAwZyMLMJO2sgWgUQGYVUzZoXGvbbV7VYfvqFhA8yba6adrp
         L8MW/adEiIsovjeVZbCP3XnP1FT39XKorWPX/8lHMc0a2r3wXo4WvAzVOVYQS8CLGj
         mlH2sZG7WG0vbYhohHhVXdaU0sN28xVzUpz1wGqo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.9 100/223] PCI: Do not poll for PME if the device is in D3cold
Date:   Fri,  2 Aug 2019 11:35:25 +0200
Message-Id: <20190802092245.666205344@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190802092238.692035242@linuxfoundation.org>
References: <20190802092238.692035242@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mika Westerberg <mika.westerberg@linux.intel.com>

commit 000dd5316e1c756a1c028f22e01d06a38249dd4d upstream.

PME polling does not take into account that a device that is directly
connected to the host bridge may go into D3cold as well. This leads to a
situation where the PME poll thread reads from a config space of a
device that is in D3cold and gets incorrect information because the
config space is not accessible.

Here is an example from Intel Ice Lake system where two PCIe root ports
are in D3cold (I've instrumented the kernel to log the PMCSR register
contents):

  [   62.971442] pcieport 0000:00:07.1: Check PME status, PMCSR=0xffff
  [   62.971504] pcieport 0000:00:07.0: Check PME status, PMCSR=0xffff

Since 0xffff is interpreted so that PME is pending, the root ports will
be runtime resumed. This repeats over and over again essentially
blocking all runtime power management.

Prevent this from happening by checking whether the device is in D3cold
before its PME status is read.

Fixes: 71a83bd727cc ("PCI/PM: add runtime PM support to PCIe port")
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Lukas Wunner <lukas@wunner.de>
Cc: 3.6+ <stable@vger.kernel.org> # v3.6+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/pci.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1786,6 +1786,13 @@ static void pci_pme_list_scan(struct wor
 			 */
 			if (bridge && bridge->current_state != PCI_D0)
 				continue;
+			/*
+			 * If the device is in D3cold it should not be
+			 * polled either.
+			 */
+			if (pme_dev->dev->current_state == PCI_D3cold)
+				continue;
+
 			pci_pme_wakeup(pme_dev->dev, NULL);
 		} else {
 			list_del(&pme_dev->list);


