Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD59C3A589
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 02:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2839E206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 02:36:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfHPCgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 22:36:04 -0400
Received: from mga07.intel.com ([134.134.136.100]:39512 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726414AbfHPCgC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 22:36:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Aug 2019 19:35:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,391,1559545200"; 
   d="scan'208";a="194894840"
Received: from gvt.bj.intel.com ([10.238.158.180])
  by fmsmga001.fm.intel.com with ESMTP; 15 Aug 2019 19:35:47 -0700
From:   Tina Zhang <tina.zhang@intel.com>
To:     intel-gvt-dev@lists.freedesktop.org
Cc:     Tina Zhang <tina.zhang@intel.com>, kraxel@redhat.com,
        alex.williamson@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, hang.yuan@intel.com,
        zhiyuan.lv@intel.com
Subject: [PATCH v5 2/6] vfio: Introduce vGPU display irq type
Date:   Fri, 16 Aug 2019 10:35:24 +0800
Message-Id: <20190816023528.30210-3-tina.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190816023528.30210-1-tina.zhang@intel.com>
References: <20190816023528.30210-1-tina.zhang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce vGPU specific irq type VFIO_IRQ_TYPE_GFX, and
VFIO_IRQ_SUBTYPE_GFX_DISPLAY_IRQ as the subtype for vGPU display.

Introduce vfio_irq_info_cap_display_plane_events capability to notify
user space with the vGPU's plane update events

v2:
- Add VFIO_IRQ_SUBTYPE_GFX_DISPLAY_IRQ description. (Alex & Kechen)
- Introduce vfio_irq_info_cap_display_plane_events. (Gerd & Alex)

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 include/uapi/linux/vfio.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index d83c9f136a5b..21ac69f0e1a9 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -465,6 +465,27 @@ struct vfio_irq_info_cap_type {
 	__u32 subtype;  /* type specific */
 };
 
+#define VFIO_IRQ_TYPE_GFX				(1)
+/*
+ * vGPU vendor sub-type
+ * vGPU device display related interrupts e.g. vblank/pageflip
+ */
+#define VFIO_IRQ_SUBTYPE_GFX_DISPLAY_IRQ		(1)
+
+/*
+ * Display capability of using one eventfd to notify user space with the
+ * vGPU's plane update events.
+ * cur_event_val: eventfd value stands for cursor plane change event.
+ * pri_event_val: eventfd value stands for primary plane change event.
+ */
+#define VFIO_IRQ_INFO_CAP_DISPLAY	4
+
+struct vfio_irq_info_cap_display_plane_events {
+	struct vfio_info_cap_header header;
+	__u64 cur_event_val;
+	__u64 pri_event_val;
+};
+
 /**
  * VFIO_DEVICE_SET_IRQS - _IOW(VFIO_TYPE, VFIO_BASE + 10, struct vfio_irq_set)
  *
-- 
2.17.1

