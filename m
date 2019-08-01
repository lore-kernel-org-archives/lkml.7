Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0385C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 03:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 742E5214DA
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 03:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pNhWt5gG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729809AbfHADo6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 23:44:58 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35712 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729729AbfHADox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 23:44:53 -0400
Received: by mail-pl1-f194.google.com with SMTP id w24so31500461plp.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 20:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yWATOQC7xCYUWMxHGpKVvr0YlzHaV7cfBrgB+3CpQl8=;
        b=pNhWt5gGCL4xlPtKcrtkLPZHmIYd/CprHM6Yk/qDos1k88CtQzSJeE6n/r/ZlPqlwq
         GWc45JHjcBnFzAdJUBmKxpql1YLn+WFRWCNBljCzD8BvF16FxsNiaQ7SdR4/oxnfuCx3
         2Y410a5S1pJB2deLPi+kGejLgYki003f2LoFpm85daRtkxfo5JY4obS2Mu6Zex3TcOt/
         9PfWkoUg1NzPt7T4jcXj1fkKQnRJ3BogsyRFF0uBWfia4bIeOBoKSaDNAvqArXxujplQ
         reRNqKcQEVWGCNkK0FB2x1Nxx+QXk3QZRCI1GyhHqhqn4ZNaqswy3drHaHvxXfaJ8WKs
         CwmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yWATOQC7xCYUWMxHGpKVvr0YlzHaV7cfBrgB+3CpQl8=;
        b=b89ENwTon2uNdOoFBvzN6ZRfVpfkExwdwyO1vvRXvvi0/S6xfIWYRDUlg1fT39dPCW
         6sa/dJ0GJzqcSI/H3oBvbj4hwuBmSIRxIRBUs4su9aYZobbnqeDnh+0sleIDYY6XB1Rq
         Ib4/cleKKCsX9slQyh374Eg2J4RnT8Vb+MRIYKkMFoXPbryTEPz2r4hy4v34xjrctXAH
         XhyaaHCS8eWHQHpKTUUlumQlGOXI9CrMuPKXkWSMGiyWL3hHnjD6wditkxPLfAmq607y
         eHsvZZ2cqDyy6phI8sJXgFWE3qkyfjoi7v5s5zSrARHtpMcbtxSRYiQ2eMN20J8jV7Th
         w0HQ==
X-Gm-Message-State: APjAAAW/WnoD5Ps1wfB1DK4YUW9iUuEQSMT5kONBtLayISYUHyYlEw3A
        xiesvZbM7/S6Nau1WCxjW8wRYtMi5vc=
X-Google-Smtp-Source: APXvYqwF2nMm4zaQPkYlX6Euo2pU4rs5CLSygCe26xqwgABVkyiJCsXcaYw81yolcPkgWCA1ofO1Ng==
X-Received: by 2002:a17:902:2ac7:: with SMTP id j65mr124662426plb.242.1564631091680;
        Wed, 31 Jul 2019 20:44:51 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id h70sm64775674pgc.36.2019.07.31.20.44.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 20:44:51 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Rongrong Zou <zourongrong@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v3 04/26] drm: kirin: Remove unreachable return
Date:   Thu,  1 Aug 2019 03:44:17 +0000
Message-Id: <20190801034439.98227-5-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190801034439.98227-1-john.stultz@linaro.org>
References: <20190801034439.98227-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'return 0' in kirin_drm_platform_probe() is unreachable
code, so remove it.

Cc: Rongrong Zou <zourongrong@gmail.com>
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

