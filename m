Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D28B9C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 20:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A266C20663
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 20:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GH6GaNaG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731824AbfFXUbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 16:31:24 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45799 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731784AbfFXUbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 16:31:22 -0400
Received: by mail-pg1-f195.google.com with SMTP id z19so4761664pgl.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 13:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JP95lZdX+e5+GJVUv6OxKodaA7GTVH/s6o/zZ4o6Yqk=;
        b=GH6GaNaGuD+3/lq/E8qiZgIhrqY4POMDMF6xHbas+S9+1gjPhAdu+raSlGPuBLqD9g
         BkKsc+XCH1g3Z10BQaTguBLuGNZWvrF/v7D7o9CGRm3XNhjIs+7yeIKYYcTpDmT9I9R8
         CIvyVtU+X72CfuHwtLu5CTf7kBuk4/yEwY9wE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JP95lZdX+e5+GJVUv6OxKodaA7GTVH/s6o/zZ4o6Yqk=;
        b=AJCig6hYkVw2uPp+u4Fn7GHxE2ImLEGGhdbebPik4GIddDlIxgJ9HqEGDp8KAXbmTd
         +KxMNhcZmEVxGRkHKG3g46RgFZbMEV5Fc1aQLWJU5njNKgDIayQo0wYdZGqOPnx0q7Nq
         AZP+jDMJBpJB/eYMUHfvsPTQuDtLdlsmyleaYl5GDSSPz7i3r9x/k3eIWafFF02Bg97f
         IHBin8qPaz80nhO6C/3m3gQKugv32LpW5S+EiLVGR9BbCY+BHUcXgiH4hc0ZrcEhf/Ff
         ajm37bvyyikroZ7/tpt9lJvFYwvBHCf+FphX2OSkaW91E9wIlNDBOQleIIqK0PavOiF1
         HbKg==
X-Gm-Message-State: APjAAAURUEDO7T7kFdm/6jdC8Hu03jYHJQeZJYDXtmOnYTKUQ8mM5H3G
        p5hx8HNbJCsUoI63SeKF4ZmmRQ==
X-Google-Smtp-Source: APXvYqw9jBap6wGYgRpzAJeJ6bDMEgATfqj/PCB+aRPwnHh0ax4ayLJ9RddKSYOnMpDP5vtjzzt8pg==
X-Received: by 2002:a17:90a:cd04:: with SMTP id d4mr27797860pju.128.1561408281769;
        Mon, 24 Jun 2019 13:31:21 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id r198sm6217026pfc.149.2019.06.24.13.31.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 13:31:21 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Douglas Anderson <dianders@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Pavel Machek <pavel@ucw.cz>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v2 1/4] MAINTAINERS: Add entry for stable backlight sysfs ABI documentation
Date:   Mon, 24 Jun 2019 13:31:10 -0700
Message-Id: <20190624203114.93277-2-mka@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190624203114.93277-1-mka@chromium.org>
References: <20190624203114.93277-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an entry for the stable backlight sysfs ABI to the MAINTAINERS
file.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
---
Changes in v2:
- added Daniel's 'Acked-by' tag
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 57f496cff999..d51e74340870 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2857,6 +2857,7 @@ F:	drivers/video/backlight/
 F:	include/linux/backlight.h
 F:	include/linux/pwm_backlight.h
 F:	Documentation/devicetree/bindings/leds/backlight
+F:	Documentation/ABI/stable/sysfs-class-backlight
 
 BATMAN ADVANCED
 M:	Marek Lindner <mareklindner@neomailbox.ch>
-- 
2.22.0.410.gd8fdbe21b5-goog

