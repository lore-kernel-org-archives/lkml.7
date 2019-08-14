Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D70FFC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB55C216F4
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XjbkzQzR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbfHNSrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 14:47:17 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39982 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729180AbfHNSrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 14:47:14 -0400
Received: by mail-pg1-f193.google.com with SMTP id w10so13453pgj.7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 11:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gZlqEMIie9JrTF+U3D4DkV2iblyXZl+ikNJHS29ktag=;
        b=XjbkzQzRC401HwYkgJTt5/alWGhUTRr63o71FoCDwgSKS/A9ToFGHy6O/sTVyshQBT
         XSD4Ca0pa9uCbyUka3KenXl3dh1eYFMQWyYVO5cA/ovDzDwVvf+MytD1iy11qXkqyxCX
         NaUKoffPiIbORR7QDPzRSpN9Xy2zHkCBkJp+i6VhBH6kNhFS5S08Qlz7Ox2koBMBbyNF
         4ymd2whYjQtP9nQQsQSNgifPOO7LbC/N5sVhYMaSju0XmZ2eQK8HGJXNFVLQKUF2jRZQ
         AilqvhFg60+Nhiq2bOXaeyNEHLXwChnrGXdzWurJ3tBtQfJMpRXJgX2HT7Ml2BlPrxpv
         D18g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gZlqEMIie9JrTF+U3D4DkV2iblyXZl+ikNJHS29ktag=;
        b=srh+RTRk4tyXtRFt5UFQPFIqqBuIHG3UC1hgRiEyQ2fSM7acZF02F49LkD49euAma1
         ql4L+fN4UkyKXVtOR0Ky6V8yH/bOzDSPknqT9QX23vKXKMAQ5Sfo1dwVPnl9jH0sk8yK
         2ga6D/xkSCrnQvp5JeGM/dZelhICVZpgwBftZyESry2ey0x6scWHMwefRS7nd3Ug9aQ+
         1bl1aj4H/GfzFy5iBI+XTwtZA98am0wam3ui8lK2dmzx0jepFFi/qrQtzmM2pHkqE21C
         bZg4QLSLoZGeM7v/3YRfixrPi6IBrcCf/pL3hcmOOY8BoGKnaGcZuBWJ8WFmn20yNG+0
         G/Pw==
X-Gm-Message-State: APjAAAWQk6zupH2JpzKJPYZRxlD75M4OkTG7Dhlc1ugBz3KKRJ57LVp8
        Q3DvQ6y7AQhTFaTqNc1aQrz08B9gTcI=
X-Google-Smtp-Source: APXvYqx1pDSc+7gIkHH4h0G8/MwRFGnnNPGCkP3tXgf2O8GF8iR/6WPGPQnWYOIEl790rNNIoAnjfA==
X-Received: by 2002:aa7:96b3:: with SMTP id g19mr1385111pfk.26.1565808433394;
        Wed, 14 Aug 2019 11:47:13 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id y16sm610855pfc.36.2019.08.14.11.47.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 14 Aug 2019 11:47:12 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Rongrong Zou <zourongrong@gmail.com>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: [RESEND][PATCH v3 04/26] drm: kirin: Remove unreachable return
Date:   Wed, 14 Aug 2019 18:46:40 +0000
Message-Id: <20190814184702.54275-5-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190814184702.54275-1-john.stultz@linaro.org>
References: <20190814184702.54275-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'return 0' in kirin_drm_platform_probe() is unreachable
code, so remove it.

Cc: Rongrong Zou <zourongrong@gmail.com>
Cc: Xinliang Liu <z.liuxinliang@hisilicon.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Suggested by: Xu YiPing <xuyiping@hisilicon.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
index fbab73c5851d..bfe0505ac4a0 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
@@ -210,8 +210,6 @@ static int kirin_drm_platform_probe(struct platform_device *pdev)
 	of_node_put(remote);
 
 	return component_master_add_with_match(dev, &kirin_drm_ops, match);
-
-	return 0;
 }
 
 static int kirin_drm_platform_remove(struct platform_device *pdev)
-- 
2.17.1

