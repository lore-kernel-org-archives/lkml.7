Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B4AC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 11:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8835C2166E
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 11:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cPSKEtJO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405196AbfHWLHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 07:07:54 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46204 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbfHWLHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 07:07:53 -0400
Received: by mail-lf1-f65.google.com with SMTP id n19so6817382lfe.13
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 04:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZHcoLOCEDvNdiKJSIaGU9TMbH+mXTX9zteaN4YnDK00=;
        b=cPSKEtJOjYq9WsIijVXnZyKIbicP5PMiaPAcAAyh8mxF2fDAkuuFN3FcjHGy6xOiA8
         dg3q+8r842lRJFe52waZ1pWOP1wKwsDLDgKLqIpRczfz3K1GCezlxU2eAw9eIZbMKxrf
         mrn4ekEkBMNN05Alm52osCbJSaG9T3p08S1uk/Etvu7P/iU5q1BQZIwSb0LvUTNiRtvb
         cYFDDf3S1vHAgguA6kMPY4lnFgRTA7hrkOSRgVLfAkUQYbXFTy9PUohmSf4W+STJYWLK
         3ZPZzlh8ATubZ3jKVG+Q0Xc8NiATpTsN2VCfjDHzuS4R6vwvK+BZ87tC4ou5Z6faQS3u
         BXhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZHcoLOCEDvNdiKJSIaGU9TMbH+mXTX9zteaN4YnDK00=;
        b=ls+ExS5UIfpCYrDIrEu4B7h8Qwh81v6kwe8jss2/nJJ9Vq+z1lHcNs2uQaS8LfEErz
         nSfLDaaxEZgPO5HXgvnj+3EQ6hu413FpIpoSXGcj+RMVLipPMn8ZvQ6IkhLEaaAbKdNi
         q16uSY0q4rmIj6Li/ycuuNJYbIqAPIKkbOn7wQzXazFeLQgzeTs7RVmbgvOudWWLmZpM
         CaIEoZCEC2HFS80p7rXtpf9KEV0aMC1Q8qB9WmTBj5MpY1nCkvIywxg1sJm84tBL3AZF
         RvSZwRyRjQ30nPJJVim/8CMYL3C4/SLxnZ7WpR2GSt9AbLNC/Qu99F4ts1SLcsTI7IyM
         IkHA==
X-Gm-Message-State: APjAAAWcKB7cj//+jeoEqa8ebdPDdZlXH0/x/h/45DmIe0QAA2wUseSW
        1qxMSvxjma/4ITpE36eXKcPdig==
X-Google-Smtp-Source: APXvYqzi3fwiyJBZWIDhJNnGDLtbqn6NPY5vwE/i10iohempQV8GMBpKT39wg3/8zN79Mnf6fd6bZA==
X-Received: by 2002:a19:2314:: with SMTP id j20mr1185222lfj.22.1566558471447;
        Fri, 23 Aug 2019 04:07:51 -0700 (PDT)
Received: from localhost (c-243c70d5.07-21-73746f28.bbcust.telenor.se. [213.112.60.36])
        by smtp.gmail.com with ESMTPSA id r23sm596312ljm.59.2019.08.23.04.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 04:07:50 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     ck.hu@mediatek.com, p.zabel@pengutronix.de, airlied@linux.ie,
        daniel@ffwll.ch, matthias.bgg@gmail.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] drm/mediatek: fix implicit function declaration
Date:   Fri, 23 Aug 2019 13:07:36 +0200
Message-Id: <20190823110736.26117-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building mtk_drm_drv.o the following build error is seen:

../drivers/gpu/drm/mediatek/mtk_drm_drv.c: In function ‘mtk_drm_kms_init’:
../drivers/gpu/drm/mediatek/mtk_drm_drv.c:291:8: error: implicit declaration of
 function ‘dma_set_max_seg_size’; did you mean ‘drm_rect_adjust_size’? [-Werror=implicit-function-declaration]
  ret = dma_set_max_seg_size(dma_dev, (unsigned int)DMA_BIT_MASK(32));
        ^~~~~~~~~~~~~~~~~~~~
        drm_rect_adjust_size
../drivers/gpu/drm/mediatek/mtk_drm_drv.c:291:52: error: implicit declaration of
 function ‘DMA_BIT_MASK’; did you mean ‘BIT_MASK’? [-Werror=implicit-function-declaration]
  ret = dma_set_max_seg_size(dma_dev, (unsigned int)DMA_BIT_MASK(32));
                                                    ^~~~~~~~~~~~
                                                    BIT_MASK

Rework to add a missing include file 'linux/dma-mapping.h', because that
is the (only) header file containing that declaration.

Fixes: 070955558e82 ("drm/mediatek: set DMA max segment size")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 54536176bcbb..352b81a7a670 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -10,6 +10,7 @@
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/pm_runtime.h>
+#include <linux/dma-mapping.h>
 
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
-- 
2.20.1

