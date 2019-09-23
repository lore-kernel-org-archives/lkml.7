Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B05C3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 12:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7F8820820
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 12:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502011AbfIWMtk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 08:49:40 -0400
Received: from regular1.263xmail.com ([211.150.70.203]:58628 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2501986AbfIWMth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 08:49:37 -0400
Received: from hjc?rock-chips.com (unknown [192.168.167.175])
        by regular1.263xmail.com (Postfix) with ESMTP id 846603AF;
        Mon, 23 Sep 2019 20:49:34 +0800 (CST)
X-263anti-spam: KSV:0;BIG:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ADDR-CHECKED4: 1
X-ABS-CHECKED: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P28975T139999806740224S1569242970112868_;
        Mon, 23 Sep 2019 20:49:34 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <e80715322c1dd25cac595a7e76606990>
X-RL-SENDER: hjc@rock-chips.com
X-SENDER: hjc@rock-chips.com
X-LOGIN-NAME: hjc@rock-chips.com
X-FST-TO: dri-devel@lists.freedesktop.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From:   Sandy Huang <hjc@rock-chips.com>
To:     dri-devel@lists.freedesktop.org,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     hjc@rock-chips.com, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 18/36] drm/xen: use bpp instead of cpp for drm_format_info
Date:   Mon, 23 Sep 2019 20:49:10 +0800
Message-Id: <1569242968-183093-3-git-send-email-hjc@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1569242968-183093-1-git-send-email-hjc@rock-chips.com>
References: <1569242968-183093-1-git-send-email-hjc@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpp[BytePerPlane] can't describe the 10bit data format correctly,
So we use bpp[BitPerPlane] to instead cpp.

Signed-off-by: Sandy Huang <hjc@rock-chips.com>
---
 drivers/gpu/drm/xen/xen_drm_front_kms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xen/xen_drm_front_kms.c b/drivers/gpu/drm/xen/xen_drm_front_kms.c
index 21ad1c3..31de140 100644
--- a/drivers/gpu/drm/xen/xen_drm_front_kms.c
+++ b/drivers/gpu/drm/xen/xen_drm_front_kms.c
@@ -123,7 +123,7 @@ static void display_enable(struct drm_simple_display_pipe *pipe,
 
 	ret = xen_drm_front_mode_set(pipeline, crtc->x, crtc->y,
 				     fb->width, fb->height,
-				     fb->format->cpp[0] * 8,
+				     fb->format->bpp[0],
 				     xen_drm_front_fb_to_cookie(fb));
 
 	if (ret) {
-- 
2.7.4



