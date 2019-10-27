Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B536ECA9EBC
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 23:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8688A21726
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 23:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cPOgXS/f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbfJ0XKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 19:10:01 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42008 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728482AbfJ0XJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 19:09:58 -0400
Received: by mail-pf1-f196.google.com with SMTP id 21so5431760pfj.9
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2019 16:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vTdKfrLaZ8h651voQL2XDjEiqFz4XHidi31jv2eQb/8=;
        b=cPOgXS/fG4NXLZ+t447zk5ZLIMYffgBBy+cNDMwQhf2zyWy8+wxvgo8flYKxNgKAGf
         jafroM/A0lMeh/BgTtSiXwMWM1k7ZU7p3GhYtJcW8ow45AROASJayz3it3GblvF2fTLT
         4+ANY/QTWcO/X7VrqklyhPm4gU9GhpHQVOwnw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vTdKfrLaZ8h651voQL2XDjEiqFz4XHidi31jv2eQb/8=;
        b=Ez7qZW9qVOvXBgKPtSPa1VX3TOCuc4wxN5NZIMBk9z2XFd8WkdZG6hlzWJndVeMlin
         hRnoqFJ6iQnk8pkHwwFUrSgZOw6hirLllMuFU/Of8Gf8ZtiumruJa7ACPRKAV5Ou0vFg
         VS6wUvfbQGXBt0apiArvC/nvumPOlkfirhDFLqc5eMgJBqV0E3DR1LhQ9bmGo7J+PjMk
         EOA3EAxK81Ie1cT0xiSX212Cxh+3NJ15aJ+21oqzenqB7XRrS7fBNd2A50c1/67/ySEg
         iCTU1o4xr8rXHR3P+K7mOJJjomN9a1QfA2jnFHrY7poAplTItI/BvHmMzlMVvqDfdvCK
         hsSw==
X-Gm-Message-State: APjAAAUwVZa0Qp++lC/JhAc5XQNq4EKVdstteZaRyDc8ECO0S/hoNcbN
        OAb/e8BhHgxKVsurGpUCpop98A==
X-Google-Smtp-Source: APXvYqyK7sN9XN6YUV1OXI0ZPMAZ2IMJCrVNlled2K1XGwtk3vPjdfMCREUiYbtUJqhuUgpAE+rDsA==
X-Received: by 2002:a63:4081:: with SMTP id n123mr8617326pga.444.1572217797813;
        Sun, 27 Oct 2019 16:09:57 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id i22sm8755307pfa.82.2019.10.27.16.09.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Oct 2019 16:09:57 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     briannorris@chromium.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, lee.jones@linaro.org,
        bleung@chromium.org, enric.balletbo@collabora.com,
        dianders@chromium.org, groeck@chromium.org,
        fabien.lahoudere@collabora.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Enrico Granata <egranata@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v3 06/18] platform: chrome: cros_ec: Do not attempt to register a non-positive IRQ number
Date:   Sun, 27 Oct 2019 16:09:09 -0700
Message-Id: <20191027230921.205251-7-gwendal@chromium.org>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
In-Reply-To: <20191027230921.205251-1-gwendal@chromium.org>
References: <20191027230921.205251-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Enrico Granata <egranata@chromium.org>

Add a layer of sanity checking to cros_ec_register against attempting to
register IRQ values that are not strictly greater than 0.

Signed-off-by: Enrico Granata <egranata@chromium.org>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
No changes in v3.
Changes in v2:
  Remove dual Enrico's signature.

 drivers/platform/chrome/cros_ec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
index 739f3cffe26e3..9b19f50572313 100644
--- a/drivers/platform/chrome/cros_ec.c
+++ b/drivers/platform/chrome/cros_ec.c
@@ -149,7 +149,7 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 		return err;
 	}
 
-	if (ec_dev->irq) {
+	if (ec_dev->irq > 0) {
 		err = devm_request_threaded_irq(
 				dev, ec_dev->irq, ec_irq_handler,
 				ec_irq_thread, IRQF_TRIGGER_LOW | IRQF_ONESHOT,
-- 
2.23.0.866.gb869b98d4c-goog

