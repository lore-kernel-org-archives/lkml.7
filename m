Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D99C432C2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 16:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61D5921A4A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 16:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569343877;
	bh=xnovLF+3uh2WwoA52FYSiy8zjjoMSiF+mmojNkCbgjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aEGgRhEUv54RsdI5fr3zgO2FMYXzONzL3LI9aaLN9rXCzFNNWyRfxICo7CiWdgEXy
	 UWjYA83FV4Vj4N0TivPh7snX8aWwDXR8vkIrBN430815dnlKdJJj5rb+1T47oKMQlY
	 YaBvL6DUZTlsevHNc1y+PH+pMiT//bX2cTFW1olw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410863AbfIXQvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 12:51:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:44458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441551AbfIXQvN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 12:51:13 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BBFC2054F;
        Tue, 24 Sep 2019 16:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569343873;
        bh=xnovLF+3uh2WwoA52FYSiy8zjjoMSiF+mmojNkCbgjQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LG65nsI7aCDrsUpI3kdv49U48RAgZzlROlQSrGSPRD8J3CnaXbeLVmarqs/35IpwF
         JkkuC3aodkGI7BIOD+zb3yVzphANTF9yg6W8WQf4KbE/akLa8w2oUCk5HBS7Ey718v
         PsnyQs+rvckRWQ6oeH16kKKIhQPzFHOjWekqonYg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mark Menzynski <mmenzyns@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Karol Herbst <kherbst@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.14 21/28] drm/nouveau/volt: Fix for some cards having 0 maximum voltage
Date:   Tue, 24 Sep 2019 12:50:24 -0400
Message-Id: <20190924165031.28292-21-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190924165031.28292-1-sashal@kernel.org>
References: <20190924165031.28292-1-sashal@kernel.org>
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

