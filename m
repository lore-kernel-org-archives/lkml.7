Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A5B2CA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 14:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5896420873
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 14:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbfJaOfv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 10:35:51 -0400
Received: from v5prod-smtp4bis.alinto.net ([31.172.161.223]:15955 "EHLO
        smtpoutv5.alinto.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727841AbfJaOfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 10:35:50 -0400
X-Virus-Scanned: amavisd-new at localdomain
Received: from smtpoutv5.alinto.net ([127.0.0.1])
        by localhost (v5prod-smtp2.alinto.net [127.0.0.1]) (amavisd-new, port 10050)
        with LMTP id 1_xfDwALJE2n for <linux-kernel@vger.kernel.org>;
        Thu, 31 Oct 2019 15:35:47 +0100 (CET)
Received: from jona.localnet (unknown [80.254.183.189])
        (Authenticated sender: brunner@stettbacher.ch)
        by smtpoutv5.alinto.net (Postfix) with ESMTPA id 473ntW150Xz7sj
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 15:35:47 +0100 (CET)
From:   Patrick Brunner <brunner@stettbacher.ch>
To:     linux-kernel@vger.kernel.org
Subject: x86: Is Multi-MSI support for PCIe working?
Date:   Thu, 31 Oct 2019 15:35:46 +0100
Message-ID: <1779233.rKVo5UmMmJ@jona>
Organization: Stettbacher Signal Processing
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all

As the subject suggests, I'm wondering whether PCIe Multi-MSI support is working on x86 with IOMMU enabled.

The reason I'm asking is, that I couldn't find any device driver using multiple MSI. There are examples using either single MSI or multiple MSI-X, but no multiple MSI.
I'm trying to get a x1 PCIe card with a Lattice ECP5 FPGA working, which utilises 2 MSIs. Depending on whether the IOMMU is enabled or not, I'm able to allocate both desired
MSIs (with IOMMU enabled) or only one MSI (IOMMU disabled). I could happily live with the IOMMU disabled, but I can't allocate the second MSI then, which is required for the 
function of the device: the first MSI is used to signal that a DMA transfer from the FPGA to the CPU has finished. The associated IRQ handler basically just wakes up an user mode task.
The second MSI is used as a shared IRQ for a number of 16750-compatible UARTs in the FPGA, mapped through a Wishbone bus to the PCIe BAR.
The first MSI works perfectly, but the second one causes one IOMMU page faults once per UART during probing of the UARTs, and one IOMMU page fault with every byte received through
any UART. I've been running out of ideas a while ago as the IOMMU subsystem is too complex to understand for me as a non-kernel developer. But I'd highly appreciate any hints from
more experienced developers. Could anybody provide me some pointers, please?

Best regards,

Patrick

-- 
Patrick Brunner

Stettbacher Signal Processing
Neugutstrasse 54
CH-8600 Duebendorf

Switzerland

Phone: +41 43 299 57 23
Mail:  brunner@stettbacher.ch



