Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67527C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 12:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47AEF20835
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 12:54:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439696AbfIWMyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 08:54:12 -0400
Received: from regular1.263xmail.com ([211.150.70.205]:38198 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437412AbfIWMyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 08:54:11 -0400
Received: from hjc?rock-chips.com (unknown [192.168.167.236])
        by regular1.263xmail.com (Postfix) with ESMTP id 352B045D;
        Mon, 23 Sep 2019 20:54:07 +0800 (CST)
X-263anti-spam: KSV:0;BIG:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ADDR-CHECKED4: 1
X-ABS-CHECKED: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P17988T139868132738816S1569243231409431_;
        Mon, 23 Sep 2019 20:54:07 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <084f3f145c6b5f8aeb6e10a2d2d49b50>
X-RL-SENDER: hjc@rock-chips.com
X-SENDER: hjc@rock-chips.com
X-LOGIN-NAME: hjc@rock-chips.com
X-FST-TO: dri-devel@lists.freedesktop.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From:   Sandy Huang <hjc@rock-chips.com>
To:     dri-devel@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Sandy Huang <hjc@rock-chips.com>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Sean Paul <sean@poorly.run>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 35/36] drm/udl: use bpp instead of cpp for drm_format_info
Date:   Mon, 23 Sep 2019 20:53:49 +0800
Message-Id: <1569243230-183568-5-git-send-email-hjc@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1569243230-183568-1-git-send-email-hjc@rock-chips.com>
References: <1569243230-183568-1-git-send-email-hjc@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpp[BytePerPlane] can't describe the 10bit data format correctly,
So we use bpp[BitPerPlane] to instead cpp.

Signed-off-by: Sandy Huang <hjc@rock-chips.com>
---
 drivers/gpu/drm/udl/udl_fb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/udl/udl_fb.c b/drivers/gpu/drm/udl/udl_fb.c
index ef3504d..33a42bd 100644
--- a/drivers/gpu/drm/udl/udl_fb.c
+++ b/drivers/gpu/drm/udl/udl_fb.c
@@ -88,8 +88,8 @@ int udl_handle_damage(struct udl_framebuffer *fb, int x, int y,
 	int aligned_x;
 	int log_bpp;
 
-	BUG_ON(!is_power_of_2(fb->base.format->cpp[0]));
-	log_bpp = __ffs(fb->base.format->cpp[0]);
+	BUG_ON(!is_power_of_2(fb->base.format->bpp[0] / 8));
+	log_bpp = __ffs(fb->base.format->bpp[0] / 8);
 
 	if (!fb->active_16)
 		return 0;
-- 
2.7.4



