Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B18D6C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 03:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84145217F5
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 03:31:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XFeWOMUh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733114AbfKGDbH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 22:31:07 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43802 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727751AbfKGDbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 22:31:06 -0500
Received: by mail-pl1-f193.google.com with SMTP id a18so452547plm.10
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 19:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YVMKh2e8YQpMospkl4uly62/DXfMMR6TYHQbH303b5U=;
        b=XFeWOMUhS7MWx/RPebBtmCTa3v9cTmuIqF0sIt4h/CPMv889KM470slck2VUqYY2lo
         2UeLrke9Zr2PjxyNv0J0juZAmCq54wv+tpRIlsvEyYIDzX3vo0vDFy/K7IFPJpUMpKMo
         JgZ+rFiOCS4jEjPjW1LKNcPMBrqVqnAqKYXow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YVMKh2e8YQpMospkl4uly62/DXfMMR6TYHQbH303b5U=;
        b=htO9Z288xvFQ9UiuydX3qANlq50EpCQTqLCPQ4rbQwGmSlOQA92LlzPSf7OM30t4ls
         fquQY582j2P06oIoR59PLVGBRoX+eMP2icpWzeF/G4XUFF+XNY/Ts+fyuigqg83KJp0q
         cS5u0QzNqbNp6BuDxS/YK2fvSOPrDO/KIaplu80X6C/2y5G8gSmUmaxSPuR0S5w6gwGZ
         67U5PVNB6+e7Th2QurbLwY8YHUFf4+U5M9xdwqTcath97WbOVd6JBw6U6mE9hlwoKPpf
         aYR8q//ruswIc6somaBOxb7qbwafPWJB79egLB27pIODF7xvHaxHsyrkhZ2id3NgfVLZ
         hJhg==
X-Gm-Message-State: APjAAAXtwTUWy/WIqswTfNqwCRh6nZxR1ON9Lh9K5lpqiSKGLchhk9mF
        vbiVlXszoiDu4l2/LlS8Fbl8ew==
X-Google-Smtp-Source: APXvYqxn6IhqqTyBR6NWv+KCnyGaorjTU5whZhdLjWbHn9627vkK/4GPQH+t7Z4ro0MKx+0DNxFmpQ==
X-Received: by 2002:a17:902:449:: with SMTP id 67mr1331873ple.20.1573097464392;
        Wed, 06 Nov 2019 19:31:04 -0800 (PST)
Received: from hiroh.tok.corp.google.com ([2401:fa00:8f:2:3bf4:6372:5b56:dd4c])
        by smtp.gmail.com with ESMTPSA id s24sm464642pfm.144.2019.11.06.19.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 19:31:03 -0800 (PST)
From:   Hirokazu Honda <hiroh@chromium.org>
To:     linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org
Cc:     mchehab@kernel.org, tiffany.lin@mediatek.com, tfiga@chromium.org,
        acourbot@chromium.org, hiroh@chromium.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] media: mtk-vcodec: Remove extra area allocation in an input buffer on encoding
Date:   Thu,  7 Nov 2019 12:30:57 +0900
Message-Id: <20191107033057.238603-1-hiroh@chromium.org>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MediaTek encoder allocates non pixel data area for an input buffer every
plane. As the input buffer should be read-only, the driver should not write
anything in the buffer. Therefore, the extra data should be unnecessary.

Signed-off-by: Hirokazu Honda <hiroh@chromium.org>
---
 drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
index fd8de027e83e..6aad53d97d74 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
@@ -332,14 +332,12 @@ static int vidioc_try_fmt(struct v4l2_format *f,
 
 		pix_fmt_mp->num_planes = fmt->num_planes;
 		pix_fmt_mp->plane_fmt[0].sizeimage =
-				pix_fmt_mp->width * pix_fmt_mp->height +
-				((ALIGN(pix_fmt_mp->width, 16) * 2) * 16);
+			pix_fmt_mp->width * pix_fmt_mp->height;
 		pix_fmt_mp->plane_fmt[0].bytesperline = pix_fmt_mp->width;
 
 		if (pix_fmt_mp->num_planes == 2) {
 			pix_fmt_mp->plane_fmt[1].sizeimage =
-				(pix_fmt_mp->width * pix_fmt_mp->height) / 2 +
-				(ALIGN(pix_fmt_mp->width, 16) * 16);
+				(pix_fmt_mp->width * pix_fmt_mp->height) / 2;
 			pix_fmt_mp->plane_fmt[2].sizeimage = 0;
 			pix_fmt_mp->plane_fmt[1].bytesperline =
 							pix_fmt_mp->width;
@@ -347,8 +345,7 @@ static int vidioc_try_fmt(struct v4l2_format *f,
 		} else if (pix_fmt_mp->num_planes == 3) {
 			pix_fmt_mp->plane_fmt[1].sizeimage =
 			pix_fmt_mp->plane_fmt[2].sizeimage =
-				(pix_fmt_mp->width * pix_fmt_mp->height) / 4 +
-				((ALIGN(pix_fmt_mp->width, 16) / 2) * 16);
+				(pix_fmt_mp->width * pix_fmt_mp->height) / 4;
 			pix_fmt_mp->plane_fmt[1].bytesperline =
 				pix_fmt_mp->plane_fmt[2].bytesperline =
 				pix_fmt_mp->width / 2;
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

