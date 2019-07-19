Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3847C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3E1721851
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563509679;
	bh=naRzSXOMxwow96QrKs/l+61O5zHaltgJdKK2olHoEuc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gxXahRSJjd0d1oTFh2lTNW7hqUGPQd8Xe+OwLQNW5v3jd56EUsVPSEdiCoVbzffBZ
	 XXzeEoIXjCedQclNnm5Y5e2PyRcVp3/j4FVlnq/vGDzBt/UgDZvqa1NIbfNuC0C1tb
	 b5IKD7rQrUJsGAeh/EbdDRW8jHCrJZBOIlAbbu84=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388717AbfGSEOi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 00:14:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:50804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733197AbfGSEOf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 00:14:35 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 847EC2189E;
        Fri, 19 Jul 2019 04:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563509674;
        bh=naRzSXOMxwow96QrKs/l+61O5zHaltgJdKK2olHoEuc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0CoshZFwlIlvZ2KRb04R37jroXLYJJuedQNrga5InNu8b5eBkP+b+s9xQStSiTMiQ
         L5q//X4uhL8DzqQpSujuXUf84l6WXGUzHMU/OWDtQ3jpO0St4NREKPOXmXMgK1wvwe
         ThFEGCS1GatZ5WGdrULDKsr+IYT+RoYgXgGbTdsU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Gen Zhang <blackgod016574@gmail.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.4 06/35] drm/edid: Fix a missing-check bug in drm_load_edid_firmware()
Date:   Fri, 19 Jul 2019 00:13:54 -0400
Message-Id: <20190719041423.19322-6-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190719041423.19322-1-sashal@kernel.org>
References: <20190719041423.19322-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gen Zhang <blackgod016574@gmail.com>

[ Upstream commit 9f1f1a2dab38d4ce87a13565cf4dc1b73bef3a5f ]

In drm_load_edid_firmware(), fwstr is allocated by kstrdup(). And fwstr
is dereferenced in the following codes. However, memory allocation
functions such as kstrdup() may fail and returns NULL. Dereferencing
this null pointer may cause the kernel go wrong. Thus we should check
this kstrdup() operation.
Further, if kstrdup() returns NULL, we should return ERR_PTR(-ENOMEM) to
the caller site.

Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
Reviewed-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190524023222.GA5302@zhanggen-UX430UQ
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_edid_load.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/drm_edid_load.c b/drivers/gpu/drm/drm_edid_load.c
index 698b8c3b09d9..b5f582466609 100644
--- a/drivers/gpu/drm/drm_edid_load.c
+++ b/drivers/gpu/drm/drm_edid_load.c
@@ -280,6 +280,8 @@ int drm_load_edid_firmware(struct drm_connector *connector)
 	 * the last one found one as a fallback.
 	 */
 	fwstr = kstrdup(edid_firmware, GFP_KERNEL);
+	if (!fwstr)
+		return ERR_PTR(-ENOMEM);
 	edidstr = fwstr;
 
 	while ((edidname = strsep(&edidstr, ","))) {
-- 
2.20.1

