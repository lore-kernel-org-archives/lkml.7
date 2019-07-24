Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD6CC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 05:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 841C52075C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 05:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564033631;
	bh=Hx3GPueWs8BDnpYvzNlYXekwIYTPfzPqRDI2b1wPrIU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K3bGeVoKzLQ/gPXozzKF/1a8ZohXo0iCsMoDapk5HgVoEXCrB0JWzvNLkVj0NvPh5
	 tPteNhxuO9+fVPKitMgimlrIt0fw5IHoB3DYPjtaCXEVhflRN8t+IvYvTkNV0+sEEq
	 BXo4DR9r8Db7Qa2I5HjMbZUkSaFt2uszi52LTF4I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729220AbfGYFrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 01:47:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:35058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729127AbfGYFrI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 01:47:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEB8C21880;
        Thu, 25 Jul 2019 05:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564033627;
        bh=Hx3GPueWs8BDnpYvzNlYXekwIYTPfzPqRDI2b1wPrIU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jgkMexdHd2qoLqplogts2gcXQcuoYGKSDj6M1nODmfXNA0i4C9WYYuuvU8UOHROv0
         fPIK5ZGcSOj7tFpVknFXeuVxtzlppWdTnyHxU4NXRC5NfPNotmEROZXxb2LB0/AMxT
         B6LkW/GZztx6c5gP9lvpw47vbR6B8QXZZmXop2mU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Greg Kurz <groug@kaod.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.19 257/271] powerpc/powernv/npu: Fix reference leak
Date:   Wed, 24 Jul 2019 21:22:06 +0200
Message-Id: <20190724191717.232074055@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191655.268628197@linuxfoundation.org>
References: <20190724191655.268628197@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kurz <groug@kaod.org>

commit 02c5f5394918b9b47ff4357b1b18335768cd867d upstream.

Since 902bdc57451c, get_pci_dev() calls pci_get_domain_bus_and_slot(). This
has the effect of incrementing the reference count of the PCI device, as
explained in drivers/pci/search.c:

 * Given a PCI domain, bus, and slot/function number, the desired PCI
 * device is located in the list of PCI devices. If the device is
 * found, its reference count is increased and this function returns a
 * pointer to its data structure.  The caller must decrement the
 * reference count by calling pci_dev_put().  If no device is found,
 * %NULL is returned.

Nothing was done to call pci_dev_put() and the reference count of GPU and
NPU PCI devices rockets up.

A natural way to fix this would be to teach the callers about the change,
so that they call pci_dev_put() when done with the pointer. This turns
out to be quite intrusive, as it affects many paths in npu-dma.c,
pci-ioda.c and vfio_pci_nvlink2.c. Also, the issue appeared in 4.16 and
some affected code got moved around since then: it would be problematic
to backport the fix to stable releases.

All that code never cared for reference counting anyway. Call pci_dev_put()
from get_pci_dev() to revert to the previous behavior.

Fixes: 902bdc57451c ("powerpc/powernv/idoa: Remove unnecessary pcidev from pci_dn")
Cc: stable@vger.kernel.org # v4.16
Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/platforms/powernv/npu-dma.c |   15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

--- a/arch/powerpc/platforms/powernv/npu-dma.c
+++ b/arch/powerpc/platforms/powernv/npu-dma.c
@@ -56,9 +56,22 @@ static struct dentry *atsd_threshold_den
 static struct pci_dev *get_pci_dev(struct device_node *dn)
 {
 	struct pci_dn *pdn = PCI_DN(dn);
+	struct pci_dev *pdev;
 
-	return pci_get_domain_bus_and_slot(pci_domain_nr(pdn->phb->bus),
+	pdev = pci_get_domain_bus_and_slot(pci_domain_nr(pdn->phb->bus),
 					   pdn->busno, pdn->devfn);
+
+	/*
+	 * pci_get_domain_bus_and_slot() increased the reference count of
+	 * the PCI device, but callers don't need that actually as the PE
+	 * already holds a reference to the device. Since callers aren't
+	 * aware of the reference count change, call pci_dev_put() now to
+	 * avoid leaks.
+	 */
+	if (pdev)
+		pci_dev_put(pdev);
+
+	return pdev;
 }
 
 /* Given a NPU device get the associated PCI device. */


