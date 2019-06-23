Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D28DC43613
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 17:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 066762133F
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 17:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IhAuLaJF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbfFWRIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 13:08:21 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38575 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbfFWRIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 13:08:16 -0400
Received: by mail-qk1-f195.google.com with SMTP id a27so8072020qkk.5;
        Sun, 23 Jun 2019 10:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M9elc0PQ+TI8jbg2PmLg+UuOO6GjGx+5PwCXytaA0Wc=;
        b=IhAuLaJF4p/Ij7jvNewOxVJ/KZgmy2R1Vv6RMRFzKePLzpQRrtXb/6Ocxrb/QaaVFO
         9mvH+TCOnyIpw7OQEzPZ58+EtOP3CtqXqCuME0XLEC0XkcDQPf4omElc8/KNLhY/H2qV
         6r8nsB39P7MoTHfGHJNAvJzZkXLdkHSnJakJbtBAhQ/SK+NTkp7zhgufqjJDYkTki46c
         r6t2B24TANc2djX1kewd6hWOm8XOX60d2xpSKSPcMvmR7KdYERJ8ct6opayn9wkD9rOV
         BI2xhmc0u59mnsxMbwsLBCbBRADgswLlUG+Sn/ogA9QKT0e1LMaMHi+zppTnmJLaFC9p
         TqaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M9elc0PQ+TI8jbg2PmLg+UuOO6GjGx+5PwCXytaA0Wc=;
        b=dznZYac/s1ozPgOEkHSVW6di61BfNlSqipiGR/6/OgYwXLqSxqZo1nzYjwQKd4QELN
         lM+Gp8y0sotK3rUx95xW2Bn7i1vQCgICyFHT0bK24bPAQCWPDEkWLRknJYjSpn+6NpaZ
         VI72Z5lGCd6lf8iFu79ZLnCEhD2ibMWd3IQkBDlcouI25QNDZuFtED/9mfdqi/zmokFs
         kIzQWTKfNaaZgI3K5XflnbCSYHEG+Ns8HPn4q0BhCX9fU3HSIxOJUDPYPMJ9N8MpDLyQ
         WWvd5YTl6XqOiWJKVa8duDH54POCAA73Uhx6qw/ujv1gv8gXwGVk1q1jQQSZtyoga6u1
         M/Dg==
X-Gm-Message-State: APjAAAVi3X2+VBbyLCDoZsQ0vR6Qd3C6yGL7vN1Vgc6xpsraSe753jM6
        pv2/J+L7rKfvihhsrfuUt7o=
X-Google-Smtp-Source: APXvYqyT/dhyY8beKLB+S5C2DTElYVyHUfi2XKiR44cnoiCe02r+rHBnMkyjjoblnPDYTakeNvfu7A==
X-Received: by 2002:a37:6152:: with SMTP id v79mr13049899qkb.488.1561309695342;
        Sun, 23 Jun 2019 10:08:15 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id o54sm5790756qtb.63.2019.06.23.10.08.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Jun 2019 10:08:14 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] staging: media: tegra-vde: Manually pack UAPI structures
Date:   Sun, 23 Jun 2019 20:07:28 +0300
Message-Id: <20190623170730.5095-6-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190623170730.5095-1-digetx@gmail.com>
References: <20190623170730.5095-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The __packed macro isn't available in userspace with the kernel headers.
Checkpatch asks to use the macro, which is unwanted in a case of a UAPI
header. There is no much benefit in a tight packing of the structures,
hence let's pack them manually to cleanup things a tad. Note that there
is no old-stable userspace that will suffer from this change, hence it's
fine to change the ABI. In a result also more space is reserved for a
possible future expansion of the UAPI as it was already shown that more
fields will be needed for a later SoC generations.

Suggested-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/staging/media/tegra-vde/tegra-vde.c | 13 +++++-
 drivers/staging/media/tegra-vde/uapi.h      | 44 +++++++++++----------
 2 files changed, 34 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/media/tegra-vde/tegra-vde.c b/drivers/staging/media/tegra-vde/tegra-vde.c
index a5020dbf6eef..cc4244da2705 100644
--- a/drivers/staging/media/tegra-vde/tegra-vde.c
+++ b/drivers/staging/media/tegra-vde/tegra-vde.c
@@ -795,7 +795,7 @@ static int tegra_vde_ioctl_decode_h264(struct tegra_vde *vde,
 {
 	struct device *dev = vde->miscdev.parent;
 	struct tegra_vde_h264_decoder_ctx ctx;
-	struct tegra_vde_h264_frame frames[17];
+	struct tegra_vde_h264_frame *frames;
 	struct tegra_vde_h264_frame __user *frames_user;
 	struct video_frame *dpb_frames;
 	struct dma_buf_attachment *bitstream_data_dmabuf_attachment;
@@ -830,11 +830,17 @@ static int tegra_vde_ioctl_decode_h264(struct tegra_vde *vde,
 	if (ret)
 		return ret;
 
+	frames = kmalloc_array(ctx.dpb_frames_nb, sizeof(*frames), GFP_KERNEL);
+	if (!frames) {
+		ret = -ENOMEM;
+		goto release_bitstream_dmabuf;
+	}
+
 	dpb_frames = kcalloc(ctx.dpb_frames_nb, sizeof(*dpb_frames),
 			     GFP_KERNEL);
 	if (!dpb_frames) {
 		ret = -ENOMEM;
-		goto release_bitstream_dmabuf;
+		goto free_frames;
 	}
 
 	macroblocks_nb = ctx.pic_width_in_mbs * ctx.pic_height_in_mbs;
@@ -955,6 +961,9 @@ static int tegra_vde_ioctl_decode_h264(struct tegra_vde *vde,
 free_dpb_frames:
 	kfree(dpb_frames);
 
+free_frames:
+	kfree(frames);
+
 release_bitstream_dmabuf:
 	tegra_vde_detach_and_put_dmabuf(bitstream_data_dmabuf_attachment,
 					bitstream_sgt, DMA_TO_DEVICE);
diff --git a/drivers/staging/media/tegra-vde/uapi.h b/drivers/staging/media/tegra-vde/uapi.h
index dd3e4a8c9f7e..ffb4983e5bb6 100644
--- a/drivers/staging/media/tegra-vde/uapi.h
+++ b/drivers/staging/media/tegra-vde/uapi.h
@@ -21,40 +21,42 @@ struct tegra_vde_h264_frame {
 	__u32 frame_num;
 	__u32 flags;
 
-	__u32 reserved;
-} __attribute__((packed));
+	// Must be zero'ed
+	__u32 reserved[6];
+};
 
 struct tegra_vde_h264_decoder_ctx {
 	__s32 bitstream_data_fd;
 	__u32 bitstream_data_offset;
 
 	__u64 dpb_frames_ptr;
-	__u8  dpb_frames_nb;
-	__u8  dpb_ref_frames_with_earlier_poc_nb;
+	__u32 dpb_frames_nb;
+	__u32 dpb_ref_frames_with_earlier_poc_nb;
 
 	// SPS
-	__u8  baseline_profile;
-	__u8  level_idc;
-	__u8  log2_max_pic_order_cnt_lsb;
-	__u8  log2_max_frame_num;
-	__u8  pic_order_cnt_type;
-	__u8  direct_8x8_inference_flag;
-	__u8  pic_width_in_mbs;
-	__u8  pic_height_in_mbs;
+	__u32 baseline_profile;
+	__u32 level_idc;
+	__u32 log2_max_pic_order_cnt_lsb;
+	__u32 log2_max_frame_num;
+	__u32 pic_order_cnt_type;
+	__u32 direct_8x8_inference_flag;
+	__u32 pic_width_in_mbs;
+	__u32 pic_height_in_mbs;
 
 	// PPS
-	__u8  pic_init_qp;
-	__u8  deblocking_filter_control_present_flag;
-	__u8  constrained_intra_pred_flag;
-	__u8  chroma_qp_index_offset;
-	__u8  pic_order_present_flag;
+	__u32 pic_init_qp;
+	__u32 deblocking_filter_control_present_flag;
+	__u32 constrained_intra_pred_flag;
+	__u32 chroma_qp_index_offset;
+	__u32 pic_order_present_flag;
 
 	// Slice header
-	__u8  num_ref_idx_l0_active_minus1;
-	__u8  num_ref_idx_l1_active_minus1;
+	__u32 num_ref_idx_l0_active_minus1;
+	__u32 num_ref_idx_l1_active_minus1;
 
-	__u32 reserved;
-} __attribute__((packed));
+	// Must be zero'ed
+	__u32 reserved[11];
+};
 
 #define VDE_IOCTL_BASE			('v' + 0x20)
 
-- 
2.22.0

