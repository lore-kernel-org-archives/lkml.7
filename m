Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8089C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 14:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CCD1218CD
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 14:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553956918;
	bh=ar6HuSPsuTQAbeDPCZQGqYEeHMmGny4xRq7ZinfB++k=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=EJFkyG/CVHucen25GJaNaO6lKirYPmc/UY+cnJrE0qkgfwzbiX9XaHi0bxuXFhUBz
	 0QBg8xEhrevrCTsvKB6lJmZvTAtimeb5X09LFiQNFnsokuX/SZ/insAQy02kayWem9
	 6fywoDM8OwNbnR/2tFs8mxih11oRhimHcT3Neqb4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730935AbfC3Olz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 10:41:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:52036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730849AbfC3Oly (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 10:41:54 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3E2C218CD;
        Sat, 30 Mar 2019 14:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553956914;
        bh=ar6HuSPsuTQAbeDPCZQGqYEeHMmGny4xRq7ZinfB++k=;
        h=From:To:Cc:Subject:Date:From;
        b=KNrc7r4RH2CtY4jleuzK5gNQhw/CLEnUUWHMcwn7qCoJV67nWjd//gc4AfcTnDsDw
         9zE8enGpu5FCgjNIGWWI9lYu/uHbMk411jmQA3DjHSm2D4T0DX7Gofx1Eag8WZZ6YV
         EKjhqqKQPtJWZoeJBQLxtvR+kYoUTa2shJrK27ao=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joe Perches <joe@perches.com>,
        Eric Auger <eric.auger@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 0/1] vfio: Use dev_printk() when possible
Date:   Sat, 30 Mar 2019 09:41:34 -0500
Message-Id: <20190330144135.17351-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Use dev_printk() in VFIO when possible.

Changes from v1:
  - Add colons after __func__ names in vfio_platform_amdxgbe.c (thanks,
    Joe).
  - Use the correct struct device * in vfio_platform_amdxgbe.c (thanks,
    Eric).
  - Use pci_printk() when we know we have a PCI device.
  - Add pci_notice_ratelimited() for use in vfio_pci.c.
  - Define dev_fmt in vfio_pci.c to avoid dropping the KBUILD_MODNAME
    prefix when converting from pr_*() to pci_printk().  This also adds
    the prefix to the places that already used dev_printk().
  - Define dev_fmt in vfio_platform_common.c to avoid repeating "VFIO :" in
    messages (this also adds it to a few that didn't use the prefix).

Bjorn Helgaas (1):
  vfio: Use dev_printk() when possible

 drivers/vfio/pci/vfio_pci.c                   | 26 +++++++----------
 drivers/vfio/pci/vfio_pci_config.c            | 28 ++++++++----------
 .../platform/reset/vfio_platform_amdxgbe.c    |  5 ++--
 drivers/vfio/platform/vfio_platform_common.c  | 12 ++++----
 drivers/vfio/vfio.c                           | 29 +++++++++----------
 include/linux/pci.h                           |  3 ++
 6 files changed, 49 insertions(+), 54 deletions(-)

-- 
2.21.0.392.gf8f6787159e-goog
