Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2EBC07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 08:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BEA12173B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 08:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfE0Ist (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 04:48:49 -0400
Received: from mga03.intel.com ([134.134.136.65]:65534 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbfE0Isq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 04:48:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 May 2019 01:48:45 -0700
X-ExtLoop1: 1
Received: from gvt.bj.intel.com ([10.238.158.187])
  by fmsmga004.fm.intel.com with ESMTP; 27 May 2019 01:48:43 -0700
From:   Tina Zhang <tina.zhang@intel.com>
Cc:     Tina Zhang <tina.zhang@intel.com>,
        intel-gvt-dev@lists.freedesktop.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kraxel@redhat.com,
        zhenyuw@linux.intel.com, alex.williamson@redhat.com,
        hang.yuan@intel.com, zhiyuan.lv@intel.com
Subject: [PATCH 1/2] vfio: ABI for setting mdev display flip eventfd
Date:   Mon, 27 May 2019 16:43:11 +0800
Message-Id: <20190527084312.8872-2-tina.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190527084312.8872-1-tina.zhang@intel.com>
References: <20190527084312.8872-1-tina.zhang@intel.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add VFIO_DEVICE_SET_GFX_FLIP_EVENTFD ioctl command to set eventfd
based signaling mechanism to deliver vGPU framebuffer page flip
event to userspace.

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 include/uapi/linux/vfio.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 02bb7ad6e986..27300597717f 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -696,6 +696,18 @@ struct vfio_device_ioeventfd {
 
 #define VFIO_DEVICE_IOEVENTFD		_IO(VFIO_TYPE, VFIO_BASE + 16)
 
+/**
+ * VFIO_DEVICE_SET_GFX_FLIP_EVENTFD - _IOW(VFIO_TYPE, VFIO_BASE + 17, __s32)
+ *
+ * Set eventfd based signaling mechanism to deliver vGPU framebuffer page
+ * flip event to userspace. A value of -1 is used to stop the page flip
+ * delivering.
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+
+#define VFIO_DEVICE_SET_GFX_FLIP_EVENTFD _IO(VFIO_TYPE, VFIO_BASE + 17)
+
 /* -------- API for Type1 VFIO IOMMU -------- */
 
 /**
-- 
2.17.1

