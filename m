Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C4FC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5042C206EC
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576781682;
	bh=dqupO76jGLS7AojuD8LNGxHXPHitJQ7TttMVQLFsQIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=upDg1k+CACkCGKH6dJT50qWE2RnBYG56yEVY6Dj4ZYrqLS6rwq+jHhR1NTD/c01y4
	 JYSS1nzNyBwW1bMnlA1LCcTu/J8mlHX16sb6RQ4Es9NK4F4JQfZhCnXbooMbThdq5L
	 4yo5P3ZOaPo0FC+yRjey6YtP/eEMIlU3IS3+y7nc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730542AbfLSSyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:54:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:50174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730531AbfLSSyi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:54:38 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76A07206EC;
        Thu, 19 Dec 2019 18:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576781677;
        bh=dqupO76jGLS7AojuD8LNGxHXPHitJQ7TttMVQLFsQIM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XZeMMBn9hLtpXc8MND+Mc2Vb3Kkg+IDGRt+owTQt3jr4dxahbPg1Ceh45d7TF7Hi+
         77dg7OnGyG/knMTkhHAn+gVzZQCfHlQHxXW+zshOmwIUVwtD7AdcuBIatujxzh35CR
         ohQJp8sx1oTAQTfnk6SH/snLoh0Tqu5Ib2S8UTn0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Doug Meyer <dmeyer@gigaio.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kelvin Cao <Kelvin.Cao@microchip.com>
Subject: [PATCH 5.4 06/80] PCI/switchtec: Read all 64 bits of part_event_bitmap
Date:   Thu, 19 Dec 2019 19:33:58 +0100
Message-Id: <20191219183036.508108102@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219183031.278083125@linuxfoundation.org>
References: <20191219183031.278083125@linuxfoundation.org>
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
@@ -675,7 +675,7 @@ static int ioctl_event_summary(struct sw
 		return -ENOMEM;
 
 	s->global = ioread32(&stdev->mmio_sw_event->global_summary);
-	s->part_bitmap = ioread32(&stdev->mmio_sw_event->part_event_bitmap);
+	s->part_bitmap = ioread64(&stdev->mmio_sw_event->part_event_bitmap);
 	s->local_part = ioread32(&stdev->mmio_part_cfg->part_event_summary);
 
 	for (i = 0; i < stdev->partition_count; i++) {


