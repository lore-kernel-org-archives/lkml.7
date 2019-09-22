Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF23C3A5A2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 18:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E123221928
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 18:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569177953;
	bh=iPazQ00aOuuilt+GzDQbr9bRbIVeHkRFhHoRkii1JTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ooXd53MdHacVSWj6neX0XGrIYGXmbP7smfMO253QBN2XM509mBFB27VJYM3z+rDMs
	 1ZAUE7mbR77FDBVgxy0gcozodeWUcN9KNoebFEK3c5v3OWnkwDsJrw8c3bRlEpxgY/
	 fp/jKoEuqfITFapx+4MNbbfd7DyFFWIkQ763e9Dc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389625AbfIVSpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 14:45:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:41512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389409AbfIVSpq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 14:45:46 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 896BA206C2;
        Sun, 22 Sep 2019 18:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569177945;
        bh=iPazQ00aOuuilt+GzDQbr9bRbIVeHkRFhHoRkii1JTQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gwlaVk9mJVxz/KN69s6DYEMlUA4acajYpHBdHZu9bnPbSWATgeJUOgCyn87sG5niB
         ru56FtX5eY6JRoSNAUW9xcqfaa8YKpf7Mnc4ZtsthXIjqsNtINdAOZ9tG/1JJy5azZ
         zrLf/p+cQMN5LewpO9XipmeP6rkavfCOFKv0evtQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 5.3 053/203] media: media/platform: fsl-viu.c: fix build for MICROBLAZE
Date:   Sun, 22 Sep 2019 14:41:19 -0400
Message-Id: <20190922184350.30563-53-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190922184350.30563-1-sashal@kernel.org>
References: <20190922184350.30563-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit 6898dd580a045341f844862ceb775144156ec1af ]

arch/microblaze/ defines out_be32() and in_be32(), so don't do that
again in the driver source.

Fixes these build warnings:

../drivers/media/platform/fsl-viu.c:36: warning: "out_be32" redefined
../arch/microblaze/include/asm/io.h:50: note: this is the location of the previous definition
../drivers/media/platform/fsl-viu.c:37: warning: "in_be32" redefined
../arch/microblaze/include/asm/io.h:53: note: this is the location of the previous definition

Fixes: 29d750686331 ("media: fsl-viu: allow building it with COMPILE_TEST")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/fsl-viu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/fsl-viu.c b/drivers/media/platform/fsl-viu.c
index 691be788e38b3..b74e4f50d7d9f 100644
--- a/drivers/media/platform/fsl-viu.c
+++ b/drivers/media/platform/fsl-viu.c
@@ -32,7 +32,7 @@
 #define VIU_VERSION		"0.5.1"
 
 /* Allow building this driver with COMPILE_TEST */
-#ifndef CONFIG_PPC
+#if !defined(CONFIG_PPC) && !defined(CONFIG_MICROBLAZE)
 #define out_be32(v, a)	iowrite32be(a, (void __iomem *)v)
 #define in_be32(a)	ioread32be((void __iomem *)a)
 #endif
-- 
2.20.1

