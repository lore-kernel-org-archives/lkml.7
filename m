Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C31C432C2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 16:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55FD0217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 16:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569343797;
	bh=xnovLF+3uh2WwoA52FYSiy8zjjoMSiF+mmojNkCbgjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Y48fPR+kwutGU/ummU52/TTRUa6Df7Mve0vxXDr72ncNYVcp7t1cnvMjNVocdQBKj
	 BbnUZ0AHr8itgAuy8j1+8IUjtAjAYKkA9wlEF8SbKJxVrZBrMzF+lUDEA30SJZ5pvz
	 QspNvNY7e9RanzvlcSrzGIT/Yk4rMxbHVQ3ZdHhI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410650AbfIXQt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 12:49:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:42326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390677AbfIXQtw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 12:49:52 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D5BD21971;
        Tue, 24 Sep 2019 16:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569343792;
        bh=xnovLF+3uh2WwoA52FYSiy8zjjoMSiF+mmojNkCbgjQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wagG87v4g9pTJqBxynBcKlllWJn/sz7SqItoactpvosaMxqSVdVup8T/HrvpI5XHb
         hg1EvSueyTuoPo6jENUVB8SfZUncGz9JDMHd2RlkhrB5wg9aRx+EiTi46zfh86Z4ly
         EvHzSZNc0Y5EVJDB2lLwIr0yTfqa/9FmVANx4U8g=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mark Menzynski <mmenzyns@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Karol Herbst <kherbst@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 31/50] drm/nouveau/volt: Fix for some cards having 0 maximum voltage
Date:   Tue, 24 Sep 2019 12:48:28 -0400
Message-Id: <20190924164847.27780-31-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190924164847.27780-1-sashal@kernel.org>
References: <20190924164847.27780-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Menzynski <mmenzyns@redhat.com>

[ Upstream commit a1af2afbd244089560794c260b2d4326a86e39b6 ]

Some, mostly Fermi, vbioses appear to have zero max voltage. That causes Nouveau to not parse voltage entries, thus users not being able to set higher clocks.

When changing this value Nvidia driver still appeared to ignore it, and I wasn't able to find out why, thus the code is ignoring the value if it is zero.

CC: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Signed-off-by: Mark Menzynski <mmenzyns@redhat.com>
Reviewed-by: Karol Herbst <kherbst@redhat.com>
Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/bios/volt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/volt.c b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/volt.c
index 7143ea4611aa3..33a9fb5ac5585 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/volt.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/volt.c
@@ -96,6 +96,8 @@ nvbios_volt_parse(struct nvkm_bios *bios, u8 *ver, u8 *hdr, u8 *cnt, u8 *len,
 		info->min     = min(info->base,
 				    info->base + info->step * info->vidmask);
 		info->max     = nvbios_rd32(bios, volt + 0x0e);
+		if (!info->max)
+			info->max = max(info->base, info->base + info->step * info->vidmask);
 		break;
 	case 0x50:
 		info->min     = nvbios_rd32(bios, volt + 0x0a);
-- 
2.20.1

