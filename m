Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C970C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 227BF20665
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560442410;
	bh=76D3vaAouJvHGGAHeFdnU7ReK0evbpdCzSUXWh05FYc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SQ20s5bhYlFO5NL8Ma++MtP5K97S96Y2ecucRYi3vq43Puxi1NYWYiINSxF3mePNQ
	 YlSS7sWqxJVIrnetZWakeI9Qj2M58lITNr6OlnYsCNewtcwY3K1rPGSC1DWkGIlBN1
	 6q04XQNpSvHXDL4jj8DwrmqhGTxSR9uSk8hJLMQo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391550AbfFMQNQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:13:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:60086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731208AbfFMIm4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 04:42:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 381CF21479;
        Thu, 13 Jun 2019 08:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560415375;
        bh=76D3vaAouJvHGGAHeFdnU7ReK0evbpdCzSUXWh05FYc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S+6tyKq8t6sL85UHSUgBcsUYGb+CgxBz7owFx+wQYGiEv+D2JdL145/VfcW4XQhbX
         aJOJpgMkAE7pjOHSJFf/T2m5jSCmKXDcdf9DUzamU6tlLbntVlQpTzvCuv5wysQL8Q
         Yu82e29Bev0tVQKVPnMyNN/A20gsWTda2TbJYVPM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wenwen Wang <wang6495@umn.edu>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 073/118] x86/PCI: Fix PCI IRQ routing table memory leak
Date:   Thu, 13 Jun 2019 10:33:31 +0200
Message-Id: <20190613075648.152331358@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190613075643.642092651@linuxfoundation.org>
References: <20190613075643.642092651@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit ea094d53580f40c2124cef3d072b73b2425e7bfd ]

In pcibios_irq_init(), the PCI IRQ routing table 'pirq_table' is first
found through pirq_find_routing_table().  If the table is not found and
CONFIG_PCI_BIOS is defined, the table is then allocated in
pcibios_get_irq_routing_table() using kmalloc().  Later, if the I/O APIC is
used, this table is actually not used.  In that case, the allocated table
is not freed, which is a memory leak.

Free the allocated table if it is not used.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
[bhelgaas: added Ingo's reviewed-by, since the only change since v1 was to
use the irq_routing_table local variable name he suggested]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/pci/irq.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/pci/irq.c b/arch/x86/pci/irq.c
index 52e55108404e..d3a73f9335e1 100644
--- a/arch/x86/pci/irq.c
+++ b/arch/x86/pci/irq.c
@@ -1119,6 +1119,8 @@ static const struct dmi_system_id pciirq_dmi_table[] __initconst = {
 
 void __init pcibios_irq_init(void)
 {
+	struct irq_routing_table *rtable = NULL;
+
 	DBG(KERN_DEBUG "PCI: IRQ init\n");
 
 	if (raw_pci_ops == NULL)
@@ -1129,8 +1131,10 @@ void __init pcibios_irq_init(void)
 	pirq_table = pirq_find_routing_table();
 
 #ifdef CONFIG_PCI_BIOS
-	if (!pirq_table && (pci_probe & PCI_BIOS_IRQ_SCAN))
+	if (!pirq_table && (pci_probe & PCI_BIOS_IRQ_SCAN)) {
 		pirq_table = pcibios_get_irq_routing_table();
+		rtable = pirq_table;
+	}
 #endif
 	if (pirq_table) {
 		pirq_peer_trick();
@@ -1145,8 +1149,10 @@ void __init pcibios_irq_init(void)
 		 * If we're using the I/O APIC, avoid using the PCI IRQ
 		 * routing table
 		 */
-		if (io_apic_assign_pci_irqs)
+		if (io_apic_assign_pci_irqs) {
+			kfree(rtable);
 			pirq_table = NULL;
+		}
 	}
 
 	x86_init.pci.fixup_irqs();
-- 
2.20.1



