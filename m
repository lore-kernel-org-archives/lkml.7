Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8060EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5670D21872
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552410855;
	bh=N12a1QoYsGmzIvAkZ4ts/mdCd2Ym6Fl+RPc8i3AGGjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UULchbPbJeBZwWnXR0WbMZ+49mHSq5VcTsS7f1/5XR4TbRi6zksOaNyHjCIF5oXLU
	 JByqn9vcjYb0Trab1s2wtpMD1fHfZK+pVsmunhLDFVSfQKUuMQ18MVufNyU9ZxODUE
	 0UGddIaH1y0wNvZubjEj7cRFYq3bswam99QymTkk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbfCLROO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:14:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:50538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727956AbfCLRNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:13:31 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E95A2184C;
        Tue, 12 Mar 2019 17:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410810;
        bh=N12a1QoYsGmzIvAkZ4ts/mdCd2Ym6Fl+RPc8i3AGGjY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZdVV4J0dfEYMLXQE531aXbSg9m1Jq7pzc5P3UkfNcSEJpFa5dTq0+LRjnmIj1vZGK
         C1koHuLc+ZxkU2r8fYnjXyRgIBZuZlPp69bWFhn6q+QgH2nQplHn/N5qfMh5nbe6jl
         hydg7zK+J5qOhD4AJwPOFuIs8Ty6SA7VjWXMI66Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.20 162/171] Revert "PCI/PME: Implement runtime PM callbacks"
Date:   Tue, 12 Mar 2019 10:09:02 -0700
Message-Id: <20190312170401.347153140@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170347.868927101@linuxfoundation.org>
References: <20190312170347.868927101@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mika Westerberg <mika.westerberg@linux.intel.com>

commit c528f7bd362b097eeeafa6fbbeccd9750b79c7ba upstream.

This reverts commit 0e157e52860441cb26051f131dd0b5ae3187a07b.

Heiner reported that the commit in question prevents his network adapter
from triggering PME and waking up when network cable is plugged.

The commit tried to prevent root port waking up from D3cold immediately but
looks like disabing root port PME interrupt is not the right way to fix
that issue so revert it now.  The patch following proposes an alternative
solution to that issue.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=202103
Fixes: 0e157e528604 ("PCI/PME: Implement runtime PM callbacks")
Reported-by: Heiner Kallweit <hkallweit1@gmail.com>
Tested-by: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
CC: stable@vger.kernel.org	# v4.20+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/pcie/pme.c |   27 ---------------------------
 1 file changed, 27 deletions(-)

--- a/drivers/pci/pcie/pme.c
+++ b/drivers/pci/pcie/pme.c
@@ -432,31 +432,6 @@ static void pcie_pme_remove(struct pcie_
 	kfree(get_service_data(srv));
 }
 
-static int pcie_pme_runtime_suspend(struct pcie_device *srv)
-{
-	struct pcie_pme_service_data *data = get_service_data(srv);
-
-	spin_lock_irq(&data->lock);
-	pcie_pme_interrupt_enable(srv->port, false);
-	pcie_clear_root_pme_status(srv->port);
-	data->noirq = true;
-	spin_unlock_irq(&data->lock);
-
-	return 0;
-}
-
-static int pcie_pme_runtime_resume(struct pcie_device *srv)
-{
-	struct pcie_pme_service_data *data = get_service_data(srv);
-
-	spin_lock_irq(&data->lock);
-	pcie_pme_interrupt_enable(srv->port, true);
-	data->noirq = false;
-	spin_unlock_irq(&data->lock);
-
-	return 0;
-}
-
 static struct pcie_port_service_driver pcie_pme_driver = {
 	.name		= "pcie_pme",
 	.port_type	= PCI_EXP_TYPE_ROOT_PORT,
@@ -464,8 +439,6 @@ static struct pcie_port_service_driver p
 
 	.probe		= pcie_pme_probe,
 	.suspend	= pcie_pme_suspend,
-	.runtime_suspend = pcie_pme_runtime_suspend,
-	.runtime_resume	= pcie_pme_runtime_resume,
 	.resume		= pcie_pme_resume,
 	.remove		= pcie_pme_remove,
 };


