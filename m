Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D647C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 14:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7526A2070B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 14:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574344953;
	bh=QNl5ddLlEQtj52j/MrXKdvbk9C/ac81zzKOpevreAlo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0MQFBy3gHsPOpG6B+yBRb48qYh0k23uAl6/h4H4YDOYjOB1WAbcpjCUn4PaAq4d5M
	 P3+BiIbSuiaSPLJxX7Yt6jTOMkcZNqN/1nQCPEq24vJ/E31PobN/C7gYmmoWy2RHTN
	 LiM2cKwDK8q+u1JJkSLK2HDKB0G06I+q21o5wk8Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfKUOCc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 09:02:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:35686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbfKUOCa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 09:02:30 -0500
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2918C2070B;
        Thu, 21 Nov 2019 14:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574344950;
        bh=QNl5ddLlEQtj52j/MrXKdvbk9C/ac81zzKOpevreAlo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nE13WhF9osewZpyc5VcK5pgYoegxUhErGHh15hrUmRqty2dv5MIKf3XhGCXZpSwOh
         +t4Q9oucbnTf26CkDgDDNN4O4wIC8nyLa2x8f1nix4T6sySG/W6pcJn0Hnt5ZyHgQL
         TI++KCuYgfo2TIGe+nr66fTwAHyswUv7QeM8WNuo=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        Frederick Lawler <fred@fredlawl.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/7] PCI: Add #defines for Enter Compliance, Transmit Margin
Date:   Thu, 21 Nov 2019 08:02:14 -0600
Message-Id: <20191121140220.38030-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
In-Reply-To: <20191121140220.38030-1-helgaas@kernel.org>
References: <20191121140220.38030-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Add definitions for the Enter Compliance and Transmit Margin fields of the
PCIe Link Control 2 register.

Link: https://lore.kernel.org/r/20191112173503.176611-2-helgaas@kernel.org
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 include/uapi/linux/pci_regs.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 29d6e93fd15e..5869e5778a05 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -673,6 +673,8 @@
 #define  PCI_EXP_LNKCTL2_TLS_8_0GT	0x0003 /* Supported Speed 8GT/s */
 #define  PCI_EXP_LNKCTL2_TLS_16_0GT	0x0004 /* Supported Speed 16GT/s */
 #define  PCI_EXP_LNKCTL2_TLS_32_0GT	0x0005 /* Supported Speed 32GT/s */
+#define  PCI_EXP_LNKCTL2_ENTER_COMP	0x0010 /* Enter Compliance */
+#define  PCI_EXP_LNKCTL2_TX_MARGIN	0x0380 /* Transmit Margin */
 #define PCI_EXP_LNKSTA2		50	/* Link Status 2 */
 #define PCI_CAP_EXP_ENDPOINT_SIZEOF_V2	52	/* v2 endpoints with link end here */
 #define PCI_EXP_SLTCAP2		52	/* Slot Capabilities 2 */
-- 
2.24.0.432.g9d3f5f5b63-goog

