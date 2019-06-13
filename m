Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC519C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 19:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D2DD20B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 19:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FE4dJnLk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729374AbfFMTng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 15:43:36 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43413 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729093AbfFMTnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 15:43:33 -0400
Received: by mail-pg1-f193.google.com with SMTP id f25so85488pgv.10
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 12:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CYPkZ1kHlegoet40jMp9lNjbYY87zm41fO5/bnIRtVY=;
        b=FE4dJnLkWT/wzZIKxQnGm9hn3MWtcyqW/MT2wtn2Lwp9cOyu42ILOuYP/pEZisNPzJ
         arWgE8Ibze4Nb38GlZev9QW5KIPYAqK71cPwZGLO95/fclJ3exbgai9UrDk+z1owjH5m
         oEzN4hVjAhOfbGDr0fVqTnrlE/qoPBYiECaho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CYPkZ1kHlegoet40jMp9lNjbYY87zm41fO5/bnIRtVY=;
        b=Hi8g39lUNBUhU4XWs+8XtvfQsKm4TWMS3tb8KzpJDrKWF11cc8KCIB/3sOLKjyP8jt
         V+lpwGspjZ4ayQonA9UjReCQSgo/P92+UOH9sUGOWYniegiccq5jHpZIpd0GZZT3rLUq
         vO8v6UTzGBCDbaz7IzyWA/SX3R7dQUYSr+0ceCp+HKBCsKyKbpHyiPR99rXQ8t5VQMWW
         rTqXQRohPf5TyDYWnNGPuTutdFfKkHTBbD7pWaHwrfRcnDtf8FM9SeZYuEBXERq7PWaR
         Pp9EeufkfN3yIeBvHX3CZ9XOaM3jCetnlW7dWPo9Yv/35zapXuzXN1vy2aISRekisY4k
         6DuA==
X-Gm-Message-State: APjAAAWCQyROs5TDhhyfjraL4NK/fJgH4mP3Ia+3xpWUrFzdkCFuzCUd
        J526eKLcJeHFoiK6sfU0kqMOTQ==
X-Google-Smtp-Source: APXvYqycbVZXlvuqRzFiBln7zYVKC7ylbynb1qlibWK1KEuqMaOj0glQOfDd2xEXmxZcdeBGNd5Pvw==
X-Received: by 2002:a63:4c:: with SMTP id 73mr30610167pga.134.1560455012940;
        Thu, 13 Jun 2019 12:43:32 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id v23sm7853735pju.3.2019.06.13.12.43.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 12:43:32 -0700 (PDT)
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
Subject: [PATCH 1/4] MAINTAINERS: Add entry for stable backlight sysfs ABI documentation
Date:   Thu, 13 Jun 2019 12:43:23 -0700
Message-Id: <20190613194326.180889-2-mka@chromium.org>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
In-Reply-To: <20190613194326.180889-1-mka@chromium.org>
References: <20190613194326.180889-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an entry for the stable backlight sysfs ABI to the MAINTAINERS
file.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
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
2.22.0.rc2.383.gf4fbbf30c2-goog

