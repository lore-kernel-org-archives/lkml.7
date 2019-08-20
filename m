Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4238DC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 08:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 148FB22CF7
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 08:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="OTazuxgS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729482AbfHTIlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 04:41:18 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:35957 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729362AbfHTIlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 04:41:16 -0400
Received: by mail-wr1-f47.google.com with SMTP id r3so11486519wrt.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 01:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L5KPw5d284IbrMAoTx1V+ek9Af8RjMLhhCTcT5HNr1o=;
        b=OTazuxgSobVpwG3fC5+kdrt2Vu/JKNOMsnyB8TitxtwiNZe5WhU5jRqZ8oB4dvEg7d
         aCvt1U6J6NPjB9ORiM+F64aSI5HS9V1gXEkGNnNsbLJkNPsRQNIXTSbMJJ+9aJO4Dn/x
         iE1+jC9Fw7+x263Uz+F2byJSR9LeKUG8XQJBd4/M7vsU7hjLy31Xr091fVDS6ZAIvu4H
         jUI6Ui6icqsYUqrBmSoZkE6K7IZHhbuMOaf5VxYYkUKNv/vD24G+mngDEwmcq3Jv6LzT
         pndCIbuE6B/zyThbR0KhFYn1H3iQpZVaLQtKMHu5Oy7kON5GchddvzlN3zi5QyOsSfVP
         rSAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L5KPw5d284IbrMAoTx1V+ek9Af8RjMLhhCTcT5HNr1o=;
        b=bUHNwDcjQhxxKfe7XOx7+hzK6T7RA9uVAl+i7Vc/3LQyubh2dnUBK0sspbdnXQKR8p
         8tUAEQwbRUxpTeGC3WC+lyYCm2ElI3aBfHOcGzWSalpqAsc8fUeHBlDWCCGdhFlOwNQ4
         /+iYGdZzwHTeRHNOUW3yA9SUA1xxPbOCRz832DpjlsdS6+1jFewXps9pHeAsaDR+pZw/
         fLCq0sqH1g7RD8rvqCwAzKBk6A4OIczzFtNs6jg0MlmVgZL4yTaNvHeavu0aDzyj4v2O
         hmXLce7wlL7KSZW1or6TYVS9sYjxtEBdVGe9319t/3CqeghDB7jKZtybZVK0FjA8yvq4
         FJ2w==
X-Gm-Message-State: APjAAAVcDw9EWc2OBmxOq2qMqX0GzC56aTQLLVQozKU0L9d1XRNzlg7Y
        HUTDI8U5S3L5xpVQAbsLB8Wsuw==
X-Google-Smtp-Source: APXvYqzPgvUubcWqtUwShfydVe+2jVHgqlhH1mD4p0zOrAFDM3WZ70Ezpo0RWAwQj8DuZOeWm5T2xw==
X-Received: by 2002:a5d:5388:: with SMTP id d8mr32354386wrv.299.1566290473617;
        Tue, 20 Aug 2019 01:41:13 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id g2sm34275648wru.27.2019.08.20.01.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 01:41:13 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@siol.net,
        boris.brezillon@collabora.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [RFC 01/11] fixup! drm/bridge: Add the necessary bits to support bus format negotiation
Date:   Tue, 20 Aug 2019 10:40:59 +0200
Message-Id: <20190820084109.24616-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190820084109.24616-1-narmstrong@baylibre.com>
References: <20190820084109.24616-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +	} else if (b->num_supported_fmts > 1 && b->supported_fmts) {
> +		*selected_bus_fmt = b->supported_fmts[0];
> +		return 0;

Here, `!a->num_supported_fmts &&` is missing otherwise this code will
select b->supported_fmts[0] whatever the supported formats of a.

> +	} else if (a->num_supported_fmts > 1 && a->supported_fmts) {
> +		*selected_bus_fmt = a->supported_fmts[0];
> +		return 0;

Here, `!b->num_supported_fmts &&` is missing otherwise this code will
select a->supported_fmts[0] whatever the supported formats of b.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/drm_bridge.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 5f0925467292..82fe7728fcd1 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -615,10 +615,12 @@ int drm_find_best_bus_format(const struct drm_bus_caps *a,
 	if (!a->num_supported_fmts && !b->num_supported_fmts) {
 		*selected_bus_fmt = 0;
 		return 0;
-	} else if (b->num_supported_fmts > 1 && b->supported_fmts) {
+	} else if (!a->num_supported_fmts &&
+		   b->num_supported_fmts > 1 && b->supported_fmts) {
 		*selected_bus_fmt = b->supported_fmts[0];
 		return 0;
-	} else if (a->num_supported_fmts > 1 && a->supported_fmts) {
+	} else if (!b->num_supported_fmts &&
+		   a->num_supported_fmts > 1 && a->supported_fmts) {
 		*selected_bus_fmt = a->supported_fmts[0];
 		return 0;
 	} else if (!a->num_supported_fmts || !a->supported_fmts ||
-- 
2.22.0

