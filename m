Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33597C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F36B420643
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555356006;
	bh=IOwCOy0l8euoE2JG7Gb3t07MSuhkev9wzBtHpfbfoqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z+Q0GtBd1M/nj3wHGo7fuV+cMJB0jPWjBbrh/vqtNdhiNnGKzENluJ7A+FDX2+cjl
	 EUsXg8ptKEB/hdw/mfFg7pfrzjKC0LVtCf3PK2bRF0A41JrN/GsrzVIb3WyXlXPg+l
	 gdbBQd0GE7ytN7Tgv9UTHJpWWAetoaSU7NC2JjOc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730873AbfDOTKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:10:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:45962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729610AbfDOTKB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:10:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54311218A1;
        Mon, 15 Apr 2019 19:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355400;
        bh=IOwCOy0l8euoE2JG7Gb3t07MSuhkev9wzBtHpfbfoqE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lkgBfcMj5s1uAOQlWxZ5NZn6QhlNRyAv2r2qmbhJtsYbAI5ME51wQhrXyLrgM6q5J
         ewiHJ8C7QHlS+4cphUSYiV4ClUv8bQtSbPSYIwMnB8g3e1KAF/jIhLVwxNK/FYYPXX
         91Jr9iq0egZmgfPWyOxbwpFkY43Oi1MhzhGZZxwk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 021/117] r8169: disable ASPM again
Date:   Mon, 15 Apr 2019 20:59:51 +0200
Message-Id: <20190415183745.985425646@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183744.887851196@linuxfoundation.org>
References: <20190415183744.887851196@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit b75bb8a5b755d0c7bf1ac071e4df2349a7644a1e ]

There's a significant number of reports that re-enabling ASPM causes
different issues, ranging from decreased performance to system not
booting at all. This affects only a minority of users, but the number
of affected users is big enough that we better switch off ASPM again.

This will hurt notebook users who are not affected by the issues, they
may see decreased battery runtime w/o ASPM. With the PCI core folks is
being discussed to add generic sysfs attributes to control ASPM.
Once this is in place brave enough users can re-enable ASPM on their
system.

Fixes: a99790bf5c7f ("r8169: Reinstate ASPM Support")
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/realtek/r8169.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/realtek/r8169.c b/drivers/net/ethernet/realtek/r8169.c
index f55d177ae894..5adb00f521db 100644
--- a/drivers/net/ethernet/realtek/r8169.c
+++ b/drivers/net/ethernet/realtek/r8169.c
@@ -28,6 +28,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/firmware.h>
 #include <linux/prefetch.h>
+#include <linux/pci-aspm.h>
 #include <linux/ipv6.h>
 #include <net/ip6_checksum.h>
 
@@ -7224,6 +7225,11 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 			return rc;
 	}
 
+	/* Disable ASPM completely as that cause random device stop working
+	 * problems as well as full system hangs for some PCIe devices users.
+	 */
+	pci_disable_link_state(pdev, PCIE_LINK_STATE_L0S | PCIE_LINK_STATE_L1);
+
 	/* enable device (incl. PCI PM wakeup and hotplug setup) */
 	rc = pcim_enable_device(pdev);
 	if (rc < 0) {
-- 
2.19.1



