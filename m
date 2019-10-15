Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F58ECE588
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 16:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2174D2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 16:23:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="MtpXMuoL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387985AbfJOQXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 12:23:25 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54872 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387895AbfJOQXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 12:23:15 -0400
Received: by mail-wm1-f68.google.com with SMTP id p7so21563757wmp.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 09:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=02ptUi820rtgb1rVywdXHHVh+A6FBo6gb2V5cVn00l4=;
        b=MtpXMuoLIGOHdIDmPktqqAnPBBGdTjagnzKbds+7qPmfpcLGCESELR2gYmKw+dAlsH
         GALZyOdhrfBMu5kJ+9Xdwc10r7YixnzgTtoEN+sXwjbniUhbJe7QvOO/aAIzGpPEh7wf
         tfCJUfOOWUzVdJeNCG6CFQB8dEnEzKFW+8j2U5xtaG1G3ZhP43Ie0qhZ8IVGsF0AXBnv
         DMOWQaRx3fOEAAcptWX7okOpspg4CH1Ta5qXiMV2qqrxphCM/NqNvepzLTjUnEvCyNA1
         1AfGvqLU5KqSe4tJuDyCVpvjoNHpQNhZx5ieCd6JnQGy7BJrhwx+i3RBcBCT1IEoLoes
         Zqtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=02ptUi820rtgb1rVywdXHHVh+A6FBo6gb2V5cVn00l4=;
        b=uX4rzjYdTPNsdyw/ieX5dO489T1wHS0egxb+GSZSm3RZh8iDenWOKkJ9TKoVmYNqXz
         cOhJiWvIcIgc1m6MwvEggLcr+LzMxtNGBiMaAK88EWRfFAQBAbaUIKZWtflNtXJ+MRwC
         YYcvMbNALYXMLirnElzEdQkfIsXeKuwqQQKk4PuVwTI0F5AuoqgrmURVrtTvTMK5QnnU
         pnSxkZ/WA4dYjdlbdJfhCu7FcBi/iFPgW01VW8qbflSbFn7sSJx9RQ/M43TCmW5cHmsO
         o6HKyKHoIUJW9BXtYnBZ9KounAvGSx2AzP2v9EKBDbT8pUtxPYhv9UKpii6Hadeb9jLE
         x/0Q==
X-Gm-Message-State: APjAAAUH+DjN4BBLI4wzdlv/CYYehRe1tBSvbGYzDDWFy2Yu4c6DuBVB
        tgDQI7AXKcHRGh+CnhcLYtrOGA==
X-Google-Smtp-Source: APXvYqyezfzjgdEUemMJTrQBNb59P7iN2VRfn6C43WnRKbQCCmslDGhSYjUP8u7dsDPSEr9csaBvYw==
X-Received: by 2002:a1c:e08a:: with SMTP id x132mr19703933wmg.155.1571156593871;
        Tue, 15 Oct 2019 09:23:13 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id x129sm41427605wmg.8.2019.10.15.09.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 09:23:13 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 6/6] MAINTAINERS: update the list of maintained files for max77650
Date:   Tue, 15 Oct 2019 18:23:00 +0200
Message-Id: <20191015162300.22024-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191015162300.22024-1-brgl@bgdev.pl>
References: <20191015162300.22024-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The DT bindings for MAX77650 MFD have now been converted to YAML.
Update the MAINTAINERS entry for this set of drivers.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a69e6db80c79..c05e6fd6aedb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9903,8 +9903,8 @@ MAXIM MAX77650 PMIC MFD DRIVER
 M:	Bartosz Golaszewski <bgolaszewski@baylibre.com>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/*/*max77650.txt
-F:	Documentation/devicetree/bindings/*/max77650*.txt
+F:	Documentation/devicetree/bindings/*/*max77650.yaml
+F:	Documentation/devicetree/bindings/*/max77650*.yaml
 F:	include/linux/mfd/max77650.h
 F:	drivers/mfd/max77650.c
 F:	drivers/regulator/max77650-regulator.c
-- 
2.23.0

