Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7415C3F68F
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EA2020848
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578005362;
	bh=Q/AXxm1gYiJzDMbgBmkkAKfLz3atIiIbLGydQgSASCg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aukH02Z2JOHH1G+lWoelcd3xOpGDHZjZFJWYWb9JCQaC5gmSbI5Zx/R4JLSjxtWJD
	 BOFN+6LXQYO3yKso5FYW+oy8QMnNq432bhpii9sRi1NdEn8chYroI1VGzjbH0ytOJy
	 NRK0I5fsOPcNp+X4t4J07ymoJAGyNYP8O4eVbfmM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729669AbgABW0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:26:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:54340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729662AbgABW0n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:26:43 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E9CB222C3;
        Thu,  2 Jan 2020 22:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578004002;
        bh=Q/AXxm1gYiJzDMbgBmkkAKfLz3atIiIbLGydQgSASCg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WjRUhz1v9jxcuHtY4jjpw6mq4ZMFfNy7Gj8spSxzlRxR28YdcHZs0ho8s/18Dvyy3
         XVCggVpE7JLxm2qRsU/yAEeNFA4ytEHMtiYo5X5GyUxpcyxSeGn6w7KQNk5wB19Z91
         a8zdZZoWpOIZnTmbT1spnv+5S1HF3RHLIjbOztM8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Doug Meyer <dmeyer@gigaio.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kelvin Cao <Kelvin.Cao@microchip.com>
Subject: [PATCH 4.14 63/91] PCI/switchtec: Read all 64 bits of part_event_bitmap
Date:   Thu,  2 Jan 2020 23:07:45 +0100
Message-Id: <20200102220441.848980103@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102220356.856162165@linuxfoundation.org>
References: <20200102220356.856162165@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Logan Gunthorpe <logang@deltatee.com>

commit 6acdf7e19b37cb3a9258603d0eab315079c19c5e upstream.

The part_event_bitmap register is 64 bits wide, so read it with ioread64()
instead of the 32-bit ioread32().

Fixes: 52eabba5bcdb ("switchtec: Add IOCTLs to the Switchtec driver")
Link: https://lore.kernel.org/r/20190910195833.3891-1-logang@deltatee.com
Reported-by: Doug Meyer <dmeyer@gigaio.com>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: stable@vger.kernel.org	# v4.12+
Cc: Kelvin Cao <Kelvin.Cao@microchip.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 drivers/pci/switch/switchtec.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -898,7 +898,7 @@ static int ioctl_event_summary(struct sw
 	u32 reg;
 
 	s.global = ioread32(&stdev->mmio_sw_event->global_summary);
-	s.part_bitmap = ioread32(&stdev->mmio_sw_event->part_event_bitmap);
+	s.part_bitmap = readq(&stdev->mmio_sw_event->part_event_bitmap);
 	s.local_part = ioread32(&stdev->mmio_part_cfg->part_event_summary);
 
 	for (i = 0; i < stdev->partition_count; i++) {


