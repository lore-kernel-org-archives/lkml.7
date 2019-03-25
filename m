Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39629C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0867F20830
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553551962;
	bh=aiXEokUhkk3Q9QkMaroYiRzW35Z0nCxC1TnA2AEMrBM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=OihtnNXHgya/gbEvvIcJWlEUIAh4rnV1soSdwlp+9RwAMKY8x0RkMtjfCk+WwsRxO
	 TBRda4xuTOBzZQv1O/+Ch/SMFwzkLzgfdOvFKFDNQ4ronXRKmNMFL6/ZJWD06xx3K4
	 E1uIZxyyp4zMrBtku1rbn8uSdJm39iews9dOWKVs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730997AbfCYWMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 18:12:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:50310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730700AbfCYWMj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 18:12:39 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E8F12075E;
        Mon, 25 Mar 2019 22:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553551958;
        bh=aiXEokUhkk3Q9QkMaroYiRzW35Z0nCxC1TnA2AEMrBM=;
        h=From:To:Cc:Subject:Date:From;
        b=Lp7vwrWCdnwbHGo8WxWT5eXiOwvnE0y+R+wrexmDJA/Fz2Rvlzc4SZlW2fpceEQI/
         /eus//gGPKSLSNcmRmTJGomzVqtuuXuIsIWt89j38aB8Dk17I90gXzvRbhfVMgN/CB
         XFkBXu/6zw7hl+pFSSDgPOg8IlIgLqyjbRdEwmWw=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 0/2] PCI/MSI: Remove unused interfaces
Date:   Mon, 25 Mar 2019 17:12:27 -0500
Message-Id: <20190325221229.36930-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

pcie-xilinx-nwl.c is the only driver to use mask_msi_irq() and
unmask_msi_irq(), which are trivial wrappers around PCI-specific functions.
We obviously know we need the PCI versions in this driver, so use them
directly, as all the other PCI host controller drivers do, and remove the
unused wrappers.

Unless there's objection, I'll merge both of these via my tree just to keep
them together.

Bjorn Helgaas (2):
  PCI/MSI: Remove unused __write_msi_msg() and write_msi_msg()
  PCI/MSI: Remove unused mask_msi_irq() and unmask_msi_irq()

 drivers/pci/controller/pcie-xilinx-nwl.c |  9 ++++-----
 include/linux/msi.h                      | 18 ------------------
 2 files changed, 4 insertions(+), 23 deletions(-)

-- 
2.21.0.392.gf8f6787159e-goog

