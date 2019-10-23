Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07596CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 12:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCC582086D
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 12:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i4gpfqId"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405319AbfJWMWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 08:22:30 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32947 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbfJWMWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 08:22:30 -0400
Received: by mail-wr1-f66.google.com with SMTP id s1so13103226wro.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 05:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e3FCsAeT5K9ZdHIcSbJyMOoHwnh6UPbcGp5phHrUoac=;
        b=i4gpfqIdPEPkJ1QTxEJgpm5N7TxdtUNBaeo3ktliHpa/YrfYV2a3i2DLSwCxuUukH9
         5TBN+AvjFQiQA0UV/Hkv6aO5jNaR4406iJlviEAeXPGBQaTJ5GD0Kdm8oFZ1SzW+QcXp
         iF+D5gv+SV4HN074ghZz+TnklNwpyqUjIAwUMtudRiYI1ar4jdk21PUbwtx/1FHTsU2k
         61hNyMVQzIbPy8GPcmcLnu0hTRDyF2h0Fc1ULq+DPnDucNhBlXLz5rfO32KQr34Trwlf
         7RBEdT//fDSlbCU/5Z/W7DqNLzDRCiJGL7TqE/xY5T5qCc9qf7iV1yzXr9sEZu5nAg/T
         PJwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=e3FCsAeT5K9ZdHIcSbJyMOoHwnh6UPbcGp5phHrUoac=;
        b=shOXXJ0up4/FdtrmxGj5SaMxdCO3p9eucZH+sxSStIJzuxJEaw6mCO5R00X2vnl/F3
         7OA+9/xng1ZH6qwYOaCCXTyGuRofqMYz5rz5HUrmeLNzbDDs9FjL8VtiRkscf5vlQIBy
         b8nUk8xcNijtbFiyYfTZdzH4ivEjVaGNDEUBNsol2QyPaUA9khvdvc/8ixyZBR9ejOXm
         OeM4RCg2eqKDJyqPjYVxgBhvx3jprEnsQuM5PTjFApVmboDDrawAJ/Lg1B2hiBzFewlw
         u+xTQVplkEYYI+1SIYuaWBGD2fKJlnYD6AmoL5xA5XlcHb7Jgx1OVp3n/+kA8bA7BHnF
         74Sw==
X-Gm-Message-State: APjAAAXK1bLJL2xq5tgoJ6Aj4LMB8cCuQ3IMrWYVOSkhDWvXaC8kR5LK
        bp124GH9xJEimimHHJftHnWtOSeWMzw=
X-Google-Smtp-Source: APXvYqw1NcJwe73jzpm/8PbdxicLWL/zyK/dS0vS9s2mDoXESRNQsH6ykzl6XO+SGpl9tHwnGk+JPg==
X-Received: by 2002:a5d:614e:: with SMTP id y14mr8543618wrt.329.1571833348216;
        Wed, 23 Oct 2019 05:22:28 -0700 (PDT)
Received: from cizrna.lan ([109.72.12.196])
        by smtp.gmail.com with ESMTPSA id x21sm9773421wmj.42.2019.10.23.05.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 05:22:26 -0700 (PDT)
From:   Tomeu Vizoso <tomeu.vizoso@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh@kernel.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v2] panfrost: Properly undo pm_runtime_enable when deferring a probe
Date:   Wed, 23 Oct 2019 14:21:57 +0200
Message-Id: <20191023122157.32067-1-tomeu.vizoso@collabora.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191023120925.30668-1-tomeu.vizoso@collabora.com>
References: <20191023120925.30668-1-tomeu.vizoso@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When deferring the probe because of a missing regulator, we were calling
pm_runtime_disable even if pm_runtime_enable wasn't called.

Move the call to pm_runtime_disable to the right place.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Reported-by: Chen-Yu Tsai <wens@csie.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Fixes: f4a3c6a44b35 ("drm/panfrost: Disable PM on probe failure")
---
 drivers/gpu/drm/panfrost/panfrost_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index bc2ddeb55f5d..f21bc8a7ee3a 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -556,11 +556,11 @@ static int panfrost_probe(struct platform_device *pdev)
 	return 0;
 
 err_out2:
+	pm_runtime_disable(pfdev->dev);
 	panfrost_devfreq_fini(pfdev);
 err_out1:
 	panfrost_device_fini(pfdev);
 err_out0:
-	pm_runtime_disable(pfdev->dev);
 	drm_dev_put(ddev);
 	return err;
 }
-- 
2.20.1

